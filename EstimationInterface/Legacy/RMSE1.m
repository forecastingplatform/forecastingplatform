%  a=ls('USMODELS\forecast_US_SW07');a=a(3:end,:);
cd ..
varnames={'xgdp_a_obs','pgdp_a_obs','rff_a_obs'};
C = {'b','y','g','c','r',[0.5 0 0.5]} ;% Cell array for colors.
str = date;
VINTAGES=[];
for y = 1984:str2num(str([8:11]))
    for q = 1:4
        a = num2str(y);
        VINTAGES = [VINTAGES;[a num2str(q)]];
    end
end
VintageSpan{1}=['19841';'20141'];%
fvint=find(strcmp(VINTAGES,{VintageSpan{1}(1,:)})==1);
lvint=find(strcmp(VINTAGES,{VintageSpan{1}(2,:)})==1);
Periods=VINTAGES(fvint:lvint,:);
b=ls(['..\OUTPUT\' basics.modelzone]);b=b(3:end,:);
h = basics.forecasthorizon;
L=[];
NBER_rd = xlsread(['..\DATA\USDATA\NBER_RD\NBER_rd.xls']);
NBER_rd = NBER_rd(157:157+size(Periods,1)-1);
rec = [];
for i= 1:size(NBER_rd,1)
    if NBER_rd(i) == 1
        rec = char( rec , Periods(i,:) );
    end
end
%% All available vintages

RevisedData=[basics.datalocation '\ExcelFileRev'];
lr=ls(RevisedData);lr=lr(3:end,:);
ListRevised=lr(:,3:7);
Report=[];
Vintages(2,:) = {[],[],[]};
for m=1:size(b,1)
    %Start by whole sample
    for v=1:3
        Estimation{v}=[];
        Revised{v}=[];
    end
    EstimationResults=ls(['..\OUTPUT\' basics.modelzone deblank(b(m,:))]);
    EstimationResults=EstimationResults(3:end,:);
    ListEstimatedVintages=EstimationResults(:,end-8:end-4);
    RMSEPeriods=intersect(cellstr(ListEstimatedVintages),cellstr(Periods));
    [RMSEVintages,IndexEstimated,IndexRevised]=intersect(cellstr(RMSEPeriods),cellstr(ListRevised));
    for v=1:3
        Estimation{v}=[];
        Revised{v}=[];
    end
    if ismember(m,(find(cellfun(@isempty,strfind(cellstr(b),'_SPF'))==0))) %%Check if the SPF nowcast has been used
        for vintnr=1:size(RMSEVintages,1)-1
            RevisedCurrent= xlsread([basics.DataArea '\DATADSGE_RolWin\ExcelFileRev\'  basics.zone ListRevised(IndexRevised(vintnr+1),:)],1);
            Forecast=xlsread(['..\OUTPUT\USMODELS\' deblank(b(m,:)) '\' EstimationResults(IndexEstimated(vintnr),:)],basics.statistics);
            for v=1:3
                Estimation{v} =[Estimation{v} [NaN; Forecast(1:h-1,v)]];
                Revised{v}   =[Revised{v} [NaN; RevisedCurrent(1:h-1,v)]];
            end
        end
    else
        for vintnr=1:size(RMSEVintages,1)
            RevisedCurrent= xlsread([basics.datalocation '\ExcelFileRev\' basics.zone ListRevised(IndexRevised(vintnr),:)],1);
            Forecast=xlsread(['..\OUTPUT\USMODELS\' deblank(b(m,:)) '\' EstimationResults(IndexEstimated(vintnr),:)],basics.statistics);
            for v=1:3
                Estimation{v} =[Estimation{v} Forecast(1:h,v)];
                Revised{v}   =[Revised{v} RevisedCurrent(:,v)];
            end
        end
    end
    %% Calculate the RMSE for the whole sample
    for v=1:3
        RMSE2{v}(m,:)=(sqrt(sum((Estimation{v}(1:h,:)' - Revised{v}(1:h,:)').^2)/size(Revised{v}(1:h,:),2)))';
    end
    
    %% Recession
    RecPeriods=intersect(cellstr(rec),cellstr(ListRevised));
    [RecVintages,RecIndexEstimated,RecIndexRevised]=intersect(cellstr(RMSEVintages),cellstr(RecPeriods));
    for v =1:3
        EstimationReshape{v}  =NaN(size(Estimation{v},2)+h-1,size(Estimation{v},2));
        RevisedReshape{v} =NaN(size(Estimation{v},2)+h-1,size(Estimation{v},2));
        RecFCE{v} = [];
        for i =1: size(Estimation{v},2)
            EstimationReshape{v}(i:i+h-1,i) = Estimation{v}(:,i);
            RevisedReshape{v}(i:i+h-1,i) = Revised{v}(:,i);
        end
    end
    for v=1:3
        for j=1:size(RecIndexEstimated,1)
            for l =1:h
                if RecIndexEstimated(j)-l+1 <=0
                    RecFCE{v}(l,j)=   NaN;
                elseif  RecIndexEstimated(j) > size(EstimationReshape{v},2)
                    RecFCE{v}(l,j)=   NaN;
                else
                    RecFCE{v}(l,j)=   (EstimationReshape{v}(RecIndexEstimated(j),RecIndexEstimated(j)-l+1)' - RevisedReshape{v}(RecIndexEstimated(j),RecIndexEstimated(j)-l+1)');
                end
                
            end
        end
    end
    for v=1:3
        for l =1:h
            RecRMSE{v}(m,l) = sqrt(nansum((RecFCE{v}(l,:).^2)')/(size(RecFCE{v}(l,:),2)-sum(isnan(RecFCE{v}(l,:)))));
        end
    end
    %% NON RECESSION
    NonRecPeriods =setdiff(cellstr(ListRevised)', cellstr(rec)')'; % Returns the values of Revised data that had no recession
    [NonRecVintages,NonRecIndexEstimated,NonRecIndexRevised]=intersect(cellstr(RMSEVintages),cellstr(NonRecPeriods));
    
    for v=1:3
        for j=1:size(NonRecIndexEstimated,1)
            for l =1:h
                if NonRecIndexEstimated(j)-l+1 <=0
                    NonRecFCE{v}(l,j) = NaN;
                elseif NonRecIndexEstimated(j) > size(EstimationReshape{v},2)
                    NonRecFCE{v}(l,j) = NaN;
                else
                    NonRecFCE{v}(l,j)=   (EstimationReshape{v}(NonRecIndexEstimated(j),NonRecIndexEstimated(j)-l+1)' - RevisedReshape{v}(NonRecIndexEstimated(j),NonRecIndexEstimated(j)-l+1)');
                end
            end
        end
    end
    for v=1:3
        for l =1:h
            NonRecRMSE{v}(m,l) = sqrt(nansum((NonRecFCE{v}(l,:).^2)')/(size(NonRecFCE{v}(l,:),2)-sum(isnan(NonRecFCE{v}(l,:)))));
        end
    end
    
    
    %%
    ListVintagesNotUsed=ListEstimatedVintages;
    ListVintagesNotUsed(IndexEstimated,:)=[];
    Reportm=[['Model:' deblank(b(m,:))],num2cell(NaN)];
    Reportm(2,:)=[{'First Vintage:'}, {ListEstimatedVintages(1,:)}];
    Reportm(3,:)=[{'Last Vintage:'}, {ListEstimatedVintages(end,:)}];
    if ~isempty(ListVintagesNotUsed)
        Reportm(4,:)=[{'Not Used Vintage:'},{ListVintagesNotUsed(1,:)}];
        for j=2:size(ListVintagesNotUsed,1)
            Reportm(j+3,:)=[num2cell(NaN),{ListVintagesNotUsed(j,:)}];
        end
    end
    if isempty(j)
        j=2;
    end
    Reportm(j+4,:)=[num2cell(NaN),num2cell(NaN)];
    Report=[Report;Reportm];
end


%% SPF
for v=1:3
    Estimation{v}=[];
    Revised{v}=[];
end
if strcmp(basics.zone, 'us') ==1
    EstimationResults=ls(['..\DATA\USDATA\SPF\ExcelFileSPF']);
else
    EstimationResults=ls(['..\DATA\EADATA\SPF\ExcelFileRev']);
end
EstimationResults=EstimationResults(3:end,:);
ListEstimatedVintages=EstimationResults(:,end-8:end-4);
RMSEPeriods=intersect(cellstr(ListEstimatedVintages),cellstr(Periods));
[RMSEVintages,IndexEstimated,IndexRevised]=intersect(cellstr(RMSEPeriods),cellstr(ListRevised));
[SPFVintages,IndexEstimated_SPF,IndexRevised_SPF]=intersect(cellstr(RMSEPeriods),cellstr(ListEstimatedVintages));
for vintnr=1:size(RMSEVintages,1)
    RevisedCurrent=xlsread([RevisedData '\us' ListRevised(IndexRevised(vintnr),:)]);
    Forecast=xlsread(['..\DATA\USDATA\SPF\ExcelFileSPF\' EstimationResults(IndexRevised_SPF(vintnr),:)]);
    for v=1:3
        Estimation{v} =[Estimation{v} Forecast(1:h,v)];
        Revised{v}   =[Revised{v} RevisedCurrent(:,v)];
    end
end
for v=1:3
    RMSE_SPF{v}=(sqrt(sum((Estimation{v}(1:h,:)' - Revised{v}(1:h,:)').^2)/size(Revised{v}(1:h,:),2)))';
end

ListVintagesNotUsed=[];
ListVintagesNotUsed=RMSEPeriods;
ListVintagesNotUsed(IndexEstimated,:)=[];
Reportm=['SPF',num2cell(NaN)];
Reportm(2,:)=[{'First Vintage:'}, {ListEstimatedVintages(1,:)}];
Reportm(3,:)=[{'Last Vintage:'}, {ListEstimatedVintages(end,:)}];
if ~isempty(ListVintagesNotUsed)
    Reportm(4,:)=[{'Not Used Vintage:'},{ListVintagesNotUsed(1,:)}];
    for j=2:size(ListVintagesNotUsed,1)
        Reportm(j+3,:)=[num2cell(NaN),{ListVintagesNotUsed(j,:)}];
    end
end
if isempty(j)
    j=2;
end
Reportm(j+4,:)=[num2cell(NaN),num2cell(NaN)];
Report=[Report;Reportm];

%% Recession
RecPeriods=intersect(cellstr(rec),cellstr(ListRevised));
[RecVintages,RecIndexEstimated,RecIndexRevised]=intersect(cellstr(RMSEVintages),cellstr(RecPeriods));
for v =1:3
    EstimationReshape{v}  =NaN(size(Estimation{v},2)+h-1,size(Estimation{v},2));
    RevisedReshape{v} =NaN(size(Estimation{v},2)+h-1,size(Estimation{v},2));
    RecFCE{v} = [];
    for i =1: size(Estimation{v},2)
        EstimationReshape{v}(i:i+h-1,i) = Estimation{v}(:,i);
        RevisedReshape{v}(i:i+h-1,i) = Revised{v}(:,i);
    end
end
for v=1:3
    for j=1:size(RecIndexEstimated,1)
        for l =1:h
            if RecIndexEstimated(j)-l+1 <=0
                RecFCE{v}(l,j)=   NaN;
            else
                RecFCE{v}(l,j)=   (EstimationReshape{v}(RecIndexEstimated(j),RecIndexEstimated(j)-l+1)' - RevisedReshape{v}(RecIndexEstimated(j),RecIndexEstimated(j)-l+1)');
            end
            
        end
    end
end
for v=1:3
    for l =1:h
        RecRMSE_SPF{v}(1,l) = sqrt(nansum((RecFCE{v}(l,:).^2)')/(size(RecFCE{v}(l,:),2)-sum(isnan(RecFCE{v}(l,:)))));
    end
end
%% NON RECESSION
NonRecPeriods =setdiff(cellstr(ListRevised)', cellstr(rec)')'; % Returns the values of Revised data that had no recession
[NonRecVintages,NonRecIndexEstimated,NonRecIndexRevised]=intersect(cellstr(RMSEVintages),cellstr(NonRecPeriods));

for v=1:3
    for j=1:size(NonRecIndexEstimated,1)
        for l =1:h
            if NonRecIndexEstimated(j)-l+1 <=0
                NonRecFCE{v}(l,j) = NaN;
            else
                NonRecFCE{v}(l,j)=   (EstimationReshape{v}(NonRecIndexEstimated(j),NonRecIndexEstimated(j)-l+1)' - RevisedReshape{v}(NonRecIndexEstimated(j),NonRecIndexEstimated(j)-l+1)');
            end
        end
    end
end
for v=1:3
    for l =1:h
        NonRecRMSE_SPF{v}(1,l) = sqrt(nansum((NonRecFCE{v}(l,:).^2)')/(size(NonRecFCE{v}(l,:),2)-sum(isnan(NonRecFCE{v}(l,:)))));
    end
end




%% ALL VINTAGES COLLECTING
j=0;
for v=1:3
    RMSE(j+1,:)=[{varnames{v}},num2cell(1:h)];
    for m=1:size(b,1)
        RMSE(j+2,:)=[{deblank(b(m,:))},num2cell(RMSE2{v}(m,:))];
        j=j+1;
    end
    RMSE(j+2,:)=[{'SPF'},num2cell(RMSE_SPF{v})',num2cell(NaN(1,5-5))];
    j=j+2;
end
%% RECESSION
j=0;
for v=1:3
    REC_RMSE(j+1,:)=[{varnames{v}},num2cell(1:h)];
    for m=1:size(b,1)
        REC_RMSE(j+2,:)=[{deblank(b(m,:))},num2cell(RecRMSE{v}(m,:))];
        j=j+1;
    end
    REC_RMSE(j+2,:)=[{'SPF'},num2cell(RecRMSE_SPF{v}),num2cell(NaN(1,5-5))];
    j=j+2;
end
%% NON RECESSION
j=0;
for v=1:3
    NONREC_RMSE(j+1,:)=[{varnames{v}},num2cell(1:h)];
    for m=1:size(b,1)
        NONREC_RMSE(j+2,:)=[{deblank(b(m,:))},num2cell(NonRecRMSE{v}(m,:))];
        j=j+1;
    end
    NONREC_RMSE(j+2,:)=[{'SPF'},num2cell(NonRecRMSE_SPF{v}),num2cell(NaN(1,5-5))];
    j=j+2;
end


%% Write output

xlswrite('Report_New',RMSE,['RMSE_h_' num2str(5)])
xlswrite('Report_New',REC_RMSE,['Recession RMSE h_' num2str(5)])
xlswrite('Report_New',NONREC_RMSE,['Non Recession RMSE h_' num2str(5)])
xlswrite('Report_New',Report,['Report RMSE_h_' num2str(5)])

%% Plot

close all
clear RMSE_plot REC_RMSE_plot NONREC_RMSE_plot L
Legendnames = cell(m+1,1)
for n = 1:size(b,1)
    if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'RW'))==0)) %%Check if the RW model
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SPF'))==0))~=1
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                % simple RW 97 first model
                RMSE_plot(1,:)=  RMSE(n+1,2:6);
                RMSE_plot(1+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(1,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(1+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(1,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(1+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{1} = b(n,:);
            else % Simple RW GLP second
                RMSE_plot(2,:)=  RMSE(n+1,2:6);
                RMSE_plot(2+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(2,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(2+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(2,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(2+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{2} = b(n,:);
            end
        else
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                % RW with SPF 3rd
                RMSE_plot(3,:)=  RMSE(n+1,2:6);
                RMSE_plot(3+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(3,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(3+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(3,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(3+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{3} = b(n,:);
            else
                %RW GLP SPF 4th
                RMSE_plot(4,:)=  RMSE(n+1,2:6);
                RMSE_plot(4+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(4,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(4+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(4,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(4+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{4} = b(n,:);
            end
        end
    elseif  ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SW'))==0)) %%Check if the SW model is taken
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
            %SW 5th
            RMSE_plot(5,:)=  RMSE(n+1,2:6);
            RMSE_plot(5+m+1,:) =  RMSE(n+m+3,2:6);
            NONREC_RMSE_plot(5,:) = NONREC_RMSE(n+1,2:6);
            NONREC_RMSE_plot(5+m+1,:) = NONREC_RMSE(n+3+m,2:6);
            REC_RMSE_plot(5,:) =    REC_RMSE(n+1,2:6);
            REC_RMSE_plot(5+m+1,:) =    REC_RMSE(m+3+n,2:6);
            Legendnames{5} = b(n,:);
        else
            %SW GLP 6th
            RMSE_plot(6,:)=  RMSE(n+1,2:6);
            RMSE_plot(6+m+1,:) =  RMSE(n+m+3,2:6);
            NONREC_RMSE_plot(6,:) = NONREC_RMSE(n+1,2:6);
            NONREC_RMSE_plot(6+m+1,:) = NONREC_RMSE(n+3+m,2:6);
            REC_RMSE_plot(6,:) =    REC_RMSE(n+1,2:6);
            REC_RMSE_plot(6+m+1,:) =    REC_RMSE(m+3+n,2:6);
            Legendnames{6} = b(n,:);
        end
    elseif   ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'FA'))==0)) %%Check if the SW model is taken
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SP'))==0))~=1
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                %FA 7th
                RMSE_plot(7,:)=  RMSE(n+1,2:6);
                RMSE_plot(7+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(7,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(7+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(7,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(7+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{7} = b(n,:);
            else
                %FA GLP 8th
                RMSE_plot(8,:)=  RMSE(n+1,2:6);
                RMSE_plot(8+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(8,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(8+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(8,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(8+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{8} = b(n,:);
            end
        else
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                %FA SP 9th
                RMSE_plot(9,:)=  RMSE(n+1,2:6);
                RMSE_plot(9+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(9,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(9+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(9,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(9+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{9} = b(n,:);
            else
                %FA SP GLP 10th
                RMSE_plot(10,:)=  RMSE(n+1,2:6);
                RMSE_plot(10+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(10,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(10+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(10,:) =    REC_RMSE(n+1,2:6);
                REC_RMSE_plot(10+m+1,:) =    REC_RMSE(m+3+n,2:6);
                Legendnames{10} = b(n,:);
            end
            
        end
    end
    RMSE_plot(11,:)=  RMSE(n+2,2:6);
    RMSE_plot(11+m+1,:) =  RMSE(n+m+4,2:6);
    NONREC_RMSE_plot(11,:) = NONREC_RMSE(n+2,2:6);
    NONREC_RMSE_plot(11+m+1,:) = NONREC_RMSE(n+4+m,2:6);
    REC_RMSE_plot(11,:) =    REC_RMSE(n+2,2:6);
    REC_RMSE_plot(11+m+1,:) =    REC_RMSE(m+4+n,2:6);
    Legendnames{11} = {'SPF'};
end


% Create figure
figure1 = figure
% Create axes
axes1 = axes('Parent',figure1,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.55 0.678931185944363 0.38]); box(axes1,'on'); grid(axes1,'on'); hold(axes1,'on');
% Create multiple lines using matrix input to plot
plot1 = plot(cell2mat(RMSE_plot(1:m+1,1:h))','Parent',axes1,'LineWidth',2);
set(plot1(1),'Color',[0.5 0 0]); %RW redish
set(plot1(2),'Color',[0.5 0 0],'LineStyle', '--'); % RW redish
set(plot1(3),'Color',[1 0 0]); %RW SPF red
set(plot1(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot1(5),'Color',[0 0 1]); %SW  blue
set(plot1(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot1(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot1(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot1(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot1(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot1(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black
% Create ylabel
%  ylim([0 2.6]);
ylabel({'RMSE of annualized ','GDP growth forecasts'},'FontSize',11);
% Create title
title('GDP','FontSize',12,'Interpreter','none');
%% Inflation

% Create axes
axes2 = axes('Parent',figure1,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.07 0.680395314787701 0.38]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim([0 1.6]);
box(axes2,'on'); grid(axes2,'on'); hold(axes2,'on');

% Create multiple lines using matrix input to plot
plot2 = plot(cell2mat(RMSE_plot(2+m:2*m+2,1:h))','Parent',axes2,'LineWidth',2);
set(plot2(1),'Color',[0.5 0 0]); %RW redish
set(plot2(2),'Color',[0.5 0 0],'LineStyle', '--'); % RW redish
set(plot2(3),'Color',[1 0 0]); %RW SPF red
set(plot2(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot2(5),'Color',[0 0 1]); %SW  blue
set(plot2(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot2(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot2(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot2(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot2(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot2(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black
% for i =1:m+1
% set(plot2(i),'DisplayName',(RMSE{1+i,1}));
% end

% Create xlabel
xlabel({'Horizon',''},'FontSize',11);
% Create ylabel
ylabel({'RMSE of inflation','forecasts'},'FontSize',11);
% Create title
title({'Inflation'},'FontSize',12,'Interpreter','none');

legend1 = legend({'US_NK_RW97' 'US_BVAR_GLP_RW' 'US_NK_RW97_SPF' 'US_BVAR_GLP_RW_SPF' ...
    'US_SW07' , 'US_BVAR_GLP_SW' 'US_NK_FA' 'US_BVAR_GLP_FA' 'US_NK_FA_SP' 'US_BVAR_GLP_FA_SP' 'SPF'});
set(legend1,...
    'Position',[0.821132262780529 0.0699186991869919 0.154709611304391 0.378357165404053],...
    'Interpreter','none');
% saveas(gcf, ['RMSE_1984q1_2013q4_all_'  'h_' num2str(h)], 'pdf')

%% NON RECESSION

% Create figure
figure2 = figure
% Create axes
axes1 = axes('Parent',figure2,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.55 0.678931185944363 0.38]); box(axes1,'on'); grid(axes1,'on'); hold(axes1,'on');
% Create multiple lines using matrix input to plot
plot1 = plot(cell2mat(NONREC_RMSE_plot(1:m+1,1:h))','Parent',axes1,'LineWidth',2);
set(plot1(1),'Color',[0.5 0 0]); %RW redish
set(plot1(2),'Color',[0.5  0 0],'LineStyle', '--'); % RW redish
set(plot1(3),'Color',[1 0 0]); %RW SPF red
set(plot1(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot1(5),'Color',[0 0 1]); %SW  blue
set(plot1(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot1(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot1(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot1(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot1(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot1(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black
% Create ylabel
%  ylim([0 2.6]);
ylabel({'RMSE of annualized ','GDP growth forecasts'},'FontSize',11);
% Create title
title('GDP','FontSize',12,'Interpreter','none');
%% Inflation

% Create axes
axes2 = axes('Parent',figure2,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.07 0.680395314787701 0.38]);
%% Uncomment the following line to preserve the Y-limits of the axes
ylim([0.5 1.6]);
box(axes2,'on'); grid(axes2,'on'); hold(axes2,'on');

% Create multiple lines using matrix input to plot
plot2 = plot(cell2mat(NONREC_RMSE_plot(2+m:2*m+2,1:h))','Parent',axes2,'LineWidth',2);
set(plot2(1),'Color',[0.7 0 0]); %RW redish
set(plot2(2),'Color',[0.7 0 0],'LineStyle', '--'); % RW redish
set(plot2(3),'Color',[1 0 0]); %RW SPF red
set(plot2(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot2(5),'Color',[0 0 1]); %SW  blue
set(plot2(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot2(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot2(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot2(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot2(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot2(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black

% Create xlabel
xlabel({'Horizon',''},'FontSize',11);
% Create ylabel
ylabel({'RMSE of inflation','forecasts'},'FontSize',11);
% Create title
title({'Inflation'},'FontSize',12,'Interpreter','none');
legend2 = legend({'US_NK_RW97' 'US_BVAR_GLP_RW' 'US_NK_RW97_SPF' 'US_BVAR_GLP_RW_SPF' ...
    'US_SW07' , 'US_BVAR_GLP_SW' 'US_NK_FA' 'US_BVAR_GLP_FA' 'US_NK_FA_SP' 'US_BVAR_GLP_FA_SP' 'SPF'});
set(legend2,...
    'Position',[0.821132262780529 0.0699186991869919 0.154709611304391 0.378357165404053],...
    'Interpreter','none');
% saveas(gcf, ['RMSE_1984q1_2013q4_all_'  'h_' num2str(h)], 'pdf')

%% RECESSSION

% Create figure
figure3 = figure
% Create axes
axes1 = axes('Parent',figure3,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.55 0.678931185944363 0.38]); box(axes1,'on'); grid(axes1,'on'); hold(axes1,'on');
% Create multiple lines using matrix input to plot
plot1 = plot(cell2mat(REC_RMSE_plot(1:m+1,1:h))','Parent',axes1,'LineWidth',2);
set(plot1(1),'Color',[0.7 0 0]); %RW redish
set(plot1(2),'Color',[0.7 0 0],'LineStyle', '--'); % RW redish
set(plot1(3),'Color',[1 0 0]); %RW SPF red
set(plot1(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot1(5),'Color',[0 0 1]); %SW  blue
set(plot1(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot1(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot1(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot1(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot1(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot1(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black
% Create ylabel
ylim([1 5]);
ylabel({'RMSE of annualized ','GDP growth forecasts'},'FontSize',11);
% Create title
title('GDP','FontSize',12,'Interpreter','none');
%% Inflation

% Create axes
axes2 = axes('Parent',figure3,'XTickLabel',{'0','0','1','2','3','4'},...
    'XTick',[0 1 2 3 4 5],...
    'Position',[0.13 0.07 0.680395314787701 0.38]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim([0 2]);
box(axes2,'on'); grid(axes2,'on'); hold(axes2,'on');

% Create multiple lines using matrix input to plot
plot2 = plot(cell2mat(REC_RMSE_plot(2+m:2*m+2,1:h))','Parent',axes2,'LineWidth',2);
set(plot2(1),'Color',[0.7 0 0]); %RW redish
set(plot2(2),'Color',[0.7 0 0],'LineStyle', '--'); % RW redish
set(plot2(3),'Color',[1 0 0]); %RW SPF red
set(plot2(4),'Color',[1 0 0],'LineStyle', '--'); % RW SPF GLP red
set(plot2(5),'Color',[0 0 1]); %SW  blue
set(plot2(6),'Color',[0 0 1],'LineStyle', '--'); % SW GLP blue
set(plot2(7),'Color',[0 0.7 0.9]); %FA cyan
set(plot2(8),'Color',[0 0.7 0.9],'LineStyle', '--'); % FA GLP cyam
set(plot2(9),'Color',[0.2 .9 0]); %FA SP  green
set(plot2(10),'Color',[0.2 .9 0],'LineStyle', '--'); % FA SP green
set(plot2(11),'Color',[0 0 0], 'LineWidth', 3); %SPF black
% Create xlabel
xlabel({'Horizon',''},'FontSize',11);
% Create ylabel
ylabel({'RMSE of inflation','forecasts'},'FontSize',11);
% Create title
title({'Inflation'},'FontSize',12,'Interpreter','none');
legend3 = legend({'US_NK_RW97' 'US_BVAR_GLP_RW' 'US_NK_RW97_SPF' 'US_BVAR_GLP_RW_SPF' ...
    'US_SW07' , 'US_BVAR_GLP_SW' 'US_NK_FA' 'US_BVAR_GLP_FA' 'US_NK_FA_SP' 'US_BVAR_GLP_FA_SP' 'SPF'});
set(legend3,...
    'Position',[0.821132262780529 0.0699186991869919 0.154709611304391 0.378357165404053],...
    'Interpreter','none');
% saveas(gcf, ['RMSE_1984q1_2013q4_all_'  'h_' num2str(h)], 'pdf')




