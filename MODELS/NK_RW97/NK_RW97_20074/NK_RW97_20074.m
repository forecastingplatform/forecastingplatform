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
M_.fname = 'NK_RW97_20074';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('NK_RW97_20074.log');
M_.exo_names = 'eR';
M_.exo_names_tex = 'eR';
M_.exo_names_long = 'eR';
M_.exo_names = char(M_.exo_names, 'eg');
M_.exo_names_tex = char(M_.exo_names_tex, 'eg');
M_.exo_names_long = char(M_.exo_names_long, 'eg');
M_.exo_names = char(M_.exo_names, 'ez');
M_.exo_names_tex = char(M_.exo_names_tex, 'ez');
M_.exo_names_long = char(M_.exo_names_long, 'ez');
M_.exo_names = char(M_.exo_names, 'exi');
M_.exo_names_tex = char(M_.exo_names_tex, 'exi');
M_.exo_names_long = char(M_.exo_names_long, 'exi');
M_.exo_names = char(M_.exo_names, 'ephi');
M_.exo_names_tex = char(M_.exo_names_tex, 'ephi');
M_.exo_names_long = char(M_.exo_names_long, 'ephi');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'yf');
M_.endo_names_tex = char(M_.endo_names_tex, 'yf');
M_.endo_names_long = char(M_.endo_names_long, 'yf');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'pie');
M_.endo_names_tex = char(M_.endo_names_tex, 'pie');
M_.endo_names_long = char(M_.endo_names_long, 'pie');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names_long = char(M_.endo_names_long, 'R');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names_long = char(M_.endo_names_long, 'g');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'Rf');
M_.endo_names_tex = char(M_.endo_names_tex, 'Rf');
M_.endo_names_long = char(M_.endo_names_long, 'Rf');
M_.endo_names = char(M_.endo_names, 'rf');
M_.endo_names_tex = char(M_.endo_names_tex, 'rf');
M_.endo_names_long = char(M_.endo_names_long, 'rf');
M_.endo_names = char(M_.endo_names, 'phi');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi');
M_.endo_names_long = char(M_.endo_names_long, 'phi');
M_.endo_names = char(M_.endo_names, 'xi');
M_.endo_names_tex = char(M_.endo_names_tex, 'xi');
M_.endo_names_long = char(M_.endo_names_long, 'xi');
M_.endo_names = char(M_.endo_names, 'outputgapn');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgapn');
M_.endo_names_long = char(M_.endo_names_long, 'outputgapn');
M_.endo_names = char(M_.endo_names, 'rff_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'rff\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'rff_q_obs');
M_.endo_names = char(M_.endo_names, 'pgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'pgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'xgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'xgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'xgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'outputgap');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgap');
M_.endo_names_long = char(M_.endo_names_long, 'outputgap');
M_.endo_partitions = struct();
M_.param_names = 'sigma';
M_.param_names_tex = 'sigma';
M_.param_names_long = 'sigma';
M_.param_names = char(M_.param_names, 'trend');
M_.param_names_tex = char(M_.param_names_tex, 'trend');
M_.param_names_long = char(M_.param_names_long, 'trend');
M_.param_names = char(M_.param_names, 'piestarobs');
M_.param_names_tex = char(M_.param_names_tex, 'piestarobs');
M_.param_names_long = char(M_.param_names_long, 'piestarobs');
M_.param_names = char(M_.param_names, 'rstarobs');
M_.param_names_tex = char(M_.param_names_tex, 'rstarobs');
M_.param_names_long = char(M_.param_names_long, 'rstarobs');
M_.param_names = char(M_.param_names, 'psi1');
M_.param_names_tex = char(M_.param_names_tex, 'psi1');
M_.param_names_long = char(M_.param_names_long, 'psi1');
M_.param_names = char(M_.param_names, 'psi2');
M_.param_names_tex = char(M_.param_names_tex, 'psi2');
M_.param_names_long = char(M_.param_names_long, 'psi2');
M_.param_names = char(M_.param_names, 'rhoR');
M_.param_names_tex = char(M_.param_names_tex, 'rhoR');
M_.param_names_long = char(M_.param_names_long, 'rhoR');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names_long = char(M_.param_names_long, 'rhog');
M_.param_names = char(M_.param_names, 'rhoz');
M_.param_names_tex = char(M_.param_names_tex, 'rhoz');
M_.param_names_long = char(M_.param_names_long, 'rhoz');
M_.param_names = char(M_.param_names, 'rhoxi');
M_.param_names_tex = char(M_.param_names_tex, 'rhoxi');
M_.param_names_long = char(M_.param_names_long, 'rhoxi');
M_.param_names = char(M_.param_names, 'rhophi');
M_.param_names_tex = char(M_.param_names_tex, 'rhophi');
M_.param_names_long = char(M_.param_names_long, 'rhophi');
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names_long = char(M_.param_names_long, 'kappa');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 5;
M_.endo_nbr = 16;
M_.param_nbr = 12;
M_.orig_endo_nbr = 16;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'xgdp_q_obs'};
options_.varobs(2)  = {'pgdp_q_obs'};
options_.varobs(3)  = {'rff_q_obs'};
options_.varobs_id = [ 15 14 13  ];
M_.Sigma_e = zeros(5, 5);
M_.Correlation_matrix = eye(5, 5);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('NK_RW97_20074_static');
erase_compiled_function('NK_RW97_20074_dynamic');
M_.orig_eq_nbr = 16;
M_.eq_nbr = 16;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 7 0;
 0 8 23;
 0 9 0;
 0 10 24;
 2 11 0;
 3 12 25;
 4 13 26;
 0 14 0;
 0 15 0;
 5 16 0;
 6 17 27;
 0 18 0;
 0 19 0;
 0 20 0;
 0 21 0;
 0 22 28;]';
M_.nstatic = 7;
M_.nfwrd   = 3;
M_.npred   = 3;
M_.nboth   = 3;
M_.nsfwrd   = 6;
M_.nspred   = 6;
M_.ndynamic   = 9;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:5];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(16, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(5, 1);
M_.params = NaN(12, 1);
M_.NNZDerivatives = [57; 0; -1];
M_.params( 2 ) = 0.500;
trend = M_.params( 2 );
M_.params( 3 ) = 1.000;
piestarobs = M_.params( 3 );
M_.params( 4 ) = 0.125;
rstarobs = M_.params( 4 );
M_.params( 12 ) = 0.300;
kappa = M_.params( 12 );
M_.params( 1 ) = 2.000;
sigma = M_.params( 1 );
M_.params( 5 ) = 1.500;
psi1 = M_.params( 5 );
M_.params( 6 ) = 0.125;
psi2 = M_.params( 6 );
M_.params( 7 ) = 0.500;
rhoR = M_.params( 7 );
M_.params( 8 ) = 0.800;
rhog = M_.params( 8 );
M_.params( 9 ) = 0.300;
rhoz = M_.params( 9 );
M_.params( 10 ) = 0.500;
rhoxi = M_.params( 10 );
M_.params( 11 ) = 0.500;
rhophi = M_.params( 11 );
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (0.01)^2;
M_.Sigma_e(2, 2) = (0.01)^2;
M_.Sigma_e(3, 3) = (0.01)^2;
M_.Sigma_e(4, 4) = (0.01)^2;
M_.Sigma_e(5, 5) = (0.01)^2;
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 2, NaN, (-Inf), Inf, 3, 0.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, NaN, (-Inf), Inf, 3, 1.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 2, 0.125, 0.0625, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 2, 0.3, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, NaN, (-Inf), Inf, 2, 2.0, 0.50, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 2, 0.125, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 1, 0.5, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 1, 0.8, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 1, 0.3, 0.10, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 1, 0.500, 0.20, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 1, 0.500, 0.20, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.0025, 0.0014, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.0063, 0.0032, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.0088, 0.0043, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.005, 0.004, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.005, 0.004, NaN, NaN, NaN ];
save('NK_RW97_20074_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('NK_RW97_20074_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('NK_RW97_20074_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('NK_RW97_20074_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('NK_RW97_20074_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('NK_RW97_20074_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('NK_RW97_20074_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
