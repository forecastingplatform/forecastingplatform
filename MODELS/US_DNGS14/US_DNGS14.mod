%% The Del Negro, Giannoni, Schorfheide DSGE model
%% Inflation in the Great Recession and New Keynesian Models

% insert endogenous, exogenous, parameter blocks
%%% endogenous variables %%%
var y_t     $\hat{y}$               %  1    => output
    c_t     $\hat{c}$               %  2    => consumption
    i_t     $\hat{i}$               %  3    => investment
    k_t     $\hat{k}$               %  4    => effective capital stock
    kbar_t  $\hat{\bar{k}}$         %  5    => installed capital stock
    L_t     $\hat{L}$               %  6    => hours worked
    mc_t    $\hat{mc}$              %  7    => marginal costs
    pi_t    $\hat{\pi}$             %  8    => infaltion
    R_t     $\hat{R}$               %  9    => nominal policy rate
    rk_t    $\hat{r}^k$             % 10    => real rate of capital
    u_t     $\hat{u}$               % 11    => capacity utilization
    w_t     $\hat{w}$               % 12    => real wage
    muw_t   $\hat{mu^w_t}$          % 13    => wage mark-up
    qk_t    $\hat{q}^k$             % 14    => Tobin's Q                                                        
    Rktil_t $\hat{\tilde{R}}^k$     % 15    => nominal return on capital
    n_t     $\hat{n}$               % 16    => entrepreneurs net worth 

%%% shock processes %%%
    z_t         $\hat{z}$                   % 17    => technology shocks process 
    ztil_t      $\hat{\tilde{z}}$           % 18    => technology shocks process 
    b_t         $\hat{b}$                   % 19    => asset shock process
    g_t         $\hat{g}$                   % 20    => government spending shock process
    laf_t       $\tilde{\lambda}^f$         % 21    => price mark-up shock process
    law_t       $\tilde{\lambda}^w$         % 22    => wage mark-up shock process
    sigw_t      $\tilde{\sigma}^{\omega}$   % 23    => spread shock process  
    mu_t        $\hat{\mu}$                 % 24    => investment specific technology process
    rm_t        $r^{m}$                     % 27    => policy rate shock iid, maybe pre-announced

%%% observables %%%
    xgdp_q_obs          $\Delta y^{obs}$    % 28    => GDP growth, observed 
    hours_obs           $L^{obs}$           % 29    => hours worked, observed
    wage_obs            $wage^{obs}$        % 30    => real wage growth, observed
    pgdp_q_obs          $\pi^{obs}$         % 31    => inflation, observed
    rff_q_obs           $R^{obs}$           % 32    => policy rate, observed (shadow rate)
    pcer_q_obs          $\Delta c^{obs}$    % 33    => consumption growth, observed 
    fpi_q_obs           $\Delta i^{obs}$    % 34    => investment growth, observed 
    cp_q_obs     		$SPREAD^{obs}$      % 35    => interest rate spread, observed

%%% flexprice economy %%%
    y_ft                $\hat{y}^f$         % 36    => output 
    c_ft                $\hat{c}^f$         % 37    => consumption
    i_ft                $\hat{i}^f$         % 38    => investment
    k_ft                $\hat{k}^f$         % 39    => effective capital stock
    kbar_ft             $\hat{\bar{k}}^f$   % 40    => installed capitla stock 
    L_ft                $\hat{L}^f$         % 41    => hours worked 
    r_ft                $\hat{r}^f$         % 42    => real interest rate 
    rk_ft               $\hat{r}^{f,k}$     % 43    => real rental of capital 
    u_ft                $\hat{u}^f$         % 44    => capacity utilization
    w_ft                $\hat{w}^f$         % 45    => real wage 
    qk_ft               $\hat{q}^{f,k}$     % 46    => Tobin's Q   
    outputgap_t         $Output Gap$        % 47    => Output Gap
    r_ft_obs
    r_ann_t;

% iid  shocks %%%
varexo  
    z_sh                $\epsilon^z$                %  1    => technology shock
    g_sh                $\epsilon^g$                %  2    => government spending shock
    b_sh                $\epsilon^b$                %  3    => asset shock
    mu_sh               $\epsilon^{\mu}$            %  4    => investment specific technology shock
    laf_sh              $\epsilon^{\lambda_f}$      %  5    => price mark-up shock
    law_sh              $\epsilon^{\lambda_w}$      %  6    => wage mark-up shock          
    sigw_sh             $\epsilon^{\tilde{\sigma}_\omega}$  %  7    => spread shock
    rm_sh               $\epsilon^{r}$;             %  8    => policy rate shocks 

parameters  
% monetary policy parameters
    psi1        $\psi_1$        % 1     => monetary policy reaction to inflation
    psi2        $\psi_2$        % 2     => monetary policy reaction to the output gap
    psi3        $\psi_3$        % 3     => monetary policy reaction to the change in the output gap
    rho_r       $\rho_r$        % 4     => interest rate smoothing parameter 
 
% nominal rigidities
    zeta_p    $\zeta_p$         % 5     =>  price Calvo prametert
    iota_p    $\iota_w$         % 6     =>  price indexation parameter
    zeta_w    $\zeta_w$         % 7     =>  wage Calvo prametert
    iota_w    $\iota_w$         % 8     =>  wage indexation parameter

% financial frictions parameters
    zeta_spb  $\zeta_{sb,b}$    % 9     => elasticity of the spread with respect to leverage
    gammstar  $\gamma_*$        % 10    => survival rate for the entrepreneurs
    sprd_aux                    % 11    => steady state spread   
    
% other endogenous propagagion and steady state parameters
    alp       $\alpha$          % 12    => capital elasticity (Cobb-Douglas production function)
    Bigphi    $\Phi$            % 13    => fixed cost of production
    h         $h$               % 14    => habit persistence
    nu_l      $\nu_l$           % 15    => inverse of the elasticity of labor with respect to the real wage
    rstar_aux                   % 16    => quarterly steady state real interest rate
    pistar_aux                  % 17    => annual steady state inflation in percent
    zstar_aux                   % 18    => quarterly steady state growth rate in percent
    s2        $s_2$             % 19    => second derivative investment adjustment cost
    sigmac    $\sigma_c$        % 20    => relative risk aversion
    ppsi      $ppsi$            % 21    => capital utilization cost
    Lmean     $\bar{L}$         % 22    => steady state hours, captures the units of measured hours worked.

% calibrated parameters
    del       $\delta$          % 23    => depreciation rate
    gstar     $g_*$             % 24    => government spending share
    law       $\lambda_w$       % 25    => elasticity of substitution between differentiated labor services   
    laf
    Fom_aux                     % 26    => cumulative distribution function of bankruptcy threshold (annual)
    epsp      $\epsilon_p$      % 27    => Kimball price parameter
    epsw      $\epsilon_w$      % 28    => Kimball wage parameter

% shock parameter
    rho_z       $\rho_z$               % 29    => persistence of technology shock process
    rho_b       $\rho_b$               % 30    => persistence of asset shock
    rho_laf     $\rho_\lambda^f$       % 31    => persistence of price mark-up shock process
    rho_law     $\rho_\lambda^w$       % 32    => persistence of wage mark-up shock process
    rho_mu      $\rho_\mu$             % 33    => persistence of marginal efficiency of investment (MEI) shock process
    rho_g       $\rho_g$               % 34    => persistence of government spending shock process
    eta_laf     $\eta_\lambda^f$       % 35    => ARMA parameter of price mark-up shock process
    eta_law     $\eta_\lambda^w$       % 36    => ARMA parameter of wage mark-up shock process
    eta_gz      $\eta_{gz}$            % 37    => elasticity of government spending to technology shock
    rho_sigw    $\rho_{\sigma_\omega}$ % 38    => persistence of the spread shock process
    rho_rm      $\rho_{rm}$            % 39    => persistence of monetary policy shock process

% parameters computed in the steady state file
    bet         $\beta$         % 43    => computed in steady state file; discount factor
    pistar    $\pi_*$           % 44    => quarterly steady state inflation rate
    sprd      $SPREAD_*$        % 45    => st st spread from annual perc to quarterly number
    Fom                         % 46    => computed in steady state file; quarterly steady state default probability
    zstar     $\z_*$            % 47    => quarterly steady state growth rate of labor augmenting technology growth
    rstar       $r_*$           % 48    => quarterly gross steady state real interest rate
    Rstarn      $R_*$           % 49    => steady state policy rate in percent
    rkstar      $r^k_*$         % 50    =>
    omegastar                   % 51    =>
    Lstar       $L_*$           % 52    =>
    kstar       $k_*$           % 53    =>
    kbarstar    $\bar{k}_*$     % 54    =>
    istar       $i_*$           % 55    => steady state investment
    ystar       $y_*$           % 56    => steady state output
    cstar       $c_*$           % 57    => steady state consumption
    wl_c        $wl_c$          % 58    => 
    zwstar      $i_*$           % 59    =>
    sigwstar                    % 60    =>
    omegabarstar                % 61    =>
    Gstar                       % 62    =>
    Gammastar                   % 63    =>
    dGdomegastar                % 64    =>
    d2Gdomega2star              % 65    =>
    dGammadomegastar            % 66    =>
    d2Gammadomega2star          % 67    =>
    dGdsigmastar                % 68    =>
    d2Gdomegadsigmastar         % 69    =>
    dGammadsigmastar            % 70    =>
    d2Gammadomegadsigmastar     % 71    =>
    muestar                     % 72    =>
    nkstar                      % 73    =>
    Rhostar                     % 74    =>
    wekstar                     % 75    =>
    vkstar                      % 76    =>
    nstar           $n_*$       % 77    =>
    vstar           $v_*$       % 78    =>
    GammamuG                    % 79    =>
    GammamuGprime               % 80    =>
    zeta_bw         $\zeta_{b,w}$   % 81    =>
    zeta_zw         $\zeta_{z,w}$   % 82    =>
    zeta_bw_zw      $\zeta_{bw,zw}$ % 83    =>
    zeta_bsigw      $\zeta_{b,\sigma_\omega}$   % 84    =>
    zeta_zsigw      $\zeta_{z,\sigma_\omega}$   % 85    =>
    zeta_spsigw     $\zeta_{sp,\sigma_\omega}$  % 86    =>
    zeta_bmue       $\zeta_{b,\mu^e}$           % 87    =>
    zeta_zmue       $\zeta_{z,\mu^e}$           % 88    =>
    zeta_spmue      $\zeta_{sp,\mu^e}$          % 89    =>
    Rkstar          $R^k_*$                     % 90    =>
    zeta_Gw         $\zeta_{G,w}$               % 91    =>
    zeta_Gsigw      $\zeta_{G,\mu^e}$           % 92    =>
    zeta_nRk        $\zeta_{n,R^k}$             % 93    =>
    zeta_nR         $\zeta_{n,R}$               % 94    =>
    zeta_nqk        $\zeta_{n,q^k}$             % 95    =>
    zeta_nn         $\zeta_{n,n}$               % 96    =>
    zeta_nmue       $\zeta_{n,\mu^e}$           % 97    =>
    zeta_nsigw      $\zeta_{n,\sigma_\omega}$;  % 98    =>  
% set parameter values
%% set parameter values

% monetary policy parameters
    psi1      = 1.50;    % monetary policy reaction to inflation
    psi2      = 0.12;    % monetary policy reaction to the output gap
    psi3      = 0.12;    % monetary policy reaction to the change in the output gap
    rho_r     = 0.75;    % interest rate smoothing parameter 
 
% nominal rigidities
    zeta_p    = 0.50;    % price Calvo prametert
    iota_p    = 0.50;    % price indexation parameter
    zeta_w    = 0.50;    % wage Calvor parameter  
    iota_w    = 0.50;    % wage indexation parameter

% financial frictions parameters
    zeta_spb  = 0.05;    % elasticity of the spread with respect to leverage
    gammstar  = 0.99;    % survival rate for the entrepreneurs
    sprd_aux  = 2.00;    % steady state spread
    
% other endogenous propagagion and steady state parameters
    alp       = 0.30;    % capital elasticity (Cobb-Douglas production function)
    Bigphi    = 1.25;    % fixed cost of production
    h         = 0.70;    % habit persistence
    nu_l      = 2.00;    % inverse of the elasticity of labor with respect to the real wage
    rstar_aux = 0.03;    % quarterly steady state real interest rate
    pistar_aux= 0.55;    % quarterly steady state inflation rate
    zstar_aux = 0.40;    % quarterly steady state growth rate of labor augmenting technology growth
    s2        = 4.00;    % second derivative investment adjustment cost
    sigmac    = 1.50;    % relative risk aversion
    ppsi      = 0.50;    % capital utilization cost
    Lmean     =    0;    % captures the units of measured hours worked.

% calibrated parameters
    del       = 0.025;   % depreciation rate             
    gstar     = 0.18;    % government spending share                                                
    law       = 1.5;     % elasticity of substitution between differentiated labor services          
    laf       = 0.15;    % elasticity of substitution parameter, net mark-up over marginal cost   
    Fom_aux   = 0.03;    % cumulative distribution function of bankruptcy threshold (annual)       
    epsp      = 10.0;    % Kimball price parameter                                                 
    epsw      = 10.0;    % Kimball wage parameter                                                  

% shock parameter
    rho_z        = 0.50;  % persistence of technology shock process
    rho_b        = 0.50;  % persistence of asset shock
    rho_laf      = 0.50;  % persistence of price mark-up shock process
    rho_law      = 0.50;  % persistence of wage mark-up shock process
    rho_mu       = 0.50;  % persistence of marginal efficiency of investment (MEI) shock process
    rho_g        = 0.50;  % persistence of government spending shock process
    eta_laf      = 0.50;  % ARMA parameter of price mark-up shock process
    eta_law      = 0.50;  % ARMA parameter of wage mark-up shock process
    eta_gz       = 0.50;  % elasticity of government spending to technology shock
    rho_sigw     = 0.75;  % persistence of the spread shock process
    rho_rm       = 0.50;  % persistence of monetary policy shock process


% Initialize parameters at posterior mode
% z_sh=0.368083282201789;
% g_sh=2.10484000874178;
% b_sh=0.0250000000128248;
% mu_sh=0.360752456024976;
% laf_sh=0.0826833145051358;
% law_sh=0.514920582406422;
% sigw_sh=0.0463942476856667;
% rm_sh=0.123295199136505;
psi1=1.69469964540873;
rho_r=0.803276455471325;
psi2=0.00100000001639462;
psi3=0.204545731556335;
zeta_p=0.632419485025427;
zeta_w=0.678233694879697;
iota_w=0.437644736106758;
iota_p=0.24871742336374;
zeta_spb=0.0567196337303234;
sprd_aux=1.79701522932504;
alp=0.151139983397578;
Bigphi=1.49611293227828;
h=0.552867893155675;
nu_l=2.61901718510982;
rstar_aux=0.185020584294076;
pistar_aux=0.636515362859173;
zstar_aux=0.675031774845207;
s2=3.83758749137638;
sigmac=0.617536968571637;
ppsi=0.704211176771862;
Lmean=0.467095066878511;
rho_z=0.927869144344177;
rho_b=0.978830768637953;
rho_g=0.973780046300972;
rho_mu=0.704174758074488;
rho_rm=0.329818529119132;
rho_laf=0.932617731912286;
rho_law=0.218530890658289;
eta_laf=0.751919860621257;
eta_law=0.330272538352786;
eta_gz=0.202558490564382;
rho_sigw=0.958288725244967;


%**************************************************************************
%% specify the (linear) model
model(linear);

%%*****************************************************
%**      1. Consumption Euler Equation
%******************************************************/
% equation (3) in the paper (combined with equation (2))
%%* sticky prices and wages */
c_t = - (1-h*exp(-zstar))/(sigmac*(1+h*exp(-zstar))) * (R_t - pi_t(+1)) + b_t 
      + (h*exp(-zstar))/(1+h*exp(-zstar)) * (c_t(-1) - z_t)
      + 1/(1+h*exp(-zstar)) * (c_t(+1) + z_t(+1))
      + (sigmac - 1)*wl_c/(sigmac*(1 + h*exp(-zstar))) * (L_t - L_t(+1));

%%* flexible prices and wages **/
c_ft = - (1-h*exp(-zstar))/(sigmac*(1+h*exp(-zstar))) * (r_ft) + b_t 
      + (h*exp(-zstar))/(1+h*exp(-zstar)) * (c_ft(-1) - z_t)
      + 1/(1+h*exp(-zstar)) * (c_ft(+1) + z_t(+1))
      + (sigmac - 1)*wl_c/(sigmac*(1 + h*exp(-zstar))) * (L_ft - L_ft(+1));


%%****************************************************
%**      2. Investment Euler Equation
%*****************************************************/
% equation (4) in the paper
%%* sticks prices and wages **/
qk_t   = (s2*exp(2*zstar)*(1+bet*exp((1-sigmac)*zstar))) * (i_t  - 1/(1+bet*exp((1-sigmac)*zstar)) * (i_t(-1)  - z_t) - bet*exp((1-sigmac)*zstar)/(1+bet*exp((1-sigmac)*zstar)) *(i_t(+1)  + z_t(+1))   - mu_t );
%%* flexible prices and wages **/
qk_ft  = (s2*exp(2*zstar)*(1+bet*exp((1-sigmac)*zstar))) * (i_ft  - 1/(1+bet*exp((1-sigmac)*zstar)) * (i_ft(-1)  - z_t) - bet*exp((1-sigmac)*zstar)/(1+bet*exp((1-sigmac)*zstar)) *(i_ft(+1)  + z_t(+1)) - mu_t );


%%****************************************************
%**      3. FINANCIAL FRICTION BLOCK
%*****************************************************/
%% return to capital, equation (20) in the paper
%%* sticky prices and wages **/
Rktil_t - pi_t = rkstar/(rkstar+1-del) * rk_t + (1-del)/(rkstar+1-del) * qk_t -  qk_t(-1);
%%* flexible prices and wages **/
% Not yet included as one would usually define the flex price allocation without financial frictions

%% spreads, equation (19) in the paper
%%* sticky prices and wages **/
Rktil_t(+1) - R_t = - (sigmac*(1+h*exp(-zstar)))/(1-h*exp(-zstar)) * b_t + zeta_spb * (qk_t + kbar_t - n_t) + sigw_t ; %+ mue_t
%%* flexible prices and wages **/
% Not yet included as one would usually define the flex price allocation without financial frictions

%% n evol, equation (21) in the paper
%%* sticky prices and wages **/
n_t = zeta_nRk * (Rktil_t - pi_t)  - zeta_nR * (R_t(-1) - pi_t) + zeta_nqk * (qk_t(-1) + kbar_t(-1)) + zeta_nn * n_t(-1) -zeta_nsigw/zeta_spsigw * sigw_t(-1) - gammstar*vstar/nstar * z_t; %- zeta_nmue/zeta_spmue * mue_t + gamm_t 
%%* flexible prices and wages **/
% Not yet included as one would usually define the flex price allocation without financial frictions

% Alternative version without financial frictions. The previous three equations are replaced with equation (6) in the paper, which simply means setting the financial friction shock sigw_t=0 and zeta_spb=0
%%* sticky prices and wages **/
%rkstar/(rkstar+1-del) * rk_t(+1) + (1-del)/(rkstar+1-del) * qk_t(+1) -  qk_t  =  R_t - pi_t(+1) - (sigmac*(1+h*exp(-zstar)))/(1-h*exp(-zstar)) * b_t;
%%* flexible prices and wages **/
% flex price allocation without financial frictions, so that the following equation is used
rkstar/(rkstar+1-del) * rk_ft(+1) + (1-del)/(rkstar+1-del) * qk_ft(+1) -  qk_ft  =  r_ft         - (sigmac*(1+h*exp(-zstar)))/(1-h*exp(-zstar)) * b_t;


%%***************************************************
%**      4. Aggregate Production Function
%****************************************************/
% equation (11) in the paper
%%* sticky prices and wages **/
% the last term drops out if technology has a stochastic trend, because in this case one has to assume that the fixed costs are proportional to the trend.
y_t  = Bigphi * (alp * k_t  + (1-alp) * L_t ) + ( Bigphi-1 ) / (1-alp) * ztil_t;     
%%* flexible prices and wages **/
y_ft = Bigphi * (alp * k_ft + (1-alp) * L_ft) + ( Bigphi-1 ) / (1-alp) * ztil_t;


%%**************************************************
%**      5. Capital Utilization
%***************************************************/
% equation (7) in the paper
%%* sticky prices and wages **/
k_t  = u_t  - z_t + kbar_t(-1);
%%* flexible prices and wages **/
k_ft = u_ft - z_t + kbar_ft(-1);


%%*************************************************
%**      6. Rental Rate of Capital
%**************************************************/
% equation (8) in the paper
%%* sticky prices and wages **/
u_t  = (1-ppsi)/ppsi * rk_t;
%% flexible prices and wages **/
u_ft = (1-ppsi)/ppsi * rk_ft;


%%*************************************************
%**      7. Evolution of Capital
%**************************************************/
% equation (5) in the paper
%% sticky prices and wages **/
kbar_t  =  (1-istar/kbarstar) * (kbar_t(-1) - z_t)  + istar/kbarstar * i_t      + istar*s2*exp(2*zstar)*(1+bet*exp((1-sigmac)*zstar))/kbarstar * mu_t;
%% flexible prices and wages **/
kbar_ft =  (1-istar/kbarstar) * (kbar_ft(-1) - z_t) + istar/kbarstar * i_ft     + istar*s2*exp(2*zstar)*(1+bet*exp((1-sigmac)*zstar))/kbarstar * mu_t;
	      

%%***********************************************
%**      8. Price Markup
%************************************************/
% equation (9) in the paper
%%* sticky prices and wages **/
mc_t  =  w_t  + alp * L_t  - alp * k_t;
%%* flexible prices and wages **/
0     =  w_ft + alp * L_ft - alp * k_ft;


%%***********************************************
%**      9. Phillips Curve
%************************************************/
% equation (13) in the paper
%%* sticky prices and wages **/
pi_t = ((1-zeta_p*bet*exp((1-sigmac)*zstar))*(1-zeta_p))/(zeta_p*((Bigphi-1)*epsp+1))*1/(1+iota_p*bet*exp((1-sigmac)*zstar)) * mc_t
      + iota_p*1/(1+iota_p*bet*exp((1-sigmac)*zstar)) * pi_t(-1)
      + bet*exp((1-sigmac)*zstar)*1/(1+iota_p*bet*exp((1-sigmac)*zstar)) * pi_t(+1)
      + laf_t;
%%* flexible prices and wages **/
%%* not necesary **/

%%**********************************************
%**     10. Rental Rate of Capital
%***********************************************/
% equation (10) in the paper
%%* sticky prices and wages **/
k_t  = w_t  - rk_t  + L_t;
%%* flexible prices and wages **/
k_ft = w_ft - rk_ft + L_ft;


%%*********************************************
%**     11. Marginal Substitution
%***********************************************/
% equation (15) in the paper
%%* sticky prices and wages **/
muw_t - w_t = -1/( 1-h*exp(-zstar) ) * c_t   + h*exp(-zstar)/( 1-h*exp(-zstar) ) * c_t(-1)  - h*exp(-zstar) /( 1-h*exp(-zstar) ) * z_t  -nu_l*L_t;
%%* flexible prices and wages **/
0           = -1/( 1-h*exp(-zstar) ) * c_ft  + h*exp(-zstar)/( 1-h*exp(-zstar) ) * c_ft(-1) - h*exp(-zstar) /( 1-h*exp(-zstar) ) * z_t  -nu_l*L_ft  + w_ft;


%%********************************************
%**     12. Evolution of Wages 
%**********************************************/
%%* sticky prices and wages **/
% equation (14) in the paper 
w_t = - (1-zeta_w*bet*exp((1-sigmac)*zstar))*(1-zeta_w)/(zeta_w*((law-1)*epsw+1))*1/(1+bet*exp((1-sigmac)*zstar)) * muw_t
      - (1+iota_w*bet*exp((1-sigmac)*zstar))*1/(1+bet*exp((1-sigmac)*zstar)) * pi_t
      + 1/(1+bet*exp((1-sigmac)*zstar)) *(w_t(-1) - z_t - iota_w * pi_t(-1))
      + bet*exp((1-sigmac)*zstar)*1/(1+bet*exp((1-sigmac)*zstar)) * (w_t(+1) + z_t(+1) + pi_t(+1))
      + law_t;
%%* flexible prices and wages **/
%%* not necessary **/ 

               
%%*********************************************
%**    13. Monetary Policy Rule
%***********************************************/
%%* sticky prices and wages **/
% equation (17) in the paper
R_t = rho_r * R_t(-1) + (1-rho_r) * (psi1 * (pi_t ) + psi2 * (y_t - y_ft)) + psi3 * ((y_t - y_ft) - (y_t(-1) - y_ft(-1))) + rm_t; %+ (1-rho_rm) * (psi1 * (pi_t - pist_t) +
%%* flexible prices and wages **/
%%* not necessary **/


%%********************************************
%**   14. Resource Constraint
%***********************************************/
% equation (12) in the paper
%%* sticky prices and wages **/
% the last term drops out if technology has a stochastic trend
y_t  = gstar*g_t + cstar/ystar * c_t  + istar/ystar * i_t  + rkstar*kstar/ystar * u_t  + gstar*( 1/(1-alp) ) * ztil_t;
%%* flexible prices and wages **/
y_ft = gstar*g_t + cstar/ystar * c_ft + istar/ystar * i_ft + rkstar*kstar/ystar * u_ft + gstar*( 1/(1-alp) ) * ztil_t;


%%*********************************************
%**   Exogenous Processes
%***********************************************/
%%* neutral technology **/
z_t = ( 1/(1-alp) )*(rho_z-1) * ztil_t(-1) + ( 1/(1-alp) ) * z_sh;
ztil_t = rho_z * ztil_t(-1) + z_sh;

%%* government spending **/
g_t = rho_g * g_t(-1) + g_sh + eta_gz * z_sh; 
 
%%* asset shock **/
b_t = rho_b * b_t(-1) + b_sh;   

%%* investment specific technology **/
mu_t = rho_mu * mu_t(-1) + mu_sh;  

%/** price mark-up shock **/
laf_t = rho_laf * laf_t(-1) + laf_sh - eta_laf * laf_sh(-1);   

%/** wage mark-up shock **/
law_t = rho_law * law_t(-1) + law_sh - eta_law * law_sh(-1);   

 %/** monetary policy shock **/  
rm_t = rho_rm * rm_t(-1) + rm_sh;

%FINANCIAL FRICTIONS:
%% sigw shock
sigw_t = rho_sigw * sigw_t(-1) + sigw_sh;     

            
%%*********************************************
%**   additional variables of interest
%***********************************************/
outputgap_t     = y_t - y_ft;         
r_ft_obs/4      = r_ft + Rstarn - 100*(pistar-1);                   
r_ann_t/4       = R_t - pi_t(+1) + Rstarn - 100*(pistar-1); 

%%*********************************************
%**   measurement equations
%***********************************************/
%%% measurement equations %%%  
xgdp_q_obs       =  ( y_t - y_t(-1) + z_t)  +  100*(exp(zstar)-1);    
pcer_q_obs       =  ( c_t - c_t(-1) + z_t)  +  100*(exp(zstar)-1);   
fpi_q_obs        =  ( i_t - i_t(-1) + z_t)  +  100*(exp(zstar)-1);    
wage_obs         =  (w_t - w_t(-1) + z_t)   +  100*(exp(zstar)-1);   
rff_q_obs        =  R_t  + Rstarn;                                    
pgdp_q_obs       =  pi_t + 100 * (pistar-1);                    
cp_q_obs         =  ( Rktil_t(+1) - R_t ) +  100*log(sprd);        
hours_obs        =  L_t +  Lmean;     
				
end;


%write_latex_dynamic_model;          % write model into Tex file

%resid;
steady;
check;

%% initialize shocks
%% ========================================================================

shocks;

var z_sh           = 0.10;
var g_sh           = 0.10;
var b_sh           = 0.10;
var mu_sh          = 0.10; 
var laf_sh         = 0.10;
var law_sh         = 0.10;
var sigw_sh        = 0.00;
var rm_sh          = 0.10;

end;

%stoch_simul(irf = 50,nograph);

estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
% monetary policy parameters
psi1,1.7985,1.0,3,NORMAL_PDF,1.5,0.25;% monetary policy reaction to inflation   %
rho_r,0.8258,0.5,0.975,BETA_PDF,0.75,0.10;% interest rate smoothing parameter 
psi2,0.0893,0.001,0.5,NORMAL_PDF,0.125,0.05;% monetary policy reaction to the output gap
psi3,0.2239,0.001,0.5,NORMAL_PDF,0.125,0.05;% monetary policy reaction to the change in the output gap

% nominal rigidities
zeta_p,0.7813,0.5,0.95,BETA_PDF,0.5,0.10;  % price Calvo prametert
zeta_w,0.7937,0.3,0.95,BETA_PDF,0.5,0.1; % wage Calvo prametert
iota_w,0.4425,0.01,0.99,BETA_PDF,0.5,0.15;% price indexation  %originally fixed 0.5
iota_p,0.3291,0.01,0.99,BETA_PDF,0.5,0.15;% price indexation  %originally fixed 0.5

% financial frictions parameters
zeta_spb            ,0.081  ,1E-5  ,.99999  ,    beta_pdf,   0.05, 0.005;  % elasticity of the spread with respect to leverage
sprd_aux            ,2.0    ,0     ,100     ,    gamma_pdf,  2.00, 0.10;    % steady state spread  

% other endogenous propagagion and steady state parameters
alp,0.24,0.01,1.0,NORMAL_PDF,0.3,0.05; % capital elasticity (Cobb-Douglas production function)
Bigphi,1.4672,1.0,3,NORMAL_PDF,1.25,0.12; % fixed cost of production
h,0.7205,0.001,0.99,BETA_PDF,0.7,0.1;% habit persistence
nu_l,2.8401,0.25,10,NORMAL_PDF,2,0.75;% inverse of the elasticity of labor with respect to the real wage  
rstar_aux,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;% steady state real interest rate
pistar_aux,0.7,0.1,2.0,GAMMA_PDF, 0.75, 0.40; % quarterly steady state inflation rate    
zstar_aux,0.3982,0.1,0.8,NORMAL_PDF,0.4,0.10; % quarterly steady state growth rate of labor augmenting technology growth
s2,6.3325,2,15,NORMAL_PDF,4,1.5;% second derivative investment adjustment cost
sigmac,1.2312,0.25,3,NORMAL_PDF,1.50,0.37 ;% relative risk aversion
ppsi,0.2648,0.01,1,BETA_PDF,0.5,0.15;% capital utilization cost
Lmean,1.2918,-10.0,10.0,NORMAL_PDF,0.0,2.0; % captures the units of measured hours worked. 

%% exogenous processes - autocorrelation
rho_z,.9676 ,.01,.9999,BETA_PDF,0.5,0.20;% persistence of technology shock process
rho_b,.2703,.01,.9999,BETA_PDF,0.5,0.20; % persistence of asset shock
rho_g,.9930,.01,.9999,BETA_PDF,0.5,0.20; % persistence of government spending shock process
rho_mu,.5724,.01,.9999,BETA_PDF,0.5,0.20;
rho_rm,.3,.01,.9999,BETA_PDF,0.5,0.20; % persistence of monetary policy shock process
rho_laf,.8692,.01,.9999,BETA_PDF,0.5,0.20;% persistence of price mark-up shock process
rho_law,.9546,.001,.9999,BETA_PDF,0.5,0.20;% persistence of marginal efficiency of investment (MEI) shock process
eta_laf,.7652,0.01,.9999,BETA_PDF,0.5,0.2;% ARMA parameter of price mark-up shock process
eta_law,.8936,0.01,.9999,BETA_PDF,0.5,0.2;% ARMA parameter of wage mark-up shock process
eta_gz,0.05,0.01,2.0,NORMAL_PDF,0.5,0.2;% elasticity of government spending to technology shock
rho_sigw            ,0.96  ,1E-5   ,.99999  ,    beta_pdf,   0.75, 0.15;  % persistence of the spread shock process

%% exogenous processes - standard deviation
stderr z_sh,0.4618,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr g_sh,3,0.01,15,INV_GAMMA_PDF,0.5,2;
stderr b_sh,0.1818513,0.025,5,INV_GAMMA_PDF,0.1,2;
stderr mu_sh,0.46017,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr laf_sh,0.1455,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr law_sh,0.2089,0.01,3,INV_GAMMA_PDF,0.1,2;
stderr sigw_sh      ,0.05  ,1E-7   ,100     ,    inv_gamma_pdf,0.05,4.00; %
stderr rm_sh,0.2397,0.01,3,INV_GAMMA_PDF,0.1,2;



end;

varobs xgdp_q_obs hours_obs wage_obs pgdp_q_obs rff_q_obs pcer_q_obs fpi_q_obs cp_q_obs;

%varobs delta_y_t_obs delta_c_t_obs delta_i_t_obs wage_t_obs hours_t_obs infl_t_obs int_t_obs cp_q_obs;

% start in 1959
%estimation(datafile=DataDSGE,xls_sheet=Data,xls_range=R2:Z229,mode_compute=4,first_obs=2,nobs=226,mh_replic=25000,mh_nblocks=1,mh_jscale=0.3,mh_drop=0.1,smoother);