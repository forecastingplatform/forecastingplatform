function ModelOutput=BVAR_MP(basics,vint)

 cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' basics.vintage(vint,:)]);
bvar_lag = fopen(['BVAROPTLAG_' basics.vintage(vint,:) '.mod'],'w+');
% Vars

fprintf(bvar_lag,'var ');
for i = 1:3
   fprintf(bvar_lag, cell2mat(basics.observables{i}));
   fprintf(bvar_lag, ' ');
end
fprintf(bvar_lag,'; \n');
%varexo
fprintf(bvar_lag,'varobs ');
for i = 1: 3
   fprintf(bvar_lag, cell2mat(basics.observables{i}));
   fprintf(bvar_lag, ' ');
end
fprintf(bvar_lag,'; \n');
%Data loading
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);
% Lag length estimation
fprintf(bvar_lag,'// Load Forecast Interface Parameters \n'); 
fprintf(bvar_lag,'cd .. \n');
fprintf(bvar_lag,'cd .. \n');
fprintf(bvar_lag,'load variables.mat ''basics'' ; \n');
fprintf(bvar_lag,'cd([basics.thispath ''\\MODELS\\'' basics.currentmodel ''\\'' basics.currentmodel ''_'' basics.vintage(basics.vintagenr,:)]); \n');
fprintf(bvar_lag,'eval([''options_.datafile = '''''' basics.datalocation ''\\ExcelFileVintages\\'' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) '''''';'']); \n' );
fprintf(bvar_lag,'options_.bvar_prior_tau = %e; \n',basics.bvarmpriors(1) );
fprintf(bvar_lag,'options_.bvar_prior_decay = %e; \n',basics.bvarmpriors(2));
fprintf(bvar_lag,'options_.bvar_prior_omega = %e; \n', basics.bvarmpriors(3));
fprintf(bvar_lag,'options_.bvar_prior_train= %e;\n',basics.bvarmpriors(end));
fprintf(bvar_lag,'options_.first_obs = %d; \n', 20);
fprintf(bvar_lag,'bvar_density 8; \n');
fclose(bvar_lag);
%% Run dynare
eval(['dynare BVAROPTLAG_' basics.vintage(vint,:)]);
%% Store the log marginal likelihoods
% Initialize variables.
filename = ['BVAROPTLAG_' basics.vintage(vint,:) '.log'];
delimiter = ' ';
% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%s%[^\n\r]';
% Open the text file.
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);
% Close the text file.
fclose(fileID);
% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
% Converts strings in the input cell array to numbers. Replaced non-numeric
% strings with NaN.
rawData = dataArray{1};
for row=1:size(rawData, 1);
    % Create a regular expression to detect and remove non-numeric prefixes and
    % suffixes.
    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
    try
        result = regexp(rawData{row}, regexstr, 'names');
        numbers = result.numbers;
        
        % Detected commas in non-thousand locations.
        invalidThousandsSeparator = false;
        if any(numbers==',');
            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
            if isempty(regexp(thousandsRegExp, ',', 'once'));
                numbers = NaN;
                invalidThousandsSeparator = true;
            end
        end
        % Convert numeric strings to numbers.
        if ~invalidThousandsSeparator;
            numbers = textscan(strrep(numbers, ',', ''), '%f');
            numericData(row, 1) = numbers{1};
            raw{row, 1} = numbers{1};
        end
    catch me
    end
end
% Exclude rows with non-numeric cells
I = ~all(cellfun(@(x) (isnumeric(x) || islogical(x)) && ~isnan(x),raw),2); % Find rows with non-numeric cells
raw(I,:) = [];
% Allocate imported array to column variable names
lmdensity = cell2mat(raw(:, 1));
% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me I J K;
%% Store Optimal laglength
[basics.bvar.minlmd,basics.bvar.optlag]=  min(lmdensity);
%% Perform out of sample forecasting with Minnesota Prior BVAR 
%bvar_forecast(datafile = temp, bvar_prior_tau=0.2, bvar_prior_decay=1, bvar_prior_omega=1,  bvar_prior_train=0, first_obs = 20, forecast = 20, bvar_replic = 10000, conf_sig = 0.9 ) 8;
%% Write mod file
bvar_forecasting = fopen(['BVAR_MP_' basics.vintage(vint,:) '.mod'],'w+');
% Vars
fprintf(bvar_forecasting,'var ');
for i = 1:3
   fprintf(bvar_forecasting, cell2mat(basics.observables{i}));
   fprintf(bvar_forecasting, ' ');
end
fprintf(bvar_forecasting,'; \n');
%varexo
fprintf(bvar_forecasting,'varobs ');
for i = 1: 3
   fprintf(bvar_forecasting, cell2mat(basics.observables{i}));
   fprintf(bvar_forecasting, ' ');
end
fprintf(bvar_forecasting,'; \n');
%Data loading
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);
% Lag length estimation
fprintf(bvar_forecasting,'// Load Forecast Interface Parameters \n');
fprintf(bvar_lag,'cd .. \n');
fprintf(bvar_lag,'cd .. \n');
fprintf(bvar_lag,'load variables.mat ''basics''; \n');
fprintf(bvar_lag,'cd([basics.thispath ''\\MODELS\\'' basics.currentmodel ''\\'' basics.currentmodel ''_'' basics.vintage(basics.vintagenr,:)]); \n');
fprintf(bvar_forecasting,'eval([''options_.datafile = '''''' basics.datalocation ''\\ExcelFileVintages\\'' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) '''''';'']);' );
fprintf(bvar_forecasting,'options_.bvar_prior_tau = %e; \n',basics.bvarmpriors(1) );
fprintf(bvar_forecasting,'options_.bvar_prior_decay = %e; \n',basics.bvarmpriors(2));
fprintf(bvar_forecasting,'options_.bvar_prior_omega = %e; \n', basics.bvarmpriors(3));
fprintf(bvar_forecasting,'options_.bvar_prior_train= %e;\n',basics.bvarmpriors(end));
fprintf(bvar_forecasting,'options_.first_obs = %d; \n', 20);
fprintf(bvar_forecasting,'options_.forecast = %d; \n', basics.forecasthorizon);
fprintf(bvar_forecasting,'options_.bvar_replic = 1000; \n' );
fprintf(bvar_forecasting,'options_.nograph = 1; \n' );
fprintf(bvar_forecasting,'bvar_forecast  %d; \n', basics.bvar.optlag);
fclose(bvar_forecasting);
%% Run Dynare
%global oo_ M_
eval(['dynare BVAR_MP_' basics.vintage(vint,:)]);
global oo_ M_
eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_oo.mat']);
ModelOutput.Mean.xgdp_a_obs = oo_.bvar.forecast.no_shock.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
ModelOutput.Mean.pgdp_a_obs = oo_.bvar.forecast.no_shock.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Mean.rff_a_obs  = oo_.bvar.forecast.no_shock.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Median.xgdp_a_obs = oo_.bvar.forecast.no_shock.Median.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
ModelOutput.Median.pgdp_a_obs = oo_.bvar.forecast.no_shock.Median.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Median.rff_a_obs  = oo_.bvar.forecast.no_shock.Median.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Var.xgdp_a_obs  = oo_.bvar.forecast.no_shock.Var.xgdp_q_obs(1:basics.forecasthorizon)*16; % The variance is scaled up
ModelOutput.Var.pgdp_a_obs  = oo_.bvar.forecast.no_shock.Var.pgdp_q_obs(1:basics.forecasthorizon)*16;
ModelOutput.Var.rff_a_obs  = oo_.bvar.forecast.no_shock.Var.rff_q_obs(1:basics.forecasthorizon)*16;


ModelOutput
end