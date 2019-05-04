function [residual, g1, g2, g3] = DSGE_TEST_20074_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(34, 1);
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
T303 = 1/((1+betav__)*params(8)*gammag__^2);
T321 = params(10)^(-1);
T342 = (1-params(7))/gammag__;
T363 = (1-params(5))*(1-params(4))*YN__/params(1)*1/gammag__;
lhs =y(25);
rhs =CY__*y(16)+C_EY__*y(29)+IY__*y(27)+params(3)*y(30);
residual(1)= lhs-rhs;
lhs =y(16);
rhs =y(50)-y(19);
residual(2)= lhs-rhs;
lhs =y(29);
rhs =y(23);
residual(3)= lhs-rhs;
lhs =y(52)-y(19);
rhs =(-params(22))*(y(23)-(y(21)+y(22)))+para_sp_sig__*y(33);
residual(4)= lhs-rhs;
lhs =y(24);
rhs =(1-epsilonv__)*(y(25)-y(26)-y(5))+y(21)*epsilonv__-y(4);
residual(5)= lhs-rhs;
lhs =y(27);
rhs =1/(1+betav__)*y(7)+betav__/(1+betav__)*y(53)+T303*(y(21)+y(32));
residual(6)= lhs-rhs;
lhs =y(25);
rhs =(1-params(5))*y(28)+params(5)*y(5)+(1-params(5))*params(4)*y(17);
residual(7)= lhs-rhs;
lhs =y(25)-y(17)-y(26)-y(16);
rhs =y(17)*T321;
residual(8)= lhs-rhs;
lhs =y(18);
rhs =y(26)*(-(1/(1+betav__*params(24))*kappav__))+params(24)/(1+betav__*params(24))*y(1)+betav__/(1+betav__*params(24))*y(51);
residual(9)= lhs-rhs;
lhs =y(22);
rhs =(1-T342)*(y(27)+y(32))+y(5)*T342;
residual(10)= lhs-rhs;
lhs =y(23);
rhs =y(24)*para_n_rk__-para_n_r__*y(2)+para_n_qk__*(y(5)+y(4))+(y(25)-y(26))*T363-para_n_sig__*y(11);
residual(11)= lhs-rhs;
lhs =y(20);
rhs =params(13)*y(3)+y(18)*(1-params(13))*params(11)+(1-params(13))*params(12)*(y(25)-y(34))+x(it_, 3);
residual(12)= lhs-rhs;
lhs =y(20);
rhs =y(19)+y(51);
residual(13)= lhs-rhs;
lhs =y(31);
rhs =y(52)-y(19);
residual(14)= lhs-rhs;
lhs =y(28);
rhs =params(14)*y(8)+x(it_, 1);
residual(15)= lhs-rhs;
lhs =y(30);
rhs =params(15)*y(9)+x(it_, 2);
residual(16)= lhs-rhs;
lhs =y(32);
rhs =params(16)*y(10)+x(it_, 4);
residual(17)= lhs-rhs;
lhs =y(33);
rhs =y(11)*params(17)+x(it_, 5);
residual(18)= lhs-rhs;
lhs =y(34);
rhs =params(3)*y(30)+CY__*y(40)+C_EY__*y(43)+IY__*y(36);
residual(19)= lhs-rhs;
lhs =y(40);
rhs =(-y(37))+y(56);
residual(20)= lhs-rhs;
lhs =y(43);
rhs =y(39);
residual(21)= lhs-rhs;
residual(22) = y(55)-y(37);
lhs =y(38);
rhs =(1-epsilonv__)*(y(34)-y(12))+epsilonv__*y(41)-y(15);
residual(23)= lhs-rhs;
lhs =y(36);
rhs =1/(1+betav__)*y(13)+betav__/(1+betav__)*y(54)+T303*(y(32)+y(41));
residual(24)= lhs-rhs;
lhs =y(34);
rhs =(1-params(5))*y(28)+params(5)*y(12)+(1-params(5))*params(4)*y(42);
residual(25)= lhs-rhs;
lhs =y(34)-y(42)-y(40);
rhs =T321*y(42);
residual(26)= lhs-rhs;
lhs =y(35);
rhs =(1-T342)*(y(32)+y(36))+T342*y(12);
residual(27)= lhs-rhs;
lhs =y(39);
rhs =para_n_rk__*y(38)-para_n_r__*y(14)+para_n_qk__*(y(12)+y(15))+T363*y(34)-para_n_sig__*y(11);
residual(28)= lhs-rhs;
lhs =y(49);
rhs =y(25)-y(34);
residual(29)= lhs-rhs;
lhs =y(44);
rhs =params(18)+y(25)-y(6);
residual(30)= lhs-rhs;
lhs =y(47);
rhs =params(18)+y(27)-y(7);
residual(31)= lhs-rhs;
lhs =y(45);
rhs =params(19)+y(18);
residual(32)= lhs-rhs;
lhs =y(46);
rhs =y(20)+rn_bar__;
residual(33)= lhs-rhs;
lhs =y(48);
rhs =params(20)+y(31);
residual(34)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(34, 61);

  %
  % Jacobian matrix
  %

  g1(1,16)=(-CY__);
  g1(1,25)=1;
  g1(1,27)=(-IY__);
  g1(1,29)=(-C_EY__);
  g1(1,30)=(-params(3));
  g1(2,16)=1;
  g1(2,50)=(-1);
  g1(2,19)=1;
  g1(3,23)=(-1);
  g1(3,29)=1;
  g1(4,19)=(-1);
  g1(4,21)=(-params(22));
  g1(4,22)=(-params(22));
  g1(4,23)=params(22);
  g1(4,52)=1;
  g1(4,33)=(-para_sp_sig__);
  g1(5,4)=1;
  g1(5,21)=(-epsilonv__);
  g1(5,5)=1-epsilonv__;
  g1(5,24)=1;
  g1(5,25)=(-(1-epsilonv__));
  g1(5,26)=1-epsilonv__;
  g1(6,21)=(-T303);
  g1(6,7)=(-(1/(1+betav__)));
  g1(6,27)=1;
  g1(6,53)=(-(betav__/(1+betav__)));
  g1(6,32)=(-T303);
  g1(7,17)=(-((1-params(5))*params(4)));
  g1(7,5)=(-params(5));
  g1(7,25)=1;
  g1(7,28)=(-(1-params(5)));
  g1(8,16)=(-1);
  g1(8,17)=(-1)-T321;
  g1(8,25)=1;
  g1(8,26)=(-1);
  g1(9,1)=(-(params(24)/(1+betav__*params(24))));
  g1(9,18)=1;
  g1(9,51)=(-(betav__/(1+betav__*params(24))));
  g1(9,26)=1/(1+betav__*params(24))*kappav__;
  g1(10,5)=(-T342);
  g1(10,22)=1;
  g1(10,27)=(-(1-T342));
  g1(10,32)=(-(1-T342));
  g1(11,2)=para_n_r__;
  g1(11,4)=(-para_n_qk__);
  g1(11,5)=(-para_n_qk__);
  g1(11,23)=1;
  g1(11,24)=(-para_n_rk__);
  g1(11,25)=(-T363);
  g1(11,26)=T363;
  g1(11,11)=para_n_sig__;
  g1(12,18)=(-((1-params(13))*params(11)));
  g1(12,3)=(-params(13));
  g1(12,20)=1;
  g1(12,25)=(-((1-params(13))*params(12)));
  g1(12,34)=(1-params(13))*params(12);
  g1(12,59)=(-1);
  g1(13,51)=(-1);
  g1(13,19)=(-1);
  g1(13,20)=1;
  g1(14,19)=1;
  g1(14,52)=(-1);
  g1(14,31)=1;
  g1(15,8)=(-params(14));
  g1(15,28)=1;
  g1(15,57)=(-1);
  g1(16,9)=(-params(15));
  g1(16,30)=1;
  g1(16,58)=(-1);
  g1(17,10)=(-params(16));
  g1(17,32)=1;
  g1(17,60)=(-1);
  g1(18,11)=(-params(17));
  g1(18,33)=1;
  g1(18,61)=(-1);
  g1(19,30)=(-params(3));
  g1(19,34)=1;
  g1(19,36)=(-IY__);
  g1(19,40)=(-CY__);
  g1(19,43)=(-C_EY__);
  g1(20,37)=1;
  g1(20,40)=1;
  g1(20,56)=(-1);
  g1(21,39)=(-1);
  g1(21,43)=1;
  g1(22,37)=(-1);
  g1(22,55)=1;
  g1(23,34)=(-(1-epsilonv__));
  g1(23,12)=1-epsilonv__;
  g1(23,38)=1;
  g1(23,15)=1;
  g1(23,41)=(-epsilonv__);
  g1(24,32)=(-T303);
  g1(24,13)=(-(1/(1+betav__)));
  g1(24,36)=1;
  g1(24,54)=(-(betav__/(1+betav__)));
  g1(24,41)=(-T303);
  g1(25,28)=(-(1-params(5)));
  g1(25,34)=1;
  g1(25,12)=(-params(5));
  g1(25,42)=(-((1-params(5))*params(4)));
  g1(26,34)=1;
  g1(26,40)=(-1);
  g1(26,42)=(-1)-T321;
  g1(27,32)=(-(1-T342));
  g1(27,12)=(-T342);
  g1(27,35)=1;
  g1(27,36)=(-(1-T342));
  g1(28,11)=para_n_sig__;
  g1(28,34)=(-T363);
  g1(28,12)=(-para_n_qk__);
  g1(28,14)=para_n_r__;
  g1(28,38)=(-para_n_rk__);
  g1(28,39)=1;
  g1(28,15)=(-para_n_qk__);
  g1(29,25)=(-1);
  g1(29,34)=1;
  g1(29,49)=1;
  g1(30,6)=1;
  g1(30,25)=(-1);
  g1(30,44)=1;
  g1(31,7)=1;
  g1(31,27)=(-1);
  g1(31,47)=1;
  g1(32,18)=(-1);
  g1(32,45)=1;
  g1(33,20)=(-1);
  g1(33,46)=1;
  g1(34,31)=(-1);
  g1(34,48)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],34,3721);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],34,226981);
end
end
end
end
