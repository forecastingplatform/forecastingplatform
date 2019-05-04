%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model estimating CMR14 model
% Created and edited by: Matyas Farkas, 2019 January
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Risk Shocks 
% by Lawrence J. Christiano, Roberto Motto and Massimo Rostagno. 
% Published in of American Economic Review, Volume 104, issue 1, pages 27-65.
% File based on cmr.mod of the replication package, figure 1 folder. 
% The file estimates the baseline of the CMR model, with all financial variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Original Copyright
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (C) 2013 Benjamin K. Johannsen, Lawrence J. Christiano
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or (at
% your option) any later version.
% 
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see http://www.gnu.org/licenses/.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 0. Housekeeping, paths, and estimation decisions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn the warnings off because division by zero is not seen as a bug by 
% Dynare so long as it is eventually handled properly once the NaNs are
% produced.  However, this potentially generates many warnings, which
% clutter the screen.
warning off

% One can estimate the baseline version of the model, 
% and versions of the model obtained by dropping none, one or several of the 
% four 'financial variables'. By dropping none of the variables, the user
% simply estimates the baseline model. The financial variables you want
% included in the estimation are in the following list:

@# define financial_data = ["networth_obs", "credit_obs", "premium_obs", "Spread1_obs"]

% Depending on the variables included in the financial data, we need some
% indicator variables.

% The model sets some measurement error on net worth.  If net worth is not
% included in the financial variables, it should not have measurement error,
% and that measurement error should not be estimated.
 
@#define net_worth_in_financial_data = ("networth_obs" in financial_data)

% The model estimates an autocorrelation and standard deviation term for
% the term structure.  If the spread is not included in the data, then
% the autocorrelation and standard deviation should not be estimated.

@#define Spread1_in_financial_data = ("Spread1_obs" in financial_data)

% When no financial data were included in the model, sig_corr_p is also not
% estimated. So, we need an indicator to see if no financial data are
% in the observable variables.

@#define credit_in_financial_data = ("credit_obs" in financial_data)
@#define premium_in_financial_data = ("premium_obs" in financial_data)

@#define some_financial_data = (Spread1_in_financial_data || credit_in_financial_data || premium_in_financial_data || net_worth_in_financial_data)

@#define cee = 0

@#define possible_signals = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

@#define taylor1p5 = 0

@#define sticky_prices = 1
@#define sticky_wages = 1
@#define sigma_in_taylor_rule = 0


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Declaration of variables and parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% @# include "../cmr_declarations.mod"

var 
c
consumption_obs, 
@#if cee == 0
credit_obs,
@# endif
epsil, 
Fp,
Fw, 
g,
@# if cee == 0
gamma,
@# endif
gdp_obs,
h,
hours_obs, 
i,
inflation_obs, 
investment_obs,
kbar,
lambdaf, 
lambdaz,
muup,
muzstar, 
@# if cee == 0
n,
networth_obs,
omegabar,
@# endif
phi,
pi,
pinvest_obs,
pitarget,
@# if cee == 0
premium_obs,
@# endif
pstar,
q,
Re, 
Re_obs,
RealRe_obs,
@# if cee == 0
rL,
@# endif
rk,
Rk,
@# if cee == 0
RL, 
@# endif
s,
@# if cee == 0
sigma,
xi0, 
xi1, 
xi2, 
xi3, 
xi4, 
xi5, 
xi6, 
xi7, 
xi8, 
Spread1_obs,
term,
volEquity,
@# endif
u,
wage_obs,
wtilde,
wstar, 
zetac,
zetai;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declare the exogenous variables in the model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All have been checked.  All are used.
varexo 
e_epsil,
e_g,
@# if cee == 0
e_gamma,
@# endif
e_lambdaf, 
e_muup,
e_muzstar, 
e_pitarget,
@# if cee == 0 
e_sigma,
e_xi1,
e_xi2,
e_xi3, 
e_xi4,
e_xi5,
e_xi6,
e_xi7,
e_xi8,
e_term,
@# endif
e_xp,
e_zetac,
e_zetai;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declare the parameters in the model.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
parameters
actil_p,
adptil_p,
adytil_p,
alpha_p,
aptil_p,
aytil_p,
b_p,
beta_p,
@# if cee == 0
bigtheta_p,
@# endif
c_p,
delta_p,
epsil_p,
etag_p,
@# if cee == 0
Fomegabar_p,
@# endif
g_p,
@# if cee == 0
gamma_p,
@# endif
i_p,
iota_p,
iotamu_p,
iotaw_p,
lambdaf_p,
lambdaw_p,
mu_p,
muup_p,
muzstar_p,
@# if cee == 0
signal_corr_p,
@# endif
pi_p,
pibar_p,
pitarget_p,
psik_p,
psil_p,
psiL_p,
Re_p,
rhoepsil_p,
rhog_p,
@# if cee == 0
rhogamma_p,
@# endif
rholambdaf_p,
rhomuup_p,
rhomuzstar_p,
rhopitarget_p,
@# if cee == 0
rhosigma_p,
@# endif
rhoterm_p,
rhozetac_p,
rhozetai_p,
rhotil_p,
Sdoupr_p,
sigmaL_p,
@# if cee == 0
sigma_p,
@# endif
sigmaa_p,
stdepsil_p,
stdg_p,
@# if cee == 0
stdgamma_p,
@# endif
stdlambdaf_p,
stdmuup_p,
stdmuzstar_p,
stdpitarget_p,
@# if cee == 0
stdsigma1_p,
@# endif
stdterm_p,
stdxp_p,
stdzetac_p,
stdzetai_p,
@# if cee == 0
stdsigma2_p,
@# endif
tauc_p,
taud_p,
tauk_p,
taul_p,
tauo_p,
term_p,
upsil_p,
we_p,
xip_p,
xiw_p,
zeta_p,
zetac_p,
zetai_p;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Set parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% when stopshock = 1, then non-risk shocks are all turned off
@# define stopshock = 0

% when stopsignal = 1, then signals on risk are turned off
@# define stopsignal = 0

% when stopunant = 1, then unanticipated risk shock turned off
@# define stopunant = 0

% when signal_corr_nonzero = 1, sig_corr_p can be non zero.
@# define signal_corr_nonzero = 1

%%@# include "../cmr_parameters.mod"

stdlambdaf_p   =   0.010955960700000  ;  
stdmuup_p      =   0.003985791800000  ;	 
stdg_p         =   0.022812723300000  ;	 
stdmuzstar_p   =   0.007148784800000  ;	 
stdgamma_p     =   0.008103540300000  ;	 
stdepsil_p     =   0.004633811900000  ;	 
stdxp_p        =   0.489344620900000  ;	 
stdzetac_p     =   0.023325355100000  ;	 
stdzetai_p     =   0.054964824400000  ;	 
stdterm_p      =   0.001603753000000  ;	 
% Place holder for net worth
@# if sticky_wages
xiw_p          =   0.812796311400000  ;	 
@# else
xiw_p          =   0.0                ;
@# endif
b_p            =   0.735843822700000  ;	 
Fomegabar_p    =   0.005588569300000  ;	 
mu_p           =   0.214894511100000  ;	 
sigmaa_p       =   2.535553419500000  ;	 
Sdoupr_p       =  10.780000003400000  ;	 
@# if sticky_prices
xip_p          =   0.741218603400000  ;	 
@# else
xip_p          =   0.0                ;
@# endif
@# if taylor1p5 == 1
aptil_p        =   1.5;
@# else
aptil_p        =   2.396495942700000  ;	 
@# endif
rhotil_p       =   0.850296450300000  ;	 
iota_p         =   0.897367052100000  ;	 
iotaw_p        =   0.489073535900000  ;	 
iotamu_p       =   0.936565280700000  ;	 
adytil_p       =   0.364943654300000  ;
@# if some_financial_data
@# if signal_corr_nonzero	 
signal_corr_p  = 0.3861343781103740 ;	 
@# else
signal_corr_p  = 0                  ;
@# endif
@# else
signal_corr_p  = 0                  ;
@# endif
rholambdaf_p   = 0.9108528528580380 ;	 
rhomuup_p      = 0.9870257396836700 ;	 
rhog_p         = 0.9427215849959780 ;	 
rhomuzstar_p   = 0.1459051086113400 ;	 
rhoepsil_p     = 0.8089285617540170 ;	 
rhosigma_p     = 0.9706370265612010 ;	 
rhozetac_p     = 0.8968400853887450 ;	 
rhozetai_p     = 0.9086616567125290 ;	 
rhoterm_p      = 0.9743991813961140 ;	 
@# if stopsignal == 0  
stdsigma2_p    = 0.0282985295279650 ;
@# else
stdsigma2_p    = 0                  ;
@# endif
stdsigma1_p    = 0.0700061676650730 ;	 
	
		 

// Calibrated parameters.
actil_p           = 0;
adptil_p          = 0;
alpha_p           = 0.4;
aytil_p           = 0;
beta_p            = 0.998704208591811;
bigtheta_p        = 0.005;
c_p               = 1.545858551297361;
delta_p           = 0.025;
epsil_p           = 1;
etag_p            = 0.2043;
g_p               = 0.586751768198739;
gamma_p           = 0.985;
i_p               = 0.739400293322006;
lambdaf_p         = 1.2;
lambdaw_p         = 1.05;
muup_p            = 1;
muzstar_p         = 1.004124413586981;
pi_p              = 1.006010795406775;
pibar_p           = 1.006010795406775;
pitarget_p        = 1.006010795406775;
psik_p            = 0;
psil_p            = 0;
psiL_p            = 0.7705;
Re_p              = 0.011470654984364;
rhogamma_p        = 0;
rhopitarget_p     = 0.975;
sigmaL_p          = 1;
sigma_p           = 0.327545843119697;
stdpitarget_p     = 0.0001;
tauc_p            = 0.047;
taud_p            = 0;
tauk_p            = 0.32;
taul_p            = 0.241;
tauo_p            = 1;
term_p            = 1;
upsil_p           = 1.004223171829000;
we_p              = 0.005;
zeta_p            = 1;
zetac_p           = 1;
zetai_p           = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%@# include "../cmr_model.mod"


model;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auxiliary expressions.  These simplify the equations without adding
% additional variables.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # pitilde    = (pitarget^iota_p * pi(-1)^(1-iota_p) * pibar_p^(1-iota_p-(1-iota_p)));
  # Kp         = (Fp * ((1 - xip_p * (pitilde / pi)^(1/(1-lambdaf))) / (1 - xip_p))^(1-lambdaf));
  # rk_ss      = (steady_state(rk));
  # a          = (rk_ss * (exp(sigmaa_p * (u - 1)) - 1) / sigmaa_p);
  @# if cee == 0  
  # F          = (normcdf(((log(omegabar) + sigma(-1)^2 / 2) / sigma(-1))));
  # G          = (normcdf((log(omegabar) + sigma(-1)^2 / 2) / sigma(-1) - sigma(-1)));
  # H          = (normcdf((log(omegabar) + sigma(-1)^2 / 2) / sigma(-1) - 2 * sigma(-1)));              
  # d          = (((G + omegabar * (1 - F)) - ((1 - mu_p) * G + omegabar * (1 - F))) * (1 + Rk) * q(-1) * kbar(-1) / (muzstar * pi));
  @# endif
  # pitildep1  = (pitarget(+1)^iota_p * pi^(1-iota_p) * pibar_p^(1-iota_p-(1-iota_p)));
  # yz         = (pstar^(lambdaf/(lambdaf-1)) * (epsil * (u * kbar(-1) / (muzstar * upsil_p))^alpha_p 
                 * (h * wstar^(lambdaw_p/(lambdaw_p-1)))^(1-alpha_p) - phi));
  # Kpp1       = (Fp(+1) * ((1 - xip_p * (pitildep1 / pi(+1))^(1/(1-lambdaf(+1)))) / (1 - xip_p))^(1-lambdaf(+1)));
  # pitildewp1 = (pitarget(+1)^iotaw_p * pi^(1-iotaw_p) * pibar_p^(1-iotaw_p-(1-iotaw_p)));
  # piwp1      = (pi(+1) * muzstar(+1) * wtilde(+1) / wtilde);
  # piw        = (pi * muzstar * wtilde / wtilde(-1));
  # pitildew   = (pitarget^iotaw_p * pi(-1)^(1-iotaw_p) * pibar_p^(1-iotaw_p-(1-iotaw_p)));
  # Kwp1       = (((1 - xiw_p * (pitildewp1 / piwp1 * muzstar_p^(1-iotamu_p) * muzstar(+1)^iotamu_p)^(1/(1-lambdaw_p))) 
                 / (1-xiw_p))^(1-lambdaw_p*(1+sigmaL_p)) * wtilde(+1) * Fw(+1) / psiL_p);
  # Kw         = (((1 - xiw_p * (pitildew / piw * muzstar_p^(1-iotamu_p) * muzstar^iotamu_p)^(1/(1-lambdaw_p))) 
                 / (1 - xiw_p))^(1-lambdaw_p*(1+sigmaL_p)) * wtilde * Fw / psiL_p);
  # S          = (exp(sqrt(Sdoupr_p / 2)*(zetai * muzstar * upsil_p * i / i(-1) - muzstar_p * upsil_p))
                 + exp(-sqrt(Sdoupr_p / 2) * (zetai * muzstar * upsil_p * i/i(-1) - muzstar_p * upsil_p)) - 2);
  # Spr        = (sqrt(Sdoupr_p / 2) * (exp(sqrt(Sdoupr_p / 2) * (zetai * muzstar * upsil_p * i / i(-1) - muzstar_p * upsil_p)) 
                 - exp(-sqrt(Sdoupr_p / 2) * (zetai * muzstar * upsil_p * i / i(-1) - muzstar_p * upsil_p))));
  # Sprp1      = (sqrt(Sdoupr_p / 2) * (exp(sqrt(Sdoupr_p / 2) * (zetai(+1) * muzstar(+1) * upsil_p * i(+1) / i - muzstar_p * upsil_p)) 
                 - exp(-sqrt(Sdoupr_p / 2) * (zetai(+1) * muzstar(+1) * upsil_p * i(+1) / i - muzstar_p * upsil_p))));
  @# if cee == 0
  # Fp1        = (normcdf((log(omegabar(+1)) + sigma^2 / 2) / sigma));
  # Gp1        = (normcdf((log(omegabar(+1)) + sigma^2 / 2) / sigma - sigma));
  # G_ss       = (normcdf((log(steady_state(omegabar)) + steady_state(sigma)^2 / 2) / steady_state(sigma) - steady_state(sigma), 0, 1));
  @# endif

  # Rk_ss      = (steady_state(Rk));
  # kbar_ss    = (steady_state(kbar));
  @# if cee == 0
  # n_ss       = (steady_state(n));
  # sigma_ss   = (steady_state(sigma));
  @# endif 
  # h_ss       = (steady_state(h));
  # g_ss       = (etag_p * (steady_state(c) + steady_state(i)) / (1 - etag_p));
  @# if cee == 0
  # Gammap1    = (omegabar(+1) * (1 - Fp1) + Gp1);
  # Gammaprp1  = (1 - Fp1);
  # Gprp1      = (omegabar(+1) * normpdf((log(omegabar(+1)) + sigma^2 / 2) / sigma) / omegabar(+1) / sigma);
  @# endif


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Equations characterizing equilibrium.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Eqn 1: Law of motion for \latex{p^*}
    pstar = ((1 - xip_p) * (Kp / Fp)^(lambdaf/(1-lambdaf)) 
            + xip_p * ((pitilde / pi) * pstar(-1))^(lambdaf/(1-lambdaf)))^((1-lambdaf)/lambdaf);
  
  % Eqn 2: Law of motion for \latex{F_p}.
    Fp = zetac * lambdaz * yz + (pitildep1 / pi(+1))^(1/(1-lambdaf(+1))) * beta_p * xip_p * Fp(+1);
  
  % Eqn 3: Law of motion for \latex{K_p}
  % This error is ignored.
  %  Kp = zetac * lambdaf * lambdaz * pstar^(lambdaf/(lambdaf-1)) * yz * s 
  %       + beta_p * xip_p * (pitildep1 / pi(+1))^(lambdaf(+1)/(1-lambdaf(+1))) * Kpp1;
    Kp = zetac * lambdaf * lambdaz * yz * s 
         + beta_p * xip_p * (pitildep1 / pi(+1))^(lambdaf(+1)/(1-lambdaf(+1))) * Kpp1;
  
  % Eqn 4: Relationship between \latex{K_p} and \latex{F_p}.
  % This equation is contained in the definitions of Kp and Kpp1 in the
  % auxiliary equations.
  
  % Eqn 5: Law of motion for \latex{F_w}.
    Fw = zetac * lambdaz * wstar^(lambdaw_p/(lambdaw_p-1)) * h * (1 - taul_p) / lambdaw_p 
         + beta_p * xiw_p * muzstar_p^((1-iotamu_p)/(1-lambdaw_p)) * (muzstar(+1)^(iotamu_p/(1-lambdaw_p)-1))
         * pitildewp1^(1/(1-lambdaw_p)) / pi(+1) * (1 / piwp1)^(lambdaw_p/(1-lambdaw_p))  *  Fw(+1);
  
  % Eqn 6: Law of motion for \latex{K_w}.
    Kw = zetac * (wstar^(lambdaw_p/(lambdaw_p-1)) * h)^(1+sigmaL_p) * zeta_p + beta_p * xiw_p
         * (pitildewp1 / piwp1 * muzstar_p^(1-iotamu_p) * muzstar(+1)^iotamu_p)^(lambdaw_p*(1+sigmaL_p)/(1-lambdaw_p)) * Kwp1;
  
  % Eqn 7: Relationship between \latex{F_w} and \latex{K_w}.
  % This equation is contained in the definitions of Kw and Kwp1 in the
  % auxiliary equations.
  
  % Eqn 8: Law of motion of \latex{w^*}
    wstar = ((1 - xiw_p) * ( ((1 - xiw_p * (pitildew / piw * muzstar_p^(1-iotamu_p) * muzstar^iotamu_p)^(1/(1-lambdaw_p))) 
            / (1 - xiw_p))^lambdaw_p ) + xiw_p * (pitildew / piw * muzstar_p^(1-iotamu_p) * muzstar^iotamu_p 
            * wstar(-1))^(lambdaw_p/(1-lambdaw_p)))^(1/(lambdaw_p/(1-lambdaw_p)));
  
  % Eqn 9: Efficiency condition for setting captial utilization
    rk = tauo_p * rk_ss * exp(sigmaa_p * (u - 1));
  
  % Eqn 10: Rental rate on capital 
    rk = alpha_p * epsil * ((upsil_p * muzstar * h * wstar^(lambdaw_p/(lambdaw_p-1)) /(u * kbar(-1)))^(1 - alpha_p)) * s;
  
  % Eqn 11: Marginal Cost 
    s = (rk / alpha_p)^alpha_p * (wtilde / (1 - alpha_p))^(1-alpha_p) / epsil;
  

  % Eqn 12: Resource constraint
    @# if cee == 0
    yz = g + c + i / muup + tauo_p * a * kbar(-1) / (muzstar * upsil_p) + d + bigtheta_p * (1 - gamma) * (n - we_p) / gamma;
    @# else
    yz = g + c + i / muup + tauo_p * a * kbar(-1) / (muzstar * upsil_p) ;
    @# endif  

  % Eqn 13: Law of motion for capital
    kbar = (1 - delta_p) * kbar(-1) / (muzstar * upsil_p) + (1 - S) * i;
  
  % Eqn 14: Household FOC w.r.t. risk-free bonds
    0 = beta_p * zetac(+1) * lambdaz(+1) / (muzstar(+1) * pi(+1)) * (1 + (1 - taud_p) * Re) - zetac * lambdaz;
  
  % Eqn 15: Household FOC w.r.t. consumption
    (1 + tauc_p) * zetac * lambdaz = muzstar * zetac / (c * muzstar - b_p * c(-1)) 
                                     - b_p * beta_p * zetac(+1) / (c(+1) * muzstar(+1) - b_p * c);
  
  % Eqn 16: FOC for capital
    @# if cee == 0
    %0 = (1 - Gp1 - omegabar(+1) * (1 - Fp1)) * (1 + Rk(+1)) / (1 + Re) + (1 - Fp1) / (1 - Fp1 - mu_p * omegabar(+1) 
    %    * normpdf((log(omegabar(+1)) + sigma^2 / 2) / sigma) / omegabar(+1) / sigma) * ((1 + Rk(+1)) / (1 + Re) * ((1 - mu_p) * Gp1 
    %    + omegabar(+1) * (1 - Fp1)) - 1);

    0 = (1 - Gammap1) * (1 + Rk(+1)) / (1 + Re) + Gammaprp1 / (Gammaprp1 - mu_p * Gprp1) * ((1 + Rk(+1)) / (1 + Re) * (Gammap1 - mu_p * Gp1) - 1);

    @# else
    0 = beta_p * zetac(+1) * lambdaz(+1) / (muzstar(+1) * pi(+1)) * (1 + Rk(+1)) - zetac * lambdaz;
    @# endif
  
  % Eqn 17: Definition of return of entrepreneurs, Rk
    1 + Rk = ((1 - tauk_p) * (u * rk - tauo_p * a) + (1 - delta_p) * q) * pi / (upsil_p * q(-1)) + tauk_p * delta_p;
  
  % Eqn 18: Household FOC w.r.t. investment
    0 = - zetac * lambdaz / muup + lambdaz * zetac * q * (-Spr * zetai * i * muzstar * upsil_p / i(-1) + 1 - S)
        + beta_p * zetac(+1) * lambdaz(+1) * q(+1) * Sprp1 * (zetai(+1) * i(+1) * muzstar(+1) * upsil_p / i)^2 / (muzstar(+1) * upsil_p);
  
  % Eqn 19: Definition of yz.  
  % This equation is represented in the definition of yz in the definition
  % of the auxiliary equations.
  
  @# if cee == 1
  % Eqn 20: Monetary Policy Rule
  %  log(Re / Re_p) = rhotil_p * log(Re(-1) / Re_p) + (1 / Re_p) * (1 - rhotil_p) 
  %                   * (aptil_p * pi_p * log(pi(+1) / pitarget) + (1 / 4) * adytil_p * muzstar_p * log(gdp_obs));
  % monetary policy rule with short term interest rate:
    log(Re / Re_p) = rhotil_p * log(Re(-1) / Re_p) + (1 / Re_p) * (1 - rhotil_p) * pi_p * log(pitarget / pi_p) 
                     + (1 / Re_p) * (1 - rhotil_p) * aptil_p * pi_p * (log(pi(+1)) - log(pitarget)) 
                     + (1 / (4 * Re_p)) * (1 - rhotil_p) * adytil_p * muzstar_p * ((c_p * log(c / c(-1)) 
                     + i_p * log(i / i(-1)) - i_p * log(muup / muup(-1)) + g_p * log(g / g(-1)) ) / ( (c_p+i_p)/(1-etag_p) ) 
                     + log(muzstar / muzstar_p)) + (1 / Re_p) * (1 - rhotil_p) * adptil_p * log(pi / pi(-1)) 
                     - (1 / (4 * Re_p)) * (1 - rhotil_p) * aytil_p * (c_p * log(c / c_p) + i_p * log(i / i_p) 
                     - i_p * log(muup) + g_p * log(g / g_p)) / ((c_p+i_p)/(1-etag_p))
                     + (1 - @{stopshock}) * (1 / (400 * Re_p)) * e_xp;
  @#else
    % monetary policy rule with short term interest rate:
    log(Re / Re_p) = rhotil_p * log(Re(-1) / Re_p) + (1 / Re_p) * (1 - rhotil_p) * pi_p * log(pitarget / pi_p) 
                     + (1 / Re_p) * (1 - rhotil_p) * aptil_p * pi_p * (log(pi(+1)) - log(pitarget)) 
                     + (1 / (4 * Re_p)) * (1 - rhotil_p) * adytil_p * muzstar_p * ((c_p * log(c / c(-1)) 
                     + i_p * log(i / i(-1)) - i_p * log(muup / muup(-1)) + g_p * log(g / g(-1)) ) / ( (c_p+i_p)/(1-etag_p) ) 
                     + log(muzstar / muzstar_p)) + (1 / Re_p) * (1 - rhotil_p) * actil_p * muzstar_p * (log(q * kbar - n) 
                     - log(q(-1)*kbar(-1)-n(-1)) + log(muzstar / muzstar_p)) + (1 / Re_p) * (1 - rhotil_p) * adptil_p * log(pi / pi(-1)) 
                     - (1 / (4 * Re_p)) * (1 - rhotil_p) * aytil_p * (c_p * log(c / c_p) + i_p * log(i / i_p) 
                     - i_p * log(muup) + g_p * log(g / g_p)) / ((c_p+i_p)/(1-etag_p))
                     + (1 - @{stopshock}) * (1 / (400 * Re_p)) * e_xp
    @# if sigma_in_taylor_rule
        - 1 * (sigma - steady_state(sigma));
    @# else
        ;
    @# endif
  @#endif
  % Eqn 21: GDP
  % This is not used.  It is only used in the manuscript in the monetary
  % policy rule.
  %  # y = g + c + i / muup;
  
    @# if cee == 0
  % Eqn 22: Zero profit condition
    q(-1) * kbar(-1) * (1 + Rk) * ((1 - mu_p) * G + omegabar * (1 - F)) / (n(-1) * (1 + Re(-1))) - q(-1) * kbar(-1) / n(-1) + 1;
  
  % Eqn 23: Law of motion of net worth
    n = gamma / (pi * muzstar) * (Rk - Re(-1)-((G + omegabar * (1 - F)) - ((1 - mu_p) * G + omegabar * (1 - F))) * (1 + Rk)) 
        * kbar(-1) * q(-1) + we_p + gamma * (1 + Re(-1)) * n(-1) / (pi * muzstar);
   
    volEquity = (1 + Rk) * q(-1) * kbar(-1) / n(-1) * sqrt( (exp(sigma(-1)^2)/(1-F)*(1-H) - ((1-G)/(1-F))^2) );

  % Long rate
    zetac * lambdaz = ((1 + RL) * beta_p)^40 * zetac(+40) * lambdaz(+40) 
    @#for index in ["+1", "+2", "+3", "+4", "+5", "+6", "+7", "+8", "+9", "+10", "+11", "+12", "+13", "+14", "+15", "+16", "+17", "+18", "+19", "+20", "+21", "+22", "+23", "+24", "+25", "+26", "+27", "+28", "+29", "+30", "+31", "+32", "+33", "+34", "+35", "+36", "+37", "+38", "+39", "+40"] 
      * (term(@{index}) / (pi(@{index}) * muzstar(@{index})))
    @#endfor
    ;
    
  % Real risk free 10 year rate
    zetac * lambdaz  = (rL * beta_p)^40 * zetac(+40) * lambdaz(+40) 
    @#for index in ["+1", "+2", "+3", "+4", "+5", "+6", "+7", "+8", "+9", "+10", "+11", "+12", "+13", "+14", "+15", "+16", "+17", "+18", "+19", "+20", "+21", "+22", "+23", "+24", "+25", "+26", "+27", "+28", "+29", "+30", "+31", "+32", "+33", "+34", "+35", "+36", "+37", "+38", "+39", "+40"] 
      /  muzstar(@{index})
    @#endfor
    ;
   @# endif


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Observation equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  consumption_obs = c / c(-1) * muzstar / muzstar_p;
  @#if cee == 0
  credit_obs      = (q * kbar - n) / (q(-1) * kbar(-1) - n(-1)) * muzstar / muzstar_p;
  @#endif
  gdp_obs         = (c + i / muup + g) / (c(-1) + i(-1) / muup(-1) + g(-1)) * muzstar / muzstar_p;
  hours_obs       = h / h_ss;
  inflation_obs   =  pi / pi_p;
  investment_obs  = i / i(-1) * muzstar / muzstar_p;
  @# if cee == 0
  networth_obs    = n / n(-1) * muzstar / muzstar_p;
  premium_obs     = exp((((G + omegabar * (1 - F)) - ((1 - mu_p) * G + omegabar * (1 - F))) * (1 + Rk) * q(-1) * kbar(-1) 
                    / (q(-1) * kbar(-1) - n(-1))) - mu_p * G_ss * (1 + Rk_ss) * kbar_ss / (kbar_ss - n_ss));
  @# endif
  pinvest_obs     = muup(-1) / muup;
  Re_obs          = exp(Re - Re_p);
  RealRe_obs      = ((1 + Re) / pi(+1))/((1 + Re_p) / pi_p);
  @# if cee == 0
  Spread1_obs     = 1 + RL - Re;  
  @# endif
  wage_obs        = wtilde / wtilde(-1) * muzstar / muzstar_p;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shock equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  log(epsil / epsil_p)       = rhoepsil_p    * log(epsil(-1) / epsil_p)       + (1 - @{stopshock}) * e_epsil;
  log(g / g_ss)              = rhog_p        * log(g(-1) / g_ss)              + (1 - @{stopshock}) * e_g;
  @# if cee == 0
  log(gamma / gamma_p)       = rhogamma_p    * log(gamma(-1) / gamma_p)       + (1 - @{stopshock}) * e_gamma;
  @# endif
  log(lambdaf / lambdaf_p)   = rholambdaf_p  * log(lambdaf(-1) / lambdaf_p)   + (1 - @{stopshock}) * e_lambdaf;
  log(muup / muup_p)         = rhomuup_p     * log(muup(-1) / muup_p)         + (1 - @{stopshock}) * e_muup;
  log(muzstar / muzstar_p)   = rhomuzstar_p  * log(muzstar(-1) / muzstar_p)   + (1 - @{stopshock}) * e_muzstar;
  log(pitarget / pitarget_p) = rhopitarget_p * log(pitarget(-1) / pitarget_p) + (1 - @{stopshock}) * e_pitarget;
  @# if cee == 0
  log(term / term_p)         = rhoterm_p     * log(term(-1) / term_p)         + (1 - @{stopshock}) * e_term;
  @# endif
  log(zetac / zetac_p)       = rhozetac_p    * log(zetac(-1) / zetac_p)       + (1 - @{stopshock}) * e_zetac;
  log(zetai / zetai_p)       = rhozetai_p    * log(zetai(-1) / zetai_p)       + (1 - @{stopshock}) * e_zetai;
  
  @# if cee == 0
  log(sigma / sigma_ss) = rhosigma_p * log(sigma(-1) / sigma_ss)  + log(xi0) 
  @#for index in ["1", "2", "3", "4", "5", "6", "7", "8"]
    + log(xi@{index}(-@{index}))
  @#endfor 
  ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal equations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  @#if ("8" in possible_signals)
  log(xi8) = stdsigma2_p * e_xi8;
  @#else
  log(xi8) = 0;
  @#endif
  
  @#if ("7" in possible_signals)
  log(xi7) = signal_corr_p * stdsigma2_p * e_xi8 
  @#for index in ["7"]
    + sqrt(1 - signal_corr_p^2) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi7) = 0;
  @#endif
  
  @#if ("6" in possible_signals)
  log(xi6) = signal_corr_p^2 * stdsigma2_p * e_xi8
  @#for index in ["7", "6"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 6) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi6) = 0;
  @#endif

  @#if ("5" in possible_signals)
  log(xi5) = signal_corr_p^3 * stdsigma2_p * e_xi8
  @#for index in ["7", "6", "5"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 5) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi5) = 0;
  @#endif

  @#if ("4" in possible_signals)
  log(xi4) = signal_corr_p^4 * stdsigma2_p * e_xi8
  @#for index in ["7", "6", "5", "4"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 4) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi4) = 0;
  @#endif

  @#if ("3" in possible_signals)  
  log(xi3) = signal_corr_p^5 * stdsigma2_p * e_xi8
  @#for index in ["7", "6", "5", "4", "3"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 3) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi3) = 0;
  @#endif

  @#if ("2" in possible_signals)  
  log(xi2) = signal_corr_p^6 * stdsigma2_p * e_xi8
  @#for index in ["7", "6", "5", "4", "3", "2"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 2) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi2) = 0;
  @#endif
  
  @#if ("1" in possible_signals)
  log(xi1) = signal_corr_p^7 * stdsigma2_p * e_xi8
  @#for index in ["7", "6", "5", "4", "3", "2", "1"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 1) * stdsigma2_p * e_xi@{index}
  @#endfor
  ;
  @#else
  log(xi1) = 0;
  @#endif
  
  @# if ("0" in possible_signals)
  log(xi0) = signal_corr_p^8 * stdsigma1_p * e_xi8
  @#for index in ["7", "6", "5", "4", "3", "2", "1"]
    + sqrt(1 - signal_corr_p^2) * signal_corr_p^(@{index} - 0) * stdsigma1_p * e_xi@{index}
  @#endfor
  + sqrt(1-signal_corr_p^2) * stdsigma1_p * e_sigma;
  @#else
  log(xi0)=0;
  @#endif  
  @#endif
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This ensures zero profits.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  phi = steady_state(phi);

end;


% Compute the steady state of the model.
steady;

% Compute the eigenvalues of the model linearized around the steady state.
check;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specifiy the shocks.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%@# include "../cmr_shocks.mod"

shocks; 
var e_xp;       stderr stdxp_p;
var e_lambdaf;  stderr stdlambdaf_p;
var e_pitarget; stderr stdpitarget_p;
var e_muup;     stderr stdmuup_p;
var e_g;        stderr stdg_p;
var e_muzstar;  stderr stdmuzstar_p;
@# if cee == 0
var e_gamma;    stderr stdgamma_p;
@# endif
var e_epsil;    stderr stdepsil_p;
@# if cee == 0
var e_sigma;    stderr 1-@{stopunant};
@# endif
var e_zetac;    stderr stdzetac_p;
var e_zetai;    stderr stdzetai_p;
@# if cee == 0
@#if Spread1_in_financial_data
var e_term;     stderr stdterm_p;
@#else
var e_term;     stderr 0;
@#endif
var e_xi8;      stderr 1-@{stopsignal};
var e_xi7;      stderr 1-@{stopsignal};
var e_xi6;      stderr 1-@{stopsignal};
var e_xi5;      stderr 1-@{stopsignal};
var e_xi4;      stderr 1-@{stopsignal};
var e_xi3;      stderr 1-@{stopsignal};
var e_xi2;      stderr 1-@{stopsignal};
var e_xi1;      stderr 1-@{stopsignal};
@# endif
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Estimation, to get the smoothed variables.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% List all parameters to be estimated and priors.
%%@# include "../cmr_estimated_params.mod"

estimated_params;
xiw_p,               BETA_PDF,       0.75,              0.1;
b_p,                 BETA_PDF,       0.5,               0.1;
@# if cee == 0
Fomegabar_p,         BETA_PDF,       0.0075,            0.00375;
mu_p,                BETA_PDF,       0.275,             0.15;
@# endif
sigmaa_p,            NORMAL_PDF,     1,                 1;
Sdoupr_p,            NORMAL_PDF,     5,                 3;
xip_p,               BETA_PDF  ,     0.5,               0.1;
aptil_p,             NORMAL_PDF,     1.5,               0.25;
rhotil_p,            BETA_PDF,       0.75,              0.1;
iota_p,              BETA_PDF,       0.5,               0.15;
iotaw_p,             BETA_PDF,       0.5,               0.15;
iotamu_p,            BETA_PDF,       0.5,               0.15;
adytil_p,            NORMAL_PDF,     0.25,              0.1;
@# if cee == 0
@# if some_financial_data
@# if signal_corr_nonzero
signal_corr_p,       NORMAL_PDF,     0,                 0.5;
@# endif
@# endif
@# endif
rholambdaf_p,        BETA_PDF,       0.5,               0.2;
rhomuup_p,           BETA_PDF,       0.5,               0.2;
rhog_p,              BETA_PDF,       0.5,               0.2;
rhomuzstar_p,        BETA_PDF,       0.5,               0.2;
rhoepsil_p,          BETA_PDF,       0.5,               0.2;
@# if cee == 0
rhosigma_p,          BETA_PDF,       0.5,               0.2;
@# endif
rhozetac_p,          BETA_PDF,       0.5,               0.2;
rhozetai_p,          BETA_PDF,       0.5,               0.2;
@# if cee == 0
@# if Spread1_in_financial_data
rhoterm_p,           BETA_PDF,       0.5,               0.2;
@# endif
@# if stopsignal == 0
stdsigma2_p,         INV_GAMMA2_PDF, 0.000824957911384, 0.00116666666667;
@# endif
stdsigma1_p,         INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;  
@# endif
stderr e_lambdaf,    INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
stderr e_muup,       INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
stderr e_g,          INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
stderr e_muzstar,    INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
@# if cee == 0
stderr e_gamma,      INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
@# endif
stderr e_epsil,      INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
stderr e_xp,         INV_GAMMA2_PDF, 0.583333333333,    0.824957911384;
stderr e_zetac,      INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
stderr e_zetai,      INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
@# if cee == 0
@# if Spread1_in_financial_data
stderr e_term,       INV_GAMMA2_PDF, 0.00233333333333,  0.00329983164554;
@# endif
@# if net_worth_in_financial_data
stderr networth_obs, INV_GAMMA_PDF,  0.01,              5;
@# endif
@# endif
end;

% Declare numerical initial values for the optimizer.
%%@# include "../cmr_estimated_params_init.mod"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The 'estimated_params_init' block declares numerical initial values for 
% the optimizer when these are different from the prior mean.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

estimated_params_init;	 	 
stderr e_lambdaf,        0.0109559606811660;  
stderr e_muup,           0.0039857917638490;
stderr e_g,              0.0228127233194570;
stderr e_muzstar,        0.0071487847687080;
@# if cee == 0
stderr e_gamma,          0.0081035403472920;
@# endif
stderr e_epsil,          0.0046338119312200;
stderr e_xp,             0.4893446208831330;
stderr e_zetac,          0.0233253551183060;
stderr e_zetai,          0.0549648244379450;
@# if cee == 0
@# if Spread1_in_financial_data
stderr e_term,           0.0016037530257270;
@# endif
@# if net_worth_in_financial_data
stderr networth_obs,     0.0174589738467390;
@# endif
@# endif
xiw_p,                   0.8127963113950160;
b_p,                     0.7358438226929010;
@# if cee == 0
Fomegabar_p,             0.0055885692972290;
mu_p,                    0.2148945111281970;
@# endif
sigmaa_p,                2.5355534195260200;
Sdoupr_p,               10.7800000034422000;
xip_p,                   0.7412186033856290;
@# if taylor1p5 == 1
aptil_p,                 1.5;
@# else
aptil_p,                 2.3964959426752000;
@# endif
rhotil_p,                0.8502964502607260;
iota_p,                  0.8973670521349900;
iotaw_p,                 0.4890735358842230;
iotamu_p,                0.9365652807278990;
adytil_p,                0.3649436543356210; 

@# if cee == 0
@# if (some_financial_data && signal_corr_nonzero)
signal_corr_p,           0.3861343781103740;
@# endif
@# endif

rholambdaf_p,            0.9108528528580380;
rhomuup_p,               0.9870257396836700;
rhog_p,                  0.9427215849959780;
rhomuzstar_p,            0.1459051086113400;
rhoepsil_p,              0.8089285617540170;
@# if cee == 0
rhosigma_p,              0.9706370265612010;
@# endif 
rhozetac_p,              0.8968400853887450;
rhozetai_p,              0.9086616567125290;
@# if cee == 0
@# if Spread1_in_financial_data
rhoterm_p,               0.9743991813961140;
@# endif
@# if stopsignal == 0
stdsigma2_p,             0.0282985295279650;
@# endif
stderr e_sigma,		 0.0700061676650730;
@# endif
end;



% The 'varobs' command lists the names of observed endogenous variables 
% for the estimation procedure. These variables must be available in the 
% data file.

varobs
@# if some_financial_data
@# for fvar in financial_data
       @{fvar},
@# endfor
@# endif
       inflation_obs, hours_obs,  gdp_obs,
       wage_obs, investment_obs, consumption_obs,  
       Re_obs, pinvest_obs;


%%%estimation(datafile = data_BAAoverTB, order = 1, mode_compute = 4) sigma;
