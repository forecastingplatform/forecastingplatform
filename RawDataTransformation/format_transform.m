function A=format_transform(DataInfos)
%DataInfos is the tructure of information on the data format and transformation needed. s is the variable under consideration.
%the function formating is the main procedure performing data
%transformations. The function is called in the file RawDataInterface.m while the
%meaning of its arguments are commented in the initialization part of the same file.

global PGNP MMBDATA;

filename      = DataInfos.filename{:};

VintLabel     = DataInfos.VintLabel{:};

transformation= cell2mat(DataInfos.transformation);

quarterly     = DataInfos.quarterly;

obsformat     = cell2mat(DataInfos.obsformat);

vintformat    = cell2mat(DataInfos.vintformat); 

posobservation= cell2mat(DataInfos.posobservation{:});

posrelease    = cell2mat(DataInfos.posrelease{:});

trend         =DataInfos.trend;


if transformation==1 % for quarterly nominal data, compute real values before the growth rate    
    B = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly, obsformat, vintformat,  posobservation,posrelease,transformation); 
    A = real_growth(B,PGNP);
    
elseif transformation == 2 % for quarterly real data, compute real values before the growth rate
    
    B = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly, obsformat, vintformat, posobservation,posrelease,transformation);
    D = PGNP;  
    D(2:size(PGNP,1),2:size(PGNP,2)) = {1}; %for data already expressed in real terms, deflate series by one!
    A=real_growth(B,D);
    
elseif transformation == 3 % for non-revised data like interest rate, GZ-spread and so on. 
    B=format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly(1,:),...
                 obsformat(1,:), vintformat(1,:), posobservation,posrelease,transformation);    
    for q=2:size(B,1)
        if (cell2mat(B(q,2)) ~= -99)&&(cell2mat(B(q,2)) ~= -999)
            B(q,2) = {cell2mat(B(q,2))/4}; %Devided the original annually data by four to obtain quarterly series
        end
    end
    
    C = B;
    B = B(:,1);
    
    for vint = 2:size(PGNP,2) %This loop just duplicate the time series as many as we have vintages
        a = PGNP(1,vint);
        a = a{1};
        B = [B [[cell2mat(VintLabel(1,:)) a(2:end)];C(2:end,2)]];
    end
    
    A=complete_missing([B(1,:);B(3:end,:)]); % Eliminate the first observation because other variables start one observation later
    
elseif transformation == 4 % for spread  between two non-revised series: filename(1,:) minus filename(2,:)
    
    B1 = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly(1,:),obsformat(1,:), vintformat(1,:), posobservation(1:2,:),posrelease(1:3,:),transformation);
    
    B2 = format_variables(cell2mat(filename(2,:)), cell2mat(VintLabel(2,:)),quarterly(2,:),obsformat(2,:), vintformat(2,:), posobservation(3:4,:),posrelease(4:6,:),transformation);
    
    B  = spreads(B1, B2,[VintLabel(1,:) '_' VintLabel(2,:)]); %compute the spreads
    
    C = B; B = B(:,1);
    
    for vint = 2:size(PGNP,2)%This loop just duplicates the time series as many as we have vintages
        a = PGNP(1,vint);
        a = a{1};
        B = [B [[cell2mat(VintLabel(1,:)) '_' cell2mat(VintLabel(2,:)) a(2:end)];C(2:end,2)]];
    end
    
    A = complete_missing([B(1,:);B(3:end,:)]);
    
elseif transformation == 5  % for combining two series: filename(1,:) plus filename(2,:)
    
    B1 = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly(1,:), obsformat(1,:), vintformat(1,:), posobservation(1:2,:),posrelease(1:3,:),transformation); 
    B2 = format_variables(cell2mat(filename(2,:)), cell2mat(VintLabel(2,:)),quarterly(2,:), obsformat(2,:), vintformat(2,:), posobservation(3:4,:),posrelease(4:end,:),transformation); 
    
    B=B2;
    
    for vint = 2:size(B2,2)%Add the two series
        for q = 2:size(B2,1)
            if (cell2mat(B1(q,vint))>0 )*( cell2mat(B2(q,vint))>0 )
                B(q,vint) = {(cell2mat(B1(q,vint))+cell2mat(B2(q,vint)))};
            end
        end
    end
    
    B = complete_missing(B);% complete missing values by -99 or -999
    
    A = real_growth(B,PGNP);
elseif transformation==6 % for hours
    
    CE16OV = format_variables(cell2mat(filename(2,:)), cell2mat(VintLabel(2,:)),quarterly(2,:), obsformat(2,:), vintformat(2,:), posobservation(3:4,:),posrelease(4:end,:),transformation);
    
    CE16OV = CE16OV([1 3:end],:); 
    HOURS_Q = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly(1,:), obsformat(1,:), vintformat(1,:), posobservation(1:2,:),posrelease(1:3,:),transformation);
    
    HOURS_Q = HOURS_Q([1 3:end],:); HOURS_PER_CAPITA = HOURS_Q; 
    for vint = 2:size(HOURS_Q,2)%the loop deflates hours worked by the civilian employement
        for j = 2:size(HOURS_Q,1)
            if (cell2mat(HOURS_Q(j,vint))~=-999)&&(cell2mat(HOURS_Q(j,vint))~=-99)&&(cell2mat(CE16OV(j,vint))~=-999)&&(cell2mat(CE16OV(j,vint))~=-99)
                HOURS_PER_CAPITA(j,vint) = {log(cell2mat(HOURS_Q(j,vint))/cell2mat(CE16OV(j,vint)))*100};
            end
        end
    end
    
    HOURS_Q_HPTrend1 = HOURS_PER_CAPITA;
    
    HOURS_Q_HPTrend = HOURS_PER_CAPITA;
    
    for vint = 2:size(HOURS_Q_HPTrend1,2)%Extract the trend in hours per capita
        
        if ~isempty(find(cell2mat(HOURS_Q_HPTrend1(2:end,vint))~=-99))
            
            v = find(cell2mat(HOURS_Q_HPTrend1(2:end,vint))~=-99);
            
            w = HOURS_Q_HPTrend1(2:end,vint);
            
            if~isempty(find(cell2mat(w(v))~=-999))
                
                f_obs = find(cell2mat(HOURS_Q_HPTrend1(2:end,vint))==-99,1,'last')+ 2;
                
                l = find(cell2mat(HOURS_Q_HPTrend1(2:end,vint))~=-999,1,'last')+1;
                
                if isempty(l)
                    l = size(HOURS_Q_HPTrend1,1);
                end
                
                if isempty(f_obs)
                    f_obs = 2;
                end
                
                S = cell2mat(HOURS_Q_HPTrend1(f_obs:l,vint));
                
                Trend = hpfilter(S,16000);
                
                for j = 1:size(S,1) 
                    HOURS_Q_HPTrend(f_obs+j-1,vint) = {Trend(j)};                    
                end
            end
        end
    end
    
    HOURS_OBS=HOURS_Q;
    
    for vint = 2:size(HOURS_Q_HPTrend,2) %Compute the detrended series.
        for j = 2:size(HOURS_Q_HPTrend,1)
            if (cell2mat(HOURS_Q(j,vint))~=-999)&&(cell2mat(HOURS_Q(j,vint))~=-99)
                HOURS_OBS(j,vint) = {cell2mat(HOURS_PER_CAPITA(j,vint))-cell2mat(HOURS_Q_HPTrend(j,vint))};
            end
        end
    end
    
    A = HOURS_OBS;
    
elseif transformation == 7 % for quarterly nominal data, compute real values before the growth rate
    
    A=format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly,obsformat, vintformat, posobservation,posrelease,transformation);
    A=complete_missing([A(1,:);A(3:end,:)]); % Eliminate the first observation because other variables start one observation later
    
elseif transformation == 8 % for quarterly nominal data, compute real values before the growth rate
    A=format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly,obsformat, vintformat, posobservation,posrelease,transformation);
    for vint=2:size(A,2)
        for q=2:size(A,1)
            if (cell2mat(A(q,vint)) ~= -99)&&(cell2mat(A(q,vint)) ~= -999)
                A(q,vint) = {cell2mat(A(q,vint))/4}; %Devided the original annually data by four to obtain quarterly series
            end
        end
    end
elseif transformation==9 % for quarterly Real data, compute real the growth rate    
    B = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly, obsformat, vintformat,  posobservation,posrelease,transformation);  
    D = PGNP;  
    D(2:size(PGNP,1),2:size(PGNP,2)) = {1}; %for data already expressed in real terms, deflate series by one!
    A = real_log(B,D,trend,transformation);
    
elseif transformation==10 % for quarterly nominal data, compute real values before the growth rate   
    if strcmp(cell2mat(filename(1,:)),'\EARawData\WAGE')
        Wages_SW03
    else
    B = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)),quarterly, obsformat, vintformat,  posobservation,posrelease,transformation); 
    end
    A = real_log(B,PGNP,trend,transformation);
end