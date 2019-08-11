%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basics.zone='us';
basics.modelzone='USMODELS\';
basics.currentpath = cd;
cd ..
basics.thispath = cd;
cd(basics.currentpath)
% keyboard
basics.models = basics.models;

basics.colorvector = char('g','b','c','m','k','g','b','c','m','k',...
    'g','b','c','m','--k','--g','--b','--c','--m','--k');

basics.markervector = char('ks','ko','kd','kh','kx');

basics.markervector1 = char('-ks','-ko','-kd','-kh','-kx');
cd([basics.thispath '\MODELS\']);
save variables basics basics

for m = 1:size(basics.chosenmodels,2)
    if basics.chosenmodels(m)
        basics.currentmodel = deblank(basics.models(m,:)); %Get the name of the model
        cd([basics.thispath '\MODELS\' basics.currentmodel]); % go to subfolder
        try
            basics.model_observables = basics.model_observables(m,:);
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
        if (strcmp(basics.currentmodel,'BVAR_MP')  +strcmp(basics.currentmodel,'BVAR_GLP')) == 0
            for vint = 1:size(basics.vintage,1)
                a = basics.vintage(vint,:);
                copyfile([deblank(basics.models(m,:)) '.mod'],[deblank(basics.models(m,:)) '_' a])
                try
                    copyfile([deblank(basics.models(m,:)) '_steadystate.m'],[deblank(basics.models(m,:)) '_' a]);
                catch
                end
                try
                    aa = ls(pwd);
                    for iaa = 3: size(aa,1)
                        if strcmp(deblank(aa(iaa,:)),[deblank(basics.models(m,:)) '_' a])
                        else
                                           copyfile(deblank(aa(iaa,:)),[deblank(basics.models(m,:)) '_' a]);
                        end
                    end
                catch
                end
            end
            for  vint = 1:size(basics.vintage,1)
                a = basics.vintage(vint,:);
                cd([deblank(basics.models(m,:)) '_' a]);
                movefile([deblank(basics.models(m,:)) '.mod'],[deblank(basics.models(m,:)) '_' a '.mod'])
                try
                    movefile([deblank(basics.models(m,:)) '_steadystate.m'],[deblank(basics.models(m,:)) '_' a '_steadystate.m'])
                catch
                end
                cd ..
            end
        end
        cd ../
        save('variables.mat','basics','-append')
        % Estimation
        basics.benchmarknr = 1;%number of benchmark
        for vintagenr = 1:size(basics.vintage,1)
            basics.vintagenr = vintagenr; % need to save the loopnumbers as dynare clears everything
            save variables basics
            if ~isempty(find(basics.chosenmodels == 1))
                if (strcmp(basics.currentmodel,'BVAR_MP')  +strcmp(basics.currentmodel,'BVAR_GLP')) == 0
                    
                    if (find(basics.EstimationMethod == 1) == 2)  % Bayesian Mode Estimate
                        if vintagenr == 1
                            try
                                rmdir([basics.currentmodel '\modeforecast'],'s')
                            catch
                            end
                            mkdir([basics.currentmodel '\modeforecast']); %content not overwritten after multiple runs
                        end
                        
                        cd(basics.currentpath)
                        
                        eval([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) ' = modeestimate(basics);']); % function for the estimation
                        
                        cd ../.. %cd([basics.thispath '\MODELS']);
                        
                        load variables
                        
                        cd([basics.thispath '\MODELS\' basics.currentmodel '\modeforecast']);
                        
                        eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ';']); % save results
                        
                        %% Setting up output names                          
                        basics.foldername = basics.currentmodel;
                        if basics.rev 
                            basics.foldername = [ basics.foldername '_RD']; % Revised date was used
                        else
                            basics.foldername = [ basics.foldername '_RT']; % Real time date was used
                        end
                         
                        if basics.expseriesvalue 
                            basics.foldername = [ basics.foldername '_EW']; % Expanding windows were used
                        else
                            basics.foldername = [ basics.foldername '_RW']; % Rolling windows were used
                        end 
                                
%                         if basics.inspf
%                             basics.foldername = [ basics.foldername '_spfnc']; % SPF nowcastings were used
%                         end
                        if basics.fnc
                            basics.foldername = [ basics.foldername '_fnc']; % Financial variable real time were included in nowcasts 
                        end
                      
                        if basics.vintagenr  == 1
                            try
                                rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_modeforecast'],'s')
                                rehash
                            catch
                            end
                            mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_modeforecast'])
                        end             
                        %%
                        if basics.inspf
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_modeforecast\' basics.currentmodel '_spfnc_' num2str(basics.vintage(basics.vintagenr,:))];
                        elseif basics.fnc
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_modeforecast\' basics.currentmodel '_fnc_' num2str(basics.vintage(basics.vintagenr,:))];
                        else
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_modeforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))];
                        end
                        %forecast mean
                        eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                        eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                        eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                        
                        xlswrite([filename '.xls'],...
                            [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                        
                        %forecast median
                        eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                        eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                        eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                        
                        xlswrite(filename,...
                            [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Median')
                        
                        cd('..\..');
                    elseif (find(basics.EstimationMethod == 1) == 3) % Bayesian Metropolis-Hastings Estimate
                        
                        if vintagenr == 1
                            try
                                rmdir([basics.currentmodel '\MHforecast'],'s')
                            catch
                            end
                            mkdir([basics.currentmodel '\MHforecast']); %content not overwritten after multiple runs
                           
                        end
                        
                        cd(basics.currentpath)
                        
                        eval([deblank(basics.models(m,:)) '_' num2str(basics.vintage(basics.vintagenr,:)) ' = MHestimate(basics);']); % function for the estimation
                        
                        cd ../..                        
                        load variables
                        
                        cd([basics.thispath '\MODELS\' basics.currentmodel '\MHforecast']);
                        
                        eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_forecast '...
                            basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) ';']); % save results
                        
                        %forecast mean
                        eval(['xgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.xgdp_a_obs;']);
                        eval(['pgdp_a_obsf_mean = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.pgdp_a_obs;']);
                        eval(['rff_a_obsf_mean  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.rff_a_obs;']);
                        %% Setting up output names                          
                        basics.foldername = basics.currentmodel;
                        if basics.rev 
                            basics.foldername = [ basics.foldername '_RD']; % Revised date was used
                        else
                            basics.foldername = [ basics.foldername '_RT']; % Real time date was used
                        end
                         
                        if basics.expseriesvalue 
                            basics.foldername = [ basics.foldername '_EW']; % Expanding windows were used
                        else
                            basics.foldername = [ basics.foldername '_RW']; % Rolling windows were used
                        end 
                      %%

                        if basics.inspf
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_MHforecast\' basics.currentmodel '_spfnc_' num2str(basics.vintage(basics.vintagenr,:))];
                        elseif basics.fnc
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_MHforecast\' basics.currentmodel '_fnc_' num2str(basics.vintage(basics.vintagenr,:))];
                        else
                            filename = [basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_MHforecast\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))];
                        end
                        if basics.vintagenr == 1
                        try
                                rmdir([basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_MHforecast'],'s')
                        catch
                        end
                        
                            mkdir([basics.thispath '\OUTPUT\' basics.modelzone basics.foldername '_MHforecast'])
                        end    
                        
                        xlswrite(filename,...
                            [{'xgdp_a_obsf','pgdp_a_obsf','rff_a_obsf'};num2cell([xgdp_a_obsf_mean pgdp_a_obsf_mean rff_a_obsf_mean])],'Mean')
                        
                        %forecast median
                        eval(['xgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.xgdp_a_obs;']);
                        eval(['pgdp_a_obsf_median = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.pgdp_a_obs;']);
                        eval(['rff_a_obsf_median  = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Median.rff_a_obs;']);
                        
                        xlswrite(filename,...
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
                        xlswrite(filename,...
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
                    
                    %Point forecasts - Densities
                    
                    
                    tableheaders=[];
                    fc_names =  {'xgdp_a_obsf';'pgdp_a_obsf';'rff_a_obsf'}; var_names =  {'xgdp_a_obs';'pgdp_a_obs';'rff_a_obs'};
                    
                    for j = 1:size(fc_names,1)
                        for i = 1:9
                            eval([cell2mat(fc_names(j,:)) '_Distribution(:,' num2str(i) ') = ' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:)) '.Mean.' cell2mat(var_names(j,:)) '+ norminv(' num2str(i/10) ',0,1)* sqrt(' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))  '.Var.' cell2mat(var_names(j,:)) ');']);
                            tableheaders = [tableheaders {[cell2mat(fc_names(j,:)) ' ' num2str(i*10),'th percentile']}];
                        end
                    end
                    xlswrite([basics.thispath '\OUTPUT\' basics.modelzone basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))],...
                        [tableheaders ;num2cell([xgdp_a_obsf_Distribution pgdp_a_obsf_Distribution rff_a_obsf_Distribution])],'Distribution')
                    
                    cd('..\..');
                elseif strcmp(basics.currentmodel,'BVAR_GLP')
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
                    
                end
                
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Load the Benchmark
            
            cd([basics.thispath '\MODELS'])
            
            if basics.hvd
                global M_ oo_ options_ bayestopt_ estim_params_
                cd(basics.currentmodel + "//" + basics.currentmodel + "_" + basics.vintage(basics.vintagenr,:));
                var_list_ = char('rff_q_obs', 'pgdp_q_obs', 'xgdp_q_obs');
                options_.no_graph.shock_decomposition = 1;
                hvd = shock_decomposition(M_, oo_, options_, '', bayestopt_, estim_params_);
                var_names = ["xgdp_q_obs", "pgdp_q_obs", "rff_q_obs"];
                var_locations = zeros(1,3);
                for all_var_index = 1:size(M_.endo_names, 1)
                    all_var_name = convertCharsToStrings(M_.endo_names(all_var_index, :));
                    for var_index = 1:3
                        if startsWith(all_var_name, var_names(var_index))
                            var_locations(var_index) = all_var_index;
                        end
                    end
                end
                hvd = hvd.shock_decomposition(var_locations, :, :);
                save hvd hvd;
                cd([basics.thispath '\MODELS']);
            end
            
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
