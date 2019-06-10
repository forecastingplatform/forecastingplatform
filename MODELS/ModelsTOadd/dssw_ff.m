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
M_.fname = 'dssw_ff';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('dssw_ff.log');
M_.exo_names = 'eps_z';
M_.exo_names_tex = 'eps\_z';
M_.exo_names_long = 'eps_z';
M_.exo_names = char(M_.exo_names, 'eps_b');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_b');
M_.exo_names_long = char(M_.exo_names_long, 'eps_b');
M_.exo_names = char(M_.exo_names, 'eps_phi');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_phi');
M_.exo_names_long = char(M_.exo_names_long, 'eps_phi');
M_.exo_names = char(M_.exo_names, 'eps_mu');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_mu');
M_.exo_names_long = char(M_.exo_names_long, 'eps_mu');
M_.exo_names = char(M_.exo_names, 'eps_lambda_f');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_lambda\_f');
M_.exo_names_long = char(M_.exo_names_long, 'eps_lambda_f');
M_.exo_names = char(M_.exo_names, 'eps_g');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_g');
M_.exo_names_long = char(M_.exo_names_long, 'eps_g');
M_.exo_names = char(M_.exo_names, 'eps_R');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_R');
M_.exo_names_long = char(M_.exo_names_long, 'eps_R');
M_.exo_names = char(M_.exo_names, 'eps_sigma');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_sigma');
M_.exo_names_long = char(M_.exo_names_long, 'eps_sigma');
M_.exo_names = char(M_.exo_names, 'eps_nu');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_nu');
M_.exo_names_long = char(M_.exo_names_long, 'eps_nu');
M_.endo_names = 'lambda';
M_.endo_names_tex = 'lambda';
M_.endo_names_long = 'lambda';
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names_long = char(M_.endo_names_long, 'R');
M_.endo_names = char(M_.endo_names, 'pic');
M_.endo_names_tex = char(M_.endo_names_tex, 'pic');
M_.endo_names_long = char(M_.endo_names_long, 'pic');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'w_tilda');
M_.endo_names_tex = char(M_.endo_names_tex, 'w\_tilda');
M_.endo_names_long = char(M_.endo_names_long, 'w_tilda');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'phi_w');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi\_w');
M_.endo_names_long = char(M_.endo_names_long, 'phi_w');
M_.endo_names = char(M_.endo_names, 'psi_w');
M_.endo_names_tex = char(M_.endo_names_tex, 'psi\_w');
M_.endo_names_long = char(M_.endo_names_long, 'psi_w');
M_.endo_names = char(M_.endo_names, 'L');
M_.endo_names_tex = char(M_.endo_names_tex, 'L');
M_.endo_names_long = char(M_.endo_names_long, 'L');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'k_bar');
M_.endo_names_tex = char(M_.endo_names_tex, 'k\_bar');
M_.endo_names_long = char(M_.endo_names_long, 'k_bar');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'Q');
M_.endo_names_tex = char(M_.endo_names_tex, 'Q');
M_.endo_names_long = char(M_.endo_names_long, 'Q');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names_long = char(M_.endo_names_long, 'd');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'R_e');
M_.endo_names_tex = char(M_.endo_names_tex, 'R\_e');
M_.endo_names_long = char(M_.endo_names_long, 'R_e');
M_.endo_names = char(M_.endo_names, 'r_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_k');
M_.endo_names_long = char(M_.endo_names_long, 'r_k');
M_.endo_names = char(M_.endo_names, 'u');
M_.endo_names_tex = char(M_.endo_names_tex, 'u');
M_.endo_names_long = char(M_.endo_names_long, 'u');
M_.endo_names = char(M_.endo_names, 'R_d');
M_.endo_names_tex = char(M_.endo_names_tex, 'R\_d');
M_.endo_names_long = char(M_.endo_names_long, 'R_d');
M_.endo_names = char(M_.endo_names, 'F1');
M_.endo_names_tex = char(M_.endo_names_tex, 'F1');
M_.endo_names_long = char(M_.endo_names_long, 'F1');
M_.endo_names = char(M_.endo_names, 'F2');
M_.endo_names_tex = char(M_.endo_names_tex, 'F2');
M_.endo_names_long = char(M_.endo_names_long, 'F2');
M_.endo_names = char(M_.endo_names, 'F1_prim');
M_.endo_names_tex = char(M_.endo_names_tex, 'F1\_prim');
M_.endo_names_long = char(M_.endo_names_long, 'F1_prim');
M_.endo_names = char(M_.endo_names, 'omega');
M_.endo_names_tex = char(M_.endo_names_tex, 'omega');
M_.endo_names_long = char(M_.endo_names_long, 'omega');
M_.endo_names = char(M_.endo_names, 'mc');
M_.endo_names_tex = char(M_.endo_names_tex, 'mc');
M_.endo_names_long = char(M_.endo_names_long, 'mc');
M_.endo_names = char(M_.endo_names, 'p_tilda');
M_.endo_names_tex = char(M_.endo_names_tex, 'p\_tilda');
M_.endo_names_long = char(M_.endo_names_long, 'p_tilda');
M_.endo_names = char(M_.endo_names, 'phi_f');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi\_f');
M_.endo_names_long = char(M_.endo_names_long, 'phi_f');
M_.endo_names = char(M_.endo_names, 'psi_f');
M_.endo_names_tex = char(M_.endo_names_tex, 'psi\_f');
M_.endo_names_long = char(M_.endo_names_long, 'psi_f');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'Delta');
M_.endo_names_tex = char(M_.endo_names_tex, 'Delta');
M_.endo_names_long = char(M_.endo_names_long, 'Delta');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'lb');
M_.endo_names_tex = char(M_.endo_names_tex, 'lb');
M_.endo_names_long = char(M_.endo_names_long, 'lb');
M_.endo_names = char(M_.endo_names, 'lphi');
M_.endo_names_tex = char(M_.endo_names_tex, 'lphi');
M_.endo_names_long = char(M_.endo_names_long, 'lphi');
M_.endo_names = char(M_.endo_names, 'lmu');
M_.endo_names_tex = char(M_.endo_names_tex, 'lmu');
M_.endo_names_long = char(M_.endo_names_long, 'lmu');
M_.endo_names = char(M_.endo_names, 'llambda_f');
M_.endo_names_tex = char(M_.endo_names_tex, 'llambda\_f');
M_.endo_names_long = char(M_.endo_names_long, 'llambda_f');
M_.endo_names = char(M_.endo_names, 'lg');
M_.endo_names_tex = char(M_.endo_names_tex, 'lg');
M_.endo_names_long = char(M_.endo_names_long, 'lg');
M_.endo_names = char(M_.endo_names, 'lA');
M_.endo_names_tex = char(M_.endo_names_tex, 'lA');
M_.endo_names_long = char(M_.endo_names_long, 'lA');
M_.endo_names = char(M_.endo_names, 'lsigma');
M_.endo_names_tex = char(M_.endo_names_tex, 'lsigma');
M_.endo_names_long = char(M_.endo_names_long, 'lsigma');
M_.endo_names = char(M_.endo_names, 'lnu');
M_.endo_names_tex = char(M_.endo_names_tex, 'lnu');
M_.endo_names_long = char(M_.endo_names_long, 'lnu');
M_.endo_names = char(M_.endo_names, 'dlnY');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnY');
M_.endo_names_long = char(M_.endo_names_long, 'dlnY');
M_.endo_names = char(M_.endo_names, 'dlnC');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnC');
M_.endo_names_long = char(M_.endo_names_long, 'dlnC');
M_.endo_names = char(M_.endo_names, 'dlnI');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnI');
M_.endo_names_long = char(M_.endo_names_long, 'dlnI');
M_.endo_names = char(M_.endo_names, 'lnL');
M_.endo_names_tex = char(M_.endo_names_tex, 'lnL');
M_.endo_names_long = char(M_.endo_names_long, 'lnL');
M_.endo_names = char(M_.endo_names, 'dlnw');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnw');
M_.endo_names_long = char(M_.endo_names_long, 'dlnw');
M_.endo_names = char(M_.endo_names, 'dlnP');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnP');
M_.endo_names_long = char(M_.endo_names_long, 'dlnP');
M_.endo_names = char(M_.endo_names, 'FedFunds');
M_.endo_names_tex = char(M_.endo_names_tex, 'FedFunds');
M_.endo_names_long = char(M_.endo_names_long, 'FedFunds');
M_.endo_names = char(M_.endo_names, 'dlnD');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnD');
M_.endo_names_long = char(M_.endo_names_long, 'dlnD');
M_.endo_names = char(M_.endo_names, 'dlnDn');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnDn');
M_.endo_names_long = char(M_.endo_names_long, 'dlnDn');
M_.endo_names = char(M_.endo_names, 'Spread');
M_.endo_names_tex = char(M_.endo_names_tex, 'Spread');
M_.endo_names_long = char(M_.endo_names_long, 'Spread');
M_.endo_partitions = struct();
M_.param_names = 'phi';
M_.param_names_tex = 'phi';
M_.param_names_long = 'phi';
M_.param_names = char(M_.param_names, 'lambda_w');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_w');
M_.param_names_long = char(M_.param_names_long, 'lambda_w');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'zeta_p');
M_.param_names_tex = char(M_.param_names_tex, 'zeta\_p');
M_.param_names_long = char(M_.param_names_long, 'zeta_p');
M_.param_names = char(M_.param_names, 'iota_p');
M_.param_names_tex = char(M_.param_names_tex, 'iota\_p');
M_.param_names_long = char(M_.param_names_long, 'iota_p');
M_.param_names = char(M_.param_names, 's_bis');
M_.param_names_tex = char(M_.param_names_tex, 's\_bis');
M_.param_names_long = char(M_.param_names_long, 's_bis');
M_.param_names = char(M_.param_names, 'h');
M_.param_names_tex = char(M_.param_names_tex, 'h');
M_.param_names_long = char(M_.param_names_long, 'h');
M_.param_names = char(M_.param_names, 'nu_l');
M_.param_names_tex = char(M_.param_names_tex, 'nu\_l');
M_.param_names_long = char(M_.param_names_long, 'nu_l');
M_.param_names = char(M_.param_names, 'zeta_w');
M_.param_names_tex = char(M_.param_names_tex, 'zeta\_w');
M_.param_names_long = char(M_.param_names_long, 'zeta_w');
M_.param_names = char(M_.param_names, 'iota_w');
M_.param_names_tex = char(M_.param_names_tex, 'iota\_w');
M_.param_names_long = char(M_.param_names_long, 'iota_w');
M_.param_names = char(M_.param_names, 'r_star');
M_.param_names_tex = char(M_.param_names_tex, 'r\_star');
M_.param_names_long = char(M_.param_names_long, 'r_star');
M_.param_names = char(M_.param_names, 'psi_1');
M_.param_names_tex = char(M_.param_names_tex, 'psi\_1');
M_.param_names_long = char(M_.param_names_long, 'psi_1');
M_.param_names = char(M_.param_names, 'psi_2');
M_.param_names_tex = char(M_.param_names_tex, 'psi\_2');
M_.param_names_long = char(M_.param_names_long, 'psi_2');
M_.param_names = char(M_.param_names, 'rho_R');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_R');
M_.param_names_long = char(M_.param_names_long, 'rho_R');
M_.param_names = char(M_.param_names, 'pi_star');
M_.param_names_tex = char(M_.param_names_tex, 'pi\_star');
M_.param_names_long = char(M_.param_names_long, 'pi_star');
M_.param_names = char(M_.param_names, 'gamma_star');
M_.param_names_tex = char(M_.param_names_tex, 'gamma\_star');
M_.param_names_long = char(M_.param_names_long, 'gamma_star');
M_.param_names = char(M_.param_names, 'lambda_f');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_f');
M_.param_names_long = char(M_.param_names_long, 'lambda_f');
M_.param_names = char(M_.param_names, 'gg_star');
M_.param_names_tex = char(M_.param_names_tex, 'gg\_star');
M_.param_names_long = char(M_.param_names_long, 'gg_star');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'nu');
M_.param_names_tex = char(M_.param_names_tex, 'nu');
M_.param_names_long = char(M_.param_names_long, 'nu');
M_.param_names = char(M_.param_names, 'chi');
M_.param_names_tex = char(M_.param_names_tex, 'chi');
M_.param_names_long = char(M_.param_names_long, 'chi');
M_.param_names = char(M_.param_names, 'we');
M_.param_names_tex = char(M_.param_names_tex, 'we');
M_.param_names_long = char(M_.param_names_long, 'we');
M_.param_names = char(M_.param_names, 'a_bis');
M_.param_names_tex = char(M_.param_names_tex, 'a\_bis');
M_.param_names_long = char(M_.param_names_long, 'a_bis');
M_.param_names = char(M_.param_names, 'rho_z');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_z');
M_.param_names_long = char(M_.param_names_long, 'rho_z');
M_.param_names = char(M_.param_names, 'rho_b');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_b');
M_.param_names_long = char(M_.param_names_long, 'rho_b');
M_.param_names = char(M_.param_names, 'rho_phi');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_phi');
M_.param_names_long = char(M_.param_names_long, 'rho_phi');
M_.param_names = char(M_.param_names, 'rho_mu');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_mu');
M_.param_names_long = char(M_.param_names_long, 'rho_mu');
M_.param_names = char(M_.param_names, 'rho_lambda_f');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_lambda\_f');
M_.param_names_long = char(M_.param_names_long, 'rho_lambda_f');
M_.param_names = char(M_.param_names, 'rho_g');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_g');
M_.param_names_long = char(M_.param_names_long, 'rho_g');
M_.param_names = char(M_.param_names, 'rho_A');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_A');
M_.param_names_long = char(M_.param_names_long, 'rho_A');
M_.param_names = char(M_.param_names, 'rho_sigma');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_sigma');
M_.param_names_long = char(M_.param_names_long, 'rho_sigma');
M_.param_names = char(M_.param_names, 'rho_nu');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_nu');
M_.param_names_long = char(M_.param_names_long, 'rho_nu');
M_.param_names = char(M_.param_names, 'L_adj');
M_.param_names_tex = char(M_.param_names_tex, 'L\_adj');
M_.param_names_long = char(M_.param_names_long, 'L_adj');
M_.param_names = char(M_.param_names, 'D_adj');
M_.param_names_tex = char(M_.param_names_tex, 'D\_adj');
M_.param_names_long = char(M_.param_names_long, 'D_adj');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 9;
M_.endo_nbr = 48;
M_.param_nbr = 35;
M_.orig_endo_nbr = 48;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'dlnY'};
options_.varobs(2)  = {'dlnC'};
options_.varobs(3)  = {'dlnI'};
options_.varobs(4)  = {'lnL'};
options_.varobs(5)  = {'dlnw'};
options_.varobs(6)  = {'dlnP'};
options_.varobs(7)  = {'FedFunds'};
options_.varobs(8)  = {'dlnDn'};
options_.varobs(9)  = {'Spread'};
options_.varobs_id = [ 39 40 41 42 43 44 45 47 48  ];
M_.Sigma_e = zeros(9, 9);
M_.Correlation_matrix = eye(9, 9);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 0;
erase_compiled_function('dssw_ff_static');
erase_compiled_function('dssw_ff_dynamic');
M_.orig_eq_nbr = 48;
M_.eq_nbr = 48;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 19 67;
 1 20 0;
 2 21 68;
 3 22 69;
 0 23 0;
 4 24 0;
 0 25 70;
 0 26 71;
 0 27 0;
 0 28 0;
 5 29 0;
 6 30 72;
 7 31 73;
 8 32 0;
 0 33 0;
 0 34 74;
 0 35 0;
 0 36 0;
 0 37 0;
 0 38 75;
 0 39 76;
 0 40 77;
 0 41 78;
 0 42 0;
 0 43 0;
 0 44 79;
 0 45 80;
 9 46 0;
 10 47 0;
 11 48 81;
 12 49 82;
 13 50 0;
 14 51 83;
 15 52 0;
 16 53 0;
 0 54 0;
 17 55 0;
 18 56 0;
 0 57 0;
 0 58 0;
 0 59 0;
 0 60 0;
 0 61 0;
 0 62 0;
 0 63 0;
 0 64 0;
 0 65 0;
 0 66 0;]';
M_.nstatic = 20;
M_.nfwrd   = 10;
M_.npred   = 11;
M_.nboth   = 7;
M_.nsfwrd   = 17;
M_.nspred   = 18;
M_.ndynamic   = 28;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:9];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(48, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(9, 1);
M_.params = NaN(35, 1);
M_.NNZDerivatives = [232; 640; -1];
close all;
M_.params( 1 ) = 0.8;
phi = M_.params( 1 );
M_.params( 2 ) = 0.3;
lambda_w = M_.params( 2 );
M_.params( 3 ) = 0.025;
delta = M_.params( 3 );
M_.params( 4 ) = 0.33;
alpha = M_.params( 4 );
M_.params( 5 ) = 0.6;
zeta_p = M_.params( 5 );
M_.params( 6 ) = 0.5;
iota_p = M_.params( 6 );
M_.params( 7 ) = 4;
s_bis = M_.params( 7 );
M_.params( 8 ) = 0.7;
h = M_.params( 8 );
M_.params( 9 ) = 2;
nu_l = M_.params( 9 );
M_.params( 10 ) = 0.6;
zeta_w = M_.params( 10 );
M_.params( 11 ) = 0.5;
iota_w = M_.params( 11 );
M_.params( 12 ) = 2;
r_star = M_.params( 12 );
M_.params( 13 ) = 1.5;
psi_1 = M_.params( 13 );
M_.params( 14 ) = 0.2;
psi_2 = M_.params( 14 );
M_.params( 15 ) = 0.5;
rho_R = M_.params( 15 );
M_.params( 16 ) = 3;
pi_star = M_.params( 16 );
M_.params( 17 ) = 2;
gamma_star = M_.params( 17 );
M_.params( 18 ) = 0.15;
lambda_f = M_.params( 18 );
M_.params( 19 ) = 0.2;
gg_star = M_.params( 19 );
M_.params( 20 ) = 0.30;
sigma = M_.params( 20 );
M_.params( 21 ) = 0.975;
nu = M_.params( 21 );
M_.params( 22 ) = 0.12;
chi = M_.params( 22 );
M_.params( 23 ) = 0.01;
we = M_.params( 23 );
M_.params( 25 ) = 0.9;
rho_z = M_.params( 25 );
M_.params( 26 ) = 0.9;
rho_b = M_.params( 26 );
M_.params( 27 ) = 0.9;
rho_phi = M_.params( 27 );
M_.params( 28 ) = 0.9;
rho_mu = M_.params( 28 );
M_.params( 29 ) = 0.9;
rho_lambda_f = M_.params( 29 );
M_.params( 30 ) = 0.9;
rho_g = M_.params( 30 );
M_.params( 31 ) = 0.9;
rho_A = M_.params( 31 );
M_.params( 32 ) = 0.9;
rho_sigma = M_.params( 32 );
M_.params( 33 ) = 0.9;
rho_nu = M_.params( 33 );
M_.params( 24 ) = 0.2;
a_bis = M_.params( 24 );
M_.params( 34 ) = 662;
L_adj = M_.params( 34 );
M_.params( 35 ) = 0;
D_adj = M_.params( 35 );
steady;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (1)^2;
M_.Sigma_e(2, 2) = (1)^2;
M_.Sigma_e(3, 3) = (1)^2;
M_.Sigma_e(4, 4) = (1)^2;
M_.Sigma_e(5, 5) = (1)^2;
M_.Sigma_e(6, 6) = (1)^2;
M_.Sigma_e(7, 7) = (1)^2;
M_.Sigma_e(8, 8) = (1)^2;
M_.Sigma_e(9, 9) = (1)^2;
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 1, 0.33, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 2, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, NaN, (-Inf), Inf, 1, 0.7, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 24, NaN, (-Inf), Inf, 2, 0.2, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, NaN, (-Inf), Inf, 2, 2, 0.75, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 10, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 11, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, NaN, (-Inf), Inf, 2, 2, 1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, NaN, (-Inf), Inf, 2, 1.5, 0.4, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 14, NaN, (-Inf), Inf, 2, 0.2, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 15, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 16, NaN, (-Inf), Inf, 3, 3.01, 1.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 17, NaN, (-Inf), Inf, 2, 2, 1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 18, NaN, (-Inf), Inf, 2, 0.15, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 19, NaN, (-Inf), Inf, 2, 0.3, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 34, NaN, (-Inf), Inf, 3, 662, 1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 35, NaN, (-Inf), Inf, 3, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 22, NaN, (-Inf), Inf, 1, 0.12, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 21, NaN, (-Inf), Inf, 1, 0.975, 0.001, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 20, NaN, (-Inf), Inf, 2, 0.3, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 25, NaN, (-Inf), Inf, 1, 0.2, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 27, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 29, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 28, NaN, (-Inf), Inf, 1, 0.8, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 26, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 30, NaN, (-Inf), Inf, 1, 0.8, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 32, NaN, (-Inf), Inf, 1, 0.8, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 33, NaN, (-Inf), Inf, 1, 0.8, 0.2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 2, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 6, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 7, NaN, (-Inf), Inf, 4, 0.25, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 8, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 9, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==4);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(4,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2647;
end
tmp1 = find(estim_params_.param_vals(:,1)==5);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(5,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.5567;
end
tmp1 = find(estim_params_.param_vals(:,1)==6);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(6,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.1332;
end
tmp1 = find(estim_params_.param_vals(:,1)==7);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(7,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.3014;
end
tmp1 = find(estim_params_.param_vals(:,1)==8);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(8,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.7427;
end
tmp1 = find(estim_params_.param_vals(:,1)==24);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(24,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2492;
end
tmp1 = find(estim_params_.param_vals(:,1)==9);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(9,:))))
else
    estim_params_.param_vals(tmp1,2) = 2.1929;
end
tmp1 = find(estim_params_.param_vals(:,1)==10);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(10,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2223;
end
tmp1 = find(estim_params_.param_vals(:,1)==11);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(11,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.0735;
end
tmp1 = find(estim_params_.param_vals(:,1)==12);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(12,:))))
else
    estim_params_.param_vals(tmp1,2) = 1.7943;
end
tmp1 = find(estim_params_.param_vals(:,1)==13);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(13,:))))
else
    estim_params_.param_vals(tmp1,2) = 2.0128;
end
tmp1 = find(estim_params_.param_vals(:,1)==14);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(14,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.1185;
end
tmp1 = find(estim_params_.param_vals(:,1)==15);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(15,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.5849;
end
tmp1 = find(estim_params_.param_vals(:,1)==16);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(16,:))))
else
    estim_params_.param_vals(tmp1,2) = 3.3172;
end
tmp1 = find(estim_params_.param_vals(:,1)==17);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(17,:))))
else
    estim_params_.param_vals(tmp1,2) = 1.3957;
end
tmp1 = find(estim_params_.param_vals(:,1)==18);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(18,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.1841;
end
tmp1 = find(estim_params_.param_vals(:,1)==19);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(19,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.3022;
end
tmp1 = find(estim_params_.param_vals(:,1)==34);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(34,:))))
else
    estim_params_.param_vals(tmp1,2) = 661.8189;
end
tmp1 = find(estim_params_.param_vals(:,1)==35);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(35,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.1877;
end
tmp1 = find(estim_params_.param_vals(:,1)==22);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(22,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.12;
end
tmp1 = find(estim_params_.param_vals(:,1)==21);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(21,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9779;
end
tmp1 = find(estim_params_.param_vals(:,1)==20);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(20,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2847;
end
tmp1 = find(estim_params_.param_vals(:,1)==25);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(25,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.0998;
end
tmp1 = find(estim_params_.param_vals(:,1)==27);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(27,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9802;
end
tmp1 = find(estim_params_.param_vals(:,1)==29);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(29,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.8715;
end
tmp1 = find(estim_params_.param_vals(:,1)==28);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(28,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.8434;
end
tmp1 = find(estim_params_.param_vals(:,1)==26);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(26,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2005;
end
tmp1 = find(estim_params_.param_vals(:,1)==30);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(30,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9274;
end
tmp1 = find(estim_params_.param_vals(:,1)==32);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(32,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9125;
end
tmp1 = find(estim_params_.param_vals(:,1)==33);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(33,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.4349;
end
tmp1 = find(estim_params_.var_exo(:,1)==1);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(1,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.9362;
end
tmp1 = find(estim_params_.var_exo(:,1)==3);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(3,:))))
else
    estim_params_.var_exo(tmp1,2) = 3.1353;
end
tmp1 = find(estim_params_.var_exo(:,1)==5);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(5,:))))
else
    estim_params_.var_exo(tmp1,2) = 5.6197;
end
tmp1 = find(estim_params_.var_exo(:,1)==4);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(4,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.6273;
end
tmp1 = find(estim_params_.var_exo(:,1)==2);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(2,:))))
else
    estim_params_.var_exo(tmp1,2) = 2.4096;
end
tmp1 = find(estim_params_.var_exo(:,1)==6);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(6,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.6698;
end
tmp1 = find(estim_params_.var_exo(:,1)==7);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(7,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.4504;
end
tmp1 = find(estim_params_.var_exo(:,1)==8);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(8,:))))
else
    estim_params_.var_exo(tmp1,2) = 9.0206;
end
tmp1 = find(estim_params_.var_exo(:,1)==9);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(9,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.8327;
end
skipline()
tmp1 = find(estim_params_.param_vals(:,1)==4);
estim_params_.param_vals(tmp1,3) = 0.1;
estim_params_.param_vals(tmp1,4) = 0.5;
tmp1 = find(estim_params_.param_vals(:,1)==5);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==6);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==7);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 10;
tmp1 = find(estim_params_.param_vals(:,1)==8);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==24);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 10;
tmp1 = find(estim_params_.param_vals(:,1)==9);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 10;
tmp1 = find(estim_params_.param_vals(:,1)==10);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==11);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==12);
estim_params_.param_vals(tmp1,3) = 0.5;
estim_params_.param_vals(tmp1,4) = 4;
tmp1 = find(estim_params_.param_vals(:,1)==13);
estim_params_.param_vals(tmp1,3) = 1;
estim_params_.param_vals(tmp1,4) = 3;
tmp1 = find(estim_params_.param_vals(:,1)==14);
estim_params_.param_vals(tmp1,3) = (-0.5);
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==15);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==16);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 6;
tmp1 = find(estim_params_.param_vals(:,1)==17);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 4;
tmp1 = find(estim_params_.param_vals(:,1)==18);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==19);
estim_params_.param_vals(tmp1,3) = 0.1;
estim_params_.param_vals(tmp1,4) = 0.4;
tmp1 = find(estim_params_.param_vals(:,1)==22);
estim_params_.param_vals(tmp1,3) = 0.05;
estim_params_.param_vals(tmp1,4) = 0.25;
tmp1 = find(estim_params_.param_vals(:,1)==21);
estim_params_.param_vals(tmp1,3) = 0.9;
estim_params_.param_vals(tmp1,4) = 0.999;
tmp1 = find(estim_params_.param_vals(:,1)==20);
estim_params_.param_vals(tmp1,3) = 0.2;
estim_params_.param_vals(tmp1,4) = 0.5;
load options_dssw_ff;
options_.nobs      = nobs;
options_.first_obs = 1;
options_.dynatol=1.0000e-004;
options_.parallel = struct('Local',1, 'ComputerName', 'localhost', 'CPUnbr', [1:4],'SingleCompThread',1,...
                   'MatlabOctavePath','matlab', 'DynarePath','C:\Dane\Marcin\Dynare\4.2.4\matlab');
options_.parallel_info = struct('RemoteTmpFolder','', 'leaveSlaveOpen',0);
parallel='c1';
options_.bayesian_irf = 1;
options_.irf = 40;
options_.mh_drop = 0.2;
options_.mh_jscale = 0.32;
options_.mh_nblck = 4;
options_.mh_replic = 125000;
options_.mode_check.status = 1;
options_.mode_compute = 4;
options_.nodiagnostic = 1;
options_.plot_priors = 0;
options_.datafile = 'data';
options_.mode_file = 'dssw_ff_mh_mode';
options_.order = 1;
var_list_ = char('dlnY','dlnC','dlnI','dlnw','lnL','dlnP','FedFunds','dlnDn','Spread');
oo_recursive_=dynare_estimation(var_list_);
save('dssw_ff_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('dssw_ff_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('dssw_ff_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('dssw_ff_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('dssw_ff_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('dssw_ff_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('dssw_ff_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
