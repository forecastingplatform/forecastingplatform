%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'BVAR_MP_20094';
M_.dynare_version = '4.5.6';
oo_.dynare_version = '4.5.6';
options_.dynare_version = '4.5.6';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('BVAR_MP_20094.log');
M_.endo_names = 'xgdp_q_obs';
M_.endo_names_tex = 'xgdp\_q\_obs';
M_.endo_names_long = 'xgdp_q_obs';
M_.endo_names = char(M_.endo_names, 'pgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'pgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'rff_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'rff\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'rff_q_obs');
M_.endo_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 0;
M_.endo_nbr = 3;
M_.param_nbr = 0;
M_.orig_endo_nbr = 3;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'xgdp_q_obs'};
options_.varobs(2)  = {'pgdp_q_obs'};
options_.varobs(3)  = {'rff_q_obs'};
options_.varobs_id = [ 1 2 3  ];
M_.Sigma_e = zeros(0, 0);
M_.Correlation_matrix = eye(0, 0);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('BVAR_MP_20094_static');
erase_compiled_function('BVAR_MP_20094_dynamic');
M_.orig_eq_nbr = 0;
M_.eq_nbr = 0;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
cd .. 
cd .. 
load variables.mat 'basics'; 
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' basics.vintage(basics.vintagenr,:)]); 
eval(['options_.datafile = ''' basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) ''';']);options_.bvar_prior_tau = 3.000000e+00; 
options_.bvar_prior_decay = 5.000000e-01; 
options_.bvar_prior_omega = 5.000000e+00; 
options_.bvar_prior_train= 0.000000e+00;
options_.first_obs = 20; 
options_.forecast = 5; 
options_.bvar_replic = 1000; 
options_.nograph = 1; 
bvar_forecast(1);
save('BVAR_MP_20094_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('BVAR_MP_20094_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
