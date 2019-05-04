//**************************************************************************
// Forecasting Under Model Uncertainty
//
// Maik Wolters
//
//**************************************************************************

// Model: US_DS04

// Further references:
// Del Negro, M. and F. Schorfheide 2004. "Priors From General Equilibrium Models For VARS" International Economic Review 45(2): pp 643-673.
// An S. and F. Schorfheide 2007. "Bayesian Analysis of DSGE Models" Econometric Reviews 26(2-4), pp. 113-171.

// Last edited: 25/06/08 by M. Wolters

var y pie R g z

//**************************************************************************
// Common Variables                                                      //*    
   interest rff_q_obs inflation pgdp_q_obs outputgap xgdp_q_obs;         //*
//**************************************************************************

varexo epsilon_R epsilon_g epsilon_z;

parameters tau kappa psi1 psi2 rhoR rhog rhoz trend inflationqstar rstar;

trend          = 0.500;
inflationqstar = 1.000;
rstar          = 0.125;
kappa          = 0.300;
tau            = 2.000;
psi1           = 1.500;
psi2           = 0.125;
rhoR           = 0.500;
rhog           = 0.800;
rhoz           = 0.300;

model(linear);
// steady state: rstar = gamma/beta  --> rstar = (gamma/beta - 1)*100  --> beta = gamma/((rstar/100)+1)  [we observe the net real interest rate; the model features the gross real interest rate]    
// gamma (trend term) in the original paper is defined in the model and is related to the observed trend as trend = log(gamma)*100 ~ (gamma-1)*100  --> gamma = trend/100+1
// steady state inflation in the model (gross inflation) is related to observed steady state inflation in the data (net inflation): (inflationqstar/100-1)=piestar 

#beta=(trend/100+1)/(rstar/100+1);  
#piestar = inflationqstar/100+1;

//**************************************************************************
// Definition of Common Variables in Terms of Original Model Variables   //*
inflation = inflationqstar + (1/4)*(pie+ pie(-1)+ pie(-2)+ pie(-3))*100; //* 
outputgap  = y*100;                                                      //* 
interest  = rff_q_obs*4;                                                 //*
                                                                         //*
// Measurement equations                                                 //*
xgdp_q_obs = trend + (y-y(-1)+z)*100;                                      //*
pgdp_q_obs = inflationqstar + pie*100;                                   //*  
rff_q_obs  = rstar + inflationqstar + R*100;                             //*  
//**************************************************************************

// model code
y = y(+1) - (1/tau)*(R-pie(+1)) + (1-rhog)*g + rhoz*(1/tau)*z;
pie = beta*pie(+1) + kappa*(y-g);
R = rhoR*R(-1) + (1-rhoR)*(psi1*pie+psi2*y) + epsilon_R;

z = rhoz*z(-1) + epsilon_z;
g = rhog*g(-1) + epsilon_g;
end;

shocks;
var epsilon_R;
stderr 0.01;
var epsilon_g; 
stderr 0.01;
var epsilon_z; 
stderr 0.01;
end;

//steady;
//check;
//stoch_simul(irf = 20, ar=100, periods=2000);

estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
trend         ,    normal_pdf, 0.5,    0.25;
inflationqstar,    normal_pdf, 1.0,    0.50;
rstar         ,    gamma_pdf , 0.5,    0.25;
kappa         ,    gamma_pdf , 0.3,    0.15;
tau           ,    gamma_pdf , 2.0,    0.50;
psi1          ,    gamma_pdf , 1.5,    0.25;
psi2          ,    gamma_pdf , 0.125,  0.10;
rhoR          ,    beta_pdf  , 0.5,    0.20;
rhog          ,    beta_pdf  , 0.8,    0.10;
rhoz          ,    beta_pdf  , 0.3,    0.10;

stderr epsilon_R,inv_gamma_pdf,0.0025,0.0014;
stderr epsilon_g,inv_gamma_pdf,0.0063,0.0032;
stderr epsilon_z,inv_gamma_pdf,0.0088,0.0043;
end;

varobs xgdp_q_obs pgdp_q_obs rff_q_obs;

//estimation(optim=('MaxIter',2000),mh_nblocks=2,mh_replic=20000,datafile=US_data_20084,xls_sheet=data,xls_range=AB3:AH300,first_obs=166,nobs=80,presample=4,lik_init=1,mode_compute=6,prefilter=0,filtered_vars,smoother,forecast=20);