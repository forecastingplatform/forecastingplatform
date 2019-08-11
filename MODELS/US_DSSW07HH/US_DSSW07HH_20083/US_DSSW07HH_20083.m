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
M_.fname = 'US_DSSW07HH_20083';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('US_DSSW07HH_20083.log');
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
M_.exo_names = char(M_.exo_names, 'eps_A');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_A');
M_.exo_names_long = char(M_.exo_names_long, 'eps_A');
M_.exo_names = char(M_.exo_names, 'eps_a');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_a');
M_.exo_names_long = char(M_.exo_names_long, 'eps_a');
M_.exo_names = char(M_.exo_names, 'eps_m');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_m');
M_.exo_names_long = char(M_.exo_names_long, 'eps_m');
M_.exo_names = char(M_.exo_names, 'eps_mu_o');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_mu\_o');
M_.exo_names_long = char(M_.exo_names_long, 'eps_mu_o');
M_.exo_names = char(M_.exo_names, 'eps_lambda_d');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_lambda\_d');
M_.exo_names_long = char(M_.exo_names_long, 'eps_lambda_d');
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
M_.endo_names = char(M_.endo_names, 'R_e');
M_.endo_names_tex = char(M_.endo_names_tex, 'R\_e');
M_.endo_names_long = char(M_.endo_names_long, 'R_e');
M_.endo_names = char(M_.endo_names, 'r_k');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_k');
M_.endo_names_long = char(M_.endo_names_long, 'r_k');
M_.endo_names = char(M_.endo_names, 'u');
M_.endo_names_tex = char(M_.endo_names_tex, 'u');
M_.endo_names_long = char(M_.endo_names_long, 'u');
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
M_.endo_names = char(M_.endo_names, 'xgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'xgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'xgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'pcer_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pcer\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'pcer_q_obs');
M_.endo_names = char(M_.endo_names, 'dlnI');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlnI');
M_.endo_names_long = char(M_.endo_names_long, 'dlnI');
M_.endo_names = char(M_.endo_names, 'hours_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'hours\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'hours_obs');
M_.endo_names = char(M_.endo_names, 'wage_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'wage\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'wage_obs');
M_.endo_names = char(M_.endo_names, 'pgdp_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'pgdp\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'pgdp_q_obs');
M_.endo_names = char(M_.endo_names, 'rff_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'rff\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'rff_q_obs');
M_.endo_names = char(M_.endo_names, 'o');
M_.endo_names_tex = char(M_.endo_names_tex, 'o');
M_.endo_names_long = char(M_.endo_names_long, 'o');
M_.endo_names = char(M_.endo_names, 'o_p');
M_.endo_names_tex = char(M_.endo_names_tex, 'o\_p');
M_.endo_names_long = char(M_.endo_names_long, 'o_p');
M_.endo_names = char(M_.endo_names, 'o_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'o\_i');
M_.endo_names_long = char(M_.endo_names_long, 'o_i');
M_.endo_names = char(M_.endo_names, 'Q_o');
M_.endo_names_tex = char(M_.endo_names_tex, 'Q\_o');
M_.endo_names_long = char(M_.endo_names_long, 'Q_o');
M_.endo_names = char(M_.endo_names, 'c_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'c\_i');
M_.endo_names_long = char(M_.endo_names_long, 'c_i');
M_.endo_names = char(M_.endo_names, 'd_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'd\_i');
M_.endo_names_long = char(M_.endo_names_long, 'd_i');
M_.endo_names = char(M_.endo_names, 'R_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'R\_i');
M_.endo_names_long = char(M_.endo_names_long, 'R_i');
M_.endo_names = char(M_.endo_names, 't_i');
M_.endo_names_tex = char(M_.endo_names_tex, 't\_i');
M_.endo_names_long = char(M_.endo_names_long, 't_i');
M_.endo_names = char(M_.endo_names, 'L_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'L\_i');
M_.endo_names_long = char(M_.endo_names_long, 'L_i');
M_.endo_names = char(M_.endo_names, 'w_i_tilda');
M_.endo_names_tex = char(M_.endo_names_tex, 'w\_i\_tilda');
M_.endo_names_long = char(M_.endo_names_long, 'w_i_tilda');
M_.endo_names = char(M_.endo_names, 'w_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'w\_i');
M_.endo_names_long = char(M_.endo_names_long, 'w_i');
M_.endo_names = char(M_.endo_names, 'phi_w_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi\_w\_i');
M_.endo_names_long = char(M_.endo_names_long, 'phi_w_i');
M_.endo_names = char(M_.endo_names, 'psi_w_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'psi\_w\_i');
M_.endo_names_long = char(M_.endo_names_long, 'psi_w_i');
M_.endo_names = char(M_.endo_names, 'w_p_tilda');
M_.endo_names_tex = char(M_.endo_names_tex, 'w\_p\_tilda');
M_.endo_names_long = char(M_.endo_names_long, 'w_p_tilda');
M_.endo_names = char(M_.endo_names, 'w_p');
M_.endo_names_tex = char(M_.endo_names_tex, 'w\_p');
M_.endo_names_long = char(M_.endo_names_long, 'w_p');
M_.endo_names = char(M_.endo_names, 'L_p');
M_.endo_names_tex = char(M_.endo_names_tex, 'L\_p');
M_.endo_names_long = char(M_.endo_names_long, 'L_p');
M_.endo_names = char(M_.endo_names, 'lambda_i');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_i');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_i');
M_.endo_names = char(M_.endo_names, 'theta');
M_.endo_names_tex = char(M_.endo_names_tex, 'theta');
M_.endo_names_long = char(M_.endo_names_long, 'theta');
M_.endo_names = char(M_.endo_names, 'i_o');
M_.endo_names_tex = char(M_.endo_names_tex, 'i\_o');
M_.endo_names_long = char(M_.endo_names_long, 'i_o');
M_.endo_names = char(M_.endo_names, 'la');
M_.endo_names_tex = char(M_.endo_names_tex, 'la');
M_.endo_names_long = char(M_.endo_names_long, 'la');
M_.endo_names = char(M_.endo_names, 'lm');
M_.endo_names_tex = char(M_.endo_names_tex, 'lm');
M_.endo_names_long = char(M_.endo_names_long, 'lm');
M_.endo_names = char(M_.endo_names, 'lmu_o');
M_.endo_names_tex = char(M_.endo_names_tex, 'lmu\_o');
M_.endo_names_long = char(M_.endo_names_long, 'lmu_o');
M_.endo_names = char(M_.endo_names, 'llambda_d');
M_.endo_names_tex = char(M_.endo_names_tex, 'llambda\_d');
M_.endo_names_long = char(M_.endo_names_long, 'llambda_d');
M_.endo_names = char(M_.endo_names, 'fpi_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'fpi\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'fpi_q_obs');
M_.endo_names = char(M_.endo_names, 'io_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'io\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'io_q_obs');
M_.endo_names = char(M_.endo_names, 'dlndin_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'dlndin\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'dlndin_obs');
M_.endo_names = char(M_.endo_names, 'po_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'po\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'po_q_obs');
M_.endo_names = char(M_.endo_names, 'spreadi_q_obs');
M_.endo_names_tex = char(M_.endo_names_tex, 'spreadi\_q\_obs');
M_.endo_names_long = char(M_.endo_names_long, 'spreadi_q_obs');
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
M_.param_names = char(M_.param_names, 'Q_o_adj');
M_.param_names_tex = char(M_.param_names_tex, 'Q\_o\_adj');
M_.param_names_long = char(M_.param_names_long, 'Q_o_adj');
M_.param_names = char(M_.param_names, 'a');
M_.param_names_tex = char(M_.param_names_tex, 'a');
M_.param_names_long = char(M_.param_names_long, 'a');
M_.param_names = char(M_.param_names, 'beta_i');
M_.param_names_tex = char(M_.param_names_tex, 'beta\_i');
M_.param_names_long = char(M_.param_names_long, 'beta_i');
M_.param_names = char(M_.param_names, 'delta_o');
M_.param_names_tex = char(M_.param_names_tex, 'delta\_o');
M_.param_names_long = char(M_.param_names_long, 'delta_o');
M_.param_names = char(M_.param_names, 'm');
M_.param_names_tex = char(M_.param_names_tex, 'm');
M_.param_names_long = char(M_.param_names_long, 'm');
M_.param_names = char(M_.param_names, 's_o_bis');
M_.param_names_tex = char(M_.param_names_tex, 's\_o\_bis');
M_.param_names_long = char(M_.param_names_long, 's_o_bis');
M_.param_names = char(M_.param_names, 'lambda_d');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_d');
M_.param_names_long = char(M_.param_names_long, 'lambda_d');
M_.param_names = char(M_.param_names, 'n_p');
M_.param_names_tex = char(M_.param_names_tex, 'n\_p');
M_.param_names_long = char(M_.param_names_long, 'n_p');
M_.param_names = char(M_.param_names, 'lambda_l');
M_.param_names_tex = char(M_.param_names_tex, 'lambda\_l');
M_.param_names_long = char(M_.param_names_long, 'lambda_l');
M_.param_names = char(M_.param_names, 'tau_i');
M_.param_names_tex = char(M_.param_names_tex, 'tau\_i');
M_.param_names_long = char(M_.param_names_long, 'tau_i');
M_.param_names = char(M_.param_names, 'rho_a');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_a');
M_.param_names_long = char(M_.param_names_long, 'rho_a');
M_.param_names = char(M_.param_names, 'rho_m');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_m');
M_.param_names_long = char(M_.param_names_long, 'rho_m');
M_.param_names = char(M_.param_names, 'rho_mu_o');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_mu\_o');
M_.param_names_long = char(M_.param_names_long, 'rho_mu_o');
M_.param_names = char(M_.param_names, 'rho_lambda_d');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_lambda\_d');
M_.param_names_long = char(M_.param_names_long, 'rho_lambda_d');
M_.param_names = char(M_.param_names, 'scalehours');
M_.param_names_tex = char(M_.param_names_tex, 'scalehours');
M_.param_names_long = char(M_.param_names_long, 'scalehours');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 12;
M_.endo_nbr = 63;
M_.param_nbr = 50;
M_.orig_endo_nbr = 63;
M_.aux_vars = [];
options_.varobs = cell(1);
options_.varobs(1)  = {'xgdp_q_obs'};
options_.varobs(2)  = {'pcer_q_obs'};
options_.varobs(3)  = {'fpi_q_obs'};
options_.varobs(4)  = {'hours_obs'};
options_.varobs(5)  = {'wage_obs'};
options_.varobs(6)  = {'pgdp_q_obs'};
options_.varobs(7)  = {'rff_q_obs'};
options_.varobs(8)  = {'io_q_obs'};
options_.varobs(9)  = {'dlndin_obs'};
options_.varobs(10)  = {'po_q_obs'};
options_.varobs(11)  = {'spreadi_q_obs'};
options_.varobs_id = [ 29 30 59 32 33 34 35 60 61 62 63  ];
M_.Sigma_e = zeros(12, 12);
M_.Correlation_matrix = eye(12, 12);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('US_DSSW07HH_20083_static');
erase_compiled_function('US_DSSW07HH_20083_dynamic');
M_.orig_eq_nbr = 63;
M_.eq_nbr = 63;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 30 93;
 1 31 0;
 2 32 94;
 3 33 95;
 4 34 0;
 0 35 96;
 0 36 97;
 0 37 0;
 0 38 0;
 5 39 0;
 6 40 98;
 7 41 99;
 0 42 100;
 0 43 0;
 0 44 0;
 0 45 0;
 0 46 0;
 0 47 101;
 0 48 102;
 8 49 0;
 9 50 0;
 10 51 103;
 11 52 104;
 12 53 0;
 13 54 105;
 14 55 0;
 15 56 0;
 16 57 0;
 0 58 0;
 0 59 0;
 0 60 0;
 0 61 0;
 0 62 0;
 0 63 0;
 0 64 0;
 17 65 0;
 0 66 0;
 18 67 0;
 19 68 106;
 20 69 107;
 21 70 0;
 22 71 0;
 0 72 0;
 0 73 0;
 0 74 0;
 23 75 0;
 0 76 108;
 0 77 109;
 0 78 0;
 24 79 0;
 0 80 0;
 0 81 110;
 0 82 0;
 25 83 111;
 26 84 0;
 27 85 0;
 28 86 112;
 29 87 0;
 0 88 0;
 0 89 0;
 0 90 0;
 0 91 0;
 0 92 0;]';
M_.nstatic = 25;
M_.nfwrd   = 9;
M_.npred   = 18;
M_.nboth   = 11;
M_.nsfwrd   = 20;
M_.nspred   = 29;
M_.ndynamic   = 38;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:12];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(63, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(12, 1);
M_.params = NaN(50, 1);
M_.NNZDerivatives = [325; -1; -1];
close all;
M_.params( 1 ) = 0.8;
phi = M_.params( 1 );
M_.params( 2 ) = 0.3;
lambda_w = M_.params( 2 );
M_.params( 3 ) = 0.025;
delta = M_.params( 3 );
M_.params( 4 ) = 0.27;
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
M_.params( 20 ) = 0.27;
sigma = M_.params( 20 );
M_.params( 21 ) = 0.977;
nu = M_.params( 21 );
M_.params( 22 ) = 0;
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
M_.params( 34 ) = 1.2918;
L_adj = M_.params( 34 );
M_.params( 35 ) = 0;
D_adj = M_.params( 35 );
M_.params( 36 ) = 0;
Q_o_adj = M_.params( 36 );
M_.params( 37 ) = 0.215;
a = M_.params( 37 );
M_.params( 38 ) = 0.97;
beta_i = M_.params( 38 );
M_.params( 39 ) = 0.005;
delta_o = M_.params( 39 );
M_.params( 40 ) = 0.75;
m = M_.params( 40 );
M_.params( 41 ) = 4;
s_o_bis = M_.params( 41 );
M_.params( 42 ) = 0.00625;
lambda_d = M_.params( 42 );
M_.params( 43 ) = 0.38;
n_p = M_.params( 43 );
M_.params( 44 ) = 0.3;
lambda_l = M_.params( 44 );
M_.params( 45 ) = 0;
tau_i = M_.params( 45 );
M_.params( 46 ) = 0.9;
rho_a = M_.params( 46 );
M_.params( 47 ) = 0.9;
rho_m = M_.params( 47 );
M_.params( 48 ) = 0.9;
rho_mu_o = M_.params( 48 );
M_.params( 49 ) = 0.9;
rho_lambda_d = M_.params( 49 );
M_.params( 50 ) = 1;
scalehours = M_.params( 50 );
steady;
oo_.dr.eigval = check(M_,options_,oo_);
estim_params_.var_exo = zeros(0, 10);
estim_params_.var_endo = zeros(0, 10);
estim_params_.corrx = zeros(0, 11);
estim_params_.corrn = zeros(0, 11);
estim_params_.param_vals = zeros(0, 10);
estim_params_.param_vals = [estim_params_.param_vals; 4, NaN, (-Inf), Inf, 1, 0.27, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, NaN, (-Inf), Inf, 1, 0.5, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, NaN, (-Inf), Inf, 2, 4, 1.5, NaN, NaN, NaN ];
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
estim_params_.param_vals = [estim_params_.param_vals; 34, 1.2918, (-10.0), 10.0, 3, 0.0, 2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 40, NaN, (-Inf), Inf, 3, 0.85, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 42, NaN, (-Inf), Inf, 2, 0.00625, 0.001, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 38, NaN, (-Inf), Inf, 1, 0.97, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 37, NaN, (-Inf), Inf, 2, 0.2, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 43, NaN, (-Inf), Inf, 1, 0.2, 0.01, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 41, NaN, (-Inf), Inf, 2, 4, 1.5, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 35, NaN, (-Inf), Inf, 3, 0.5, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 36, NaN, (-Inf), Inf, 3, 0.2, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 25, NaN, (-Inf), Inf, 1, 0.2, 0.1, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 27, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 29, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 28, NaN, (-Inf), Inf, 1, 0.8, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 26, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 30, NaN, (-Inf), Inf, 1, 0.8, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 46, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 47, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 48, NaN, (-Inf), Inf, 1, 0.8, 0.05, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 49, NaN, (-Inf), Inf, 1, 0.6, 0.2, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 1, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 3, NaN, (-Inf), Inf, 4, 2, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 5, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 4, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 2, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 6, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 7, NaN, (-Inf), Inf, 4, 0.25, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 9, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 10, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 11, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.var_exo = [estim_params_.var_exo; 12, NaN, (-Inf), Inf, 4, 0.5, Inf, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 50, 1, 0.01, 10, 5, NaN, NaN, 0.01, 10, NaN ];
tmp1 = find(estim_params_.param_vals(:,1)==4);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(4,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.27;
end
tmp1 = find(estim_params_.param_vals(:,1)==5);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(5,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.6;
end
tmp1 = find(estim_params_.param_vals(:,1)==6);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(6,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==7);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(7,:))))
else
    estim_params_.param_vals(tmp1,2) = 4;
end
tmp1 = find(estim_params_.param_vals(:,1)==8);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(8,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.7;
end
tmp1 = find(estim_params_.param_vals(:,1)==24);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(24,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2;
end
tmp1 = find(estim_params_.param_vals(:,1)==9);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(9,:))))
else
    estim_params_.param_vals(tmp1,2) = 2;
end
tmp1 = find(estim_params_.param_vals(:,1)==10);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(10,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.6;
end
tmp1 = find(estim_params_.param_vals(:,1)==11);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(11,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==12);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(12,:))))
else
    estim_params_.param_vals(tmp1,2) = 2;
end
tmp1 = find(estim_params_.param_vals(:,1)==13);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(13,:))))
else
    estim_params_.param_vals(tmp1,2) = 1.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==14);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(14,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2;
end
tmp1 = find(estim_params_.param_vals(:,1)==15);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(15,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.5;
end
tmp1 = find(estim_params_.param_vals(:,1)==16);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(16,:))))
else
    estim_params_.param_vals(tmp1,2) = 3;
end
tmp1 = find(estim_params_.param_vals(:,1)==17);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(17,:))))
else
    estim_params_.param_vals(tmp1,2) = 2;
end
tmp1 = find(estim_params_.param_vals(:,1)==18);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(18,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.15;
end
tmp1 = find(estim_params_.param_vals(:,1)==19);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(19,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2;
end
tmp1 = find(estim_params_.param_vals(:,1)==34);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(34,:))))
else
    estim_params_.param_vals(tmp1,2) = 1.2918;
end
tmp1 = find(estim_params_.param_vals(:,1)==25);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(25,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.2;
end
tmp1 = find(estim_params_.param_vals(:,1)==27);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(27,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==29);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(29,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==28);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(28,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==26);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(26,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.6;
end
tmp1 = find(estim_params_.param_vals(:,1)==30);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(30,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==46);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(46,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==47);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(47,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==48);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(48,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.param_vals(:,1)==49);
if isempty(tmp1)
    disp(sprintf('Parameter %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.param_names(49,:))))
else
    estim_params_.param_vals(tmp1,2) = 0.9;
end
tmp1 = find(estim_params_.var_exo(:,1)==1);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(1,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.7519;
end
tmp1 = find(estim_params_.var_exo(:,1)==3);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(3,:))))
else
    estim_params_.var_exo(tmp1,2) = 3.4435;
end
tmp1 = find(estim_params_.var_exo(:,1)==5);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(5,:))))
else
    estim_params_.var_exo(tmp1,2) = 7.3085;
end
tmp1 = find(estim_params_.var_exo(:,1)==4);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(4,:))))
else
    estim_params_.var_exo(tmp1,2) = 4.1324;
end
tmp1 = find(estim_params_.var_exo(:,1)==2);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(2,:))))
else
    estim_params_.var_exo(tmp1,2) = 2.2806;
end
tmp1 = find(estim_params_.var_exo(:,1)==6);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(6,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.5998;
end
tmp1 = find(estim_params_.var_exo(:,1)==7);
if isempty(tmp1)
    disp(sprintf('The standard deviation of %s is not estimated (the value provided in estimated_params_init is not used).', deblank(M_.exo_names(7,:))))
else
    estim_params_.var_exo(tmp1,2) = 0.2873;
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
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==15);
estim_params_.param_vals(tmp1,3) = 0;
estim_params_.param_vals(tmp1,4) = 1;
tmp1 = find(estim_params_.param_vals(:,1)==16);
estim_params_.param_vals(tmp1,3) = 1;
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
options_.irf = 0;
options_.order = 1;
var_list_ = char('xgdp_q_obs','pcer_q_obs','dlnI','wage_obs','hours_obs','pgdp_q_obs','rff_q_obs');
info = stoch_simul(var_list_);
save('US_DSSW07HH_20083_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('US_DSSW07HH_20083_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
