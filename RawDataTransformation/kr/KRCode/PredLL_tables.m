
clear
load('ALLfct.mat');


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
    vnm         = varNames{n};
    PredLL      = NaN(M,H);
    PredLLp     = NaN(M,H);
    fctStd      = NaN(M,H);        % standard deviation of predictive density
    
    for m = 1:M
        eval(['y  = ALLfct{m}.', vnm ,';'])
        eval(['y0 = ALLfct{1}.', vnm ,';'])                       % benchmark model (for AG statistic)
        pLL        = y.pLL;      pLL0   = y0.pLL;                 % predictive LL
             
        % statistics
        % Amisano-Giacomini test for HO: equal predictive accuracy
        for h = 1:H
            ObsTemp      = Obs-(79+h);
            ObsTemp      = ObsTemp(ObsTemp>0);           % only positive indices
            
            PredLL(m,h)     = nansum(log(pLL(ObsTemp,h)));
            fctStd(m,h)     = nanmean(y.fctStd(ObsTemp,h));
            d            = log(pLL(ObsTemp,h)) - log(pLL0(ObsTemp,h));   
            d            = d(~isnan(d));
            temp         = NeweyWestSE(d);
            PredLLp(m,h) = temp.prob; 
        end
    end
    
    eval(['stat.',vnm,'.PredLL   = PredLL;']);
    eval(['stat.',vnm,'.PredLLp  = PredLLp;']);
    eval(['stat.',vnm,'.fctStd   = fctStd;']);
        
    horiz = [1 2 3 4 6 8 12 16 24];
    
    xlswrite('stats', {'LogPredictive Density'},            vnm, 'M1');
    xlswrite('stats', horiz         ,                       vnm, 'N1');
    xlswrite('stats', modelNames'  ,                        vnm, 'M2');
    xlswrite('stats', PredLL(:,horiz)   ,                   vnm, 'N2');
    
    xlswrite('stats', {'Amisano-Giacomini Test'},           vnm, ['M' num2str(M+3)]);
    xlswrite('stats', modelNames'  ,                        vnm, ['M' num2str(M+4)]);
    xlswrite('stats', PredLLp(:,horiz)      ,               vnm, ['N' num2str(M+4)]);
    
    xlswrite('stats', {'Denisty forecast Std'},  vnm, ['M' num2str(2*M+5)]);
    xlswrite('stats', modelNames'  ,             vnm, ['M' num2str(2*M+6)]);
    xlswrite('stats', fctStd(:,horiz)      ,     vnm, ['N' num2str(2*M+6)]);
   
end


% STEP 2. Multivariate measures of point forecast accuracy

PredLL3      = NaN(M,H); PredLL7      = NaN(M,H);
PredLLp3     = NaN(M,H); PredLLp7     = NaN(M,H);

for m = 1:M
    pLL3  = MULTIfct{m}.v3.pLL;     pLL7  = MULTIfct{m}.v7.pLL;            % predictive Likelihood
    pLL30 = MULTIfct{1}.v3.pLL;     pLL70  = MULTIfct{1}.v7.pLL;            % benchmark model
    
    % statistics
    % Amisano-Giacomini test for HO: equal predictive accuracy
    for h = 1:H
        ObsTemp      = Obs-(79+h);
        ObsTemp      = ObsTemp(ObsTemp>0);           % only positive indices
            
        PredLL3(m,h)     = nansum(log(pLL3(ObsTemp,h)));
        PredLL7(m,h)     = nansum(log(pLL7(ObsTemp,h)));
            
        d      = log(pLL3(ObsTemp,h)) - log(pLL30(ObsTemp,h));   
        d      = d(~isnan(d));
        temp   = NeweyWestSE(d);
        PredLLp3(m,h) = temp.prob; 
        
        d      = log(pLL7(ObsTemp,h)) - log(pLL70(ObsTemp,h));   
        d      = d(~isnan(d));
        temp   = NeweyWestSE(d);
        PredLLp7(m,h) = temp.prob;       
    end
end
    
stat.v3.PredLL  = PredLL3; 
stat.v3.PredLLp = PredLLp3;
stat.v7.PredLL  = PredLL7; 
stat.v7.PredLLp = PredLLp7;

horiz = [1 2 3 4 6 8 12 16 24];

xlswrite('stats', {'log predictive Dens'},   'v3', 'M1');
xlswrite('stats', horiz         ,            'v3', 'N1');
xlswrite('stats', modelNames'  ,            'v3', 'M2');
xlswrite('stats', PredLL3(:,horiz)   ,       'v3', 'N2');   

xlswrite('stats', {'Amisano-Giacomini Test'},  'v3', ['M' num2str(M+3)]);
xlswrite('stats', modelNames'  ,              'v3', ['M' num2str(M+4)]);
xlswrite('stats', PredLLp3(:,horiz)      ,     'v3', ['N' num2str(M+4)]);

%xlswrite('stats', {'log predictive Dens'},   'v7', 'M1');
%xlswrite('stats', horiz         ,            'v7', 'N1');
%xlswrite('stats', modelNames'  ,            'v7', 'M2');
xlswrite('stats', PredLL7(:,horiz)   ,       'v7', 'N2');   

xlswrite('stats', {'Amisano-Giacomini Test'},  'v7', ['M' num2str(M+3)]);
xlswrite('stats', modelNames'  ,              'v7', ['M' num2str(M+4)]);
xlswrite('stats', PredLLp7(:,horiz)      ,     'v7', ['N' num2str(M+4)]);



% Saves results

%save('ALLfct.mat', 'stat', '-append'); 