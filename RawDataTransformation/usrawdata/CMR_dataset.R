## Loading CMR dataset based on https://macro.nomics.world/article/2016-06/cmr14-data/
# Written by Matyas Farkas, 2019

# Loading libraries
      library(magrittr)
      library(dplyr)
      library(ggplot2)
      library(rdbnomics)
      library(stringr)
      library(tidyr)
      library(lubridate)
      library(alfred)
      #install.packages("fredr")
      fredr_set_key("8ce324fcfb4663bfef63d3d44fbdbc73")
      library(fredr)
      library(knitr)
      library(zoo)
      setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load in Macro.nomics.world data
      
              df <- rdb(ids=c("BEA/NIPA-T10106/A191RX-Q",
                              "BEA/NIPA-T10109/A191RD-Q",
                              "BEA/NIPA-T10106/A006RX-Q",
                              "BEA/NIPA-T10109/A006RD-Q",
                              "BIS/CNFS/Q.US.N.A.M.XDC.A",
                              "BIS/CNFS/Q.US.H.A.M.XDC.A",
                              "BIS/PP-SS/Q.US.N.628",
                              "BLS/pr/PRS85006033",
                              "BLS/pr/PRS85006103",
                              "OECD/MEI/USA.IRLTLT01.ST.Q",
                              "OECD/MEI/USA.LFWA64TT.STSA.Q")) %>% 
                mutate(series_name=case_when(str_detect(series_code,"RD-") ~ paste("Deflator,",series_name),
                                             str_detect(series_code,"RX-") ~ paste("Real,",series_name),
                                             str_detect(series_code,"Q.US.N.A.M.XDC.A") ~ paste("Loans to non-financial corporations,",series_name),
                                             str_detect(series_code,"Q.US.H.A.M.XDC.A") ~ paste("Loans to households and NPISHs,",series_name),
                                             str_detect(series_code,"Q.US.N.628") ~ paste("Property prices,",series_name),
                                             TRUE ~ series_name)) %>% 
                select(var_name=series_name,
                       var_code=series_code,
                       value,
                       period)
              
              df %<>% 
                mutate(var_code=
                         case_when(var_code=="A191RX-Q" ~ "gdp",
                                   var_code=="A006RX-Q" ~ "inves",
                                   var_code=="A191RD-Q" ~ "defgdp",
                                   var_code=="A006RD-Q" ~ "definves",
                                   var_code=="Q.US.H.A.M.XDC.A" ~ "loans_hh",
                                   var_code=="Q.US.N.A.M.XDC.A" ~ "loans_nfc",
                                   var_code=="Q.US.N.628" ~ "houseprice",
                                   var_code=="PRS85006033" ~ "hours",
                                   var_code=="PRS85006103" ~ "wage",
                                   var_code=="USA.LFWA64TT.STSA.Q" ~ "pop",
                                   var_code=="USA.IRLTLT01.ST.Q" ~ "longrate"))
              
              shortrate <- 
                rdb(ids="FED/H15/129.FF.O") %>% 
                mutate(period=paste(year(period),quarter(period),sep="-")) %>% 
                group_by(period) %>% 
                summarise(value=mean(value)) %>% 
                mutate(var_code="shortrate",
                       var_name="Monthly - Federal funds - Overnight",
                       period=yq(period))
              
              conso_level <- 
                rdb(ids=c("BEA/NIPA-T20306/DDURRX-Q",
                          "BEA/NIPA-T20306/DNDGRX-Q",
                          "BEA/NIPA-T20306/DSERRX-Q")) %>% 
                select(period,
                       value,
                       var_name=concept)
              
              conso_rate <- 
                rdb(ids=c("BEA/NIPA-T20301/DDURRL-Q",
                          "BEA/NIPA-T20301/DNDGRL-Q",
                          "BEA/NIPA-T20301/DSERRL-Q")) %>% 
                select(period,
                       value,
                       var_name=concept)
              
              conso_level_02 <-
                conso_level %>% 
                filter(period=="2002-01-01")
              
              conso <-
                conso_rate %>% 
                filter(period <= "2002-01-01") %>% 
                full_join(conso_level_02,by="var_name") %>% 
                group_by(var_name) %>% 
                arrange(desc(period.x)) %>% 
                mutate(value = value.y / lag(cumprod((1 + value.x/100)^(1/4)))) %>%
                ungroup() %>% 
                transmute(period=period.x,
                          var_name,
                          value) %>% 
                na.omit() %>% 
                bind_rows(conso_level)# %>% 
              #  filter(period >= "1980-01-01")
              
              #ggplot(conso,aes(period,value))+
              #  geom_line(colour=blues9)+
              #  facet_wrap(~var_name,ncol=3,scales = "free_y")+
              #  scale_x_date(expand = c(0.01,0.01)) +
              #  theme + xlab(NULL) + ylab(NULL)+
              #  ggtitle("Real Personal Consumption Expenditures")
              
              conso %<>% 
                mutate(
                  var_code=case_when(
                    var_name=="Durable goods" ~ "conso_d",
                    var_name=="Nondurable goods" ~ "conso_nd",
                    var_name=="Services" ~ "conso_s"
                  ),
                  var_name=paste("Real Personal Consumption Expenditures,",var_name))
              
              conso %<>% 
                mutate(
                  var_code=case_when(
                    var_name=="Real Personal Consumption Expenditures, durable-goods" ~ "conso_d",
                    var_name=="Real Personal Consumption Expenditures, nondurable-goods" ~ "conso_nd",
                    var_name=="Real Personal Consumption Expenditures, services" ~ "conso_s"
                  ),
                  var_name=paste("Real Personal Consumption Expenditures,",var_name))
              
              
              WILL5000IND<-            data.frame(fredr(series_id = 'WILL5000IND', 
                                           frequency="q", 
                                           aggregation='avg'), 
                                     var_name="Wilshire 5000 Total Market Index",
                                     var_code="networth")
              
              WILL5000IND<- transmute(WILL5000IND, period=ymd(date),
                        value=as.numeric(value),
                        var_code,var_name)
              
                          
              BAA <- data.frame(fredr(series_id = 'BAA',
                                        frequency="q", 
                                        aggregation='avg'), 
                                  var_name="Moody's Seasoned Baa Corporate Bond Yield",
                                  var_code="riskrate")  
                
              BAA <-transmute(BAA, period=ymd(date),
                          value=as.numeric(value),
                          var_code,var_name)

# Combine to raw data              
rawdata <- 
                bind_rows(conso,df,shortrate,WILL5000IND,BAA) %>%
                filter(year(period) >= 1945)

var_names <- unique(rawdata$var_name)
var_names <- gsub("Expenditures,.*","",var_names) %>% unique()
maxDate <- 
  rawdata %>% 
  group_by(var_code) %>% 
  summarize(maxdate=max(period)) %>% 
  arrange(maxdate)
kable(maxDate)

minmaxDate <- min(maxDate$maxdate)
rawdata %<>% filter(period <= minmaxDate) %>% select(-var_name)
# Export raw data
rawdata %>%
  spread(var_code,value) %>%
  write.csv(file = "US_CMR_rawdata.csv", row.names= FALSE)

# Make CMR data and transformations
US_CMR_data <- 
  rawdata %>%
  spread(var_code,value) %>% 
  transmute(period,
            gdp_rpc=1e+9*gdp/(1000*pop),
            conso_rpc=1e+9*(conso_nd+conso_s)/(1000*pop),
            inves_rpc=1e+9*(inves+conso_d)/(1000*pop),
            defgdp = defgdp/100,
            wage_rph=wage/defgdp,
            hours_pc=1e+9*hours/(1000*pop),
            pinves_defl=definves/defgdp,
            loans_nfc_rpc=1e+9*loans_nfc/(1000*pop)/defgdp,
            loans_hh_rpc=1e+9*loans_hh/(1000*pop)/defgdp,
            houseprice_defl=houseprice/defgdp,
            networth_rpc=1e+9*networth/(1000*pop)/defgdp,
            re=shortrate/100,
            slope=(longrate - shortrate)/100,
            creditspread=(riskrate - longrate)/100)

# Export CMR data
US_CMR_data %>%
  mutate(period=gsub(" ","",as.yearqtr(as.Date(period)))) %>%
  write.csv("US_CMR_data.csv", row.names=FALSE)
