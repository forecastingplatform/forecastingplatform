function [residual, g1, g2, g3] = US_SW07_20074_static(y, x, params)
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

residual = zeros( 43, 1);

%
% Model equations
%

T19 = (-(1-params(11)*exp((-params(41)))))/(params(17)*(1+params(11)*exp((-params(41)))));
T26 = params(11)*exp((-params(41)))/(1+params(11)*exp((-params(41))));
T31 = 1/(1+params(11)*exp((-params(41))));
T64 = params(16)*exp(2*params(41))*(1+params(37)*exp(params(41)*(1-params(17))));
T66 = 1/(1+params(37)*exp(params(41)*(1-params(17))));
T70 = params(37)*exp(params(41)*(1-params(17)))/(1+params(37)*exp(params(41)*(1-params(17))));
T93 = params(44)/(1+params(44)-params(20));
T97 = (1-params(20))/(1+params(44)-params(20));
T101 = params(17)*(1+params(11)*exp((-params(41))))/(1-params(11)*exp((-params(41))));
T102 = y(17)*T101;
T154 = params(49)/params(48);
T163 = (1+params(37)*exp(params(41)*(1-params(17))))*exp(2*params(41))*params(16)*params(49)/params(48);
T164 = y(21)*T163;
T199 = (1-exp(params(41)*(1-params(17)))*params(37)*params(5))*(1-params(5))/(params(5)*(1+(params(10)-1)*params(25)))/(1+exp(params(41)*(1-params(17)))*params(37)*params(6));
T204 = params(37)*exp(params(41)*(1-params(17)))/(1+exp(params(41)*(1-params(17)))*params(37)*params(6));
T218 = (-1)/(1-params(11)*exp((-params(41))));
T220 = params(11)*exp((-params(41)))/(1-params(11)*exp((-params(41))));
T251 = (-(1-exp(params(41)*(1-params(17)))*params(37)*params(7)))*(1-params(7))/(params(7)*(1+(params(22)-1)*params(26)))/(1+params(37)*exp(params(41)*(1-params(17))));
T257 = (1+exp(params(41)*(1-params(17)))*params(37)*params(8))/(1+params(37)*exp(params(41)*(1-params(17))));
lhs =y(2);
rhs =T19*(y(9)-y(8))+y(17)+T26*(y(2)-y(15))+T31*(y(2)+y(15));
residual(1)= lhs-rhs;
lhs =y(31);
rhs =y(17)+T19*y(36)+T26*(y(31)-y(15))+T31*(y(15)+y(31));
residual(2)= lhs-rhs;
lhs =y(14);
rhs =T64*(y(3)-T66*(y(3)-y(15))-T70*(y(15)+y(3))-y(21));
residual(3)= lhs-rhs;
lhs =y(40);
rhs =T64*(y(32)-T66*(y(32)-y(15))-T70*(y(15)+y(32))-y(21));
residual(4)= lhs-rhs;
lhs =T93*y(10)+y(14)*T97-y(14);
rhs =y(9)-y(8)-T102;
residual(5)= lhs-rhs;
lhs =T93*y(37)+y(40)*T97-y(40);
rhs =y(36)-T102;
residual(6)= lhs-rhs;
lhs =y(1);
rhs =params(10)*(params(9)*y(4)+y(6)*(1-params(9)))+(params(10)-1)/(1-params(9))*y(16);
residual(7)= lhs-rhs;
lhs =y(30);
rhs =(params(10)-1)/(1-params(9))*y(16)+params(10)*(params(9)*y(33)+y(35)*(1-params(9)));
residual(8)= lhs-rhs;
lhs =y(4);
rhs =y(11)-y(15)+y(5);
residual(9)= lhs-rhs;
lhs =y(33);
rhs =y(38)-y(15)+y(34);
residual(10)= lhs-rhs;
lhs =y(11);
rhs =y(10)*(1-params(18))/params(18);
residual(11)= lhs-rhs;
lhs =y(38);
rhs =y(37)*(1-params(18))/params(18);
residual(12)= lhs-rhs;
lhs =y(5);
rhs =(1-T154)*(y(5)-y(15))+y(3)*T154+T164;
residual(13)= lhs-rhs;
lhs =y(34);
rhs =T164+(1-T154)*(y(34)-y(15))+y(32)*T154;
residual(14)= lhs-rhs;
lhs =y(7);
rhs =y(12)+y(6)*params(9)-params(9)*y(4);
residual(15)= lhs-rhs;
lhs =0;
rhs =y(39)+y(35)*params(9)-params(9)*y(33);
residual(16)= lhs-rhs;
lhs =y(8);
rhs =y(7)*T199+y(8)*params(6)/(1+exp(params(41)*(1-params(17)))*params(37)*params(6))+y(8)*T204+y(19);
residual(17)= lhs-rhs;
lhs =y(4);
rhs =y(6)+y(12)-y(10);
residual(18)= lhs-rhs;
lhs =y(33);
rhs =y(35)+y(39)-y(37);
residual(19)= lhs-rhs;
lhs =y(13)-y(12);
rhs =y(2)*T218+y(2)*T220-y(15)*T220-y(6)*params(12);
residual(20)= lhs-rhs;
lhs =0;
rhs =y(39)+y(31)*T218+y(31)*T220-y(15)*T220-y(35)*params(12);
residual(21)= lhs-rhs;
lhs =y(12);
rhs =y(13)*T251-y(8)*T257+T66*(y(12)-y(15)-y(8)*params(8))+T70*(y(8)+y(15)+y(12))+y(20);
residual(22)= lhs-rhs;
lhs =y(9);
rhs =y(9)*params(4)+(1-params(4))*(y(8)*params(1)+params(2)*(y(1)-y(30)))+y(22);
residual(23)= lhs-rhs;
lhs =y(1);
rhs =params(21)*y(18)+y(2)*params(51)/params(50)+y(3)*params(49)/params(50)+y(11)*params(44)*params(47)/params(50)+y(16)*params(21)*1/(1-params(9));
residual(24)= lhs-rhs;
lhs =y(30);
rhs =y(16)*params(21)*1/(1-params(9))+params(21)*y(18)+y(31)*params(51)/params(50)+y(32)*params(49)/params(50)+y(38)*params(44)*params(47)/params(50);
residual(25)= lhs-rhs;
lhs =y(15);
rhs =y(16)*1/(1-params(9))*(params(27)-1)+1/(1-params(9))*x(1);
residual(26)= lhs-rhs;
lhs =y(16);
rhs =x(1)+y(16)*params(27);
residual(27)= lhs-rhs;
lhs =y(18);
rhs =y(18)*params(32)+x(2)+x(1)*params(35);
residual(28)= lhs-rhs;
lhs =y(17);
rhs =y(17)*params(28)+x(3);
residual(29)= lhs-rhs;
lhs =y(21);
rhs =y(21)*params(31)+x(4);
residual(30)= lhs-rhs;
lhs =y(19);
rhs =y(19)*params(29)+x(5)-x(5)*params(33);
residual(31)= lhs-rhs;
lhs =y(20);
rhs =y(20)*params(30)+x(6)-x(6)*params(34);
residual(32)= lhs-rhs;
lhs =y(22);
rhs =y(22)*params(36)+x(7);
residual(33)= lhs-rhs;
lhs =y(41);
rhs =y(1)-y(30);
residual(34)= lhs-rhs;
lhs =y(42)/4;
rhs =y(36)+params(43)-100*(params(38)-1);
residual(35)= lhs-rhs;
lhs =y(43)/4;
rhs =y(9)-y(8)+params(43)-100*(params(38)-1);
residual(36)= lhs-rhs;
lhs =y(23);
rhs =y(15)+100*(exp(params(41))-1);
residual(37)= lhs-rhs;
lhs =y(28);
rhs =y(15)+100*(exp(params(41))-1);
residual(38)= lhs-rhs;
lhs =y(29);
rhs =y(15)+100*(exp(params(41))-1);
residual(39)= lhs-rhs;
lhs =y(25);
rhs =y(15)+100*(exp(params(41))-1);
residual(40)= lhs-rhs;
lhs =y(27);
rhs =y(9)+params(43);
residual(41)= lhs-rhs;
lhs =y(26);
rhs =y(8)+100*(params(38)-1);
residual(42)= lhs-rhs;
lhs =y(24);
rhs =y(6)+params(19);
residual(43)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(43, 43);

  %
  % Jacobian matrix
  %

  g1(1,2)=1-(T26+T31);
  g1(1,8)=T19;
  g1(1,9)=(-T19);
  g1(1,15)=(-(T31+(-T26)));
  g1(1,17)=(-1);
  g1(2,15)=(-(T31+(-T26)));
  g1(2,17)=(-1);
  g1(2,31)=1-(T26+T31);
  g1(2,36)=(-T19);
  g1(3,3)=(-(T64*(1-T66-T70)));
  g1(3,14)=1;
  g1(3,15)=(-(T64*(T66-T70)));
  g1(3,21)=T64;
  g1(4,15)=(-(T64*(T66-T70)));
  g1(4,21)=T64;
  g1(4,32)=(-(T64*(1-T66-T70)));
  g1(4,40)=1;
  g1(5,8)=1;
  g1(5,9)=(-1);
  g1(5,10)=T93;
  g1(5,14)=T97-1;
  g1(5,17)=T101;
  g1(6,17)=T101;
  g1(6,36)=(-1);
  g1(6,37)=T93;
  g1(6,40)=T97-1;
  g1(7,1)=1;
  g1(7,4)=(-(params(10)*params(9)));
  g1(7,6)=(-(params(10)*(1-params(9))));
  g1(7,16)=(-((params(10)-1)/(1-params(9))));
  g1(8,16)=(-((params(10)-1)/(1-params(9))));
  g1(8,30)=1;
  g1(8,33)=(-(params(10)*params(9)));
  g1(8,35)=(-(params(10)*(1-params(9))));
  g1(9,4)=1;
  g1(9,5)=(-1);
  g1(9,11)=(-1);
  g1(9,15)=1;
  g1(10,15)=1;
  g1(10,33)=1;
  g1(10,34)=(-1);
  g1(10,38)=(-1);
  g1(11,10)=(-((1-params(18))/params(18)));
  g1(11,11)=1;
  g1(12,37)=(-((1-params(18))/params(18)));
  g1(12,38)=1;
  g1(13,3)=(-T154);
  g1(13,5)=1-(1-T154);
  g1(13,15)=1-T154;
  g1(13,21)=(-T163);
  g1(14,15)=1-T154;
  g1(14,21)=(-T163);
  g1(14,32)=(-T154);
  g1(14,34)=1-(1-T154);
  g1(15,4)=params(9);
  g1(15,6)=(-params(9));
  g1(15,7)=1;
  g1(15,12)=(-1);
  g1(16,33)=params(9);
  g1(16,35)=(-params(9));
  g1(16,39)=(-1);
  g1(17,7)=(-T199);
  g1(17,8)=1-(params(6)/(1+exp(params(41)*(1-params(17)))*params(37)*params(6))+T204);
  g1(17,19)=(-1);
  g1(18,4)=1;
  g1(18,6)=(-1);
  g1(18,10)=1;
  g1(18,12)=(-1);
  g1(19,33)=1;
  g1(19,35)=(-1);
  g1(19,37)=1;
  g1(19,39)=(-1);
  g1(20,2)=(-(T218+T220));
  g1(20,6)=params(12);
  g1(20,12)=(-1);
  g1(20,13)=1;
  g1(20,15)=T220;
  g1(21,15)=T220;
  g1(21,31)=(-(T218+T220));
  g1(21,35)=params(12);
  g1(21,39)=(-1);
  g1(22,8)=(-(T70+(-T257)+T66*(-params(8))));
  g1(22,12)=1-(T66+T70);
  g1(22,13)=(-T251);
  g1(22,15)=(-(T70+(-T66)));
  g1(22,20)=(-1);
  g1(23,1)=(-((1-params(4))*params(2)));
  g1(23,8)=(-((1-params(4))*params(1)));
  g1(23,9)=1-params(4);
  g1(23,22)=(-1);
  g1(23,30)=(-((1-params(4))*(-params(2))));
  g1(24,1)=1;
  g1(24,2)=(-(params(51)/params(50)));
  g1(24,3)=(-(params(49)/params(50)));
  g1(24,11)=(-(params(44)*params(47)/params(50)));
  g1(24,16)=(-(params(21)*1/(1-params(9))));
  g1(24,18)=(-params(21));
  g1(25,16)=(-(params(21)*1/(1-params(9))));
  g1(25,18)=(-params(21));
  g1(25,30)=1;
  g1(25,31)=(-(params(51)/params(50)));
  g1(25,32)=(-(params(49)/params(50)));
  g1(25,38)=(-(params(44)*params(47)/params(50)));
  g1(26,15)=1;
  g1(26,16)=(-(1/(1-params(9))*(params(27)-1)));
  g1(27,16)=1-params(27);
  g1(28,18)=1-params(32);
  g1(29,17)=1-params(28);
  g1(30,21)=1-params(31);
  g1(31,19)=1-params(29);
  g1(32,20)=1-params(30);
  g1(33,22)=1-params(36);
  g1(34,1)=(-1);
  g1(34,30)=1;
  g1(34,41)=1;
  g1(35,36)=(-1);
  g1(35,42)=0.25;
  g1(36,8)=1;
  g1(36,9)=(-1);
  g1(36,43)=0.25;
  g1(37,15)=(-1);
  g1(37,23)=1;
  g1(38,15)=(-1);
  g1(38,28)=1;
  g1(39,15)=(-1);
  g1(39,29)=1;
  g1(40,15)=(-1);
  g1(40,25)=1;
  g1(41,9)=(-1);
  g1(41,27)=1;
  g1(42,8)=(-1);
  g1(42,26)=1;
  g1(43,6)=(-1);
  g1(43,24)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],43,1849);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],43,79507);
end
end
end
end
