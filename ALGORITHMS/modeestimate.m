function ModelOutput = modeestimate(basics)

basics.path = cd;
% Data loading

data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);

% go to subdirectoy of current vintage
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))]);

% evaluate dynare file
eval(['dynare ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '.mod;']);

% estimation options
global options_
cd('..');

% Number of Replications
options_.mh_replic = 0;

% Optimization Algorithm
options_.mode_compute = 4 ;
options_.mode_file = '';
options_.mh_file = '';
options_.subdraws = 0;
options_.mh_recover = 0;
options_.nograph = 0;
options_.presample = 4;        % To make the marginal likelihood comparable to a VAR(4)
options_.forecast = basics.forecasthorizon;
options_.load_mh_file=0;
options_.model_mode = 0;
options_.smoother = 1;         % just to check stationarity of the output gap for the other project
options_.filtered_vars = 0;
options_.linear = 1;
options_.lik_init = 1;
options_.mh_nblck = 1;
options_.prefilter = 0;
options_.order = 1;
eval(['options_.datafile = ''' basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) ''';']);
options_.optim_opt = '''MaxIter'',2000';
options_.varobs=[];

for i=1:size(basics.model_observables,2)
    if basics.model_observables(i) 
        options_.varobs = [options_.varobs basics.observables{i}];%[options_.varobs basics.variables{i}];%
    end
end

var_list_ = [];
var_list_ = strvcat(var_list_, 'rff_q_obs');
var_list_ = strvcat(var_list_, 'pgdp_q_obs');
var_list_ = strvcat(var_list_, 'xgdp_q_obs');

%% NEW code to determine the xls range
% options_.varobs = cellstr(options_.varobs);
Letters = ['A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K'; 'L'; 'M'; 'N'; 'O'; 'P'; 'Q']; 
options_.xls_range = ['B1:' , Letters(size(data,2)+1) , num2str(size(data,1)+1)];
clear Letters

% estimate the model to generate forecasts
cd([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))]);

eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_options options_ var_list_']);

optimizationinfo = 1;

eval(['diary ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '.log']);
%while optimizationinfo
dynare_estimation(var_list_); % run the estimation
%global optimizationinfo
global options_ oo_ optcrit
options_.mode_compute = 4; % start with Sims' algorithm
if options_.mode_compute == 4 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation <-1000% NaN optcrit ==1
    options_.mode_compute = 5;
    disp('optcrit after mode 4 if unsuccessfull');
    optcrit
    dynare_estimation(var_list_);
else optcrit = 0;
    disp('optcrit after mode 4 if successfull');
    optcrit
end
if options_.mode_compute == 5 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 7;
    disp('optcrit after mode 5 if unsuccessfull');
    optcrit
    dynare_estimation(var_list_);
else optcrit = 0;
    disp('optcrit after mode 5 if successfull');
    optcrit
end
if options_.mode_compute == 7 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 1;
    dynare_estimation(var_list_);
end
if options_.mode_compute == 1 & optcrit==1% oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 3;
    dynare_estimation(var_list_);
end
if options_.mode_compute == 3 & optcrit==1% oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 6;
    dynare_estimation(var_list_);
end
global oo_ M_ %options_
MarginalDensityLaPlace = oo_.MarginalDensity.LaplaceApproximation;

eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_estimationresults MarginalDensityLaPlace M_ options_']);

ModelOutput.MLLaPlace = oo_.MarginalDensity.LaplaceApproximation; % save ML for fit measurement

ModelOutput.Mean.xgdp_a_obs = oo_.forecast.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
ModelOutput.Mean.pgdp_a_obs = oo_.forecast.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Mean.rff_a_obs  = oo_.forecast.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Median.xgdp_a_obs = oo_.forecast.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
ModelOutput.Median.pgdp_a_obs = oo_.forecast.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Median.rff_a_obs  = oo_.forecast.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

close all

diary off
