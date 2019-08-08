% A script to calculate:
% forecasts
% actuals
% PITs
% Predictive Likelihood
% for all variables and methods

% The results are saved in file ALLfct.mat

clear
clc
format compact

% loads actuals
load(['data']);
H  = 24;                   % forecast horizon
T  = 164;                  % total number of observations
T0 = 80;                   % observation for 90q1
varnames = [{'FedFunds'}; {'dlnY'}; {'dlnP'}; {'dlnC'}; {'dlnI'}; {'dlnw'}; {'lnL'}];
%mdlnames = ['noff'; 'ff  '; 'hh  '];
mdlnames = [{'noff'} {'ff'} {'hh'}];
N        = size(varnames,1);      % number of variables

for m = 1:3 % loop for models
    %model = deblank(mdlnames(m,:)); 
    model = mdlnames{m};
            
    % initializes matrices for growth rates and levels
    for n = 1:N
        vnm = varnames{n};
        eval(['ALLfct{m}.',vnm,'.fct    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.act    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.pit    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.pLL    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.fctStd = NaN(T-T0,H);'])
    end
    
    for n = 2:6
        vnm = varnames{n};
        vnm = vnm(2:end);
        eval(['ALLfct{m}.',vnm,'.fct    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.act    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.pit    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.pLL    = NaN(T-T0,H);'])
        eval(['ALLfct{m}.',vnm,'.fctStd = NaN(T-T0,H);'])
    end
    
    % main loop for each periods loads draws and calculates forecasts,
    % actuals, predictive Likelihhod and PITs
    for i = 90:110
    for j = 1:4
        display([num2str(i),'q',num2str(j)])
        
        Tf    = T0 + 4*(i-90) + (j-1);                                % moment of forecast formulation
        fname = [model,'/',num2str(i),'q',num2str(j),'/forecasts.mat'];  
        load(fname);                                                  % loads forecast draws  
        
        % loop for oryginal variables
        for n = 1:N 
            vnm = varnames{n};
            eval(['draws=f.',vnm,';']); draws = draws(2:H+1,:);     % forecast draws
            fct      = (mean(draws,2))';                                      % point forecasts (mean)
            fctStd   = (std(draws,0,2))';                                     % stand. dev. of density forecasts
            pit      = NaN(1,H);                                              % probability integral transform
            pLL      = NaN(1,H);                                              % log Scores
            act      = NaN(1,H);                                              % actuals
                  
            % chack if actuals exists
            Hf    = H;
            if Tf+H > T; Hf = T-Tf; end
            for h = 1:Hf
                eval(['act(h)=',vnm,'(Tf+h);']); 
                pit(h)    = PIT(draws(h,:),act(h));
                pLL(h)    = PredLL(draws(h,:),act(h));
            end
            eval(['ALLfct{m}.',vnm,'.fct(Tf-T0+1,:)    = fct;'])
            eval(['ALLfct{m}.',vnm,'.act(Tf-T0+1,:)    = act;'])
            eval(['ALLfct{m}.',vnm,'.pit(Tf-T0+1,:)    = pit;'])
            eval(['ALLfct{m}.',vnm,'.pLL(Tf-T0+1,:)    = pLL;'])
            eval(['ALLfct{m}.',vnm,'.fctStd(Tf-T0+1,:) = fctStd;'])
        end
        
        %loop for levels
        for n = 2:6 
            vnm = varnames{n};
            eval(['draws=f.',vnm,';']); draws = draws(2:H+1,:);     % forecast draws
            draws = cumsum(draws,1);
            fct   = (mean(draws,2))';                                      % point forecasts (median)
            fctStd   = (std(draws,0,2))';                                  % stand. dev. of density forecasts
            pit   = NaN(1,H);                                              % probability integral transform
            pLL   = NaN(1,H);                                              % log Scores
            act   = NaN(1,H);                                              % actuals
            % check if actuals exists
            Hf    = H;
            if Tf+H > T; Hf = T-Tf; end
            for h = 1:Hf
                eval(['act(h)=',vnm,'(Tf+h);']); 
            end
            act = cumsum(act);
            for h = 1:Hf    
                pit(h)   = PIT(draws(h,:),act(h));
                pLL(h)   = PredLL(draws(h,:),act(h));
            end
            vnm = vnm(2:end);
            eval(['ALLfct{m}.',vnm,'.fct(Tf-T0+1,:)    = fct;'])
            eval(['ALLfct{m}.',vnm,'.act(Tf-T0+1,:)    = act;'])
            eval(['ALLfct{m}.',vnm,'.pit(Tf-T0+1,:)    = pit;'])
            eval(['ALLfct{m}.',vnm,'.pLL(Tf-T0+1,:)    = pLL;'])
            eval(['ALLfct{m}.',vnm,'.fctStd(Tf-T0+1,:) = fctStd;'])
        end
    end
    end
end


% PART 2. Multivariate forecasts

varnames1 = [{'FedFunds'}; {'lnY'}; {'lnP'}; {'lnC'}; {'lnI'}; {'lnw'}; {'lnL'}];
for m = 1:3
    model = mdlnames{m};
    % model = deblank(mdlnames(m,:)); 
    
    MULTIfct{m}.v3.fct = NaN(T-T0,3,H);   MULTIfct{m}.v7.fct = NaN(T-T0,7,H);
    MULTIfct{m}.v3.act = NaN(T-T0,3,H);   MULTIfct{m}.v7.act = NaN(T-T0,7,H);
    MULTIfct{m}.v3.pLL = NaN(T-T0,H);     MULTIfct{m}.v7.pLL = NaN(T-T0,H);

    % reads individual forecasts and actuals from ALLfct
    for n = 1:7
        vnm = varnames1{n};
        eval(['fct = ALLfct{m}.',vnm,'.fct;'])
        eval(['act = ALLfct{m}.',vnm,'.act;'])
        
        if n < 4
            MULTIfct{m}.v3.fct(:,n,:) = fct;
            MULTIfct{m}.v3.act(:,n,:) = act;
        end
        
        MULTIfct{m}.v7.fct(:,n,:) = fct;
        MULTIfct{m}.v7.act(:,n,:) = act;
    end
    
    % Calculates predictive Likelihhod with Adolfson-Linde method
    for i = 90:110
    for j = 1:4
        display([num2str(i),'q',num2str(j)])
        
        Tf      = T0 + 4*(i-90) + (j-1);
        fname   = [model,'/',num2str(i),'q',num2str(j),'/forecasts.mat'];  
        load(fname);  % loads forecast draws  
        Ndraws  = size(f.FedFunds,2);
        
        drawsALL = NaN(Ndraws,7,H);
                        
        for n = 1:7
            vnm      = varnames{n};
            eval(['draws=f.',vnm,';']); draws = draws(2:H+1,:);     % forecast draws
            if (n > 1 && n < 7) 
                draws = cumsum(draws,1);
            end
            drawsALL(:,n,:) = draws'; 
        end
        
        % chack if actuals exists
        pLL3  = NaN(H,1); pLL7  = NaN(H,1);
        Hf    = H; 
        if Tf+H > T; Hf = T-Tf; end
        for h = 1:Hf
            % three vars
            draws     = drawsALL(:,1:3,h);
            act       = MULTIfct{m}.v3.act(Tf-T0+1,1:3,h); act = act';
            pLL3(h)   = PredLL(draws , act);
            % seven vars
            draws     = drawsALL(:,1:7,h);
            act       = MULTIfct{m}.v7.act(Tf-T0+1,1:7,h); act = act';
            pLL7(h)   = PredLL(draws , act);
        end
        
        MULTIfct{m}.v3.pLL(Tf-T0+1,:) = pLL3;
        MULTIfct{m}.v7.pLL(Tf-T0+1,:) = pLL7;
    end
    end
end



save('ALLfct.mat', 'ALLfct', 'MULTIfct');    






   


