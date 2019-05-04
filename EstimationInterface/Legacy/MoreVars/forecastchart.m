
 Periods = periods(basics);
% Periods = '20074';

% Title declaration:
charttitle = char([...
    '             Forecasts with BVAR with Minnesta prior            ';
    '     Forecasts with BVAR with Giannone Lenza Primiceri prior    ';
    '         Forecasts from Smets Wouters (2007) US model           ';
    'Forecasts with Del Negro Schorfheide Giannoni with credit spread';
    '               Forecasts from Small NK US model                 ']);


forecast = ls(['..\OUTPUT\' basics.modelzone]); forecast = forecast(3:end,:);
fill_between_lines = @(X,Y1,Y2,C) fill( [X fliplr(X)],  [Y1' fliplr(Y2')], C,'EdgeColor','none');

C = {'b','r',[0.5 0 0.5],[.5 .6 .7],[.8 .2 .2],[0.9 0.6 0.9] , [0.5 0 0.3] , [1 0.5 0.3],  [.1 .1 .1], [.1 .9 .1]} ;% Cell array for colors.


try
    forecast = [ forecast(:,:) ; forecast(find(cellfun(@isempty,strfind(cellstr(forecast),basics.densitymodel))==0),:)];
catch
end
% display(['Displaying the chart for 2007Q4.' ]);
display(['Generating plots for the ' basics.statistics ' forecasts of the models: ' ]);

for i = 1: (size(forecast,1))
    display(forecast(i,:));
end
if isa(basics.densitymodel,'char')
    basics.densitymodel =  {basics.densitymodel};
end
if isempty(deblank(cell2mat(basics.densitymodel)))
    display(['Density will not be plotted.']);
else
    display(['Density will be plotted for ' deblank(cell2mat(basics.densitymodel)) '.']);
end

for i = 1:size(Periods,1)
    disp(['Forecasts for vintage ' Periods(i,1:4) 'Q' Periods(i,end) ' will be plotted. Please wait, while collecting results.' ]);

    %Load and annualize the data used in the estimations
        [~,~,data] = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone num2str(Periods(i,:))],1);
    data = [data(:,1) [data(1,2:end);num2cell(cell2mat(data(2:end,2:end))*4)]]; data = data(:,1:4);
    data_available=1;
    %
    %     catch
    %         data_available=0;
    %     end
    if data_available
        figure;
        L = [];Llabel=[];
        orient landscape
        densityplot=[];
        %% Plotting the densities for the benchmark model
        % if isempty(basics.densitymodel) ~=1
        % else
        % end
        
        % Create a list of the available vintage of revised data
        aa = ls([basics.datalocation '\RealTimePlusRev']);aa = aa(3:end,:);
        if ~isempty(aa)
            m  = size(aa,2);
            jj = strmatch(Periods(i,:),aa(:,m-8:m-4));
            if ~isempty(jj)
                [~,~,dataplotrev] = xlsread([basics.datalocation '\RealTimePlusRev\' basics.zone num2str(Periods(i,:))],1);
                ab=num2str(Periods(i,:));ab=[ab(1:4) 'Q' ab(end)];
                startf = find(strcmp(cellstr(dataplotrev(2:end,1)),{ab})==1)+1;
                start = startf-4;
                try
                    xAxis = cellstr(dataplotrev(start:start+9,1));
                    available=1;
                catch
                    xAxis = cellstr(dataplotrev(start:end,1));
                    available=0;
                end
                
                for var = 1:3
                    subplot(2,2,var)
                    %for f = size(forecast,1)
                    a = ls(['..\OUTPUT\' basics.modelzone deblank(cell2mat(basics.densitymodel))]); a=a(3:end,:);
                    if ~isempty(a)
                        m = size(a,2);  ii = strmatch(Periods(i,:),a(:,m-8:m-4));
                    else
                        ii=[];
                    end
                    if ~isempty(ii)
                        [~,~,dataplotf_dens_orig] = xlsread(['..\OUTPUT\' basics.modelzone deblank(cell2mat(basics.densitymodel)) '\' a(ii,:)],'Distribution');
                        % Append with the density  forecasts
                        for j = 2:size(data,2)
                            dataplotf_dens1(:,(1+(j-2)*9):(j-1)*9) = [repmat(data(:,j),1,9); dataplotf_dens_orig(2:end,(1+(j-2)*9):(j-1)*9)];
                        end
                        dataplotf_dens =dataplotf_dens1;
                        clear dataplotf_dens1;
                        %Creating forecast matrices that can be exported into Excel
                        dataplotf_dens = [dataplotrev(:,1) dataplotf_dens];
                        %Plotting densities
                        if available
                            for k = 1:8
                                densityplot = fill_between_lines([1:(numel(xAxis)-1)],...
                                    cell2mat(dataplotf_dens(start:start+8,(1+k+(var-1)*9):(1+k+(var-1)*9))),...
                                    cell2mat(dataplotf_dens(start:start+8,(2+k+(var-1)*9):(2+k+(var-1)*9))),...
                                    [1 (0.5+abs(k-4.5)*0.1) (0.5+abs(k-4.5)*0.1) ])  ;
                                hold on
                                
                            end
                        else
                            for k = 1:8
                                densityplot = fill_between_lines([1:(numel(xAxis))],...
                                    cell2mat(dataplotf_dens(start:end,(1+k+(var-1)*9):(1+k+(var-1)*9))),...
                                    cell2mat(dataplotf_dens(start:end,(2+k+(var-1)*9):(2+k+(var-1)*9))),...
                                    [1 (0.5+abs(k-4.5)*0.1) (0.5+abs(k-4.5)*0.1) ])  ;
                                hold on
                            end
                        end
                    end
                    %end
                end
            end
        end
        
        %% Plotting the forecast statistics for all models in the output folder
        
        if ~isempty(aa)
            m  = size(aa,2);
            jj = strmatch(Periods(i,:),aa(:,m-8:m-4));
            if ~isempty(jj)
                for var = 1:3
                    subplot(2,2,var)
                    for f = 1:(size(forecast,1)-1)
                        a = ls(['..\OUTPUT\' basics.modelzone deblank(forecast(f,:))]); a=a(3:end,:);
                        if ~isempty(a)
                            m = size(a,2);  ii = strmatch(Periods(i,:),a(:,m-8:m-4));
                        else
                            ii=[];
                        end
                        
                        if ~isempty(ii)
                            [~,~,dataplotf] = xlsread(['..\OUTPUT\' basics.modelzone deblank(forecast(f,:)) '\' a(ii,:)],deblank(basics.statistics));
                            % Append the forecasts
                            if strcmp('BVAR',a(ii,1:4))
                              end
                            if strcmp('spfnc',a(ii,m-14:m-10)) 
                                %% load in SPF nowcasts if it is not in the reference
                                if ~basics.inspf 
                                   aspf = ls([basics.DataArea '\SPF\ExcelFileSPFNC']); aspf = aspf(4:end,:); mspf = size(aspf,2); iispf = strmatch(Periods(i,:),aspf(:,mspf-8:mspf-4));
                                   [~,~,spfnowcast] = xlsread([basics.DataArea '\SPF\ExcelFileSPF\' aspf(iispf,:)],1);
                                  dataplotf = [data(:,2:end); spfnowcast(2,2:end); dataplotf(2:end,:)];
                                else
                                    dataplotf = [data(:,2:end); dataplotf(2:end,:)];
                                end
                            elseif   strcmp('BVAR',a(ii,1:4))
                                    dataplotf = [data(:,2:end); dataplotf(2:end,:)];
                            else
                                dataplotf = [data(1:end-1,2:end); dataplotf(2:end,:)];
                            end
                           
                            %Creating forecast matrices that can be exported into Excel
                            if strcmp('spfnc',a(ii,m-14:m-10))
                                dataplotf = dataplotf(1:size(dataplotrev,1),:);
                                dataplotf = [dataplotrev(1:end,1) dataplotf];
                            else
                                dataplotf = dataplotf(1:size(dataplotrev,1)-1,:);
                                dataplotf = [dataplotrev(1:end-1,1) dataplotf];
                                
                            end
                            %Plotting densities
                            if available
                                yAxis = cell2mat(dataplotf(start:end,var+1));
                            else
                                yAxis = cell2mat(dataplotf(start:end,var+1));
                            end
                            plot_forecast=plot(yAxis,'color',C{f},'LineWidth',2); hold on
                            if var == 3
                                L=[L plot_forecast];
                                if strcmp('spfnc',a(ii,m-14:m-10))
                                    Llabel=[Llabel; cellstr([deblank(forecast(f,:)) ' - Conditioned on SPF nowcast (' basics.statistics ')' ])];
                                else
                                    Llabel=[Llabel; cellstr([deblank(forecast(f,:)) ' (' basics.statistics ')' ])];
                                end
                            end
                        end
                    end
                    
                    if basics.spf
                        if ~basics.inspf
                            a = ls([basics.DataArea '\SPF\ExcelFileSPF']); a = a(4:end,:); m = size(a,2); ii = strmatch(Periods(i,:),a(:,m-8:m-4));
                        else
                            a = ls([basics.DataArea '\SPF\ExcelFileSPFNC']); a = a(4:end,:); m = size(a,2); ii = strmatch(Periods(i,:),a(:,m-8:m-4));
                        end
                        if ~isempty(ii)
                            if ~basics.inspf
                                [~,~,dataplotf] = xlsread([basics.DataArea '\SPF\ExcelFileSPF\' a(ii,:)],1);
                            else
                                [~,~,dataplotf] = xlsread([basics.DataArea '\SPF\ExcelFileSPFNC\' a(ii,:)],1);
                            end
                            dataplotf = [data(:,1:end); dataplotf(2:end,:)];
                            if ~basics.inspf
                                dataplotf = dataplotf(1:size(dataplotrev,1),:);
                            else
                                %                                 if var == 1
                                %                                     dataplotrev = dataplotrev(1:(size(dataplotrev,1)-1),:);
                                %                                 end
                                dataplotf = dataplotf(1:size(dataplotrev,1)-1,:);
                            end
                            dataplotf = dataplotf(1:size(dataplotrev,1)-1,:);
                            
                            yAxis = cell2mat(dataplotf(start:end,var+1));
                            %Plotting SPF augmeted data
                            plot_spf=plot(yAxis,'color',C{end},'LineWidth',2); hold on
                            
                            if var == 3
                                L=[L plot_spf];
                                Llabel=[Llabel;{'SPF'}];
                                
                            end
                        end
                    end
                    %Plotting revised data
                    if available
                        yAxisrev = cell2mat(dataplotrev(start:start+8,var+1));
                    else
                        yAxisrev = cell2mat(dataplotrev(start:end,var+1));
                    end
                    plot_rev=plot(yAxisrev,'color','k','LineWidth',3); hold on
                    grid on
                    try
                        hx = graph2d.constantline(startf-start+1, 'LineStyle','-', 'Color','r');
                        changedependvar(hx,'x');
                    catch
                        matlab.graphics.axis.decorator.Baseline('BaseValue',0, 'Parent',gca, 'Axis',1, 'Visible','on', 'LineStyle','-', 'Color','r');
                    end
                    set(gca,'xtick',1:2:numel(xAxis)-1)
                    set(gca,'xticklabel',[xAxis(1:2:numel(xAxis))])
                    
                    set(gca,'FontSize', 12)
                    if ~basics.inspf
                        xlim([1 numel(xAxis)-1])
                    else
                        xlim([1 numel(xAxis)-1])
                    end
                    
                    if var == 3
                        L = [L plot_rev];
                        Llabel=[Llabel;{'Data'}];
                        if ~isempty(densityplot)
                            L = [L densityplot];
                            Llabel=[Llabel;{['* Density plot for ' deblank(cell2mat(basics.densitymodel))]}];
                        end
                        Leg = legend(L, Llabel, 'Interpreter', 'none','location','southeastoutside');
                        l = size(data,1)+1;
                    end
                    % Plot vertical line to indicate first forecast
                    hold on
                    y1=get(gca,'ylim');
                    plot([5, 5],y1,'LineStyle','-', 'Color','g')
                    if  var ==1
                        title('GDP')
                    elseif var ==2
                        title('Inflation')
                    else
                        title('Nominal Interest Rate')
                    end
                end
                
                annotation('textbox', [0.0007 0.891 0.95 0.1],'String', {['\fontsize{18}',charttitle(find(basics.chosenmodels==1,1),:)],...
                    ['\fontsize{12}','Real time vintage starts at: ',char(dataplotrev(2,1))],...
                    ['\fontsize{12}','Forecasting from: ',char(dataplotrev(start+4,1))]}, ...%[0.5 0.8 0.95 0.1]
                    'EdgeColor', 'none', 'FontUnits','normalized','HorizontalAlignment', 'center')
                
                set(subplot(2,2,1), 'Position',[0.131 0.495 0.335 0.341])
                set(subplot(2,2,2), 'Position',[0.570 0.495 0.335 0.341])
                set(subplot(2,2,3), 'Position',[0.131 0.066 0.335 0.341])
                set(Leg, 'Position', [0.570 0.066 0.335 0.341])
                set(gcf,'units','normalized','outerposition',[0 0 1 1])
                
            end
        end
    end
    
    promptMessage = sprintf('Would you like to store the charts \ndisplayed on screen? \nPress Yes, and it will be stored\nor No to skip to next output chart!');
button = questdlg(promptMessage, 'Yes', 'Yes', 'No', 'No');
if strcmpi(button, 'No')
else
    img = getframe(gcf);
    mkdir(['..\OUTPUT\Charts'])
    imwrite(img.cdata, ['..\OUTPUT\Charts\' num2str(Periods(i,:))  '.png']);
end

end


