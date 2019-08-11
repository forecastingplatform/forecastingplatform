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

options_csminwel.maxiter = 1000000;
options_newrat.maxiter = 1000000;
options_.varobs=[];

for i=1:size(basics.model_observables,2)
    if basics.model_observables(i)
        options_.varobs = [options_.varobs basics.observables{i}];%[options_.varobs basics.variables{i}];%
    end
end

var_list_ = [];
% var_list_ = strvcat(var_list_, 'rff_q_obs');
% var_list_ = strvcat(var_list_, 'pgdp_q_obs');
var_list_ = strvcat(var_list_, 'xgdp_q_obs');

%% NEW code to determine the xls range
% options_.varobs = cellstr(options_.varobs);
Letters = ['A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K'; 'L'; 'M'; 'N'; 'O'; 'P'; 'Q']; 
options_.xls_range = ['B1:' , Letters(size(data,2)+1) , num2str(size(data,1)+1)];
clear Letters

% estimate the model to generate forecasts
cd([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))]);

eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_options options_ var_list_']);
%global optimizationinfo
optimizationinfo = 1;
global options_ oo_ optcrit
eval(['diary ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '.log']);
%while optimizationinfo

options_.mode_compute = 4; % start with Sims' algorithm
try
    disp('Trying mode_compute = 4, Chris Sims’ csminwel, and checking if estimation is feasible.');
    dynare_estimation(var_list_); % run the estimation
catch
    optcrit = 1;
end
if options_.mode_compute == 4 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 7;
    disp('Mode_compute=4, Chris Sims, csminwel algorithm was unsuccessfull, trying mode_compute=7, fminsearch.');
    optcrit =0;
    try
        dynare_estimation(var_list_);
        disp('Mode_compute=7, fminsearch, was successfull.');
    catch
        optcrit = 1;
    end
end
if options_.mode_compute == 7 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 1;
    disp('Mode_compute=7, fminsearch, was unsuccessfull, trying mode_compute=1, fmincon.');
    optcrit =0;
    try
        dynare_estimation(var_list_);
        disp('Mode_compute=1, fmincon, was successfull.');
        
    catch
        optcrit = 1;
    end
end
if options_.mode_compute == 1 & optcrit==1% oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 3;
    disp('Mode_compute=1, fmincon, was unsuccessfull, trying mode_compute=3, fminunc.')
    optcrit =0;
    try
        dynare_estimation(var_list_);
        disp('Mode_compute=3, fminunc, was successfull.');
    catch
        optcrit = 1;
    end
end
if options_.mode_compute == 3 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation <-1000% NaN optcrit ==1
    options_.mode_compute = 5;
    disp('Mode_compute=3,fminunc was unsuccessfull, trying mode_compute=5, Marco Ratto’s newrat.');
    optcrit =0;
    try
        dynare_estimation(var_list_);
        disp('Mode_compute=5,newrat, was successfull.');
    catch
        optcrit = 1;
    end
end
if options_.mode_compute == 5 & optcrit==1% oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 6;
    disp('Mode_compute=5, newrat, was unsuccessfull, trying mode_compute=6,  Monte-Carlo based optimization.')
    optcrit =0;
    try
        dynare_estimation(var_list_);
    catch
        optcrit = 1;
    end
    disp('Mode_compute=6, Monte-Carlo based optimization failed, please check the model.');
end

global oo_ M_ %options_
MarginalDensityLaPlace = oo_.MarginalDensity.LaplaceApproximation;

eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_estimationresults MarginalDensityLaPlace M_ options_']);

ModelOutput.MLLaPlace = oo_.MarginalDensity.LaplaceApproximation; % save ML for fit measurement

ModelOutput.Mean.xgdp_a_obs = oo_.forecast.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
% ModelOutput.Mean.pgdp_a_obs = oo_.forecast.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
% ModelOutput.Mean.rff_a_obs  = oo_.forecast.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Median.xgdp_a_obs = oo_.forecast.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4; % get rid of + maximum lag at both ends
% ModelOutput.Median.pgdp_a_obs = oo_.forecast.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
% ModelOutput.Median.rff_a_obs  = oo_.forecast.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

close all

diary off
