//New Keynesian Model similar to Woodford or Walsh with all kinds of shocks including preference and a mark-up shock.

//The model is written in terms of the output gap and the natural interest rate.



// Last edited: 08/10/09 by M. Wolters



var y yf c pie R g z Rf rf phi xi outputgapn



//**************************************************************************

// Common Variables                                                      //*    

   rff_q_obs pgdp_q_obs xgdp_q_obs outputgap;                            //*  

//**************************************************************************



varexo eR eg ez exi ephi;

parameters sigma trend piestarobs rstarobs psi1 psi2 rhoR rhog rhoz rhoxi rhophi kappa; 



trend      = 0.500;

piestarobs = 1.000;

rstarobs   = 0.125;

kappa      = 0.300;

sigma      = 2.000;

psi1       = 1.500;

psi2       = 0.125;

rhoR       = 0.500;

rhog       = 0.800;

rhoz       = 0.300;

rhoxi      = 0.500;

rhophi     = 0.500;





model(linear);



// steady state: r = trend/beta  --> rstarobs = (trend/beta - 1)*100  --> beta = trend/ ( (rstarobs/100)+1 )      [we observe the net real interest rate; the model // features the gross real interst rate]    

// trend (gamma in the original paper) is defined in the model and is related to the observed trend as obstrend (logtrend) = log(trend)*100 = (trend-1)*100  --> trend = logtrend/100+1

// steady state inflation in the model (gross inflation) is related to observed steady state inflation in the data (net inflation): (piestarobs/100-1)=piestar 



#beta=(trend/100+1)/(rstarobs/100+1);  

#piestar = piestarobs/100+1;



//**************************************************************************

// Measurement equations                                                 //*

xgdp_q_obs = trend + (y-y(-1)+z)*100;                                    //*

pgdp_q_obs = piestarobs + pie*100;                                       //*  

rff_q_obs  = rstarobs + piestarobs + R*100;                              //*  

//**************************************************************************





outputgap = outputgap(+1) - (1/sigma)*(R-pie(+1)-rf);   //efficient output gap

Rf        = sigma*(yf(+1)-yf) - (xi(+1)-xi) - sigma*(g(+1)-g)+ z(+1) + pie(+1);

rf        = Rf - pie(+1);

pie       = beta*pie(+1) + kappa  * outputgapn;  //kappa=(sigma*(theta-1)/(rho*piestar^2)

outputgapn= outputgap+ 1/sigma*phi;  //output gap relevant for Phillips curve

yf        = g + 1/sigma * xi;

R         = rhoR*R(-1) + (1-rhoR)*(psi1 * pie+ psi2 * outputgap) + eR;

c         = y-g;

outputgap = y-yf;



z = rhoz*z(-1) + ez;

g = rhog*g(-1) + eg;

xi    = rhoxi*xi(-1) + exi;

phi   = rhophi*phi(-1) + ephi;



end;



shocks;

var eR;

stderr 0.01;

var exi;  

stderr 0.01;

var ephi;  

stderr 0.01;

var eg; 

stderr 0.01;

var ez; 

stderr 0.01;

end;



//steady;

//check;

//stoch_simul(irf=20);



estimated_params;

// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE

// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF

trend     ,    normal_pdf, 0.5,    0.25;

piestarobs,    normal_pdf, 1.0,    0.50;

rstarobs  ,    gamma_pdf , 0.125,  0.0625;

kappa     ,    gamma_pdf , 0.3,    0.15;

sigma     ,    gamma_pdf , 2.0,    0.50;

psi1      ,    gamma_pdf , 1.5,    0.25;

psi2      ,    gamma_pdf , 0.125,  0.10;

rhoR      ,    beta_pdf  , 0.5,    0.20;

rhog      ,    beta_pdf  , 0.8,    0.10;

rhoz      ,    beta_pdf  , 0.3,    0.10;

rhoxi     ,    beta_pdf  , 0.500,  0.20; //this parameter is not included in the original model

rhophi    ,    beta_pdf  , 0.500,  0.20; //this parameter is not included in the original model





stderr eR,inv_gamma_pdf,0.0025,0.0014;

stderr eg,inv_gamma_pdf,0.0063,0.0032;

stderr ez,inv_gamma_pdf,0.0088,0.0043;

stderr exi,inv_gamma_pdf,0.005,0.004;       //this parameter is not included in the original model

stderr ephi,inv_gamma_pdf,0.005,0.004;      //this parameter is not included in the original model



end;

//steady;

//check;

varobs xgdp_q_obs pgdp_q_obs rff_q_obs;