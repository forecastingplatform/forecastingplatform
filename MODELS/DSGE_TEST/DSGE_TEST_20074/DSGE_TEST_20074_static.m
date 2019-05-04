function [residual, g1, g2, g3] = DSGE_TEST_20074_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 34, 1);

%
% Model equations
%

gammag__ = 1+params(18)/100;
betav__ = 1/(1+params(23)/100);
R__ = gammag__/betav__;
Rn__ = gammag__*(1+params(19)/100)/betav__;
rn_bar__ = 100*(Rn__-1);
s__ = 1+params(20)/100;
R_K__ = s__*R__;
YK__ = params(1)/params(5)*(R_K__-(1-params(7)));
WY__ = (1-params(5))*params(4)/(params(1)*params(2));
TEF_1 = call_csolve1(params(21),s__,params(22));
sigmav__ = TEF_1;
TEF_2 = norminv(params(21),0,1);
z_bar__ = TEF_2;
omega_bar__ = exp(sigmav__*z_bar__-0.5*sigmav__^2);
G_bar__ = normcdf(z_bar__-sigmav__,0,1);
fp_bar__ = normpdf(z_bar__,0,1);
Gamma_bar__ = omega_bar__*(1-params(21))+G_bar__;
muv__ = (1-1/s__)/(G_bar__+(1-Gamma_bar__)*fp_bar__/sigmav__/(1-params(21)));
KN__ = 1/(1-s__*(omega_bar__*(1-params(21))+G_bar__*(1-muv__)));
para_b_omg__ = omega_bar__*muv__/KN__*((-(fp_bar__^2))+(1-params(21))*z_bar__*fp_bar__)/(s__*sigmav__^2*omega_bar__*(1-params(21)-fp_bar__*muv__/sigmav__)^2*(1-Gamma_bar__+(1-params(21))*(Gamma_bar__-G_bar__*muv__)/(1-params(21)-fp_bar__*muv__/sigmav__)));
para_z_omg__ = omega_bar__*(1-params(21)-fp_bar__*muv__/sigmav__)/(Gamma_bar__-G_bar__*muv__);
PARA1__ = (1-z_bar__*muv__/sigmav__)/(1-fp_bar__*muv__/(sigmav__*(1-params(21))))-1;
PARA2__ = fp_bar__^2*(z_bar__/sigmav__-1)/sigmav__+(1-params(21))*fp_bar__/sigmav__^2*(1-z_bar__*(z_bar__-sigmav__));
para_b_sig__ = sigmav__*(s__*PARA1__*fp_bar__*(-omega_bar__)+muv__/KN__*PARA2__/(1-params(21)-fp_bar__*muv__/sigmav__)^2)/(s__*(1-Gamma_bar__)+(1-params(21))*(1-1/KN__)/(1-params(21)-fp_bar__*muv__/sigmav__));
para_z_sig__ = sigmav__*(fp_bar__*(-omega_bar__)+fp_bar__*omega_bar__*z_bar__*muv__/sigmav__)/(Gamma_bar__-G_bar__*muv__);
para_g_omg__ = omega_bar__*fp_bar__/sigmav__/G_bar__;
para_sp_sig__ = (para_b_omg__/para_z_omg__*para_z_sig__-para_b_sig__)/(1-para_b_omg__/para_z_omg__);
para_n_rk__ = KN__*R_K__*params(6)/gammag__*(1-G_bar__*muv__*(1-para_g_omg__/para_z_omg__));
para_n_r__ = KN__*params(6)/betav__*(1-1/KN__+para_g_omg__*s__*G_bar__*muv__/para_z_omg__);
para_n_qk__ = KN__*R_K__*params(6)/gammag__*(1-G_bar__*muv__*(1-para_g_omg__/(para_z_omg__*(KN__-1))))-KN__*params(6)/betav__;
para_n_sig__ = para_g_omg__*G_bar__*muv__*KN__*R_K__*params(6)/gammag__*(1-para_z_sig__/para_z_omg__);
NY__ = (params(6)/YK__*(R_K__*(1-G_bar__*muv__)-R__)+(1-params(5))*(1-params(4))/params(1))/(gammag__-R__*params(6));
DY__ = 1/YK__-NY__;
CY__ = params(2)*WY__-params(3)+(params(1)-1)/params(1)+(R__-1)*DY__;
IY__ = 1/YK__*(params(7)+gammag__-1);
C_EY__ = 1-CY__-IY__-params(3);
YN__ = 1/NY__;
kappav__ = (1-params(9))/params(9)*(1-betav__*params(9));
epsilonv__ = (1-params(7))/(1-params(7)+params(5)*YK__/params(1));
T297 = 1/((1+betav__)*params(8)*gammag__^2);
T315 = params(10)^(-1);
T335 = 1-(1-params(7))/gammag__;
T353 = (1-params(5))*(1-params(4))*YN__/params(1)*1/gammag__;
lhs =y(10);
rhs =CY__*y(1)+C_EY__*y(14)+IY__*y(12)+params(3)*y(15);
residual(1)= lhs-rhs;
lhs =y(1);
rhs =y(1)-y(4);
residual(2)= lhs-rhs;
lhs =y(14);
rhs =y(8);
residual(3)= lhs-rhs;
lhs =y(9)-y(4);
rhs =(-params(22))*(y(8)-(y(6)+y(7)))+para_sp_sig__*y(18);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =(1-epsilonv__)*(y(10)-y(11)-y(7))+y(6)*epsilonv__-y(6);
residual(5)= lhs-rhs;
lhs =y(12);
rhs =y(12)*1/(1+betav__)+y(12)*betav__/(1+betav__)+T297*(y(6)+y(17));
residual(6)= lhs-rhs;
lhs =y(10);
rhs =(1-params(5))*y(13)+params(5)*y(7)+(1-params(5))*params(4)*y(2);
residual(7)= lhs-rhs;
lhs =y(10)-y(2)-y(11)-y(1);
rhs =y(2)*T315;
residual(8)= lhs-rhs;
lhs =y(3);
rhs =y(11)*(-(1/(1+betav__*params(24))*kappav__))+y(3)*params(24)/(1+betav__*params(24))+y(3)*betav__/(1+betav__*params(24));
residual(9)= lhs-rhs;
lhs =y(7);
rhs =T335*(y(12)+y(17))+y(7)*(1-params(7))/gammag__;
residual(10)= lhs-rhs;
lhs =y(8);
rhs =y(9)*para_n_rk__-y(4)*para_n_r__+(y(6)+y(7))*para_n_qk__+(y(10)-y(11))*T353-y(18)*para_n_sig__;
residual(11)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(13)+y(3)*(1-params(13))*params(11)+(1-params(13))*params(12)*(y(10)-y(19))+x(3);
residual(12)= lhs-rhs;
lhs =y(5);
rhs =y(4)+y(3);
residual(13)= lhs-rhs;
lhs =y(16);
rhs =y(9)-y(4);
residual(14)= lhs-rhs;
lhs =y(13);
rhs =y(13)*params(14)+x(1);
residual(15)= lhs-rhs;
lhs =y(15);
rhs =y(15)*params(15)+x(2);
residual(16)= lhs-rhs;
lhs =y(17);
rhs =y(17)*params(16)+x(4);
residual(17)= lhs-rhs;
lhs =y(18);
rhs =y(18)*params(17)+x(5);
residual(18)= lhs-rhs;
lhs =y(19);
rhs =params(3)*y(15)+CY__*y(25)+C_EY__*y(28)+IY__*y(21);
residual(19)= lhs-rhs;
lhs =y(25);
rhs =y(25)-y(22);
residual(20)= lhs-rhs;
lhs =y(28);
rhs =y(24);
residual(21)= lhs-rhs;
residual(22) = y(23)-y(22);
lhs =y(23);
rhs =(1-epsilonv__)*(y(19)-y(20))+epsilonv__*y(26)-y(26);
residual(23)= lhs-rhs;
lhs =y(21);
rhs =1/(1+betav__)*y(21)+betav__/(1+betav__)*y(21)+T297*(y(17)+y(26));
residual(24)= lhs-rhs;
lhs =y(19);
rhs =(1-params(5))*y(13)+params(5)*y(20)+(1-params(5))*params(4)*y(27);
residual(25)= lhs-rhs;
lhs =y(19)-y(27)-y(25);
rhs =T315*y(27);
residual(26)= lhs-rhs;
lhs =y(20);
rhs =T335*(y(17)+y(21))+(1-params(7))/gammag__*y(20);
residual(27)= lhs-rhs;
lhs =y(24);
rhs =para_n_rk__*y(23)-para_n_r__*y(22)+para_n_qk__*(y(20)+y(26))+T353*y(19)-y(18)*para_n_sig__;
residual(28)= lhs-rhs;
lhs =y(34);
rhs =y(10)-y(19);
residual(29)= lhs-rhs;
lhs =y(29);
rhs =params(18);
residual(30)= lhs-rhs;
lhs =y(32);
rhs =params(18);
residual(31)= lhs-rhs;
lhs =y(30);
rhs =params(19)+y(3);
residual(32)= lhs-rhs;
lhs =y(31);
rhs =y(5)+rn_bar__;
residual(33)= lhs-rhs;
lhs =y(33);
rhs =params(20)+y(16);
residual(34)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(34, 34);

  %
  % Jacobian matrix
  %

T496 = 1-(1/(1+betav__)+betav__/(1+betav__));
  g1(1,1)=(-CY__);
  g1(1,10)=1;
  g1(1,12)=(-IY__);
  g1(1,14)=(-C_EY__);
  g1(1,15)=(-params(3));
  g1(2,4)=1;
  g1(3,8)=(-1);
  g1(3,14)=1;
  g1(4,4)=(-1);
  g1(4,6)=(-params(22));
  g1(4,7)=(-params(22));
  g1(4,8)=params(22);
  g1(4,9)=1;
  g1(4,18)=(-para_sp_sig__);
  g1(5,6)=(-(epsilonv__-1));
  g1(5,7)=1-epsilonv__;
  g1(5,9)=1;
  g1(5,10)=(-(1-epsilonv__));
  g1(5,11)=1-epsilonv__;
  g1(6,6)=(-T297);
  g1(6,12)=T496;
  g1(6,17)=(-T297);
  g1(7,2)=(-((1-params(5))*params(4)));
  g1(7,7)=(-params(5));
  g1(7,10)=1;
  g1(7,13)=(-(1-params(5)));
  g1(8,1)=(-1);
  g1(8,2)=(-1)-T315;
  g1(8,10)=1;
  g1(8,11)=(-1);
  g1(9,3)=1-(params(24)/(1+betav__*params(24))+betav__/(1+betav__*params(24)));
  g1(9,11)=1/(1+betav__*params(24))*kappav__;
  g1(10,7)=T335;
  g1(10,12)=(-T335);
  g1(10,17)=(-T335);
  g1(11,4)=para_n_r__;
  g1(11,6)=(-para_n_qk__);
  g1(11,7)=(-para_n_qk__);
  g1(11,8)=1;
  g1(11,9)=(-para_n_rk__);
  g1(11,10)=(-T353);
  g1(11,11)=T353;
  g1(11,18)=para_n_sig__;
  g1(12,3)=(-((1-params(13))*params(11)));
  g1(12,5)=1-params(13);
  g1(12,10)=(-((1-params(13))*params(12)));
  g1(12,19)=(1-params(13))*params(12);
  g1(13,3)=(-1);
  g1(13,4)=(-1);
  g1(13,5)=1;
  g1(14,4)=1;
  g1(14,9)=(-1);
  g1(14,16)=1;
  g1(15,13)=1-params(14);
  g1(16,15)=1-params(15);
  g1(17,17)=1-params(16);
  g1(18,18)=1-params(17);
  g1(19,15)=(-params(3));
  g1(19,19)=1;
  g1(19,21)=(-IY__);
  g1(19,25)=(-CY__);
  g1(19,28)=(-C_EY__);
  g1(20,22)=1;
  g1(21,24)=(-1);
  g1(21,28)=1;
  g1(22,22)=(-1);
  g1(22,23)=1;
  g1(23,19)=(-(1-epsilonv__));
  g1(23,20)=1-epsilonv__;
  g1(23,23)=1;
  g1(23,26)=(-(epsilonv__-1));
  g1(24,17)=(-T297);
  g1(24,21)=T496;
  g1(24,26)=(-T297);
  g1(25,13)=(-(1-params(5)));
  g1(25,19)=1;
  g1(25,20)=(-params(5));
  g1(25,27)=(-((1-params(5))*params(4)));
  g1(26,19)=1;
  g1(26,25)=(-1);
  g1(26,27)=(-1)-T315;
  g1(27,17)=(-T335);
  g1(27,20)=T335;
  g1(27,21)=(-T335);
  g1(28,18)=para_n_sig__;
  g1(28,19)=(-T353);
  g1(28,20)=(-para_n_qk__);
  g1(28,22)=para_n_r__;
  g1(28,23)=(-para_n_rk__);
  g1(28,24)=1;
  g1(28,26)=(-para_n_qk__);
  g1(29,10)=(-1);
  g1(29,19)=1;
  g1(29,34)=1;
  g1(30,29)=1;
  g1(31,32)=1;
  g1(32,3)=(-1);
  g1(32,30)=1;
  g1(33,5)=(-1);
  g1(33,31)=1;
  g1(34,16)=(-1);
  g1(34,33)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],34,1156);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],34,39304);
end
end
end
end
