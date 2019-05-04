% function [optlag] = bvar_optlag(basics)
%% Choose lag length 
%% Write mod file
cd(basics.currentpath)
bvar_lag = fopen('bvaroptlag.mod','w+');
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
fprintf(bvar_lag,'cd .. ; \n');
fprintf(bvar_lag,'cd .. ; \n');
fprintf(bvar_lag,'load variables.mat; \n');
fprintf(bvar_lag,'cd BVAR; \n');
fprintf(bvar_lag,'cd BVAR_lag; \n');
fprintf(bvar_lag,'eval([''options_.datafile = '''''' basics.datalocation ''\\ExcelFileVintages\\'' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) '''''';'']);' );
fprintf(bvar_lag,'options_.bvar_prior_tau = %e; \n',basics.bvarmpriors(1) );
fprintf(bvar_lag,'options_.bvar_prior_decay = %e; \n',basics.bvarmpriors(2));
fprintf(bvar_lag,'options_.bvar_prior_omega = %e; \n', basics.bvarmpriors(3));
fprintf(bvar_lag,'options_.bvar_prior_train= %e;\n',basics.bvarmpriors(end));
fprintf(bvar_lag,'options_.first_obs = %d; \n', 20);
fprintf(bvar_lag,'bvar_density 8; \n');
fclose(bvar_lag);
%% Run dynare
dynare bvaroptlag
%% Store the log marginal likelihoods
% Initialize variables.
filename = 'bvaroptlag.log';
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
%% Optimal laglength
[basics.bvar.minlmd,basics.bvar.optlag]=  min(lmdensity);
