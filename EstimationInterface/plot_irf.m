%% Function description
% Plot the impulse response functions based on 'PosteriorIRF'
% Shock: monetary policy shock
% Endogenous variables: GDP, inflation, nominal interest rate

%% Preambles
current_model_name = string(basics.currentmodel);
current_vintages = string(basics.vintage);

% Length of the IRF
periods_length = basics.irf_periods;
periods = (1:periods_length);

% Header
plot_type = "Posterior IRFs to Monetary Policy Shock: ";
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

% Shocks and variable names
shock_names = ["", "", "rm_sh", "rm_sh", "eR", ""];
var_names = ["xgdp_q_obs", "pgdp_q_obs", "rff_q_obs"];

% set path
current_folder = string(pwd); % Estimation Interface folder
root_folder = extractBefore(current_folder, "EstimationInterface");
charts_folder = root_folder + "OUTPUT//Charts";
irf_folder = root_folder + "OUTPUT//IRFs";

%% Main
for vintage_index = 1:numel(current_vintages)
    
    %% retreive Dynare result
    dynare_folder = root_folder + "MODELS//" + basics.currentmodel + "//" + basics.currentmodel + "_" + current_vintages(vintage_index);
    cd(dynare_folder);
    load(basics.currentmodel + "_" + current_vintages(vintage_index) + "_oo.mat");
    
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
    
    %% store IRFs in a new struct called 'IRFs'
    IRFs = {};
    IRFs.(current_full_name) = oo_.PosteriorIRF.dsge.Mean;
    
    %% save IRFs to disk
    xls_name = current_full_name + ".xlsx";
    cd(irf_folder)
    writetable(struct2table(oo_.PosteriorIRF.dsge.Mean), xls_name)
    
    %% Load the IRFs of other models with the same vintage (if exists)
    temp = dir(irf_folder);
    xls_names = convertCharsToStrings({temp.name});
    for xls_index = 1:numel(xls_names)
        xls_name = xls_names(xls_index);
        if (contains(xls_name, current_vintages(vintage_index))) && ~(contains(xls_name, current_full_name))
            table = readtable(xls_name);
            struct = table2struct(table, 'ToScalar', true);
            IRFs.(extractBefore(xls_name, ".xlsx")) = struct;
        end
    end
    
    %% Plot IRFs
    figure;
    
    for current_plot = 1:3
        subplot(2,2,current_plot)
        hold on

        % Plot IRFs of all models
        full_names = string(fieldnames(IRFs));
        leg_num = 0;
        legend_irfs = "";
        for fullname_index = 1:numel(full_names)
            model_index = 0;
            for modelname_index = 1:numel(model_names)
                if contains(full_names(fullname_index), model_names(modelname_index))
                    model_index = modelname_index;
                    break
                end
            end
            series = var_names(current_plot) + "_" + shock_names(model_index);
            plot(IRFs.(full_names(fullname_index)).(series)(1: periods_length), "Linewidth", 2)
            leg_num = leg_num + 1;
            legend_irfs(leg_num) = [full_names(fullname_index) + " (Mean)"]; % legend
        end

        % Plot confidence bands
        bounds = eval("oo_.PosteriorIRF.dsge.deciles." + var_names(current_plot) + "_" + shock_names(current_model_index));
        for bound = 1:4
            lower_line = bounds(1: periods_length, bound)';
            upper_line = bounds(1: periods_length, 10 - bound)';
            bands(current_plot, bound) = fill([periods, fliplr(periods)], [lower_line, fliplr(upper_line)], [1 0.5 0.5], "Edgecolor", "none");
        end

        % Plot a reference line
        ref = refline([0 0]);
        ref.Color = 'k';
        alpha(0.5)

        % Subplot properties
        ax = gca;
        ax.FontSize = 12;
        ax.XLim = [1 periods_length];
        ax.XTick = [1 2:2:periods_length];
        ax.XGrid = "on";
        ax.YGrid = "on";
        ax.Box = "on";
        ax.Title.String = subheaders(current_plot);

    end
    
    % Add legend
    % legend_irfs already defined above
    legend_interval = "Confidence intervals for " + current_full_name;
    legend_all = legend([legend_irfs, legend_interval], 'Interpreter', 'none');

    % Adjust position
    set(subplot(2,2,1), "Position",[0.131 0.495 0.335 0.341])
    set(subplot(2,2,2), "Position",[0.570 0.495 0.335 0.341])
    set(subplot(2,2,3), "Position",[0.131 0.066 0.335 0.341])
    set(legend_all, "Position", [0.570 0.066 0.335 0.341])
    set(gcf,"units","normalized","outerposition",[0 0 1 1])

    % Add header
    annotation(...
        "textbox", [0.0007 0.891 0.95 0.1], ...
        "String", ["\fontsize{18}", header, ...
        "\fontsize{12}", "using " + insertAfter(current_vintages(vintage_index),4,"Q") + " vintage"], ...
        "Interpreter", "tex", "EdgeColor", "none", "FontUnits", "normalized", "HorizontalAlignment", "center")

    % Move confidence bands to the bottom
    for i = 1:numel(bands)
        uistack(bands(i), 'bottom')
    end
    
    %% Save the IRF plot to disk
    choice = questdlg("Would you like to store the graph?", "Save to disk", "Yes", "No", "Yes");
    if convertCharsToStrings(choice) == "Yes"
        cd(charts_folder);
        saveas(gcf, "IRF_" + current_full_name + ".png")
    end
    
end

cd(current_folder);

