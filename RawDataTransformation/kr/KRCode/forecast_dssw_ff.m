clear
clear global
format compact

load data  

ErrCount1 = [];

for i=90:110
    for j=1:4
                 
       display([num2str(i),'q',num2str(j)])
       load(['ff/',num2str(i),'q',num2str(j),'/results.mat']);
       
       % Initializes variables 
       fcst_options.replic  = 7;               % nr of draws for future shocks
       fcst_options.periods = 24;              % forecast horizon
       nrep                 = fcst_options.replic;
       h                    = fcst_options.periods+1;  
             
       % reads MH settings
       load(['ff/',num2str(i),'q',num2str(j),'/dssw_ff_mh_history.mat']);
       npar = estim_params_.nvx + estim_params_.nvn + estim_params_.ncx + estim_params_.ncn + estim_params_.np;
       draw_.mh_nblck      = options_.mh_nblck;
       draw_.NumberOfDraws = sum(record.MhDraws(:,1))-floor(options_.mh_drop*sum(record.MhDraws(:,1)));
       draw_.fname         = ['ff/',num2str(i),'q',num2str(j),'/dssw_ff'];
       draw_.FirstLine     = record.KeepedDraws.FirstLine; 
       draw_.FirstMhFile   = record.KeepedDraws.FirstMhFile; 
       draw_.MAX_nruns     = ceil(options_.MaxNumberOfBytes/(npar+2)/8);
       
       % Forecast is calculated for every k-th step
       k = 20*4;
       
       % some parameters
       h  = fcst_options.periods+1;     % max forecast horizon
       n  = draw_.mh_nblck;
       m  = floor(draw_.NumberOfDraws/k);
       
       % initializes matices for unconditional forecasts
       f.FedFunds = NaN(h,n*m*nrep); f.dlnC   = NaN(h,n*m*nrep); f.dlnY  = NaN(h,n*m*nrep); 
       f.dlnI     = NaN(h,n*m*nrep); f.lnL    = NaN(h,n*m*nrep); f.dlnw  = NaN(h,n*m*nrep); 
       f.dlnP     = NaN(h,n*m*nrep); f.Spread = NaN(h,n*m*nrep); f.dlnDn = NaN(h,n*m*nrep);
       
       % LOOP for MH draws
       
       for ChainNumber = 1:n
            for DrawNumber  = 1:m
       
               % draw from posterior distribution of theta
               fcst_options.parameter_set = ParamPosteriorDraw(draw_, ChainNumber, DrawNumber*k);
               place = (DrawNumber-1+(ChainNumber-1)*m)*nrep + 1:(DrawNumber+(ChainNumber-1)*m)*nrep;
               
               % unconditional DSGE forecasts 
               try
                    [fmean fdraws] = generate_forecast_uncond(fcst_options);
               catch
                    ErrCount1 = [ErrCount1; i j ChainNumber DrawNumber];
               end
               
               % collects forecasts for all draws
               f.FedFunds(:, place)  = fdraws.FedFunds; f.dlnC(:, place)    = fdraws.dlnC;
               f.dlnY(:, place)      = fdraws.dlnY;     f.dlnI(:, place)    = fdraws.dlnI;
               f.lnL(:, place)       = fdraws.lnL;      f.dlnw(:, place)    = fdraws.dlnw;
               f.dlnP(:, place)      = fdraws.dlnP;     f.Spread(:, place)  = fdraws.Spread;
               f.dlnDn(:, place)     = fdraws.dlnDn;
               
                           
            end                           
       end
       
       % saves forecast draws
       save(['ff/',num2str(i),'q',num2str(j),'/forecasts.mat'], 'f');  
    end
end
       
 




