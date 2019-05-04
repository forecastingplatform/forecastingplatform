
% initializations:

nvint=size(MMBEST.Identifier,1);
basics.estimateModel = ones(1,nvint);
basics.numchains     = MMBEST.numchains;
basics.chainslength  = MMBEST.chainslength;
basics.numburnin     = MMBEST.numburnin;
basics.acceptance    = MMBEST.acceptance;
basics.EstimationMethod=MMBEST.EstimationMethod;
basics.windowlength  = MMBEST.windowlength;
basics.spf           = MMBEST.spf;
basics.forecasthorizon = MMBEST.horizon;
basics.chosenmodels    = MMBEST.chosenmodels;
basics.NumberModel     = size(MMBEST.chosenmodels,2);
basics.thispath0       = MMBEST.thispath0;
basics.deletefiles     = MMBEST.deletefiles;
basics.DataArea          = MMBEST.DataArea;
basics.plots           = MMBEST.plots;
basics.computeRMSE     = MMBEST.rmse;
basics.datalocation    = MMBEST.datalocation;
basics.vintage         = MMBEST.Identifier;
basics.benchmarkvintage= MMBEST.IdentifierBenchmark;
basics.IndVec          = MMBEST.IndVec;
basics.variables       = MMBEST.variables;
basics.observables     = MMBEST.observables;
basics.inspf           = MMBEST.inspf;
basics.region          = MMBEST.region;
basics.statistics      = MMBEST.statistics;
basics.densitymodel    = MMBEST.densitymodel;
basics.yearfirstvintfc = MMBEST.yearfirstvintfc;
basics.yearlastvintfc  = MMBEST.yearlastvintfc;
basics.quarterfirstvintfc = MMBEST.quarterfirstvintfc;
basics.quarterlastvintfc  = MMBEST.quarterlastvintfc;
basics.modelvars       = MMBEST.modelvars;
basics.bvarmpriors     = MMBEST.bvarmpriors;
basics.bvarNdraws      = MMBEST.bvarglpdraws; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if basics.region(find(basics.chosenmodels>0))==2
    basics.zone='ea';
    basics.modelzone='EAMODELS\';
else
    basics.zone='us';
    basics.modelzone='USMODELS\';
end
basics.currentpath = cd;
cd ..
basics.thispath = cd;
cd(basics.currentpath)

basics.models = MMBEST.models;

basics.colorvector = char('g','b','c','m','k','g','b','c','m','k',...
    'g','b','c','m','--k','--g','--b','--c','--m','--k');

basics.markervector = char('ks','ko','kd','kh','kx');

basics.markervector1 = char('-ks','-ko','-kd','-kh','-kx');
cd([basics.thispath '\MODELS\']);
save('variables.mat','basics','MMBEST','-append')

for m = 1:basics.NumberModel

    if basics.chosenmodels(m)
        
        basics.currentmodel = deblank(basics.models(m,:));
        
        cd([basics.thispath '\MODELS\' basics.currentmodel]); % go to subfolder
       try
        basics.model_observables = MMBEST.model_observables(m,:);
       catch
       end
        % generate folders and duplicate mod-files for all vintages
        a = ls([basics.thispath '\MODELS\' basics.currentmodel]);
        
        for ii = 1:size(a,1)
            if strmatch([basics.currentmodel '_'],a(ii,:))
                try
                    rmdir([basics.thispath '\MODELS\' basics.currentmodel '\' a(ii,:)],'s')
                    rehash
                catch
                end
            end
        end
        NamesFolder = [];
  
        for vint = 1:size(basics.vintage,1)
            a = basics.vintage(vint,:); 
            NamesFolder = [NamesFolder;[deblank(basics.models(m,:)) '_' a]]; 
            mkdir([deblank(basics.models(m,:)) '_' a])
        end
        if (strcmp(basics.currentmodel,'BVAR_MP')  +strcmp(basics.currentmodel,'BVAR_GLP') + strcmp(basics.currentmodel,'GVAR')) == 0
        for vint = 1:size(basics.vintage,1)
            a = basics.vintage(vint,:);
            copyfile([deblank(basics.models(m,:)) '.mod'],[deblank(basics.models(m,:)) '_' a])
        end
        for  vint = 1:size(basics.vintage,1)
            a = basics.vintage(vint,:);
            cd([deblank(basics.models(m,:)) '_' a]);
            movefile([deblank(basics.models(m,:)) '.mod'],[deblank(basics.models(m,:)) '_' a '.mod'])
            cd ..            
        end
        end
        cd ../
        save('variables.mat','basics','-append')
        % Estimation
        basics.benchmarknr = 1;%number of benchmark
        for vintagenr = 1:size(basics.vintage,1)
            basics.vintagenr = vintagenr; % need to save the loopnumbers as dynare clears everything
            save('variables.mat','basics','-append')
            if ~isempty(find(basics.chosenmodels == 1))
             if (strcmp(basics.currentmodel,'BVAR_MP')  +strcmp(basics.currentmodel,'BVAR_GLP') + strcmp(basics.currentmodel,'GVAR'))== 0
                 
               if (find(basics.EstimationMethod == 1) == 1)      % Maximum Likelihood
                   if vintagenr == 1
                        try
                            rmdir([basics.currentmodel '\MLforecast'],'s')
                        catch
                        end
                        mkdir([basics.currentmodel '\MLforecast']); %content not overwritten after multiple runs
                        try
                            rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MLforecast'],'s')
                            rehash
                        catch
                        end
                        mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MLforecast'])
                    end
                    
                    cd(basics.currentpath)
                    
                    eval([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) ' = MLestimate(basics);']); % function for the estimation
                    
                    cd([basics.thispath '\MODELS']);
                    
                    load variables
                    
                    cd([basics.thispath '\MODELS\' basics.currentmodel '\MLforecast']);
                    
                    eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ';']); % save results
                    %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MLforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    
                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MLforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')
                    
                    cd('..\..');
                elseif (find(basics.EstimationMethod == 1) == 2)  % Bayesian Mode Estimate
                    if vintagenr == 1
                        try
                            rmdir([basics.currentmodel '\modeforecast'],'s')
                        catch
                        end
                        mkdir([basics.currentmodel '\modeforecast']); %content not overwritten after multiple runs
                        try
                            rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_modeforecast'],'s')
                            rehash
                        catch
                        end
                        mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_modeforecast'])
                    end
                    
                    cd(basics.currentpath)
                    
                    eval([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) ' = modeestimate(basics);']); % function for the estimation
                    
                    cd([basics.thispath '\MODELS']);
                    
                    load variables
                    
                    cd([basics.thispath '\MODELS\' basics.currentmodel '\modeforecast']);
                    
                    eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ';']); % save results
                    %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_modeforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    
                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_modeforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')
                    
                    cd('..\..');
                elseif (find(basics.EstimationMethod == 1) == 3) % Bayesian Metropolis-Hastings Estimate
                    
                    if vintagenr == 1
                        mkdir([basics.currentmodel '\MHforecast']); %content not overwritten after multiple runs
                        try
                            rmdir([basics.currentmodel '\MHforecast'],'s')
                        catch
                        end
                        mkdir([basics.currentmodel '\MHforecast']); %content not overwritten after multiple runs
                        try
                            rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MHforecast'],'s')
                        catch
                        end
                        mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MHforecast'])
                    end
                    
                    cd(basics.currentpath)
                    
                    eval([deblank(basics.models(m,:)) '_' num2str(basics.vintage(basics.vintagenr,:)) ' = MHestimate(basics);']); % function for the estimation
                    
                    cd([basics.thispath '\MODELS']);
                    
                    load variables
                    
                    cd([basics.thispath '\MODELS\' basics.currentmodel '\MHforecast']);
                    
                    eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast '...
                        basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ';']); % save results
                    
                    %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MHforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    
                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MHforecast\' basics.currentmodel '_' num2str(basics.vintage(vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')
                    
                    %Point forecasts - Densities
                    eval(['xgdp_a_obsf_Distribution = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_Distribution = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.pgdp_a_obs;']);
                    eval(['rff_a_obsf_Distribution  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.rff_a_obs;']);
                    tableheaders=[];
                    fc_names =  {'xgdp_a_obsf';'pgdp_a_obsf';'rff_a_obsf'};
                    for j = 1:size(fc_names,1)
                        for i = 1:9
                            tableheaders = [tableheaders {[cell2mat(fc_names(j,:)) ' ' num2str(i*10),'th percentile']}];
                        end
                    end                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '_MHforecast\' basics.currentmodel '_' num2str(basics.vintage(vintagenr,:))],...
                        [tableheaders ;num2cell([xgdp_a_obsf_Distribution' pgdp_a_obsf_Distribution' rff_a_obsf_Distribution'])],'Distribution')
                    
                    cd('..\..');
                end
             elseif strcmp(basics.currentmodel,'BVAR_MP')
                    %% BVAR 
                              
                        if vintagenr == 1
                            mkdir([basics.currentmodel '\BVAR_MP_forecast']); %content not overwritten after multiple runs
                            try
                                rmdir([basics.currentmodel '\BVAR_MP_forecast'],'s')
                            catch
                            end
                            mkdir([basics.currentmodel '\BVAR_MP_forecast']); %content not overwritten after multiple runs
                            try
                                rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel],'s')
                            catch
                            end
                            mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel])
                        end         
                        
                    
                        cd(basics.currentpath)
                        
                        eval([deblank(basics.models(m,:)) '_' num2str(basics.vintage(basics.vintagenr,:)) ' = BVAR_MP(basics,vintagenr);']); % function for the estimation
                        
                        %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    
                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')
                   close all
                                     
                     elseif strcmp(basics.currentmodel,'BVAR_GLP') %%GLP
                         
                        if vintagenr == 1
                            mkdir([basics.currentmodel '\BVAR_GLP_forecast']); %content not overwritten after multiple runs
                            try
                                rmdir([basics.currentmodel '\BVAR_GLP_forecast'],'s')
                            catch
                            end
                            mkdir([basics.currentmodel '\BVAR_GLP_forecast']); %content not overwritten after multiple runs
                            try
                                rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel],'s')
                            catch
                            end
                            mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel])
                        end         
            
                        cd(basics.currentpath)
                        eval([deblank(basics.models(m,:)) '_' num2str(basics.vintage(basics.vintagenr,:)) ' = BVAR_GLP(basics,vintagenr);']); % function for the estimation  
                     %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    
                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')   
               
                    
                    %Point forecasts - Densities
                    eval(['xgdp_a_obsf_Distribution = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_Distribution = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.pgdp_a_obs;']);
                    eval(['rff_a_obsf_Distribution  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Distribution.rff_a_obs;']);
                    tableheaders=[];
                    fc_names =  {'xgdp_a_obsf';'pgdp_a_obsf';'rff_a_obsf'};
                    for j = 1:size(fc_names,1)
                        for i = 1:9
                            tableheaders = [tableheaders {[cell2mat(fc_names(j,:)) ' ' num2str(i*10),'th percentile']}];
                        end
                    end                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [tableheaders ;num2cell([xgdp_a_obsf_Distribution pgdp_a_obsf_Distribution rff_a_obsf_Distribution])],'Distribution')
                    
                    cd('..\..');
                   
                    %% GVAR
                    
                    elseif strcmp(basics.currentmodel,'GVAR')
                        if vintagenr == 1
                            try
                                rmdir([basics.currentmodel '\GVAR_forecast'],'s')
                            catch
                            end
                            try
                                rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel],'s')
                            catch
                            end
                            mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel])
                        end         
                        cd(basics.currentpath) %comes back to ALGORITHMS
                        eval([deblank(basics.models(m,:)) '_' num2str(basics.vintage(basics.vintagenr,:)) ' = gvar_forecast(basics,vintagenr);']); % function for the estimation  
                     %forecast mean
                    eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.' upper(basics.zone) '.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.' upper(basics.zone) '.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.' upper(basics.zone) '.rff_a_obs;']);
                    
                    
                    eval(['xgdp_a_obsf_mean_ea = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.US.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean_ea = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.US.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean_ea  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.US.rff_a_obs;']);
                    eval(['xgdp_a_obsf_mean_us = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.EA.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_mean_us = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.EA.pgdp_a_obs;']);
                    eval(['rff_a_obsf_mean_us  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.EA.rff_a_obs;']);
                    
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean_ea pgdp_a_obsf_mean_ea rff_a_obsf_mean_ea])],'EA Mean')
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean_us pgdp_a_obsf_mean_us rff_a_obsf_mean_us])],'US Mean')

                    %forecast median
                    eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.' upper(basics.zone) '.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.' upper(basics.zone) '.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.' upper(basics.zone) '.rff_a_obs;']);
                    
                    eval(['xgdp_a_obsf_median_ea = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.EA.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median_ea = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.EA.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median_ea  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.EA.rff_a_obs;']);
                    eval(['xgdp_a_obsf_median_us = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.US.xgdp_a_obs;']);
                    eval(['pgdp_a_obsf_median_us = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.US.pgdp_a_obs;']);
                    eval(['rff_a_obsf_median_us  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.US.rff_a_obs;']);
                    
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')   
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean_ea pgdp_a_obsf_mean_ea rff_a_obsf_mean_ea])],'EA Median')   
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean_us pgdp_a_obsf_mean_us rff_a_obsf_mean_us])],'US Median')   
                      
                    cd([basics.thispath '\MODELS\' basics.currentmodel]);
                    
                    disp( ['Estimating and storing forecasts of the GVAR for vintage: ' num2str(basics.vintage(basics.vintagenr,:)) ]);
                    eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast '...
                    basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ' ;']); % save results    
             end
 
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Load the Benchmark
 
            cd([basics.thispath '\MODELS'])
        end
   
        if basics.deletefiles
            filelist = ls([basics.thispath '\MODELS\' basics.currentmodel]);
            filelist = filelist(3:end,:);
            for l = 1:size(filelist,1)
                if isempty(strmatch([basics.currentmodel '.mod'],filelist(l,:)))
                    try
                        rmdir([basics.thispath '\MODELS\' basics.currentmodel '\' filelist(l,:)],'s');
                    catch
                    end
                end
            end
        end
    end
end
cd(basics.thispath0)
