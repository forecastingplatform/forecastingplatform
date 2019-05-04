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
M_.fname = 'DSGE_TEST_20074';
M_.dynare_version = '4.5.6';
oo_.dynare_version = '4.5.6';
options_.dynare_version = '4.5.6';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('DSGE_TEST_20074.log');
M_.exo_names = 'e_a';
M_.exo_names_tex = 'e\_a';
M_.exo_names_long = 'e_a';
M_.exo_names = char(M_.exo_names, 'e_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_g');
M_.exo_names_long = char(M_.exo_names_long, 'e_g');
M_.exo_names = char(M_.exo_names, 'e_rn');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_rn');
M_.exo_names_long = char(M_.exo_names_long, 'e_rn');
M_.exo_names = char(M_.exo_names, 'e_i');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_i');
M_.exo_names_long = char(M_.exo_names_long, 'e_i');
M_.exo_names = char(M_.exo_names, 'e_f');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_f');
M_.exo_names_long = char(M_.exo_names_long, 'e_f');
M_.endo_names = 'cH';
M_.endo_names_tex = 'cH';
M_.endo_names_long = 'cH';
M_.endo_names = char(M_.endo_names, 'hH');
M_.endo_names_tex = char(M_.endo_names_tex, 'hH');
M_.endo_names_long = char(M_.endo_names_long, 'hH');
M_.endo_names = char(M_.endo_names, 'piH');
M_.endo_names_tex = char(M_.endo_names_tex, 'piH');
M_.endo_names_long = char(M_.endo_names_long, 'piH');
M_.endo_names = char(M_.endo_names, 'rH');
M_.endo_names_tex = char(M_.endo_names_tex, 'rH');
M_.endo_names_long = char(M_.endo_names_long, 'rH');
M_.endo_names = char(M_.endo_names, 'r_nH');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_nH');
M_.endo_names_long = char(M_.endo_names_long, 'r_nH');
M_.endo_names = char(M_.endo_names, 'qH');
M_.endo_names_tex = char(M_.endo_names_tex, 'qH');
M_.endo_names_long = char(M_.endo_names_long, 'qH');
M_.endo_names = char(M_.endo_names, 'kH');
M_.endo_names_tex = char(M_.endo_names_tex, 'kH');
M_.endo_names_long = char(M_.endo_names_long, 'kH');
M_.endo_names = char(M_.endo_names, 'nH');
M_.endo_names_tex = char(M_.endo_names_tex, 'nH');
M_.endo_names_long = char(M_.endo_names_long, 'nH');
M_.endo_names = char(M_.endo_names, 'r_kH');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_kH');
M_.endo_names_long = char(M_.endo_names_long, 'r_kH');
M_.endo_names = char(M_.endo_names, 'yH');
M_.endo_names_tex = char(M_.endo_names_tex, 'yH');
M_.endo_names_long = char(M_.endo_names_long, 'yH');
M_.endo_names = char(M_.endo_names, 'xH');
M_.endo_names_tex = char(M_.endo_names_tex, 'xH');
M_.endo_names_long = char(M_.endo_names_long, 'xH');
M_.endo_names = char(M_.endo_names, 'iH');
M_.endo_names_tex = char(M_.endo_names_tex, 'iH');
M_.endo_names_long = char(M_.endo_names_long, 'iH');
M_.endo_names = char(M_.endo_names, 'aH');
M_.endo_names_tex = char(M_.endo_names_tex, 'aH');
M_.endo_names_long = char(M_.endo_names_long, 'aH');
M_.endo_names = char(M_.endo_names, 'c_eH');
M_.endo_names_tex = char(M_.endo_names_tex, 'c\_eH');
M_.endo_names_long = char(M_.endo_names_long, 'c_eH');
M_.endo_names = char(M_.endo_names, 'gH');
M_.endo_names_tex = char(M_.endo_names_tex, 'gH');
M_.endo_names_long = char(M_.endo_names_long, 'gH');
M_.endo_names = char(M_.endo_names, 'premiumH');
M_.endo_names_tex = char(M_.endo_names_tex, 'premiumH');
M_.endo_names_long = char(M_.endo_names_long, 'premiumH');
M_.endo_names = char(M_.endo_names, 'xiH');
M_.endo_names_tex = char(M_.endo_names_tex, 'xiH');
M_.endo_names_long = char(M_.endo_names_long, 'xiH');
M_.endo_names = char(M_.endo_names, 'fH');
M_.endo_names_tex = char(M_.endo_names_tex, 'fH');
M_.endo_names_long = char(M_.endo_names_long, 'fH');
M_.endo_names = char(M_.endo_names, 'yHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'yHf');
M_.endo_names_long = char(M_.endo_names_long, 'yHf');
M_.endo_names = char(M_.endo_names, 'kHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'kHf');
M_.endo_names_long = char(M_.endo_names_long, 'kHf');
M_.endo_names = char(M_.endo_names, 'iHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'iHf');
M_.endo_names_long = char(M_.endo_names_long, 'iHf');
M_.endo_names = char(M_.endo_names, 'rHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'rHf');
M_.endo_names_long = char(M_.endo_names_long, 'rHf');
M_.endo_names = char(M_.endo_names, 'r_kHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_kHf');
M_.endo_names_long = char(M_.endo_names_long, 'r_kHf');
M_.endo_names = char(M_.endo_names, 'nHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'nHf');
M_.endo_names_long = char(M_.endo_names_long, 'nHf');
M_.endo_names = char(M_.endo_names, 'cHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'cHf');
M_.endo_names_long = char(M_.endo_names_long, 'cHf');
M_.endo_names = char(M_.endo_names, 'qHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'qHf');
M_.endo_names_long = char(M_.endo_names_long, 'qHf');
M_.endo_names = char(M_.endo_names, 'hHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'hHf');
M_.endo_names_long = char(M_.endo_names_long, 'hHf');
M_.endo_names = char(M_.endo_names, 'c_eHf');
M_.endo_names_tex = char(M_.endo_names_tex, 'c\_eHf');
M_.endo_names_long = char(M_.endo_names_long, 'c_eHf');
M_.endo_names = char(M_.endo_names, 'xgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'xgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'xgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'pgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'pgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'rff_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'rff\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'rff_q_obs');
M_.endo_names = char(M_.endo_names, 'fpi_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'fpi\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'fpi_q_obs');
M_.endo_names = char(M_.endo_names, 'cp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'cp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'cp_q_obs');
M_.endo_names = char(M_.endo_names, 'outputgap');
M_.endo_names_tex = char(M_.endo_names_tex, 'outputgap');
M_.endo_names_long = char(M_.endo_names_long, 'outputgap');
M_.endo_partitions = struct();
M_.param_names = 'X';
M_.param_names_tex = 'X';
M_.param_names_long = 'X';
M_.param_names = char(M_.param_names, 'H');
M_.param_names_tex = char(M_.param_names_tex, 'H');
M_.param_names_long = char(M_.param_names_long, 'H');
M_.param_names = char(M_.param_names, 'GY');
M_.param_names_tex = char(M_.param_names_tex, 'GY');
M_.param_names_long = char(M_.param_names_long, 'GY');
M_.param_names = char(M_.param_names, 'omegav');
M_.param_names_tex = char(M_.param_names_tex, 'omegav');
M_.param_names_long = char(M_.param_names_long, 'omegav');
M_.param_names = char(M_.param_names, 'alphav');
M_.param_names_tex = char(M_.param_names_tex, 'alphav');
M_.param_names_long = char(M_.param_names_long, 'alphav');
M_.param_names = char(M_.param_names, 'gammav');
M_.param_names_tex = char(M_.param_names_tex, 'gammav');
M_.param_names_long = char(M_.param_names_long, 'gammav');
M_.param_names = char(M_.param_names, 'deltav');
M_.param_names_tex = char(M_.param_names_tex, 'deltav');
M_.param_names_long = char(M_.param_names_long, 'deltav');
M_.param_names = char(M_.param_names, 'phiv');
M_.param_names_tex = char(M_.param_names_tex, 'phiv');
M_.param_names_long = char(M_.param_names_long, 'phiv');
M_.param_names = char(M_.param_names, 'thetav');
M_.param_names_tex = char(M_.param_names_tex, 'thetav');
M_.param_names_long = char(M_.param_names_long, 'thetav');
M_.param_names = char(M_.param_names, 'etav');
M_.param_names_tex = char(M_.param_names_tex, 'etav');
M_.param_names_long = char(M_.param_names_long, 'etav');
M_.param_names = char(M_.param_names, 'zetav');
M_.param_names_tex = char(M_.param_names_tex, 'zetav');
M_.param_names_long = char(M_.param_names_long, 'zetav');
M_.param_names = char(M_.param_names, 'zetay');
M_.param_names_tex = char(M_.param_names_tex, 'zetay');
M_.param_names_long = char(M_.param_names_long, 'zetay');
M_.param_names = char(M_.param_names, 'rhov');
M_.param_names_tex = char(M_.param_names_tex, 'rhov');
M_.param_names_long = char(M_.param_names_long, 'rhov');
M_.param_names = char(M_.param_names, 'rhov_a');
M_.param_names_tex = char(M_.param_names_tex, 'rhov\_a');
M_.param_names_long = char(M_.param_names_long, 'rhov_a');
M_.param_names = char(M_.param_names, 'rhov_g');
M_.param_names_tex = char(M_.param_names_tex, 'rhov\_g');
M_.param_names_long = char(M_.param_names_long, 'rhov_g');
M_.param_names = char(M_.param_names, 'rhov_i');
M_.param_names_tex = char(M_.param_names_tex, 'rhov\_i');
M_.param_names_long = char(M_.param_names_long, 'rhov_i');
M_.param_names = char(M_.param_names, 'rhov_f');
M_.param_names_tex = char(M_.param_names_tex, 'rhov\_f');
M_.param_names_long = char(M_.param_names_long, 'rhov_f');
M_.param_names = char(M_.param_names, 'ytrend');
M_.param_names_tex = char(M_.param_names_tex, 'ytrend');
M_.param_names_long = char(M_.param_names_long, 'ytrend');
M_.param_names = char(M_.param_names, 'pi_bar');
M_.param_names_tex = char(M_.param_names_tex, 'pi\_bar');
M_.param_names_long = char(M_.param_names_long, 'pi_bar');
M_.param_names = char(M_.param_names, 's_bar');
M_.param_names_tex = char(M_.param_names_tex, 's\_bar');
M_.param_names_long = char(M_.param_names_long, 's_bar');
M_.param_names = char(M_.param_names, 'F_bar');
M_.param_names_tex = char(M_.param_names_tex, 'F\_bar');
M_.param_names_long = char(M_.param_names_long, 'F_bar');
M_.param_names = char(M_.param_names, 'para_sp_b');
M_.param_names_tex = char(M_.param_names_tex, 'para\_sp\_b');
M_.param_names_long = char(M_.param_names_long, 'para_sp_b');
M_.param_names = char(M_.param_names, 'constebeta');
M_.param_names_tex = char(M_.param_names_tex, 'constebeta');
M_.param_names_long = char(M_.param_names_long, 'constebeta');
M_.param_names = char(M_.param_names, 'iotapi');
M_.param_names_tex = char(M_.param_names_tex, 'iotapi');
M_.param_names_long = char(M_.param_names_long, 'iotapi');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 5;
M_.endo_nbr = 34;
M_.param_nbr = 24;
M_.orig_endo_nbr = 34;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'xgdp_q_obs'};
options_.varobs(2)  = {'fpi_q_obs'};
options_.varobs(3)  = {'pgdp_q_obs'};
options_.varobs(4)  = {'rff_q_obs'};
options_.varobs(5)  = {'cp_q_obs'};
options_.varobs_id = [ 29 32 30 31 33  ];
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
erase_compiled_function('DSGE_TEST_20074_static');
erase_compiled_function('DSGE_TEST_20074_dynamic');
M_.orig_eq_nbr = 34;
M_.eq_nbr = 34;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 16 50;
 0 17 0;
 1 18 51;
 2 19 0;
 3 20 0;
 4 21 0;
 5 22 0;
 0 23 0;
 0 24 52;
 6 25 0;
 0 26 0;
 7 27 53;
 8 28 0;
 0 29 0;
 9 30 0;
 0 31 0;
 10 32 0;
 11 33 0;
 0 34 0;
 12 35 0;
 13 36 54;
 14 37 0;
 0 38 55;
 0 39 0;
 0 40 56;
 15 41 0;
 0 42 0;
 0 43 0;
 0 44 0;
 0 45 0;
 0 46 0;
 0 47 0;
 0 48 0;
 0 49 0;]';
M_.nstatic = 15;
M_.nfwrd   = 4;
M_.npred   = 12;
M_.nboth   = 3;
M_.nsfwrd   = 7;
M_.nspred   = 15;
M_.ndynamic   = 19;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:5];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(34, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(5, 1);
M_.params = NaN(24, 1);
M_.NNZDerivatives = [130; 0; -1];
thispath = cd; 
cd('..');
external_function_path = cd('..'); 
eval(['addpath  ' external_function_path '; ']);
cd(thispath); 
M_.params( 10 ) = 2;
etav = M_.params( 10 );
M_.params( 7 ) = 0.025;
deltav = M_.params( 7 );
M_.params( 1 ) = 1.1;
X = M_.params( 1 );
M_.params( 6 ) = 0.9728;
gammav = M_.params( 6 );
M_.params( 21 ) = 0.0075;
F_bar = M_.params( 21 );
M_.params( 3 ) = 0.2;
GY = M_.params( 3 );
M_.params( 5 ) = 0.35;
alphav = M_.params( 5 );
M_.params( 4 ) = 0.64/(1-M_.params(5));
omegav = M_.params( 4 );
M_.params( 2 ) = 0.3333333333333333;
H = M_.params( 2 );
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 22, NaN, (-Inf), Inf, 1, 0.05, 0.005, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 3, 4, 1.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 1, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 2, 1.5, 0.25, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 2, 0.125, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 19, NaN, (-Inf), Inf, 2, 0.62, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 24, NaN, (-Inf), Inf, 1, 0.5, 0.15, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 23, NaN, (-Inf), Inf, 2, 0.3, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 18, NaN, (-Inf), Inf, 3, 0.4, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 20, NaN, (-Inf), Inf, 2, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 14, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 15, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 16, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 17, NaN, (-Inf), Inf, 1, 0.75, 0.15, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.1, 2.0, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.05, 4.0, NaN, NaN, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==22);
estim_params_.param_vals(tmp1,2) = 0.05;
tmp1 = find(estim_params_.param_vals(:,1)==8);
estim_params_.param_vals(tmp1,2) = 5;
tmp1 = find(estim_params_.param_vals(:,1)==9);
estim_params_.param_vals(tmp1,2) = 0.75;
tmp1 = find(estim_params_.param_vals(:,1)==13);
estim_params_.param_vals(tmp1,2) = 0.7;
tmp1 = find(estim_params_.param_vals(:,1)==11);
estim_params_.param_vals(tmp1,2) = 1.5;
tmp1 = find(estim_params_.param_vals(:,1)==12);
estim_params_.param_vals(tmp1,2) = 0.125;
tmp1 = find(estim_params_.param_vals(:,1)==19);
estim_params_.param_vals(tmp1,2) = 0.625;
tmp1 = find(estim_params_.param_vals(:,1)==23);
estim_params_.param_vals(tmp1,2) = 0.25;
tmp1 = find(estim_params_.param_vals(:,1)==24);
estim_params_.param_vals(tmp1,2) = 0.5;
tmp1 = find(estim_params_.param_vals(:,1)==18);
estim_params_.param_vals(tmp1,2) = 0.4;
tmp1 = find(estim_params_.param_vals(:,1)==20);
estim_params_.param_vals(tmp1,2) = 0.5;
tmp1 = find(estim_params_.param_vals(:,1)==14);
estim_params_.param_vals(tmp1,2) = 0.90;
tmp1 = find(estim_params_.param_vals(:,1)==15);
estim_params_.param_vals(tmp1,2) = 0.80;
tmp1 = find(estim_params_.param_vals(:,1)==16);
estim_params_.param_vals(tmp1,2) = 0.80;
tmp1 = find(estim_params_.param_vals(:,1)==17);
estim_params_.param_vals(tmp1,2) = 0.80;
tmp1 = find(estim_params_.var_exo(:,1)==1);
estim_params_.var_exo(tmp1,2) = 0.5;
tmp1 = find(estim_params_.var_exo(:,1)==2);
estim_params_.var_exo(tmp1,2) = 0.5;
tmp1 = find(estim_params_.var_exo(:,1)==3);
estim_params_.var_exo(tmp1,2) = 0.0625;
tmp1 = find(estim_params_.var_exo(:,1)==4);
estim_params_.var_exo(tmp1,2) = 0.5;
tmp1 = find(estim_params_.var_exo(:,1)==5);
estim_params_.var_exo(tmp1,2) = 0.5;
save('DSGE_TEST_20074_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('DSGE_TEST_20074_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
