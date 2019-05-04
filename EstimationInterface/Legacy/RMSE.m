C = {'b','y','g','c','r',[0.5 0 0.5]} ;% Cell array for colors.
RMSE1 =[];
cd .. 
b=ls(['..\OUTPUT\' basics.modelzone]);b=b(3:end,:);
h = basics.forecasthorizon;
L=[];

j=0;
RevisedData=[basics.datalocation '\ExcelFileRev'];
lr=ls(RevisedData);lr=lr(3:end,:);
ListRevised=lr(:,3:7);
Report=[];Vintages(2,:) = {[],[],[]};
for m=1:size(b,1)
    for v=1:3
        Estimation{v}=[];
        Revised{v}=[];
    end
    EstimationResults=ls(['..\OUTPUT\' basics.modelzone '\' deblank(b(m,:))]);
    EstimationResults=EstimationResults(3:end,:);
    ListEstimatedVintages=EstimationResults(:,end-8:end-4);
    ListEstimatedVintages=intersect(cellstr(ListEstimatedVintages),cellstr(Periods));
    RMSEPeriods=intersect(cellstr(ListEstimatedVintages),cellstr(Periods));
    [RMSEVintages,IndexEstimated,IndexRevised]=intersect(cellstr(RMSEPeriods),cellstr(ListRevised)); 
    if ~isempty(RMSEVintages)
        for vintnr=1:size(RMSEVintages,1)
            RevisedCurrent= xlsread([basics.datalocation '\ExcelFileRev\' basics.zone ListRevised(IndexRevised(vintnr),:)],1);
            Forecast=xlsread(['..\OUTPUT\USMODELS\' deblank(b(m,:)) '\' EstimationResults(IndexEstimated(vintnr),:)],basics.statistics);
            %manageexcell
            for v=1:3
                Estimation{v} =[Estimation{v} Forecast(1:h,v)];
                Revised{v}   =[Revised{v} RevisedCurrent(:,v)];
            end
        end
        for v=1:3 
            RMSE1{v}(m,:)=(sqrt(sum((Estimation{v}(1:h,:)' - Revised{v}(1:h,:)').^2,1)/size(Revised{v}(1:h,:),2)))';
        end
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
        if j==0
            j=2;
        end
        Reportm(j+3,:)=[num2cell(NaN),num2cell(NaN)];
        Report=[Report;Reportm];
    else
        Reportm=[['Model:' deblank(b(m,:))],num2cell(NaN)];
        if ~isempty(ListEstimatedVintages)
        Reportm(2,:)=[{'First Vintage:'}, {ListEstimatedVintages(1,:)}];
        Reportm(3,:)=[{'Last Vintage:'}, {ListEstimatedVintages(end,:)}];
        else            
        Reportm(2,:)=[{'First Vintage:'}, {'no vintage estimated'}];
        Reportm(3,:)=[{'Last Vintage:'}, {'no vintage estimated'}];
        end
        Reportm(3,:)=[{'No matching  is possible between forecast vintages and revised data for the chosen time span.'}, {''}];
    end
end
j=0;
for v=1:3
    RMSEvar(j+1,:)=[{basics.variables{v}},num2cell(NaN(1,h))];
    try
        for m=1:size(b,1)
            RMSEvar(j+2,:)=[{deblank(b(m,:))},num2cell(RMSE1{v}(m,:))];
            j=j+1;
        end
        j=j+1;
    catch
    end
end
try
    xlswrite('Report1',RMSEvar,['RMSE' VintageSpan(1,:) '_' VintageSpan(2,:) 'h_' num2str(h)])
    xlswrite('Report1',Report,['Report' VintageSpan(1,:) '_' VintageSpan(2,:) 'h_' num2str(h)])
catch
end
if isempty(RMSE1)
    fprintf(['No RMSEs were computed, please change the specification.']);
else
    figure
    subplot(2,1,1)
    for m=1:size(b,1)
        try
            plot(RMSE1{1}(m,:),'color',C{m},'LineWidth',2); hold on
            grid on
            title(basics.variables{1}, 'Interpreter', 'none', 'FontSize', 12)
        catch
        end
    end
    subplot(2,1,2)
    for m=1:size(b,1)
        try
            plot(RMSE1{2}(m,:),'color',C{m},'LineWidth',2); hold on
            grid on
            title(basics.variables{2}, 'Interpreter', 'none', 'FontSize', 12)
            L = [L {deblank(b(m,:))}];
        catch
        end
    end 
Leg = legend(L, 'Interpreter', 'none','location','northeast');
% clear RMSE1 RMSE
saveas(gcf, ['RMSE'  'h_' num2str(h)], 'pdf')
end