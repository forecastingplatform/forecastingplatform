function ModelOutput = MHestimate(basics)

basics.path = cd;

%Data loading
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);

% go to subdirectoy of current vintage
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))]);

% evaluate dynare file
eval(['dynare ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '.mod;']);

% load US_SW07_20081_options basics
% data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);


%%% estimation options
global options_

cd('..');

% Number of Replications
options_.mh_replic = basics.chainslength;

% Optimization Algorithm
options_.mode_compute = 4 ;

options_.mode_file = '';
options_.mh_file = '';
options_.subdraws = 50000/4;
options_.mh_recover = 0;

options_.nograph = 0;
options_.presample = 4;  % To make the marginal likelihood comparable to a VAR(4)
options_.forecast = basics.forecasthorizon;%40; %
options_.load_mh_file=0;
options_.model_mode = 0;
options_.smoother = 1;         % just to check stationarity of the output gap for the other project
options_.filtered_vars = 0;
options_.linear = 1;            
options_.lik_init = 1;
options_.mh_nblck = basics.numchains;% Number of Chains
options_.prefilter = 0;
options_.order = 1; %added by Elena
eval(['options_.datafile = ''' basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) ''';']);
options_.optim_opt = '''MaxIter'',2000';
options_.mh_drop = basics.numburnin;
options_.mh_jscale = basics.acceptance;

if ((basics.windowlength == 80) && strcmp(basics.currentmodel,'US_DNGS14') && (basics.expseriesvalue == 0) &&  (str2num(basics.vintage(basics.vintagenr,:))>= 20022 && str2num(basics.vintage(basics.vintagenr,:))<=20162) )
eval(['options_.mode_file = ''' basics.thispath '\DATA\DNSG_mode_files_RW80_nocond\US_DNGS14_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_mode.mat'';']);
end

options_.varobs = [];
for i = 1:size(basics.model_observables,2)
    if basics.model_observables(i)
        options_.varobs = strvcat(options_.varobs, cell2mat(basics.observables{i}));
    end
end

%% NEW code to determine the xls range
options_.varobs = cellstr(options_.varobs);
Letters = ['A'; 'B'; 'C'; 'D'; 'E'; 'F'; 'G'; 'H'; 'I'; 'J'; 'K'; 'L'; 'M'; 'N'; 'O'; 'P'; 'Q']; 
options_.xls_range = ['B1:' , Letters(size(data,2)+1) , num2str(size(data,1)+1)];
clear Letters

%%
var_list_ = [];
var_list_ = strvcat(var_list_, 'rff_q_obs');
var_list_ = strvcat(var_list_, 'pgdp_q_obs');
var_list_ = strvcat(var_list_, 'xgdp_q_obs');
%%

% Match=cellfun(@(x) ismember(x, cellstr(var_list_)), options_.varobs , 'UniformOutput', 0);
% options_.varobs_id= find(cell2mat(Match));
% clear Match


% estimate the model to generate forecasts
cd([basics.currentmodel '_' num2str(basics.vintage(basics.vintagenr,:))]);
eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_options basics options_ var_list_']);
optimizationinfo = 1;
eval(['diary ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '.log']);

%while optimizationinfo
% dynare_estimation(var_list_); % run the estimation
%global optimizationinfo

options_.bayesian_irf = 1;
options_.irf=100;

global options_ oo_ optcrit
try
        disp('Trying mode_compute = 4, Chris Sims’s csminwel, and checking if estimation is feasible.');
        if ~isempty(options_.mode_file)
            options_.mode_compute = 0;
        else
        options_.mode_compute = 4; % start with Sims' algorithm
        end
        dynare_estimation(var_list_); % run the estimation
catch
            optcrit = 1;
end

if options_.mode_compute == 4 & optcrit==1 %oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 7;
    disp('Mode_compute=5, Marco Ratto’s newrat, was unsuccessfull, trying mode_compute=7, fminsearch.');
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
    disp('Mode_compute=3 was unsuccessfull, trying mode_compute=5, Marco Ratto’s newrat.');
    optcrit =0;
    try
    dynare_estimation(var_list_);
    disp('Mode_compute=5 was successfull.');
    catch
         optcrit = 1;
    end
end
if options_.mode_compute == 5 & optcrit==1% oo_.MarginalDensity.LaplaceApproximation == NaN
    options_.mode_compute = 6;
       disp('Mode_compute=3, fminunc, was unsuccessfull, trying mode_compute=6,  Monte-Carlo based optimization.')
        optcrit =0;
    try
    dynare_estimation(var_list_);
    catch
     optcrit = 1;
    end
    disp('Mode_compute=6, Monte-Carlo based optimization failed, please check the model.');
end
global oo_ M_

MarginalDensityLaPlace = oo_.MarginalDensity.LaplaceApproximation;

eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_estimationresults MarginalDensityLaPlace M_ options_']);
eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) '_oo.mat']);

ModelOutput.MLLaPlace = oo_.MarginalDensity.LaplaceApproximation; % save ML for fit measurement
ModelOutput.MLMHM     = oo_.MarginalDensity.ModifiedHarmonicMean; %Modified Harmonic Mean
% %everything is annualized and saved with '_a_'
ModelOutput.Mean.xgdp_a_obs = oo_.PointForecast.Mean.xgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Mean.pgdp_a_obs = oo_.PointForecast.Mean.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Mean.rff_a_obs  = oo_.PointForecast.Mean.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Median.xgdp_a_obs = oo_.PointForecast.Median.xgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Median.pgdp_a_obs = oo_.PointForecast.Median.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.Median.rff_a_obs  = oo_.PointForecast.Median.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.Distribution.xgdp_a_obs = oo_.PointForecast.deciles.xgdp_q_obs(:,1:basics.forecasthorizon)*4;
ModelOutput.Distribution.pgdp_a_obs = oo_.PointForecast.deciles.pgdp_q_obs(:,1:basics.forecasthorizon)*4;
ModelOutput.Distribution.rff_a_obs  = oo_.PointForecast.deciles.rff_q_obs(:,1:basics.forecasthorizon)*4;

ModelOutput.HPDinf.xgdp_a_obs = oo_.PointForecast.HPDinf.xgdp_q_obs(1:basics.forecasthorizon)*4; 
ModelOutput.HPDinf.pgdp_a_obs = oo_.PointForecast.HPDinf.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.HPDinf.rff_a_obs  = oo_.PointForecast.HPDinf.rff_q_obs(1:basics.forecasthorizon)*4;

ModelOutput.HPDsup.xgdp_a_obs = oo_.PointForecast.HPDsup.xgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.HPDsup.pgdp_a_obs = oo_.PointForecast.HPDsup.pgdp_q_obs(1:basics.forecasthorizon)*4;
ModelOutput.HPDsup.rff_a_obs  = oo_.PointForecast.HPDsup.rff_q_obs(1:basics.forecasthorizon)*4;

close all

diary off
