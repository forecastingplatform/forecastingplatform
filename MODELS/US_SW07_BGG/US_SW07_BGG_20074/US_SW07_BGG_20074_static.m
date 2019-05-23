function [residual, g1, g2, g3] = US_SW07_BGG_20074_static(y, x, params)
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

residual = zeros( 41, 1);

%
% Model equations
%

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
conster__ = 100*(cr__-1);
crkp__ = 1-params(8)+(1+params(2)/100)*(1+cgamma__/100)^params(18);
T94 = params(2)/(1+params(2));
T96 = 1/(1+params(2));
T122 = T96*(1-params(2)*params(4))*(1-params(4))/(params(4)*(1+params(5)*params(6)));
T198 = (1-params(2)*params(11))*(1-params(11))/((1+params(2)*params(10))*params(11));
T241 = (1-params(2)*params(12))*(1-params(12))/((1+params(2))*params(12));
T326 = 1/(params(35)/(1-params(35)));
T346 = cgamma__^2*params(36);
T356 = params(1)/cgamma__;
T360 = (1-T356)/(params(18)*(1+T356));
lhs =(1+params(1))/(1-params(1))*y(1);
rhs =y(1)*1/(1-params(1))+y(1)*params(1)/(1-params(1))-y(2);
residual(1)= lhs-rhs;
lhs =y(3);
rhs =y(3)*T94+y(3)*T96+T94*y(4)-y(4)*(1+params(2)*params(3))/(1+params(2))+y(4)*params(3)/(1+params(2))+T122*(y(1)*1/(1-params(1))+params(6)*y(5)-y(1)*params(1)/(1-params(1))-y(3))+y(23);
residual(2)= lhs-rhs;
lhs =y(6);
rhs =params(8)*(y(7)+y(20))+(1-params(8))*(y(6)+y(18));
residual(3)= lhs-rhs;
lhs =y(8);
rhs =params(7)/(1-params(7))*y(9);
residual(4)= lhs-rhs;
lhs =y(7);
rhs =1/((1+params(2))*params(9))*(y(20)+y(10))+T96*y(7)+T94*y(7);
residual(5)= lhs-rhs;
lhs =y(16);
rhs =ccy__*y(1)+ciy__*y(7)+params(20)*y(19)+crk__*cky__*y(9);
residual(6)= lhs-rhs;
lhs =y(16);
rhs =params(17)*(params(19)*(y(18)+y(6)+y(9))+(1-params(19))*y(5)+y(17));
residual(7)= lhs-rhs;
lhs =y(3);
rhs =y(9)+y(6)+y(8)-y(5);
residual(8)= lhs-rhs;
lhs =y(4);
rhs =y(4)*params(10)/(1+params(2)*params(10))+y(4)*params(2)/(1+params(2)*params(10))-T198*(y(17)-params(19)*y(8)-(1-params(19))*y(3))+y(22);
residual(9)= lhs-rhs;
lhs =y(11);
rhs =y(11)*params(21)+(1-params(21))*(y(4)*params(22)+params(23)*(y(16)-y(30)))+params(24)*(y(30)+y(16)-y(30)-y(16))+x(7);
residual(10)= lhs-rhs;
lhs =y(11);
rhs =y(2)+y(4);
residual(11)= lhs-rhs;
lhs =y(12);
rhs =T96*y(12)+T94*y(12)-T241*(y(5)-y(12));
residual(12)= lhs-rhs;
lhs =y(15);
rhs =y(8)*crk__/crkp__+(1-params(8))/crkp__*(y(18)+y(10))-y(10);
residual(13)= lhs-rhs;
lhs =y(14);
rhs =params(25)*(y(6)+y(10)-y(13));
residual(14)= lhs-rhs;
lhs =y(15);
rhs =y(2)+y(14);
residual(15)= lhs-rhs;
lhs =y(13)*1/(crkp__*params(26));
rhs =y(15)*params(27)-y(2)*(params(27)-1)-(y(6)+y(10))*params(25)*(params(27)-1)+y(13)*(1+params(25)*(params(27)-1));
residual(16)= lhs-rhs;
lhs =y(17);
rhs =y(17)*params(28)+x(4);
residual(17)= lhs-rhs;
lhs =y(18);
rhs =y(18)*params(29)+x(3);
residual(18)= lhs-rhs;
lhs =y(19);
rhs =y(19)*params(30)+x(6);
residual(19)= lhs-rhs;
lhs =y(20);
rhs =y(20)*params(31)+x(2);
residual(20)= lhs-rhs;
lhs =y(21);
rhs =x(7)+y(21)*params(32);
residual(21)= lhs-rhs;
lhs =y(22);
rhs =y(22)*params(33)+x(5);
residual(22)= lhs-rhs;
lhs =y(23);
rhs =y(23)*params(34)+x(1);
residual(23)= lhs-rhs;
lhs =y(17);
rhs =params(19)*y(25)+(1-params(19))*y(32);
residual(24)= lhs-rhs;
lhs =y(24);
rhs =y(25)*T326;
residual(25)= lhs-rhs;
lhs =y(25);
rhs =y(32)+y(31)-y(26);
residual(26)= lhs-rhs;
lhs =y(26);
rhs =y(24)+y(34);
residual(27)= lhs-rhs;
lhs =y(29);
rhs =y(20)+1/(1+cgamma__*cbetabar__)*(y(29)+y(29)*cgamma__*cbetabar__+1/T346*y(27));
residual(28)= lhs-rhs;
lhs =y(27);
rhs =(-y(33))+y(18)*1/T360+y(25)*crk__/(1-params(8)+crk__)+y(27)*(1-params(8))/(1-params(8)+crk__);
residual(29)= lhs-rhs;
lhs =y(28);
rhs =y(18)+y(28)*T356/(1+T356)+y(28)*1/(1+T356)-y(33)*T360;
residual(30)= lhs-rhs;
lhs =y(30);
rhs =y(19)+ccy__*y(28)+ciy__*y(29)+y(24)*crkky__;
residual(31)= lhs-rhs;
lhs =y(30);
rhs =params(17)*(y(17)+params(19)*y(26)+(1-params(19))*y(31));
residual(32)= lhs-rhs;
lhs =y(32);
rhs =params(6)*y(31)+y(28)*1/(1-T356)-y(28)*T356/(1-T356);
residual(33)= lhs-rhs;
lhs =y(34);
rhs =y(34)*(1-cikbar__)+y(29)*cikbar__+y(20)*T346*cikbar__;
residual(34)= lhs-rhs;
lhs =y(35);
rhs =params(15);
residual(35)= lhs-rhs;
lhs =y(40);
rhs =params(15);
residual(36)= lhs-rhs;
lhs =y(41);
rhs =params(15);
residual(37)= lhs-rhs;
lhs =y(37);
rhs =params(15);
residual(38)= lhs-rhs;
lhs =y(36);
rhs =y(5)+params(14);
residual(39)= lhs-rhs;
lhs =y(38);
rhs =params(16)+y(4);
residual(40)= lhs-rhs;
lhs =y(39);
rhs =y(2)+conster__;
residual(41)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(41, 41);

  %
  % Jacobian matrix
  %

  g1(1,1)=(1+params(1))/(1-params(1))-(1/(1-params(1))+params(1)/(1-params(1)));
  g1(1,2)=1;
  g1(2,1)=(-(T122*(1/(1-params(1))-params(1)/(1-params(1)))));
  g1(2,3)=1-(T94+T96-T122);
  g1(2,4)=(-(params(3)/(1+params(2))+T94-(1+params(2)*params(3))/(1+params(2))));
  g1(2,5)=(-(params(6)*T122));
  g1(2,23)=(-1);
  g1(3,6)=1-(1-params(8));
  g1(3,7)=(-params(8));
  g1(3,18)=(-(1-params(8)));
  g1(3,20)=(-params(8));
  g1(4,8)=1;
  g1(4,9)=(-(params(7)/(1-params(7))));
  g1(5,7)=1-(T94+T96);
  g1(5,10)=(-(1/((1+params(2))*params(9))));
  g1(5,20)=(-(1/((1+params(2))*params(9))));
  g1(6,1)=(-ccy__);
  g1(6,7)=(-ciy__);
  g1(6,9)=(-(crk__*cky__));
  g1(6,16)=1;
  g1(6,19)=(-params(20));
  g1(7,5)=(-((1-params(19))*params(17)));
  g1(7,6)=(-(params(19)*params(17)));
  g1(7,9)=(-(params(19)*params(17)));
  g1(7,16)=1;
  g1(7,17)=(-params(17));
  g1(7,18)=(-(params(19)*params(17)));
  g1(8,3)=1;
  g1(8,5)=1;
  g1(8,6)=(-1);
  g1(8,8)=(-1);
  g1(8,9)=(-1);
  g1(9,3)=T198*(-(1-params(19)));
  g1(9,4)=1-(params(10)/(1+params(2)*params(10))+params(2)/(1+params(2)*params(10)));
  g1(9,8)=T198*(-params(19));
  g1(9,17)=T198;
  g1(9,22)=(-1);
  g1(10,4)=(-((1-params(21))*params(22)));
  g1(10,11)=1-params(21);
  g1(10,16)=(-((1-params(21))*params(23)));
  g1(10,30)=(-((1-params(21))*(-params(23))));
  g1(11,2)=(-1);
  g1(11,4)=(-1);
  g1(11,11)=1;
  g1(12,5)=T241;
  g1(12,12)=1-(T94+T96-(-T241));
  g1(13,8)=(-(crk__/crkp__));
  g1(13,10)=(-((1-params(8))/crkp__-1));
  g1(13,15)=1;
  g1(13,18)=(-((1-params(8))/crkp__));
  g1(14,6)=(-params(25));
  g1(14,10)=(-params(25));
  g1(14,13)=params(25);
  g1(14,14)=1;
  g1(15,2)=(-1);
  g1(15,14)=(-1);
  g1(15,15)=1;
  g1(16,2)=params(27)-1;
  g1(16,6)=params(25)*(params(27)-1);
  g1(16,10)=params(25)*(params(27)-1);
  g1(16,13)=1/(crkp__*params(26))-(1+params(25)*(params(27)-1));
  g1(16,15)=(-params(27));
  g1(17,17)=1-params(28);
  g1(18,18)=1-params(29);
  g1(19,19)=1-params(30);
  g1(20,20)=1-params(31);
  g1(21,21)=1-params(32);
  g1(22,22)=1-params(33);
  g1(23,23)=1-params(34);
  g1(24,17)=1;
  g1(24,25)=(-params(19));
  g1(24,32)=(-(1-params(19)));
  g1(25,24)=1;
  g1(25,25)=(-T326);
  g1(26,25)=1;
  g1(26,26)=1;
  g1(26,31)=(-1);
  g1(26,32)=(-1);
  g1(27,24)=(-1);
  g1(27,26)=1;
  g1(27,34)=(-1);
  g1(28,20)=(-1);
  g1(28,27)=(-(1/(1+cgamma__*cbetabar__)*1/T346));
  g1(28,29)=1-(1+cgamma__*cbetabar__)*1/(1+cgamma__*cbetabar__);
  g1(29,18)=(-(1/T360));
  g1(29,25)=(-(crk__/(1-params(8)+crk__)));
  g1(29,27)=1-(1-params(8))/(1-params(8)+crk__);
  g1(29,33)=1;
  g1(30,18)=(-1);
  g1(30,28)=1-(T356/(1+T356)+1/(1+T356));
  g1(30,33)=T360;
  g1(31,19)=(-1);
  g1(31,24)=(-crkky__);
  g1(31,28)=(-ccy__);
  g1(31,29)=(-ciy__);
  g1(31,30)=1;
  g1(32,17)=(-params(17));
  g1(32,26)=(-(params(19)*params(17)));
  g1(32,30)=1;
  g1(32,31)=(-((1-params(19))*params(17)));
  g1(33,28)=(-(1/(1-T356)-T356/(1-T356)));
  g1(33,31)=(-params(6));
  g1(33,32)=1;
  g1(34,20)=(-(T346*cikbar__));
  g1(34,29)=(-cikbar__);
  g1(34,34)=1-(1-cikbar__);
  g1(35,35)=1;
  g1(36,40)=1;
  g1(37,41)=1;
  g1(38,37)=1;
  g1(39,5)=(-1);
  g1(39,36)=1;
  g1(40,4)=(-1);
  g1(40,38)=1;
  g1(41,2)=(-1);
  g1(41,39)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],41,1681);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],41,68921);
end
end
end
end
