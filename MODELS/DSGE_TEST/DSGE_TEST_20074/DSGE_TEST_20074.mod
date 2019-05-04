
// Further references:
// Bernanke, Ben S., Mark Gertler, and Simon Gilchrist (1999) ``The Financial Accelerator 
//in a Quantitative Business Cycle Framework''
// In: Handbook of Macroeconomics. North Holland, Amsterdam.
// mod file for estimation including additional shocks (a financial shock and an investment shock)
//**************************************************************************
// For the exercise of forecasting, we add the investment-specific shock, the external premium shock.
// In order to identify these shocks two observables are included: private investment, risk spread.  
// Values of two parameters, etav, H, are adjusted.
// We explicitly consider the optimal financial contract and risk shock.
// We define a flexible-price economy where there is no nominal and financial frictions.
// We introduce a partial indexation to inflation dynamics

//close all

var cH              //Consumption
    hH              //Household labor
    piH             //Inflation
    rH              //Gross real risk-free intrest rate
    r_nH            //Gross nominal risk-free intrest rate
    qH              //Price of capital
    kH              //Capital
    nH              //Net worth    
    r_kH            //Return on capital
    yH              //Output
    xH              //Markup
    iH              //Investment
    aH              //Aggregate technology level  
    c_eH            //Entrepreneurial consumption        
    gH              //Government expenditures
//    pi_t1H //pipH sH //One period forward inflation
    premiumH        //External finance premium
    xiH             // Investment-specific shock
    fH              // Financial shock
    yHf kHf iHf rHf r_kHf nHf cHf  qHf hHf c_eHf         // flexible-price variables
    xgdp_q_obs pgdp_q_obs rff_q_obs fpi_q_obs cp_q_obs  
    outputgap
;

varexo e_a e_g e_rn e_i e_f;    //Technology, government spending, monetary, investment and risk-premium shocks

parameters 
    X               //Steady state gross markup
//    R               //Steady state gross real risk-free interest rate
    H               //Steady state of household labor
//    R_K             //Steady state return on capital
//    s               //Steady state external finnace premium
//    KN              //Steady state capital to net worth ratio
//    CY              //Steady state consumption to output ratio
    GY              //Steady state govern. expenditures to output ratio
//    C_EY            //Steady state entrepreneurial consumption to output ratio
//    IY              //Steady state investment to output ratio
//    YK              //Steady state output to capital ratio
//    WY              //Steady state wage to output ratio
//    GAMMA_WBAR      //Steady state share of profits that is used to repay debt
//    NY              //Steady state net worth to output ratio
//    DY              //Steady state deposit to output ratio
//    YN              //Steady state output to net worth ratio
//    niv               //Elasticity of external finance premium wrt a change in leverage

    omegav                  //Entrepreneurial labor share in labor
    alphav                  //Capital share
//    betav                 //Discount factor
//  sigmav                  //Standard deviation of log normally distribution of idiosyncratic shocks (not use in this computation)
    gammav                  //Death rate
//  muvv                     //Auditig costs
    deltav                  //Depreciation rate
    phiv                    //Elasticity of price of capital wrt investment capital ratio
//    kappav                  //Parameter in Phillips curve
    thetav                  //Probability that a firm does not change price (Calvo)
//    epsilonv                //Parameter
    etav                    //Labor supply elasticity
    zetav                   //Coefficient on inflation in MP rule
    zetay // coefficient on output in (modified) MP rule
    rhov rhov_a rhov_g rhov_i rhov_f     //Serial correlation coefficients
    ytrend pi_bar s_bar F_bar // cgy itrend r_bar
    para_sp_b constebeta iotapi
; 

%--------------------------------------------------------------------------
%------ Declaration of External Function

thispath = cd; 
cd('..');
external_function_path = cd('..'); 
eval(['addpath  ' external_function_path '; ']);
external_function(name=norminv, nargs=3);
external_function(name=call_csolve1, nargs=3);
 
cd(thispath); 

% normpdf Normal probability density function (pdf).
%    Y = normpdf(X,muv,SIGMA) returns the pdf of the normal distribution with
%    mean muv and standard deviation SIGMA, evaluated at the values in X.
%    The size of Y is the common size of the input arguments.  
%    Default values for muv and SIGMA are 0 and 1 respectively.
%--------------------------------------------------------------------------

//**** Calibration parameters following Christensen and Dib (2008), Table 1
// Values are taken from the calibration of BGG (1999) itself.
// betav = 0.99;
etav = 2;   // 3;
deltav = 0.025;
X = 1.1;
gammav = 1-0.0272;
F_bar = 0.03/4; 
GY = 0.2;
alphav = 0.35;
omegav = 0.64/(1-alphav);  
H = 1/3; // 0.25;
//s = 1.005;
// KN = 2;
// sigmav = 0.28; 
// muvv = 0.12;
//phiv = 0.6;  


model(linear);

//*****  variables detrended with a deterministic trend gammag
//***** cH, c_eH, iH, yH, aH, kH(-1), nH(-1), D, B

#gammag=1+ytrend/100;
#betav= 1/(1+constebeta/100); //#betav = gammag/R;
#R = gammag / betav;     
#Rn = gammag * (1+pi_bar/100) / betav;
#rn_bar = (Rn - 1)*100;
#s = 1+s_bar/100;
#R_K = s*R;
#YK = X/alphav*(R_K - (1 - deltav));     // From (4.4) Equation
#WY = (1-alphav)*omegav/(H*X);           // From (4.11) Equation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW FEATURES DUE TO EXPLICIT CONSIDERATION OF OPTIMAL FINANCIAL CONTRACT
#sigmav = call_csolve1(F_bar, s, para_sp_b);
#z_bar = norminv(F_bar,0,1);
#omega_bar = exp(sigmav*z_bar - 0.5*sigmav^2);
#G_bar = normcdf(z_bar-sigmav,0,1);
#fp_bar = normpdf(z_bar,0,1);
#Gamma_bar = omega_bar * (1- F_bar) + G_bar;
#muv = (1-1/s)/(G_bar + (1-Gamma_bar)*(fp_bar/sigmav)/(1-F_bar));
#KN = 1/(1- (omega_bar*(1-F_bar) + (1-muv)*G_bar)*s);
#para_b_omg = (muv/KN*omega_bar)*(-(fp_bar)^2 + z_bar*fp_bar*(1-F_bar))/
            (omega_bar*sigmav^2*s * (1-F_bar - muv/sigmav*fp_bar)^2 * 
            (1- Gamma_bar + (1-F_bar)*(Gamma_bar - muv*G_bar)/(1-F_bar - muv/sigmav*fp_bar)));
#para_z_omg = (1-F_bar - muv/sigmav*fp_bar)/(Gamma_bar - muv*G_bar)*omega_bar;
#PARA1=(1-muv*z_bar/sigmav)/(1-muv*fp_bar/((1-F_bar)*sigmav)) -1;
#PARA2=(z_bar/sigmav -1)*fp_bar^2/sigmav + fp_bar/sigmav^2*(1- z_bar*(z_bar - sigmav))*(1-F_bar);
#para_b_sig = (PARA1*s*(-omega_bar*fp_bar) + muv/KN*PARA2/(1-F_bar - muv/sigmav*fp_bar)^2)*sigmav
             /((1-Gamma_bar)*s + (1-F_bar)*(1-1/KN)/(1-F_bar - muv/sigmav*fp_bar));
#para_z_sig = (-omega_bar*fp_bar + muv*z_bar/sigmav*omega_bar*fp_bar)*sigmav/(Gamma_bar - muv*G_bar);
#para_g_omg = (fp_bar/sigmav)*omega_bar/G_bar;
#para_g_sig = - z_bar*omega_bar*fp_bar/G_bar;
#para_sp_sig = ((para_b_omg/para_z_omg)*para_z_sig - para_b_sig)/(1- (para_b_omg/para_z_omg));
#para_n_rk = (gammav*R_K*KN/gammag)*(1- muv*G_bar*(1- para_g_omg/para_z_omg));
#para_n_r = (gammav*KN/betav)*(1-1/KN + muv*G_bar*s*para_g_omg/para_z_omg);
#para_n_qk = (gammav*R_K*KN/gammag)*(1- muv*G_bar*(1- para_g_omg/(para_z_omg*(KN-1)))) - gammav*KN/betav;
#para_n_n = (gammav/betav) + (gammav*R_K*KN/gammag)*muv*G_bar*para_g_omg/(para_z_omg*(KN-1));
#para_n_sig = (gammav*R_K*KN/gammag)*muv*G_bar*para_g_omg*(1 - para_z_sig/para_z_omg);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%#GAMMA_WBAR = 1-1/(gammav*s)*(betav/KN - (1-alphav)*(1-omegav)/alphav *(s-(1-deltav*betav)));   // From GNN (2003)
%//#NY = gammav*(1-GAMMA_WBAR)*R_K/YK + (1-alphav)*(1-omegav)/X;                // From (4.13) Equation                                
%#NY = (gammav*(1-GAMMA_WBAR)*R_K/YK + (1-alphav)*(1-omegav)/X)/gammag;      // From (4.13) Equation
#NY = (gammav/YK*(R_K*(1-muv*G_bar)-R)+ (1-alphav)*(1-omegav)/X)/(gammag-gammav*R);      // From (4.13) Equation
#DY = 1/YK - NY;                                                             // From (3.2) Equation
#CY = WY*H - GY + (X-1)/X + (R-1)*DY;                                        // From (B.2) Equation
#IY = 1/YK *(gammag -1 + deltav); // #IY = 1/YK *deltav;                                  
#C_EY = 1 - CY - IY - GY;                                                    // From (B.8) Equation
#YN = 1/NY;
#kappav = (1-thetav)/thetav*(1-thetav*betav);
#epsilonv = (1 - deltav)/((1 - deltav) + alphav*YK /X);  

// Aggregate demand block
   
yH = CY*cH + C_EY*c_eH + IY*iH+GY*gH;    // yH = CY*cH + C_EY*c_eH + IY*iH+gH;
cH = cH(+1) - rH; 
c_eH = nH;

// Add the shock on credit spread 
// r_kH(+1)-rH = -niv*(nH -(qH+kH))+fH; // r_kH(+1)-rH = -niv*(nH -(qH+kH));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_kH(+1)-rH = - para_sp_b * (nH -(qH+kH))+ para_sp_sig * fH;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
r_kH = (1-epsilonv)*(yH - xH - kH(-1)) +epsilonv*qH -qH(-1);

// Add an investment-specific shock
//qH = phiv*(iH - kH(-1))-xiH; // qH = phiv*(iH - kH(-1)); //capital adjustment costs
//iH = 1/(1+betav)*iH(-1) + betav/(1+betav)*iH(+1) + 1/(phiv*(1+betav))*(qH + xiH);  //investment adjustment costs
iH = 1/(1+betav)*iH(-1) + betav/(1+betav)*iH(+1) + 1/(phiv*(1+betav)*(gammag^2))*(qH + xiH);  //investment adjustment costs
                                            
// Aggregate supply block
// yH = aH + alphav*kH(-1)+(1-alphav)*omegav*hH;
yH = (1-alphav)*aH + alphav*kH(-1)+(1-alphav)*omegav*hH;
yH -hH -xH -cH = etav^(-1)*hH;
// piH = kappav*(-1)* xH + betav *piH(+1); // pi_t1H = kappav*(-1)*xH(+1)+betav *piH(+2);                                            
piH = 1/(1+betav*iotapi)*kappav*(-1)* xH + iotapi/(1+betav*iotapi)*piH(-1) + betav/(1+betav*iotapi)*piH(+1);

// piH = pi_t1H(-1);  

// Evolution of state variables:
// kH = deltav*(iH+xiH) + (1-deltav)*kH(-1);   // kH = deltav*iH+(1-deltav)*kH(-1); // capital evolution
kH = (1- (1-deltav)/gammag)*(iH+xiH) + ((1-deltav)/gammag)*kH(-1);
//nH = gammav*R_K*KN*r_kH - gammav*R*KN*rH(-1)+ gammav*(R_K - R)*KN*(qH(-1) + kH(-1)) + gammav*R*(rH(-1)+nH(-1))+(1-alphav)*(1-omegav)*(YN/X)*(yH - xH);
//nH = (gammav/gammag)*R_K*KN*r_kH - (gammav/gammag)*R*KN*rH(-1)+ (gammav/gammag)*(R_K - R)*KN*(qH(-1) + kH(-1)) 
//    + (gammav/gammag)*R*(rH(-1)+nH(-1))+(1-alphav)*(1-omegav)*(YN/X)*(1/gammag)*(yH - xH);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nH = para_n_rk * r_kH - para_n_r *rH(-1) + para_n_qk * (qH(-1) + kH(-1)) 
        +(1-alphav)*(1-omegav)*(YN/X)*(1/gammag)*(yH - xH) - para_n_sig *  fH(-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//r_nH = rhov*r_nH(-1)+(1-rhov)*zetav*piH - e_rn; // changed from the original rule     
r_nH = rhov*r_nH(-1)+(1-rhov)*zetav*piH +(1-rhov)*zetay*(yH-yHf) + e_rn; //new policy rule 
r_nH = rH + piH(+1); 
premiumH = r_kH(+1) - rH;

aH = rhov_a*aH(-1)+e_a;                                                     
gH = rhov_g*gH(-1)+e_g; // gH = rhov_g*gH(-1)+e_g+cgy*e_a; // 
xiH = rhov_i*xiH(-1)+e_i;
fH = rhov_f*fH(-1)+e_f;

// Flexible price model (defined without financial frictions)

// Aggregate demand block

yHf = CY*cHf + C_EY*c_eHf +IY*iHf +GY*gH; 
cHf = -rHf+cHf(+1);
c_eHf = nHf;
// r_kHf(+1) - rHf = -niv*(nHf-qHf-kHf);  
// r_kHf(+1)-rHf = - para_sp_b * (nHf -(qHf+kHf)) + para_sp_sig * fH; 
r_kHf(+1)-rHf =0;
r_kHf = (1-epsilonv)*(yHf-kHf(-1))+epsilonv*qHf-qHf(-1); 

// qHf = phiv*(iHf-kHf(-1)); 
iHf = 1/(1+betav)*iHf(-1) + betav/(1+betav)*iHf(+1) + 1/(phiv*(1+betav)*(gammag^2))*(qHf+xiH);

// Aggregate supply block
yHf = (1-alphav)*aH + alphav*kHf(-1) +(1-alphav)*omegav*hHf; 
yHf -hHf-cHf = (etav^(-1))*hHf;  
                                   
// Evolution of state variables:
// kHf = deltav*iHf+(1-deltav)*kHf(-1); // capital evolution
kHf = (1- (1-deltav)/gammag)*(iHf+xiH) + ((1-deltav)/gammag)*kHf(-1);
// nHf = gammav*R_K*KN*r_kHf - gammav*R*KN*rHf(-1)+ gammav*(R_K - R)*KN*(qHf(-1) + kHf(-1)) + gammav*R*(rHf(-1)+nHf(-1))+(1-alphav)*(1-omegav)*(YN/X)*(yHf);
nHf = para_n_rk * r_kHf - para_n_r *rHf(-1) + para_n_qk * (qHf(-1) + kHf(-1)) 
       +(1-alphav)*(1-omegav)*(YN/X)*(1/gammag)*(yHf) - para_n_sig * fH(-1);
outputgap = yH-yHf;

// measurement equations

xgdp_q_obs=yH-yH(-1)+ytrend;
fpi_q_obs=iH-iH(-1)+ytrend;  //fpi_q_obs=iH-iH(-1)+itrend;
pgdp_q_obs = piH + pi_bar; 
rff_q_obs = r_nH + rn_bar;
cp_q_obs = premiumH + s_bar;

end;

varobs xgdp_q_obs fpi_q_obs pgdp_q_obs rff_q_obs cp_q_obs;

estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
para_sp_b,    BETA_PDF, 0.05,0.005;      // Del Negro et al. (2013), niv 
           //  GAMMA_PDF, 0.05, 0.01;       // 0.02; Bailliu et al (2012)
           //phiv,   NORMAL_PDF, 0.25,0.05;       // Bailliu et al (2012)
phiv,   NORMAL_PDF, 4, 1.5; // De Graeve (2008), 4, 1.5
thetav, BETA_PDF, 0.5,0.1;           // SW(2007), cprobp
rhov,   BETA_PDF,0.5,0.2;  //BETA_PDF,0.75,0.1;           // An and Schorfheide (2007)//SW(2007), crr
zetav,  //NORMAL_PDF,1.5, 0.25;      // An and Schorfheide (2007)
       GAMMA_PDF, 1.5, 0.25;
zetay, GAMMA_PDF, 0.125,0.1;         //An and Schorfheide (2007)
pi_bar, GAMMA_PDF, 0.62, 0.1;        // Del Negro and Schorfheide (2012) // SW(2007), constepinf
iotapi, BETA_PDF,0.5,0.15;           // SW(2007)
constebeta, GAMMA_PDF,  0.3, 0.1;   // 0.25, 0.1;       // SW(2007), constebeta
ytrend, NORMAL_PDF, 0.4,0.1;         // SW(2007), ctrend
//itrend, NORMAL_PDF, 0.4,0.1;         // SW(2007), ctrend
s_bar,  GAMMA_PDF, 0.5,0.1;          // Del Negro et al. (2013)
        // NORMAL_PDF, 0.4,0.1;
rhov_a, BETA_PDF, 0.5, 0.2;          // SW(2007), crhoa
rhov_g, BETA_PDF, 0.5, 0.2;          // SW(2007), crhog
rhov_i, BETA_PDF, 0.5, 0.2;          // SW(2007), crhoqs 
rhov_f, BETA_PDF, 0.75, 0.15;         // Del Negro and Schorfheide (2012)
        // BETA_PDF, 0.5, 0.2;          // 0.8, 0.05;         // Bailliu et al (2012)
// cgy,    NORMAL_PDF,0.5,0.25;         // SW(2007), cgy 
stderr e_a, INV_GAMMA_PDF,0.1, 2.0;  // SW(2007), stderr ea
stderr e_g, INV_GAMMA_PDF,0.1, 2.0;  // 1.0, 4.0;  // An and Schorfheide (2007)
stderr e_rn,INV_GAMMA_PDF,0.1, 2.0;  // 0.4, 4.0;  // An and Schorfheide (2007)  
stderr e_i, INV_GAMMA_PDF,0.1, 2.0;  // SW(2007), stderr eqs 
stderr e_f, INV_GAMMA_PDF,0.05, 4.0;      // Del Negro and Schorfheide (2012) 
         // INV_GAMMA_PDF,0.1, 2.0;   
        
end;

estimated_params_init;
para_sp_b, 0.05; 
phiv, 5; //5.7670 from De Graeve (2008)
thetav, 0.75;  
rhov, 0.7;
zetav, 1.5;
zetay, 0.125;
pi_bar, 0.625;
constebeta, 0.25;
iotapi, 0.5;
ytrend, 0.4;
//itrend, 0.4;
s_bar, 0.5;
rhov_a, 0.90;   
rhov_g, 0.80;
rhov_i, 0.80;
rhov_f, 0.80;
// cgy, 0.5;
stderr e_a, 0.5;
stderr e_g, 0.5;
stderr e_rn, 0.25/4;
stderr e_i, 0.5;
stderr e_f, 0.5;
end;

//estimation(datafile='us20084s.xls',xls_range=B1:F105,mh_replic=0,first_obs=1,mh_nblocks = 1,mode_compute=4, forecast=10, presample=4,lik_init=1, smoother) rff_q_obs, pgdp_q_obs, xgdp_q_obs outputgap;
// estimation(datafile='us20091.xls',xls_range=B1:J178,mh_replic=50000,first_obs=1,mh_nblocks = 2, mh_drop=0.1, mh_jscale=0.4, mode_compute=4, forecast=30, mode_check) rff_q_obs, pgdp_q_obs, xgdp_q_obs;
//shock_decomposition(parameter_set=posterior_mode) xgdp_q_obs pgdp_q_obs rff_q_obs fpi_q_obs cp_q_obs;
//stoch_simul (irf = 0, ar=20);