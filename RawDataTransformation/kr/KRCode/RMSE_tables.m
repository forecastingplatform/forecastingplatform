
clear
load('ALLfct.mat');

% modelNames = [{'noff'} {'ff'} {'hh'} {'p110'} {'p101'} {'p011'} {'p111'}];
varNames = fieldnames(ALLfct{1});
M        = size(modelNames,2);
N        = size(varNames,1);   % number of variables
H        = 24;                 % forecast horizon

% Enter observations you want to include in calculating
% ME and RMSE (MEp and RMSEp require no intervals)
% Full evaluation sample from 81 to 164
% t=1 stands for 1970:1, t=81 for 1990:1 etc
% Obs = 81:164; for full sample 1990:1-2010:4
% Obs = 81:151;  for 1990:1-2007:3
% Obs = 152:164; for 2007:4-2010:4

Obs   = 152:164;            

for n=1:N
    vnm     = varNames{n};
    ME      = NaN(M,H);
    MEp     = NaN(M,H);
    RMSE    = NaN(M,H);
    RMSEp   = NaN(M,H);
            
    for m = 1:M
    eval(['y  = ALLfct{m}.', vnm ,';'])
    eval(['y0 = ALLfct{1}.', vnm ,';'])                       % benchmark model (for DM statistic)
    fct        = y.fct;      fct0   = y0.fct;                 % forecasts
    act        = y.act;      act0   = y0.act;                 % actuals
    err        = act - fct;  err0   = act0 - fct0;            % forecast errors
    
    if act ~= act0
        display('Problem with actuals')
    end
    
    % statistics
    % Unbiasedness test for HO: ME(h)=0
    for h = 1:H
        ObsTemp      = Obs-(79+h);
        ObsTemp      = ObsTemp(ObsTemp>0);           % only positive indices
        x            = err(ObsTemp,h); x = x(~isnan(x));
                
        ME(m,h)      = mean(x);
        RMSE(m,h)    = sqrt(mean(x.^2));
        
        temp      = NeweyWestSE(x);
        MEp(m,h)  = temp.prob;
        
        a          = act(ObsTemp,h);             
        f0         = fct0(ObsTemp,h); f0 = f0(~isnan(a));
        f1         = fct(ObsTemp,h);  f1 = f1(~isnan(a));  
        a          = a(~isnan(a)); 
        temp       = DMtest(f0, f1, a, 'DM'); 
        RMSEp(m,h) = temp.prob;
        
    end
        
    end
    eval(['stat.',vnm,'.ME   = ME;']);
    eval(['stat.',vnm,'.MEp  = MEp;']);
    eval(['stat.',vnm,'.RMSE = RMSE;']);
    eval(['stat.',vnm,'.RMSEp  = RMSEp;']);
        
    horiz = [1 2 3 4 6 8 12 16 24];
    
    xlswrite('stats', {'Mean Error'},            vnm, 'A1');
    xlswrite('stats', horiz         ,            vnm, 'B1');
    xlswrite('stats', modelNames'  ,             vnm, 'A2');
    xlswrite('stats', ME(:,horiz)   ,            vnm, 'B2');
    
    xlswrite('stats', {'Mean Error prob'},       vnm, ['A' num2str(M+3)]);
    xlswrite('stats', modelNames'  ,             vnm, ['A' num2str(M+4)]);
    xlswrite('stats', MEp(:,horiz)      ,        vnm, ['B' num2str(M+4)]);
    
    xlswrite('stats', {'RMSE'},                  vnm, ['A' num2str(2*M+5)]);
    xlswrite('stats', modelNames'  ,             vnm, ['A' num2str(2*M+6)]);
    xlswrite('stats', RMSE(:,horiz)      ,       vnm, ['B' num2str(2*M+6)]);
    
    xlswrite('stats', {'DM prob'},               vnm, ['A' num2str(3*M+7)]);
    xlswrite('stats', modelNames'  ,             vnm, ['A' num2str(3*M+8)]);
    xlswrite('stats', RMSEp(:,horiz)      ,      vnm, ['B' num2str(3*M+8)]);
  
end

% Multivariate measures of point forecast accuracy

logOmega3   = NaN(M,H);
logOmega7   = NaN(M,H);

for m = 1:M
    fct3  = MULTIfct{m}.v3.fct;      fct7   = MULTIfct{m}.v7.fct;                 % forecasts
    act3  = MULTIfct{m}.v3.act;      act7   = MULTIfct{m}.v7.act;                 % actuals
    err3  = act3 - fct3;             err7   = act7 - fct7;                        % forecast errors
    
    % covariance matrix
    for h = 1:H
        ObsTemp      = Obs-(79+h);
        ObsTemp      = ObsTemp(ObsTemp>0); 
        
        logOmega3(m,h)   = log(det(nancov(err3(ObsTemp,:,h))));
        logOmega7(m,h)   = log(det(nancov(err7(ObsTemp,:,h))));
    end
end
stat.v3.logOmega = logOmega3; 
stat.v7.logOmega = logOmega7; 

horiz = [1 2 3 4 6 8 12 16 24];


xlswrite('stats', {'Multivariate point forecasts'},   'v3', 'A1');
xlswrite('stats', horiz         ,                     'v3', 'B1');
xlswrite('stats', modelNames'  ,                      'v3', 'A2');
xlswrite('stats', logOmega3(:,horiz)   ,              'v3', 'B2');    

xlswrite('stats', {'Multivariate point forecasts'},   'v7', 'A1');
xlswrite('stats', horiz         ,                     'v7', 'B1');
xlswrite('stats', modelNames'  ,                      'v7', 'A2');
xlswrite('stats', logOmega7(:,horiz)   ,              'v7', 'B2'); 


%save('ALLfct.mat', 'stat', '-append');   
    