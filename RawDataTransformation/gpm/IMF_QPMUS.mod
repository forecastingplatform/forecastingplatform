// computed with Dynare 4.1.3


var RR_US RR_US_BAR
    UNR_US UNR_US_GAP UNR_US_BAR
    PIE_US PIE_US4 Y_US LGDP_US LGDP_US_BAR RS_US G_US LCPI_US
    E4_PIE_US4 E1_Y_US E1_PIE_US 
    UNR_G_US GROWTH_US GROWTH4_US GROWTH4_US_BAR
    BLT_US BLT_US_BAR
    E E2
    GROWTH_US_BAR RR_US_GAP BLT_US_GAP;


varexo RES_RR_US_BAR RES_UNR_US_GAP RES_UNR_US_BAR
       RES_RS_US RES_G_US RES_Y_US RES_LGDP_US_BAR RES_PIE_US
       RES_UNR_G_US
       RES_BLT_US RES_BLT_US_BAR 
;

parameters rho_us rr_us_bar_ss alpha_us1 alpha_us2
           tau_us growth_us_ss beta_us1 beta_us2 beta_us3 lambda_us1 lambda_us2 gamma_us1 gamma_us2 gamma_us4
           pietar_us_ss 
           alpha_us3
           kappa_us
           theta
;


alpha_us1    = 0.7796;
alpha_us2    = 0.1874;
alpha_us3    = 0.3352;
rho_us       = 0.9;
rr_us_bar_ss = 1.8456;
tau_us      = 0.10;
growth_us_ss= 2.7599;
beta_us1    = 0.9223;
beta_us2    = 0.1198;
beta_us3    = 0.1300;
lambda_us1  = 0.6380;
lambda_us2  = 0.1948;
gamma_us1   = 0.8318;
gamma_us2   = 1.8091;
gamma_us4   = 0.5332;
pietar_us_ss= 2.5;
kappa_us   = 20.0890;
theta = 1;


model(linear);

UNR_US_GAP = alpha_us1*UNR_US_GAP(-1) + alpha_us2*Y_US + RES_UNR_US_GAP;

UNR_US_GAP = UNR_US_BAR - UNR_US;

UNR_US_BAR = UNR_US_BAR(-1) + UNR_G_US + RES_UNR_US_BAR;

UNR_G_US = (1-alpha_us3)*UNR_G_US(-1) + RES_UNR_G_US;




LGDP_US = LGDP_US_BAR + Y_US;

G_US = tau_us*growth_us_ss + (1-tau_us)*G_US(-1) + RES_G_US;

LGDP_US_BAR = LGDP_US_BAR(-1) + G_US/4 + RES_LGDP_US_BAR;

Y_US = beta_us1*Y_US(-1) + beta_us2*Y_US(+1) - beta_us3*(RR_US(-1) - RR_US_BAR(-1)) - 
theta*(0.04*(E(-1)+E(-9))+0.08*(E(-2)+E(-8))+0.12*(E(-3)+E(-7))+0.16*(E(-4)+E(-6))+0.2*E(-5)) + RES_Y_US; 


E = RES_BLT_US;
BLT_US = BLT_US_BAR - kappa_us*Y_US(+4) + RES_BLT_US;
BLT_US_BAR = BLT_US_BAR(-1) + RES_BLT_US_BAR;
BLT_US_GAP = BLT_US-BLT_US_BAR;


GROWTH_US = 4*(LGDP_US - LGDP_US(-1));
GROWTH4_US = LGDP_US - LGDP_US(-4);
GROWTH_US_BAR = 4*(LGDP_US_BAR - LGDP_US_BAR(-1));
GROWTH4_US_BAR = LGDP_US_BAR - LGDP_US_BAR(-4);



PIE_US = lambda_us1*PIE_US4(+4) + (1-lambda_us1)*PIE_US4(-1) + lambda_us2*Y_US(-1) - RES_PIE_US;

RS_US = gamma_us1*RS_US(-1) +
      (1-gamma_us1)*(RR_US_BAR + PIE_US4(+3) + gamma_us2*(PIE_US4(+3)-pietar_us_ss) + gamma_us4*Y_US) + RES_RS_US;


RR_US = RS_US - PIE_US(+1);

LCPI_US = LCPI_US(-1) + PIE_US/4;

RR_US_BAR = rho_us*rr_us_bar_ss + (1-rho_us)*RR_US_BAR(-1) + RES_RR_US_BAR;

PIE_US4 = (PIE_US + PIE_US(-1) + PIE_US(-2) + PIE_US(-3))/4;

RR_US_GAP = RR_US - RR_US_BAR;



// reporting expectations


E4_PIE_US4 = PIE_US4(+4);
E1_PIE_US = PIE_US(+1);
E1_Y_US = Y_US(+1);
E2 = theta*(0.04*(E(-1)+E(-9))+0.08*(E(-2)+E(-8))+0.12*(E(-3)+E(-7))+0.16*(E(-4)+E(-6))+0.2*E(-5));


end;



shocks; 
var RES_RR_US_BAR;  stderr 0.1; 
var RES_UNR_US_GAP; stderr 0.2;
var RES_UNR_US_BAR;  stderr 0.10;
var RES_RS_US	;stderr 0.7;
var RES_G_US	;stderr 0.10;
var RES_Y_US	;stderr 0.25;
var RES_LGDP_US_BAR;stderr 0.05;
var RES_PIE_US    ;stderr 0.7; 
var RES_UNR_G_US ;stderr 0.10;
var RES_BLT_US;    stderr 0.4;
var RES_BLT_US_BAR; stderr 0.2;



//var RES_BLT_US,RES_G_US=(.1*0.40*0.1);
//var RES_BLT_US,RES_LGDP_US_BAR=(.1*0.40*0.05);
var RES_Y_US,RES_G_US=(.1*0.25*0.1);
var RES_LGDP_US_BAR,RES_PIE_US=(.1*0.05*0.7);
end;

unit_root_vars UNR_US_BAR UNR_US LCPI_US LGDP_US LGDP_US_BAR BLT_US BLT_US_BAR;

steady;

check;


estimated_params;
alpha_us1,    beta_pdf,      0.8, 0.1;
alpha_us2,    gamma_pdf,     0.3, 0.20;
alpha_us3,    beta_pdf,     0.5, 0.20;


growth_us_ss,normal_pdf,    2.5, 0.25;
rr_us_bar_ss, normal_pdf,    2.0, 0.2;

rho_us  ,beta_pdf,      0.9, 0.05;
tau_us  ,beta_pdf,      0.1, 0.05;

beta_us1    ,gamma_pdf,      0.75, 0.10;
beta_us2    ,beta_pdf,      0.15, 0.1; 
beta_us3    ,gamma_pdf,     0.20, 0.05;
lambda_us1  ,beta_pdf,      0.50, 0.10;
lambda_us2  ,gamma_pdf,     0.25, 0.05;
gamma_us1   ,beta_pdf,      0.5, 0.05;
gamma_us2   ,gamma_pdf,     0.50, 0.30;
gamma_us4   ,gamma_pdf,     0.20, 0.05;



//gamma_us1   ,beta_pdf,      0.7, 0.05;
//gamma_us2   ,gamma_pdf,     1.50, 0.30;
//gamma_us4   ,gamma_pdf,     0.50, 0.05;

kappa_us   ,gamma_pdf,     20, 0.5;
theta          ,gamma_pdf,     1, 0.5;



stderr RES_UNR_US_GAP, inv_gamma_pdf, 0.2  , inf;
stderr RES_UNR_US_BAR, inv_gamma_pdf,  0.1  , inf;
stderr RES_UNR_G_US, inv_gamma_pdf,  0.10  ,inf;



stderr RES_Y_US, inv_gamma_pdf,       0.25 , inf; 
stderr RES_LGDP_US_BAR, inv_gamma_pdf, 0.05 , inf; 
stderr RES_G_US, inv_gamma_pdf,  0.10  ,inf;


stderr RES_PIE_US,   inv_gamma_pdf,  0.7  , inf; 
stderr RES_RS_US,	inv_gamma_pdf,  0.7  , inf; 
stderr RES_RR_US_BAR, inv_gamma_pdf,  0.2  , inf;

stderr RES_BLT_US         , inv_gamma_pdf,  0.4  , inf;
stderr RES_BLT_US_BAR     , inv_gamma_pdf,  0.2  , inf;

//corr RES_BLT_US, RES_G_US , beta_pdf, 0.40, 0.15;
//corr RES_BLT_US, RES_LGDP_US_BAR, beta_pdf, 0.4, 0.15;
corr RES_Y_US, RES_G_US, beta_pdf, 0.25, 0.1;
corr RES_LGDP_US_BAR,RES_PIE_US, beta_pdf, 0.05, 0.02;

end;

varobs UNR_US RS_US LCPI_US LGDP_US BLT_US;


observation_trends;
LGDP_US (growth_us_ss/4);
LCPI_US (pietar_us_ss/4);
end;


options_.kalman_algo = 5;
options_.plot_priors = 0;
//estimation(datafile=data,xls_sheet=data,xls_range=V1:Z69,nobs=[56],nograph,mode_compute=5,mh_replic=0,smoother,mh_jscale=0.25,mh_nblocks=1,filter_step_ahead=[1:12],forecast=12,conf_sig=0.9,presample=4) Y_US PIE_US4 PIE_US RS_US UNR_US UNR_US_BAR GROWTH_US GROWTH4_US GROWTH4_US_BAR BLT_US GROWTH_US_BAR UNR_US_GAP RR_US RR_US_BAR RR_US_GAP BLT_US_GAP BLT_US_BAR; //filtered_vars
estimation(nodiagnostic,datafile=data,xls_sheet=data,xls_range=V1:Z69,nobs=56,nograph,mode_compute=0,mh_replic=0,mode_file=IMF_QPMUS_mode,smoother,mh_jscale=0.25,mh_nblocks=1,filter_step_ahead=[1:12],forecast=12,conf_sig=0.9,presample=4) Y_US PIE_US4 PIE_US RS_US UNR_US UNR_US_BAR GROWTH_US GROWTH4_US GROWTH4_US_BAR BLT_US GROWTH_US_BAR UNR_US_GAP RR_US RR_US_BAR RR_US_GAP BLT_US_GAP BLT_US_BAR; //filtered_vars




shocks;
var RES_RS_US;
stderr 1.8201+pietar_us_ss;
end;

stoch_simul (order=1,irf = 20, ar=100) RS_US PIE_US Y_US LGDP_US;