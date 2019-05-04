clear
warning off
current = pwd;
cd('../MODELS/')
load variables basics
modelsfold = pwd;
cd(current)
% Get a list of all files and folders in this folder.
files = dir(modelsfold);
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files( [files.isdir]);
subFolders  = subFolders(3:end,:);
% Print folder names to command window.
for k = 1 : length(subFolders)
    model{k} = [modelsfold, '\', subFolders(k).name];
    modelname{k} = subFolders(k).name;
% 	modelvint(k,:) =  dir(model{k});
%     
%     for j = 1:size(modelvint(k,:),2)
%         if (modelvint(k,j).isdir)
%             vintloc{k,j} = modelvint(k,j).name;
%         end
%     end
%     clear modelvint
end
clear files k subFoldsers dirFlags

RevisedData=['..\DATA\Forecast_eval_files\ExcelFileRev'];
lr=ls(RevisedData);lr=lr(4:end,:);
allvint=lr(:,3:7);
allvint = [allvint; '20163';'20164';'20171';'20172';'20173';'20174'];

%% Table that sets the amount of parameters in the model


nvars = {'BVAR_GLP','BVAR_MP','DSGE_TEST','NK_RW97','US_DNGS14','US_SW07';...
        [],         [],        15,        12,      32,          29};
%% INFLATION
D = []; F =[];
disp('Loading parameters:');
for mloop = 1:size(modelname,2)
        cont = ls(model{mloop});
        for jj  = 1:size(cont,1)
            if jj <3
                cont_keep(jj) = false;
            else
                cont_keep(jj) =  strcmp(cont(jj,1:size(modelname{mloop},2)+1),[ modelname{mloop} ,'_']);
            end
        end
        cont = cont(cont_keep,:);
        cont = deblank(cont);
        vint = [];
        for looper = 1:size(allvint,1)
            try
                cd([model{mloop} '\' , modelname{mloop} ,'_' ,allvint(looper,:)]);
                vint= [vint;{allvint(looper,:)}];
                try
                    vintag_exits(looper) = 1;
                    load([modelname{mloop} ,'_', (allvint(looper,:)),'_oo.mat']);
                    LL(looper)= MarginalDensityLaPlace;
                    parameters{looper} = oo_.posterior_mode.parameters;
                    density{looper}= oo_.posterior_density.parameters;
                    nvar = size(fields(oo_.posterior_mode.parameters),1);
                    pgdp_forecast{looper} = oo_.PointForecast.deciles.pgdp_q_obs;
                    xgdp_forecast{looper} = oo_.PointForecast.deciles.xgdp_q_obs;
                    disp('*');
                    clear oo_ MarginalDensityLaPlace
                catch
                    disp('.');
                    vintag_exits(looper) = 0;
                    LL(looper) = -999;
                    density{looper} =[];
                    pgdp_forecast{looper} = [];
                    xgdp_forecast{looper} = [];
                end
                cd ..
            catch
                vintag_exits(looper) = 0;
                LL(looper) = -999;
                density{looper} =[];
                pgdp_forecast{looper} =[];
                xgdp_forecast{looper} = [];
            end
        end
        
        %% Set up number of paramters in model
    if  ismember(deblank(modelname(mloop)),nvars(1,:))
        cellfind = @(string)(@(cell_contents)(strcmp(string,cell_contents)));
        logical_cells = cellfun(cellfind(deblank(modelname(mloop))),nvars(1,:));
        nvar = nvars{2,logical_cells};
    end
    %% Loop through restuls to put them in a table
        for looper = 1: size(allvint,1)
            if looper  ==1
                if  vintag_exits(looper) == 0
                    T =  cell2table(num2cell(-999*ones(1,nvar)));
                else
                    T = struct2table(parameters{1});
                end
            else

                if  vintag_exits(looper) == 0 
                    if (exist('parameters'))
                                           T.Properties.VariableNames = fields(parameters{end});

                    T  = [T; cell2table(num2cell(-999*ones(1,nvar)), 'VariableNames',fields(parameters{end})) ];
                    else
                    T  = [T; cell2table(num2cell(-999*ones(1,nvar)))];
                    end
                else
                                    
                    T  = [T;   struct2table(parameters{looper})];
                end
            end
            
        end
        
        
        D{mloop} = density;
        F{mloop} = pgdp_forecast;
        F_gdp{mloop} = xgdp_forecast;
        %     D{mloop} = cell2table(density,'VariableNames', cellstr([repmat('v',size(cont(1:end,end-4:end),1),1),char(cont(1:end,end-4:end))]));
        %     F{mloop} = cell2table(pgdp_forecast,'VariableNames', cellstr([repmat('v',size(cont(1:end,end-4:end),1),1),char(cont(1:end,end-4:end))]));
        if sum(vintag_exits) == 0
                    T = table(LL','VariableNames', {'LogLike'});
        else
                    T = [table(LL','VariableNames', {'LogLike'}), T];
        end

        T = [table(vintag_exits','VariableNames',{'VintageRan'}), T];
        T = [table(char(allvint(1:end,:)),'VariableNames', {'Vintage'}),T];
        eval([modelname{mloop} ,'= T;']);
            disp([modelname{mloop}, ' has been completed, there were '  num2str(sum(vintag_exits)) , ' vintages laoded.']) ;

        clear T vint LL optcrit optios_ M_ cont cont_keep basics data i jj  optimizationinfo  options_ parameters var_list_ vintag_exits looper density pgdp_forecast
        
end
cd(current)
cd ('..\OUTPUT\USMODELS\')
for mloop = 1:size(modelname,2)
    if i == 1
   eval(['save(''parameters.mat'', '''  modelname{mloop} ''')']);
     else
   eval(['save(''parameters.mat'',''' modelname{mloop} ''',''-append'')']); 
    end
end
cd(current)

%%  COLLECT THE REVISED VINTAGES
disp(['Parameter evaluation is finished, turning to RMSE.']) ;

RevisedData=['..\DATA\Forecast_eval_files\ExcelFileRev'];
lr=ls(RevisedData);lr=lr(4:end,:);
ListRevised=lr(:,3:7);
varnames={'xgdp_a_obs','pgdp_a_obs','rff_a_obs'};
C = {'b','y','g','c','r',[0.5 0 0.5]} ;% Cell array for colors.
str = date;
VINTAGES=[];
for y = 1980:str2num(str([8:11]))
    for q = 1:4
        a = num2str(y);
        VINTAGES = [VINTAGES;[a num2str(q)]];
    end
end
VintageSpan{1}=['19801';'20181'];%
fvint=find(strcmp(VINTAGES,{VintageSpan{1}(1,:)})==1);
lvint=find(strcmp(VINTAGES,{VintageSpan{1}(2,:)})==1);
Periods=VINTAGES(fvint:lvint,:);
b=dir(['..\OUTPUT\USMODELS']);b=b([b.isdir]);
b = b(3:end);
h = 5;
L=[];
cd('../MODELS/')
load variables basics
modelsfold = pwd;
cd(current)

%% All available vintages
Report=[];
Vintages(2,:) = {[],[],[]};
for m=1:size(b,1)
    %Start by whole sample
                disp(['RMSE is being computed for model ' b(m,:).name '. Please wait.']) ;

   for v=1:3
        Estimation{v}=[];
        Revised{v}=[];
    end
    EstimationResults=ls(['..\OUTPUT\USMODELS\' deblank(b(m,:).name)]);
    EstimationResults=EstimationResults(3:end,:);
    ListEstimatedVintages=EstimationResults(:,end-8:end-4);
    RMSEPeriods=intersect(cellstr(ListEstimatedVintages),cellstr(Periods));
    [RMSEVintages,IndexEstimated,IndexRevised]=intersect(cellstr(RMSEPeriods),cellstr(ListRevised));
    for v=1:3
        Estimation{v}=[];
        Revised{v}=[];
    end
    if ismember(m,(find(cellfun(@isempty,strfind(cellstr(b(m,:).name),'spfnc'))==0))) %%Check if the SPF nowcast has been used
        for vintnr=1:size(RMSEVintages,1)
            RevisedCurrent= xlsread( ['..\DATA\Forecast_eval_files\ExcelFileRev\us' ListRevised(IndexRevised(vintnr),:)],1);
            Forecast=xlsread(['..\OUTPUT\USMODELS\' deblank(b(m,:).name) '\' EstimationResults(IndexEstimated(vintnr),:)],basics.statistics);
            for v=1:3
                Estimation{v} =[Estimation{v} [NaN; Forecast(1:h-1,v)]];
                Revised{v}   =[Revised{v} [NaN; RevisedCurrent(1:h-1,v)]];
            end
        end
    else
        for vintnr=1:size(RMSEVintages,1)
            RevisedCurrent= xlsread( ['..\DATA\Forecast_eval_files\ExcelFileRev\us' ListRevised(IndexRevised(vintnr),:)],1);
            Forecast=xlsread(['..\OUTPUT\USMODELS\' deblank(b(m,:).name) '\' EstimationResults(IndexEstimated(vintnr),:)],basics.statistics);
            for v=1:3
                Estimation{v} =[Estimation{v} Forecast(1:h,v)];
                Revised{v}   =[Revised{v} RevisedCurrent(:,v)];
            end
        end
    end
    %% Calculate the RMSE for the whole sample
    for v=1:3
        RMSE2{v}(m,:)=(sqrt(sum((Estimation{v}(1:h,:)' - Revised{v}(1:h,:)').^2,1)/size(Revised{v}(1:h,:),2)))';
    end
    
    
    %%
    ListVintagesNotUsed=ListEstimatedVintages;
     ListVintagesNotUsed(IndexEstimated,:)=[];
    Reportm=[['Model:' deblank(b(m,:).name)],num2cell(NaN)];
    Reportm(2,:)=[{'First Vintage:'}, {ListEstimatedVintages(1,:)}];
    Reportm(3,:)=[{'Last Vintage:'}, {ListEstimatedVintages(end,:)}];
    if ~isempty(ListVintagesNotUsed)
        Reportm(4,:)=[{'Not Used Vintage:'},{ListVintagesNotUsed(1,:)}];
        for j=2:size(ListVintagesNotUsed,1)
            Reportm(j+3,:)=[num2cell(NaN),{ListVintagesNotUsed(j,:)}];
        end
    else
    j = 2;    
    end
    Reportm(j+4,:)=[num2cell(NaN),num2cell(NaN)];
    Report=[Report;Reportm];
end



%% ALL VINTAGES COLLECTING
j=0;
for v=1:3
    RMSE(j+1,:)=[{varnames{v}},num2cell(1:h)];
    for m=1:size(b,1)
        RMSE(j+2,:)=[{deblank(b(m,:).name)},num2cell(RMSE2{v}(m,:))];
        j=j+1;
    end
end


%% Write output
disp(['Creating Report file. Please wait...']) ;
cd ('../Output/USMODELS/');
xlswrite('Report_New',RMSE,['RMSE_h_' num2str(5)])
xlswrite('Report_New',Report,['Report RMSE_h_' num2str(5)])

disp(['Forecast evaluation is completed. Please consult parameter file and Report file in the OUTPUT folder.']) ;

%% Plot
 % NEED TO ADD





%% MORE CODE for posterior estimate
% RevisedData=['..\DATA\Forecast_eval_files\ExcelFileRev'];
% lr=ls(RevisedData);lr=lr(4:end,:);
% ListRevised=lr(:,3:7);
% for vint = 1:size(lr,1)
%     Revised{vint}=[];
%     RevisedCurrent{vint} = xlsread(['..\DATA\Forecast_eval_files\ExcelFileRev\' lr(vint,:)],1);
%     Revised{vint}   =[Revised{vint} RevisedCurrent{vint}];
% end


% ngridpoints= 1000; % Number of grid points for the kernel estimator
% lps_temp = [];
% FCE_temp = [];
% FCE_temp_gdp = [];
% 
% for mloop =1 :size(modelname,1)
%     tic
%     for vint  = 1:size(F{1,mloop},2)
%         for h = 1:5
%             try
%                 [f,xi]   = ksdensity(F{1,mloop}{1,vint}(:,h)*4,'npoints',ngridpoints);  %'npoints',1000
%                 temp  = abs(xi-RevisedCurrent{vint}(h,2));
%                 [loc loc]   = min(temp);
%                 FCE_temp(mloop,vint,h) = F{1,mloop}{1,vint}(5,h)*4-RevisedCurrent{vint}(h,2);
%                 FCE_temp_gdp(mloop,vint,h) = F_gdp{1,mloop}{1,vint}(5,h)*4-RevisedCurrent{vint}(h,1);
%                 lps_temp(mloop,vint,h)  = log(f(loc));
%             catch
%                 lps_temp(mloop,vint,h) = NaN;
%                 FCE_temp(mloop,vint,h) = NaN;
%                 FCE_temp_gdp(mloop,vint,h) = NaN;
%             end
%         end
%     end
%     toc
% end
% %Store the Log predictive score for the density evaluation into the table
% for mloop = 1: size(modelname,1)
%     for h = 1:5
%         eval([modelname{mloop} ,'= [', modelname{mloop}, ',table(FCE_temp(' , num2str(mloop), ',:,', num2str(h) ,')'', ''VariableNames'',{''FCE_INF_', num2str(h) ,'''})];' ]);
%         eval([modelname{mloop} ,'= [', modelname{mloop}, ',table(FCE_temp_gdp(' , num2str(mloop), ',:,', num2str(h) ,')'', ''VariableNames'',{''FCE_GDP_', num2str(h) ,'''})];' ]);
%         eval([modelname{mloop} ,'= [', modelname{mloop}, ',table(lps_temp(' , num2str(mloop), ',:,', num2str(h) ,')'', ''VariableNames'',{''LPS_', num2str(h) ,'''})];' ]);
%     end
% end
% 
% %% Log predictive score and RMSE across all vintages
% lps            = squeeze(nanmean(lps_temp,2));
% rmse           = squeeze(sqrt(nanmean(FCE_temp.^2,2)));
% rmse_gdp       = squeeze(sqrt(nanmean(FCE_temp_gdp.^2,2)));
% 
% LPS = cell2table(num2cell(lps'),'VariableNames', modelname);
% RMSE = cell2table(num2cell(rmse'),'VariableNames', modelname);
% RMSE_GDP = cell2table(num2cell(rmse_gdp'),'VariableNames', modelname)
% %% RMSE across vintages that are complete
% FCE_match =[];
% for vint = 1: size(allvint,1)
%     for h = 1:5
%         if (isnan(FCE_temp(:,vint,h)))'*ones(size(model,1),1) == 0
%             FCE_match(1:size(model,1),vint,h) = FCE_temp(:,vint,h);
%             FCE_match_gdp(1:size(model,1),vint,h) = FCE_temp_gdp(:,vint,h);
%         else
%             FCE_match(1:size(model,1),vint,h) = NaN;
%             FCE_match_gdp(1:size(model,1),vint,h) = NaN;
%         end
%     end
% end
% rmse_match     = squeeze(sqrt(nanmean(FCE_match.^2,2)));
% rmse_match_gdp = squeeze(sqrt(nanmean(FCE_match_gdp.^2,2)));
% RMSE_match = cell2table(num2cell(rmse_match'),'VariableNames', modelname);
% RMSE_match_GDP = cell2table(num2cell(rmse_match_gdp'),'VariableNames', modelname);
% 
% 
% 
% save Allparam.mat
% 
