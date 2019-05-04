var xgdp_q_obs pgdp_q_obs rff_q_obs ; 
varobs xgdp_q_obs pgdp_q_obs rff_q_obs ; 
// Load Forecast Interface Parameters 
cd .. 
cd .. 
load variables.mat 'basics' ; 
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' basics.vintage(basics.vintagenr,:)]); 
eval(['options_.datafile = ''' basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) ''';']); 
options_.bvar_prior_tau = 3.000000e+00; 
options_.bvar_prior_decay = 5.000000e-01; 
options_.bvar_prior_omega = 5.000000e+00; 
options_.bvar_prior_train= 0.000000e+00;
options_.first_obs = 20; 
bvar_density 8; 
