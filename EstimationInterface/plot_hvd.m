%% Function description
% Plot the historical variance decomposition (HVD)
% Shock groups: monetary, demand, supply
% Endogenous variables: GDP, inflation, nominal interest rate

%% Preambles
current_model_name = string(basics.currentmodel);
current_vintages = string(basics.vintage);

% Length of the HVD
periods_length = basics.hvd_periods;
periods = (1:periods_length);

% Header
plot_type = "Historical Variance Decompositions: ";
% model_names = string(basics.models);
model_names = ["BVAR_MP", "BVAR_GLP", "US_SW07", "US_DNGS14", "NK_RW97", "DSGE_TEST"];
current_model_index = find(current_model_name == model_names);
% model_descriptions = string(basics.charttitle);
model_descriptions = [...
    "BVAR with Minnesta prior";
    "BVAR with Giannone Lenza Primiceri prior";
    "Smets Wouters (2007) US model ";
    "Del Negro Schorfheide Giannoni with credit spread";
    "Small NK US model";
    "Small NK model with BGG financial frictions"];
model_description = model_descriptions(current_model_index);
header = plot_type + model_description;
subheaders = ["GDP", "Inflation", "Nominal Interest Rate"];

% Shock groups
% G1: Supply, G2: Demand, G3: Monetary, G4: Fiscal, G5: Init_condition
% Give the definition of the VD matrix, always end shock_groups with [4, 0]
shock_group_names = ["supply_shocks", "demand_shocks", "monetary_shocks", "fiscal_shocks", "initial_conditions"];
switch current_model_name
    case "NK_RW97"
        shock_group_identifiers = [3, 2, 1, 2, 1, 4, 0];
    case "US_SW07"
        shock_group_identifiers = [1, 2, 2, 1, 1, 1, 3, 4, 0];
    case "US_DNGS14"
        shock_group_identifiers = [1, 2, 2, 1, 1, 1, 1, 3, 4, 0];
end

% Variable names
var_names = ["xgdp_q_obs", "pgdp_q_obs", "rff_q_obs"];

% set path
current_folder = string(pwd); % Estimation Interface folder
root_folder = extractBefore(current_folder, "EstimationInterface");
charts_folder = root_folder + "OUTPUT//Charts";
hvd_folder = root_folder + "OUTPUT//HVDs";

for vintage_index = 1:numel(current_vintages)
    
    %% retreive Dynare HVD result
    dynare_folder = root_folder + "MODELS//" + basics.currentmodel + "//" + basics.currentmodel + "_" + current_vintages(vintage_index);
    cd(dynare_folder);
    load("hvd.mat");
    total_length = size(hvd,3);
    total_periods = (1:total_length);
    
    % hvd contains the absolute contributions of ungrouped shocks to three observables
    % size(hvd) = (n_vars, n_shocks, n_periods)
    hvd = hvd(:, :, end:-1:end - total_length +1); 
    
    % hvda contains the absolute contributions of shocks to three observables
    % size(hvda) = (n_vars, n_shock_groups, n_periods)
    hvda = zeros(numel(var_names), numel(shock_group_names), total_length);
    for period = total_periods
        for shock_index = 1:size(hvd(:,:,period), 2) - 1
            hvda(:, shock_group_identifiers(shock_index), period) = hvda(:, shock_group_identifiers(shock_index), period) + hvd(:, shock_index, period);
        end
    end
    hvda_temp = shiftdim(hvda, 1);
    hvda = zeros(total_length, numel(shock_group_names), numel(var_names));
    for var_index = 1:numel(var_names)
        hvda(:, :, var_index) = transpose(hvda_temp(:, :, var_index));
    end
    
    % hvdr contains the relative contributions of shocks to three observables
    % size(hvdr) = size(hvda);
    hvdr = zeros(size(hvda));
    for var_index = 1:numel(var_names)
        hvdr(:, :, var_index) = abs(hvda(:, :, var_index))./sum(abs(hvda(:, :, var_index)), 2);
    end
    
    %% specify the full model name
    current_full_name = basics.currentmodel + "_" + current_vintages(vintage_index);
    if basics.real
    current_full_name = current_full_name + "_RT";
    else
        current_full_name = current_full_name + "_RD";
    end
    if basics.expseriesvalue
        current_full_name = current_full_name + "_EW";
    else
        current_full_name = current_full_name + "_RW";
    end
    if basics.inspf
        current_full_name = current_full_name + "_spfnc";
    end
    current_full_name = current_full_name + "_" + extractAfter(extractAfter(string(basics.densitymodel), "_"), "_");
    
    % HVDs contains both relative and absolute variance decompositions
    HVDs = {};
    for var_index = 1:numel(var_names)
        HVDs.(current_full_name).absolute.(var_names(var_index)) = array2table(hvda(:,:,var_index), "VariableNames", cellstr(shock_group_names));
        HVDs.(current_full_name).relative.(var_names(var_index)) = array2table(hvdr(:,:,var_index), "VariableNames", cellstr(shock_group_names));
    end
        
    %% Save HVDs to disk
    xls_name = current_full_name + ".xlsx";
    cd(hvd_folder)
    for var_index = 1:numel(var_names)
        writetable(HVDs.(current_full_name).absolute.(var_names(var_index)), xls_name, "Sheet", "absolute_" + var_names(var_index));
        writetable(HVDs.(current_full_name).relative.(var_names(var_index)), xls_name, "Sheet", "relative_" + var_names(var_index));
    end
    
    %% Load the HVDs of other models with the same vintage (if exists)
    temp = dir(hvd_folder);
    xls_names = convertCharsToStrings({temp.name});
    for xls_index = 1:numel(xls_names)
        xls_name = xls_names(xls_index);
        disp(xls_name)
        if (contains(xls_name, current_vintages(vintage_index))) && ~(contains(xls_name, current_full_name))
            for var_index = 1:numel(var_names)
                table_absolute = readtable(xls_name, "Sheet", "absolute_" + var_names(var_index));
                table_relative = readtable(xls_name, "Sheet", "relative_" + var_names(var_index));
                HVDs.(extractBefore(xls_name, ".xlsx")).absolute.(var_names(var_index)) = table_absolute;
                HVDs.(extractBefore(xls_name, ".xlsx")).relative.(var_names(var_index)) = table_relative;
            end
        end
        % make sure to present not more than five HVDs
        if numel(fieldnames(HVDs))>=5
            warning('Found more than five variance decomposition result under the same vintage. Only show the first five');
            break
        end
    end
    
    %% Plot HVDs
    begin_Xs = [-0, -0.175, -0.25, -0.4, -0.4];
    diff_Xs = [0, 0.35, 0.25, 0.2, 0.2];

    bar_width = 0.6/numel(fieldnames(HVDs));
    begin_X = begin_Xs(numel(fieldnames(HVDs)));
    diff_X = diff_Xs(numel(fieldnames(HVDs)));

    face_alpha = 1;
    edge_width = 1.2;
    
    % number of edge colors = maximum number of models allowed
    edge_colors = [54, 54, 54; 
        139 0 0;
        0 0 139;
        139 0 139;
        0 139 139]./255;

    % number of face colors = number of shock groups
    face_colors = {[255 231 186]/255; [176 224 230]/255; [100 100 100]/255; [255 228 225]/255; [207 207 207]/255};

    models_for_legend = [];
    legend_name_models = "";
    
    % dates in the x-axis
    % endDate = datenum(insertAfter(current_vintages(vintage_index),4,"Q"),"yyyyQQ");
    % startDate = endDate - (periods_length-1)*91;
    % xData = linspace(startDate,endDate,periods_length);

    figure;

    for current_plot = 1:3
        subplot(2,2,current_plot)
        hold on

        % Plot HVDs
        i = 1;
        full_names = string(fieldnames(HVDs));
        for fullname_index = 1:numel(full_names)
            if basics.hvd_absolute
                matrix = table2array(HVDs.(full_names(fullname_index)).absolute.(var_names(current_plot)));
            else
                matrix = table2array(HVDs.(full_names(fullname_index)).relative.(var_names(current_plot)));
            end
            matrix = matrix(1:periods_length,:);
            
            matrix_neg = matrix;
            matrix_neg(matrix_neg > 0) = 0;
            matrix_pos = matrix;
            matrix_pos(matrix_pos < 0) = 0;

            hp(i, :) = bar(matrix_pos, bar_width, "stacked");
            hn(i, :) = bar(matrix_neg, bar_width, "stacked");

            set(hp(i, :), "XData", 1 + begin_X + diff_X*(i-1):1:periods_length + begin_X + diff_X*(i-1), {"FaceColor"}, face_colors, ...
                "FaceAlpha", face_alpha, "EdgeColor", edge_colors(i, :), "EdgeAlpha", 1, "LineWidth", edge_width);
            set(hn(i, :), "XData", 1 + begin_X + diff_X*(i-1):1:periods_length + begin_X + diff_X*(i-1), {"FaceColor"}, face_colors, ...
                "FaceAlpha", face_alpha, "EdgeColor", edge_colors(i, :), "EdgeAlpha", 1, "LineWidth", edge_width);

            models_for_legend(i) = bar(0);
            set(models_for_legend(i), "FaceColor", "w", "EdgeColor", edge_colors(i, :), "EdgeAlpha", 1, "LineWidth", edge_width);
            legend_name_models(i) = full_names(fullname_index);

            i = i + 1;
        end

        % Subplot properties
        ax = gca;
        ax.FontSize = 12;
        if ~basics.hvd_absolute
            ax.YLim = [0 1];
        end
        ax.XLim = [0 periods_length+1];
        ax.XTick = [1:ceil(periods_length/5):periods_length];
        
        % dates as XTickLabel
        dates = strings(1, periods_length + 1);
        current_date = str2num(current_vintages(vintage_index));
        dates(periods_length + 1) = insertAfter(num2str(current_date),4,"Q");

        for i = periods_length:-1:1
            if ~mod(current_date-1, 10)
                current_date = current_date - 11 + 4;
            else
                current_date = current_date - 1;
            end
            dates(i) = insertAfter(num2str(current_date),4,"Q");
        end

        if basics.inspf == 0
            dates = dates(1:periods_length);
        else
            dates = dates(2:periods_length+1);
        end

        dates = dates([1:ceil(periods_length/5):periods_length]);

        for i = 1:numel(dates)
            dates(i) = extractAfter(dates(i),2);
        end
        
        ax.XTickLabel = dates;
%         ax.XTickLabel = zeros(size([1:ceil(periods_length/5):periods_length]));
%         ax.XTick = xData;
%         ax.XLim = [startDate-60 endDate+60];
%         ax.XTick = xData(1:ceil(periods_length/5):end);
%         datetick(ax,'x','yyQQ','keepticks', 'keeplimits');
%         datetick(ax,'x','yyQQ','keepticks', 'keeplimits')
        ax.XGrid = "on";
        ax.YGrid = "on";
        ax.Box = "on";
        ax.Title.String = subheaders(current_plot);

    end

    % Legends for shock groups
    subplot(2,2,1)
    bars_for_legend = bar(zeros(2, numel(shock_group_names)), bar_width, "stacked");
    set(bars_for_legend, {"FaceColor"}, face_colors, "EdgeColor", "w");   
    legend_bars = legend(bars_for_legend, shock_group_names);
    set(legend_bars, "Interpreter", "none");
    set(legend_bars, "Position", [0.745 0.066 0.16 0.341])
    set(legend_bars, "Units","normalized")
    title(legend_bars, "Shock groups")

    % Legend for models
    legend_models = legend(models_for_legend, legend_name_models);
    set(legend_models, "Interpreter", "none");
    title(legend_models, "Models")

    % Adjust position
    set(subplot(2,2,1), "Position", [0.131 0.495 0.335 0.341])
    set(subplot(2,2,2), "Position", [0.570 0.495 0.335 0.341])
    set(subplot(2,2,3), "Position", [0.131 0.066 0.335 0.341])
    set(legend_models, "Position", [0.570 0.066 0.16 0.341])
    set(gcf, "Units", "normalized", "outerposition", [0 0 1 1])

    % Add header
    annotation(...
        "textbox", [0.0007 0.891 0.95 0.1], ...
        "String", ["\fontsize{18}", header, ...
        "\fontsize{12}", "using " + insertAfter(current_vintages(vintage_index),4,"Q") + " vintage"], ...
        "Interpreter", "tex", "EdgeColor", "none", "FontUnits", "normalized", "HorizontalAlignment", "center")

    %% Save the IRF plot to disk
    choice = questdlg("Would you like to store the graph?", "Save to disk", "Yes", "No", "Yes");
    if convertCharsToStrings(choice) == "Yes"
        cd(charts_folder)
        if basics.hvd_absolute
            saveas(gcf, "HVD_absolute_" + current_full_name + ".png")
        else
            saveas(gcf, "HVD_relative_" + current_full_name + ".png")
        end
    end
   
end

cd(current_folder);