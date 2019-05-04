% computes the steady state and additional parameters

function [ys,check] = US_NK_FA_steadystate(ys,exe)
global M_

%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end                                                           % End of the loop.  
check = 0;
%%
%% END OF THE FIRST MODEL INDEPENDENT BLOCK.


%% THIS BLOCK IS MODEL SPECIFIC.
%%
%% Here the user has to define the steady state.
%%
ups = 1;

% Transformations
bet  = 1/(1+rstar_aux/100);
pistar = (pistar_aux/100)+1;

% Financial Frictions Parameters
Fom = 1-(1-Fom_aux)^(1/4);  %% F(omega) from annualized to quarterly default prob
sprd = (1+sprd_aux/100)^(1/4); sprd = exp(sprd_aux/400);    %% st st spread from annual perc to quarterly number

% exogenous processes - level
gam = zstar_aux/100;

% Parameters (implicit) -- from steady state
zstar      = log(gam+1)+(alp/(1-alp))*log(ups); 
rstar      = (1/bet)*exp(sigmac*zstar);
Rstarn     = 100*(rstar*pistar-1);
rkstar     = sprd*rstar*ups - (1-del); % %notice that this depends on the spread (for the version without financial frictions, set sprd_aux=0)
omegastar  = (alp^(alp)*(1-alp)^(1-alp)*rkstar^(-alp)/Bigphi)^(1/(1-alp));
Lstar      = 1;
kstar      = (alp/(1-alp))*omegastar*Lstar/rkstar;
kbarstar   = kstar*(gam+1)*ups^(1/(1-alp));
istar      = kbarstar*( 1-((1-del)/((gam+1)*ups^(1/(1-alp)))) );
ystar      = (kstar^alp)*(Lstar^(1-alp))/Bigphi;
if ystar <= 0
    disp([alp,  bet, kstar,Lstar])
    dm([ystar,Lstar,kstar,Bigphi])
    error('ystar negative');
end
cstar      = (1-gstar)*ystar - istar;
wl_c       = (omegastar*Lstar/cstar)/law;

%FINANCIAL FRICTIONS ADDITIONS
% solve for sigmaomegastar and zomegastar
zwstar = norminv(Fom);
sigwstar = fzero(@(sigma)zetaspbfcn(zwstar,sigma,sprd)-zeta_spb,0.5);

% evaluate omegabarstar
omegabarstar = omegafcn(zwstar,sigwstar);

%% Calculate reamining parameters

% evaluate all BGG function elasticities
Gstar = Gfcn(zwstar,sigwstar);
Gammastar = Gammafcn(zwstar,sigwstar);
dGdomegastar = dGdomegafcn(zwstar,sigwstar);
d2Gdomega2star = d2Gdomega2fcn(zwstar,sigwstar);
dGammadomegastar = dGammadomegafcn(zwstar);
d2Gammadomega2star = d2Gammadomega2fcn(zwstar,sigwstar);
dGdsigmastar = dGdsigmafcn(zwstar,sigwstar);
d2Gdomegadsigmastar = d2Gdomegadsigmafcn(zwstar,sigwstar);
dGammadsigmastar = dGammadsigmafcn(zwstar,sigwstar);
d2Gammadomegadsigmastar = d2Gammadomegadsigmafcn(zwstar,sigwstar);

% evaluate mu, nk, and Rhostar
muestar = mufcn(zwstar,sigwstar,sprd);
nkstar = nkfcn(zwstar,sigwstar,sprd);
Rhostar = 1/nkstar-1;

% evaluate wekstar and vkstar
wekstar = (1-gammstar/bet)*nkstar...
    -gammstar/bet*(sprd*(1-muestar*Gstar)-1);
vkstar = (nkstar-wekstar)/gammstar;

% evaluate nstar and vstar
nstar = nkstar*kstar;
vstar = vkstar*kstar;

% a couple of combinations
GammamuG = Gammastar-muestar*Gstar;
GammamuGprime = dGammadomegastar-muestar*dGdomegastar;

% elasticities wrt omegabar
zeta_bw = zetabomegafcn(zwstar,sigwstar,sprd);
zeta_zw = zetazomegafcn(zwstar,sigwstar,sprd);
zeta_bw_zw = zeta_bw/zeta_zw;

% elasticities wrt sigw
zeta_bsigw = sigwstar*(((1-muestar*dGdsigmastar/dGammadsigmastar)/...
    (1-muestar*dGdomegastar/dGammadomegastar)-1)*dGammadsigmastar*sprd+...
    muestar*nkstar*(dGdomegastar*d2Gammadomegadsigmastar-dGammadomegastar*d2Gdomegadsigmastar)/...
    GammamuGprime^2)/...
    ((1-Gammastar)*sprd+dGammadomegastar/GammamuGprime*(1-nkstar));
zeta_zsigw = sigwstar*(dGammadsigmastar-muestar*dGdsigmastar)/GammamuG;
zeta_spsigw = (zeta_bw_zw*zeta_zsigw-zeta_bsigw)/(1-zeta_bw_zw);

% elasticities wrt mue
zeta_bmue = muestar*(nkstar*dGammadomegastar*dGdomegastar/GammamuGprime+dGammadomegastar*Gstar*sprd)/...
    ((1-Gammastar)*GammamuGprime*sprd+dGammadomegastar*(1-nkstar));
zeta_zmue = -muestar*Gstar/GammamuG;
zeta_spmue = (zeta_bw_zw*zeta_zmue-zeta_bmue)/(1-zeta_bw_zw);

    
% some ratios/elasticities
Rkstar = sprd*pistar*rstar; % (rkstar+1-delta)/ups*pistar;
zeta_Gw = dGdomegastar/Gstar*omegabarstar;
zeta_Gsigw = dGdsigmastar/Gstar*sigwstar;

% elasticities for the net worth evolution
zeta_nRk = gammstar*Rkstar/pistar/exp(zstar)*(1+Rhostar)*(1-muestar*Gstar*(1-zeta_Gw/zeta_zw));
zeta_nR = gammstar/bet*(1+Rhostar)*(1-nkstar+muestar*Gstar*sprd*zeta_Gw/zeta_zw);
zeta_nqk = gammstar*Rkstar/pistar/exp(zstar)*(1+Rhostar)*(1-muestar*Gstar*(1+zeta_Gw/zeta_zw/Rhostar))...
    -gammstar/bet*(1+Rhostar);
zeta_nn = gammstar/bet+gammstar*Rkstar/pistar/exp(zstar)*(1+Rhostar)*muestar*Gstar*zeta_Gw/zeta_zw/Rhostar;
zeta_nmue = gammstar*Rkstar/pistar/exp(zstar)*(1+Rhostar)*muestar*Gstar*(1-zeta_Gw*zeta_zmue/zeta_zw);
zeta_nsigw = gammstar*Rkstar/pistar/exp(zstar)*(1+Rhostar)*muestar*Gstar*(zeta_Gsigw-zeta_Gw/zeta_zw*zeta_zsigw);

%%
% the model is written in deviations from steady state. So, the steady
% state is zero for all variables (we use this file only to compute the
% elasticities for the financial frictions). Otherwise one could define
% steady states here.

y_t = 0;
c_t = 0;
i_t = 0;
k_t = 0;
kbar_t = 0;
L_t = 0;
mc_t = 0;
pi_t = 0;
R_t = 0;
rk_t = 0;
u_t = 0;
w_t = 0;
muw_t = 0;
qk_t = 0;
Rktil_t = 0;
n_t = 0;

%%% shock processes %%%
z_t = 0;
ztil_t = 0;
b_t = 0;
g_t = 0;
laf_t = 0;
law_t = 0;
sigw_t = 0;
mu_t = 0;
mue_t = 0;
gamm_t = 0;
rm_t = 0;
pist_t = 0;
rm_sh_antall = 0;

%%% flexprice economy %%%
y_ft = 0;
c_ft = 0;
i_ft = 0;
k_ft = 0;
kbar_ft = 0;
L_ft = 0;
r_ft = 0;
rk_ft = 0;
u_ft = 0;
w_ft = 0;
qk_ft = 0;
outputgap_t = 0;
r_ft_obs      = 4* (Rstarn - 100*(pistar-1));                   
r_ann_t       = 4* (Rstarn - 100*(pistar-1)); 

%%% observables %%%
xgdp_q_obs    = 100*(exp(zstar)-1);           
hours_obs      = Lmean;                         
laborshare_t_obs = 100*log((1-alp)/(1+laf));  
wage_obs         = 100*(exp(zstar)-1);   
pgdp_q_obs       = 100 * (pistar-1);
rff_q_obs        = 1 * Rstarn;     
pcer_q_obs       = 100*(exp(zstar)-1);           
fpi_q_obs        = 100*(exp(zstar)-1);           
cp_q_obs         = 100*log(sprd);

%%
%% END OF THE MODEL SPECIFIC BLOCK.

%% DO NOT CHANGE THIS PART.
%%
%% Update parameters set in the file
for iter = 1:length(M_.params) %update parameters set in the file
 eval([ 'M_.params(' num2str(iter) ') = ' M_.param_names(iter,:) ';' ])
end

%% Here we define the steady state values of the endogenous variables of
%% the model.
%%
NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).

% We don't need this as all steady state values are zero.
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:));                      %    Get the name of endogenous variable i.                     
  if ~exist(varname)
      eval(['ys(' int2str(i) ') = 0;']);                      % to deal with auxiliary variables that are defined by dynare
  else
      eval(['ys(' int2str(i) ') = ' varname ';']);                %    Get the steady state value of this variable.
  end
end                                                           % End of the loop.
%%
%% END OF THE SECOND MODEL INDEPENDENT BLOCK.
end

function f=zetaspbfcn(z,sigma,sprd)
zetaratio = zetabomegafcn(z,sigma,sprd)/zetazomegafcn(z,sigma,sprd);
nk = nkfcn(z,sigma,sprd);
f = -zetaratio/(1-zetaratio)*nk/(1-nk);
end

function f=zetabomegafcn(z,sigma,sprd)
nk = nkfcn(z,sigma,sprd);
mustar = mufcn(z,sigma,sprd);
omegastar = omegafcn(z,sigma);
Gammastar = Gammafcn(z,sigma);
Gstar = Gfcn(z,sigma);
dGammadomegastar = dGammadomegafcn(z);
dGdomegastar = dGdomegafcn(z,sigma);
d2Gammadomega2star = d2Gammadomega2fcn(z,sigma);
d2Gdomega2star = d2Gdomega2fcn(z,sigma);
f = omegastar*mustar*nk*(d2Gammadomega2star*dGdomegastar-d2Gdomega2star*dGammadomegastar)/...
    (dGammadomegastar-mustar*dGdomegastar)^2/sprd/...
    (1-Gammastar+dGammadomegastar*(Gammastar-mustar*Gstar)/(dGammadomegastar-mustar*dGdomegastar));
end

function f=zetazomegafcn(z,sigma,sprd)
mustar = mufcn(z,sigma,sprd);
f = omegafcn(z,sigma)*(dGammadomegafcn(z)-mustar*dGdomegafcn(z,sigma))/...
    (Gammafcn(z,sigma)-mustar*Gfcn(z,sigma));
end

function f=nkfcn(z,sigma,sprd)
f = 1-(Gammafcn(z,sigma)-mufcn(z,sigma,sprd)*Gfcn(z,sigma))*sprd;
end

function f=mufcn(z,sigma,sprd)
f = (1-1/sprd)/(dGdomegafcn(z,sigma)/dGammadomegafcn(z)*(1-Gammafcn(z,sigma))+Gfcn(z,sigma));
end

function f=omegafcn(z,sigma)
f = exp(sigma*z-1/2*sigma^2);
end

function f=Gfcn(z,sigma)
f = normcdf(z-sigma);
end

function f=Gammafcn(z,sigma)
f = omegafcn(z,sigma)*(1-normcdf(z))+normcdf(z-sigma);
end

function f=dGdomegafcn(z,sigma)
f=normpdf(z)/sigma;
end

function f=d2Gdomega2fcn(z,sigma)
f = -z*normpdf(z)/omegafcn(z,sigma)/sigma^2;
end

function f=dGammadomegafcn(z)
f = 1-normcdf(z);
end

function f=d2Gammadomega2fcn(z,sigma)
f = -normpdf(z)/omegafcn(z,sigma)/sigma;
end

function f=dGdsigmafcn(z,sigma)
f = -z*normpdf(z-sigma)/sigma;
end

function f=d2Gdomegadsigmafcn(z,sigma)
f = -normpdf(z)*(1-z*(z-sigma))/sigma^2;
end

function f=dGammadsigmafcn(z,sigma)
f = -normpdf(z-sigma);
end

function f=d2Gammadomegadsigmafcn(z,sigma)
f = (z/sigma-1)*normpdf(z);
end