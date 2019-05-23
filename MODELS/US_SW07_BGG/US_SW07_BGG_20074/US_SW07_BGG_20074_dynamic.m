function [residual, g1, g2, g3] = US_SW07_BGG_20074_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(41, 1);
cpie__ = 1+params(16)/100;
cgamma__ = 1+params(15)/100;
cbetabar__ = params(2)*cgamma__^(-params(18));
cr__ = cpie__/(params(2)*cgamma__^(-params(18)));
crk__ = params(2)^(-1)*cgamma__^params(18)-(1-params(8));
cw__ = (params(19)^params(19)*(1-params(19))^(1-params(19))/(params(17)*crk__^params(19)))^(1/(1-params(19)));
cikbar__ = 1-(1-params(8))/cgamma__;
cik__ = cgamma__*(1-(1-params(8))/cgamma__);
clk__ = (1-params(19))/params(19)*crk__/cw__;
cky__ = params(17)*clk__^(params(19)-1);
ciy__ = cik__*cky__;
ccy__ = 1-params(20)-ciy__;
crkky__ = crk__*cky__;
cwhlc__ = cky__*crk__*(1-params(19))*1/params(37)/params(19)/ccy__;
conster__ = 100*(cr__-1);
crkp__ = 1-params(8)+(1+params(2)/100)*(1+cgamma__/100)^params(18);
T84 = 1/(1-params(1));
T96 = params(2)/(1+params(2));
T99 = 1/(1+params(2));
T128 = T99*(1-params(2)*params(4))*(1-params(4))/(params(4)*(1+params(5)*params(6)));
T208 = (1-params(2)*params(11))*(1-params(11))/((1+params(2)*params(10))*params(11));
T256 = (1-params(2)*params(12))*(1-params(12))/((1+params(2))*params(12));
T352 = 1/(params(35)/(1-params(35)));
T367 = 1/(1+cgamma__*cbetabar__);
T374 = cgamma__^2*params(36);
T384 = params(1)/cgamma__;
T388 = (1-T384)/(params(18)*(1+T384));
T413 = (params(18)-1)*cwhlc__/(params(18)*(1+T384));
lhs =(1+params(1))/(1-params(1))*y(20);
rhs =T84*y(61)+params(1)/(1-params(1))*y(1)-y(21);
residual(1)= lhs-rhs;
lhs =y(22);
rhs =T96*y(62)+T99*y(2)+T96*y(63)-(1+params(2)*params(3))/(1+params(2))*y(23)+params(3)/(1+params(2))*y(3)+T128*(params(6)*y(24)-params(1)/(1-params(1))*y(1)+y(20)*T84-y(22))+y(42);
residual(2)= lhs-rhs;
lhs =y(64);
rhs =params(8)*(y(26)+y(39))+(1-params(8))*(y(25)+y(37));
residual(3)= lhs-rhs;
lhs =y(27);
rhs =params(7)/(1-params(7))*y(28);
residual(4)= lhs-rhs;
lhs =y(26);
rhs =1/((1+params(2))*params(9))*(y(39)+y(29))+T99*y(4)+T96*y(65);
residual(5)= lhs-rhs;
lhs =y(35);
rhs =ccy__*y(20)+ciy__*y(26)+params(20)*y(38)+crk__*cky__*y(28);
residual(6)= lhs-rhs;
lhs =y(35);
rhs =params(17)*(params(19)*(y(37)+y(25)+y(28))+(1-params(19))*y(24)+y(36));
residual(7)= lhs-rhs;
lhs =y(22);
rhs =y(28)+y(25)+y(27)-y(24);
residual(8)= lhs-rhs;
lhs =y(23);
rhs =y(3)*params(10)/(1+params(2)*params(10))+y(63)*params(2)/(1+params(2)*params(10))-T208*(y(36)-params(19)*y(27)-(1-params(19))*y(22))+y(41);
residual(9)= lhs-rhs;
lhs =y(30);
rhs =params(21)*y(6)+(1-params(21))*(y(23)*params(22)+params(23)*(y(35)-y(49)))+params(24)*(y(35)-y(49)-y(8)+y(18))+x(it_, 7);
residual(10)= lhs-rhs;
lhs =y(30);
rhs =y(21)+y(63);
residual(11)= lhs-rhs;
lhs =y(31);
rhs =T99*y(7)+T96*y(66)-T256*(y(24)-y(31));
residual(12)= lhs-rhs;
lhs =y(34);
rhs =y(27)*crk__/crkp__+(1-params(8))/crkp__*(y(37)+y(29))-y(5);
residual(13)= lhs-rhs;
lhs =y(33);
rhs =params(25)*(y(64)+y(29)-y(67));
residual(14)= lhs-rhs;
lhs =y(68);
rhs =y(21)+y(33);
residual(15)= lhs-rhs;
lhs =y(67)*1/(crkp__*params(26));
rhs =y(34)*params(27)-y(21)*(params(27)-1)-params(25)*(params(27)-1)*(y(25)+y(5))+(1+params(25)*(params(27)-1))*y(32);
residual(16)= lhs-rhs;
lhs =y(36);
rhs =params(28)*y(9)+x(it_, 4);
residual(17)= lhs-rhs;
lhs =y(37);
rhs =params(29)*y(10)+x(it_, 3);
residual(18)= lhs-rhs;
lhs =y(38);
rhs =params(30)*y(11)+x(it_, 6);
residual(19)= lhs-rhs;
lhs =y(39);
rhs =params(31)*y(12)+x(it_, 2);
residual(20)= lhs-rhs;
lhs =y(40);
rhs =x(it_, 7)+params(32)*y(13);
residual(21)= lhs-rhs;
lhs =y(41);
rhs =params(33)*y(14)+x(it_, 5);
residual(22)= lhs-rhs;
lhs =y(42);
rhs =params(34)*y(15)+x(it_, 1);
residual(23)= lhs-rhs;
lhs =y(36);
rhs =params(19)*y(44)+(1-params(19))*y(51);
residual(24)= lhs-rhs;
lhs =y(43);
rhs =y(44)*T352;
residual(25)= lhs-rhs;
lhs =y(44);
rhs =y(51)+y(50)-y(45);
residual(26)= lhs-rhs;
lhs =y(45);
rhs =y(43)+y(19);
residual(27)= lhs-rhs;
lhs =y(48);
rhs =y(39)+T367*(y(17)+cgamma__*cbetabar__*y(72)+1/T374*y(46));
residual(28)= lhs-rhs;
lhs =y(46);
rhs =(-y(52))+y(37)*1/T388+crk__/(1-params(8)+crk__)*y(69)+(1-params(8))/(1-params(8)+crk__)*y(70);
residual(29)= lhs-rhs;
lhs =y(47);
rhs =y(37)+T384/(1+T384)*y(16)+1/(1+T384)*y(71)+T413*(y(50)-y(73))-y(52)*T388;
residual(30)= lhs-rhs;
lhs =y(49);
rhs =y(38)+ccy__*y(47)+ciy__*y(48)+y(43)*crkky__;
residual(31)= lhs-rhs;
lhs =y(49);
rhs =params(17)*(y(36)+params(19)*y(45)+(1-params(19))*y(50));
residual(32)= lhs-rhs;
lhs =y(51);
rhs =params(6)*y(50)+y(47)*1/(1-T384)-y(16)*T384/(1-T384);
residual(33)= lhs-rhs;
lhs =y(53);
rhs =y(19)*(1-cikbar__)+y(48)*cikbar__+y(39)*T374*cikbar__;
residual(34)= lhs-rhs;
lhs =y(54);
rhs =params(15)+y(35)-y(8);
residual(35)= lhs-rhs;
lhs =y(59);
rhs =params(15)+y(20)-y(1);
residual(36)= lhs-rhs;
lhs =y(60);
rhs =params(15)+y(26)-y(4);
residual(37)= lhs-rhs;
lhs =y(56);
rhs =params(15)+y(22)-y(2);
residual(38)= lhs-rhs;
lhs =y(55);
rhs =y(24)+params(14);
residual(39)= lhs-rhs;
lhs =y(57);
rhs =params(16)+y(23);
residual(40)= lhs-rhs;
lhs =y(58);
rhs =y(21)+conster__;
residual(41)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(41, 80);

  %
  % Jacobian matrix
  %

  g1(1,1)=(-(params(1)/(1-params(1))));
  g1(1,20)=(1+params(1))/(1-params(1));
  g1(1,61)=(-T84);
  g1(1,21)=1;
  g1(2,1)=(-(T128*(-(params(1)/(1-params(1))))));
  g1(2,20)=(-(T84*T128));
  g1(2,2)=(-T99);
  g1(2,22)=1-(-T128);
  g1(2,62)=(-T96);
  g1(2,3)=(-(params(3)/(1+params(2))));
  g1(2,23)=(1+params(2)*params(3))/(1+params(2));
  g1(2,63)=(-T96);
  g1(2,24)=(-(params(6)*T128));
  g1(2,42)=(-1);
  g1(3,25)=(-(1-params(8)));
  g1(3,64)=1;
  g1(3,26)=(-params(8));
  g1(3,37)=(-(1-params(8)));
  g1(3,39)=(-params(8));
  g1(4,27)=1;
  g1(4,28)=(-(params(7)/(1-params(7))));
  g1(5,4)=(-T99);
  g1(5,26)=1;
  g1(5,65)=(-T96);
  g1(5,29)=(-(1/((1+params(2))*params(9))));
  g1(5,39)=(-(1/((1+params(2))*params(9))));
  g1(6,20)=(-ccy__);
  g1(6,26)=(-ciy__);
  g1(6,28)=(-(crk__*cky__));
  g1(6,35)=1;
  g1(6,38)=(-params(20));
  g1(7,24)=(-((1-params(19))*params(17)));
  g1(7,25)=(-(params(19)*params(17)));
  g1(7,28)=(-(params(19)*params(17)));
  g1(7,35)=1;
  g1(7,36)=(-params(17));
  g1(7,37)=(-(params(19)*params(17)));
  g1(8,22)=1;
  g1(8,24)=1;
  g1(8,25)=(-1);
  g1(8,27)=(-1);
  g1(8,28)=(-1);
  g1(9,22)=T208*(-(1-params(19)));
  g1(9,3)=(-(params(10)/(1+params(2)*params(10))));
  g1(9,23)=1;
  g1(9,63)=(-(params(2)/(1+params(2)*params(10))));
  g1(9,27)=T208*(-params(19));
  g1(9,36)=T208;
  g1(9,41)=(-1);
  g1(10,23)=(-((1-params(21))*params(22)));
  g1(10,6)=(-params(21));
  g1(10,30)=1;
  g1(10,8)=params(24);
  g1(10,35)=(-(params(24)+(1-params(21))*params(23)));
  g1(10,18)=(-params(24));
  g1(10,49)=(-((1-params(21))*(-params(23))-params(24)));
  g1(10,80)=(-1);
  g1(11,21)=(-1);
  g1(11,63)=(-1);
  g1(11,30)=1;
  g1(12,24)=T256;
  g1(12,7)=(-T99);
  g1(12,31)=1-T256;
  g1(12,66)=(-T96);
  g1(13,27)=(-(crk__/crkp__));
  g1(13,5)=1;
  g1(13,29)=(-((1-params(8))/crkp__));
  g1(13,34)=1;
  g1(13,37)=(-((1-params(8))/crkp__));
  g1(14,64)=(-params(25));
  g1(14,29)=(-params(25));
  g1(14,67)=params(25);
  g1(14,33)=1;
  g1(15,21)=(-1);
  g1(15,33)=(-1);
  g1(15,68)=1;
  g1(16,21)=params(27)-1;
  g1(16,25)=params(25)*(params(27)-1);
  g1(16,5)=params(25)*(params(27)-1);
  g1(16,32)=(-(1+params(25)*(params(27)-1)));
  g1(16,67)=1/(crkp__*params(26));
  g1(16,34)=(-params(27));
  g1(17,9)=(-params(28));
  g1(17,36)=1;
  g1(17,77)=(-1);
  g1(18,10)=(-params(29));
  g1(18,37)=1;
  g1(18,76)=(-1);
  g1(19,11)=(-params(30));
  g1(19,38)=1;
  g1(19,79)=(-1);
  g1(20,12)=(-params(31));
  g1(20,39)=1;
  g1(20,75)=(-1);
  g1(21,13)=(-params(32));
  g1(21,40)=1;
  g1(21,80)=(-1);
  g1(22,14)=(-params(33));
  g1(22,41)=1;
  g1(22,78)=(-1);
  g1(23,15)=(-params(34));
  g1(23,42)=1;
  g1(23,74)=(-1);
  g1(24,36)=1;
  g1(24,44)=(-params(19));
  g1(24,51)=(-(1-params(19)));
  g1(25,43)=1;
  g1(25,44)=(-T352);
  g1(26,44)=1;
  g1(26,45)=1;
  g1(26,50)=(-1);
  g1(26,51)=(-1);
  g1(27,43)=(-1);
  g1(27,45)=1;
  g1(27,19)=(-1);
  g1(28,39)=(-1);
  g1(28,46)=(-(T367*1/T374));
  g1(28,17)=(-T367);
  g1(28,48)=1;
  g1(28,72)=(-(cgamma__*cbetabar__*T367));
  g1(29,37)=(-(1/T388));
  g1(29,69)=(-(crk__/(1-params(8)+crk__)));
  g1(29,46)=1;
  g1(29,70)=(-((1-params(8))/(1-params(8)+crk__)));
  g1(29,52)=1;
  g1(30,37)=(-1);
  g1(30,16)=(-(T384/(1+T384)));
  g1(30,47)=1;
  g1(30,71)=(-(1/(1+T384)));
  g1(30,50)=(-T413);
  g1(30,73)=T413;
  g1(30,52)=T388;
  g1(31,38)=(-1);
  g1(31,43)=(-crkky__);
  g1(31,47)=(-ccy__);
  g1(31,48)=(-ciy__);
  g1(31,49)=1;
  g1(32,36)=(-params(17));
  g1(32,45)=(-(params(19)*params(17)));
  g1(32,49)=1;
  g1(32,50)=(-((1-params(19))*params(17)));
  g1(33,16)=T384/(1-T384);
  g1(33,47)=(-(1/(1-T384)));
  g1(33,50)=(-params(6));
  g1(33,51)=1;
  g1(34,39)=(-(T374*cikbar__));
  g1(34,48)=(-cikbar__);
  g1(34,19)=(-(1-cikbar__));
  g1(34,53)=1;
  g1(35,8)=1;
  g1(35,35)=(-1);
  g1(35,54)=1;
  g1(36,1)=1;
  g1(36,20)=(-1);
  g1(36,59)=1;
  g1(37,4)=1;
  g1(37,26)=(-1);
  g1(37,60)=1;
  g1(38,2)=1;
  g1(38,22)=(-1);
  g1(38,56)=1;
  g1(39,24)=(-1);
  g1(39,55)=1;
  g1(40,23)=(-1);
  g1(40,57)=1;
  g1(41,21)=(-1);
  g1(41,58)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],41,6400);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],41,512000);
end
end
end
end
