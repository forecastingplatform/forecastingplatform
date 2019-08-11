function [residual, g1, g2, g3] = US_DNGS14_20074_static(y, x, params)
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

residual = zeros( 47, 1);

%
% Model equations
%

T19 = (-(1-params(14)*exp((-params(45)))))/(params(20)*(1+params(14)*exp((-params(45)))));
T26 = params(14)*exp((-params(45)))/(1+params(14)*exp((-params(45))));
T31 = 1/(1+params(14)*exp((-params(45))));
T64 = params(19)*exp(2*params(45))*(1+params(41)*exp(params(45)*(1-params(20))));
T66 = 1/(1+params(41)*exp(params(45)*(1-params(20))));
T70 = params(41)*exp(params(45)*(1-params(20)))/(1+params(41)*exp(params(45)*(1-params(20))));
T95 = params(48)/(1+params(48)-params(23));
T99 = (1-params(23))/(1+params(48)-params(23));
T106 = (-(params(20)*(1+params(14)*exp((-params(45))))))/(1-params(14)*exp((-params(45))));
T147 = params(20)*(1+params(14)*exp((-params(45))))/(1-params(14)*exp((-params(45))));
T192 = params(53)/params(52);
T201 = (1+params(41)*exp(params(45)*(1-params(20))))*exp(2*params(45))*params(19)*params(53)/params(52);
T202 = y(24)*T201;
T237 = (1-exp(params(45)*(1-params(20)))*params(41)*params(5))*(1-params(5))/(params(5)*(1+(params(13)-1)*params(28)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T242 = params(41)*exp(params(45)*(1-params(20)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T256 = (-1)/(1-params(14)*exp((-params(45))));
T258 = params(14)*exp((-params(45)))/(1-params(14)*exp((-params(45))));
T289 = (-(1-exp(params(45)*(1-params(20)))*params(41)*params(7)))*(1-params(7))/(params(7)*(1+(params(25)-1)*params(29)))/(1+params(41)*exp(params(45)*(1-params(20))));
T295 = (1+exp(params(45)*(1-params(20)))*params(41)*params(8))/(1+params(41)*exp(params(45)*(1-params(20))));
lhs =y(2);
rhs =T19*(y(9)-y(8))+y(19)+T26*(y(2)-y(17))+T31*(y(2)+y(17));
residual(1)= lhs-rhs;
lhs =y(35);
rhs =y(19)+T19*y(40)+T26*(y(35)-y(17))+T31*(y(17)+y(35));
residual(2)= lhs-rhs;
lhs =y(14);
rhs =T64*(y(3)-T66*(y(3)-y(17))-T70*(y(17)+y(3))-y(24));
residual(3)= lhs-rhs;
lhs =y(44);
rhs =T64*(y(36)-T66*(y(36)-y(17))-T70*(y(17)+y(36))-y(24));
residual(4)= lhs-rhs;
lhs =y(15)-y(8);
rhs =T95*y(10)+y(14)*T99-y(14);
residual(5)= lhs-rhs;
lhs =y(15)-y(9);
rhs =y(19)*T106+params(9)*(y(14)+y(5)-y(16))+y(23);
residual(6)= lhs-rhs;
lhs =y(16);
rhs =(y(15)-y(8))*params(91)-(y(9)-y(8))*params(92)+(y(14)+y(5))*params(93)+y(16)*params(94)-y(23)*params(96)/params(84)-y(17)*params(10)*params(76)/params(75);
residual(7)= lhs-rhs;
lhs =T95*y(41)+y(44)*T99-y(44);
rhs =y(40)-y(19)*T147;
residual(8)= lhs-rhs;
lhs =y(1);
rhs =params(13)*(params(12)*y(4)+y(6)*(1-params(12)))+(params(13)-1)/(1-params(12))*y(18);
residual(9)= lhs-rhs;
lhs =y(34);
rhs =(params(13)-1)/(1-params(12))*y(18)+params(13)*(params(12)*y(37)+y(39)*(1-params(12)));
residual(10)= lhs-rhs;
lhs =y(4);
rhs =y(5)+y(11)-y(17);
residual(11)= lhs-rhs;
lhs =y(37);
rhs =y(42)-y(17)+y(38);
residual(12)= lhs-rhs;
lhs =y(11);
rhs =y(10)*(1-params(21))/params(21);
residual(13)= lhs-rhs;
lhs =y(42);
rhs =y(41)*(1-params(21))/params(21);
residual(14)= lhs-rhs;
lhs =y(5);
rhs =(1-T192)*(y(5)-y(17))+y(3)*T192+T202;
residual(15)= lhs-rhs;
lhs =y(38);
rhs =T202+(1-T192)*(y(38)-y(17))+y(36)*T192;
residual(16)= lhs-rhs;
lhs =y(7);
rhs =y(12)+y(6)*params(12)-params(12)*y(4);
residual(17)= lhs-rhs;
lhs =0;
rhs =y(43)+y(39)*params(12)-params(12)*y(37);
residual(18)= lhs-rhs;
lhs =y(8);
rhs =y(7)*T237+y(8)*params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))+y(8)*T242+y(21);
residual(19)= lhs-rhs;
lhs =y(4);
rhs =y(6)+y(12)-y(10);
residual(20)= lhs-rhs;
lhs =y(37);
rhs =y(39)+y(43)-y(41);
residual(21)= lhs-rhs;
lhs =y(13)-y(12);
rhs =y(2)*T256+y(2)*T258-y(17)*T258-y(6)*params(15);
residual(22)= lhs-rhs;
lhs =0;
rhs =y(43)+y(35)*T256+y(35)*T258-y(17)*T258-y(39)*params(15);
residual(23)= lhs-rhs;
lhs =y(12);
rhs =y(13)*T289-y(8)*T295+T66*(y(12)-y(17)-y(8)*params(8))+T70*(y(8)+y(17)+y(12))+y(22);
residual(24)= lhs-rhs;
lhs =y(9);
rhs =y(9)*params(4)+(1-params(4))*(y(8)*params(1)+params(2)*(y(1)-y(34)))+y(25);
residual(25)= lhs-rhs;
lhs =y(1);
rhs =params(24)*y(20)+y(2)*params(55)/params(54)+y(3)*params(53)/params(54)+y(11)*params(48)*params(51)/params(54)+y(18)*params(24)*1/(1-params(12));
residual(26)= lhs-rhs;
lhs =y(34);
rhs =y(18)*params(24)*1/(1-params(12))+params(24)*y(20)+y(35)*params(55)/params(54)+y(36)*params(53)/params(54)+y(42)*params(48)*params(51)/params(54);
residual(27)= lhs-rhs;
lhs =y(17);
rhs =y(18)*1/(1-params(12))*(params(30)-1)+1/(1-params(12))*x(1);
residual(28)= lhs-rhs;
lhs =y(18);
rhs =x(1)+y(18)*params(30);
residual(29)= lhs-rhs;
lhs =y(20);
rhs =y(20)*params(35)+x(2)+x(1)*params(38);
residual(30)= lhs-rhs;
lhs =y(19);
rhs =y(19)*params(31)+x(3);
residual(31)= lhs-rhs;
lhs =y(24);
rhs =y(24)*params(34)+x(4);
residual(32)= lhs-rhs;
lhs =y(21);
rhs =y(21)*params(32)+x(5)-x(5)*params(36);
residual(33)= lhs-rhs;
lhs =y(22);
rhs =y(22)*params(33)+x(6)-x(6)*params(37);
residual(34)= lhs-rhs;
lhs =y(25);
rhs =y(25)*params(40)+x(8);
residual(35)= lhs-rhs;
lhs =y(23);
rhs =y(23)*params(39)+x(7);
residual(36)= lhs-rhs;
lhs =y(45);
rhs =y(1)-y(34);
residual(37)= lhs-rhs;
lhs =y(46)/4;
rhs =y(40)+params(47)-100*(params(42)-1);
residual(38)= lhs-rhs;
lhs =y(47)/4;
rhs =y(9)-y(8)+params(47)-100*(params(42)-1);
residual(39)= lhs-rhs;
lhs =y(26);
rhs =y(17)+100*(exp(params(45))-1);
residual(40)= lhs-rhs;
lhs =y(31);
rhs =y(17)+100*(exp(params(45))-1);
residual(41)= lhs-rhs;
lhs =y(32);
rhs =y(17)+100*(exp(params(45))-1);
residual(42)= lhs-rhs;
lhs =y(28);
rhs =y(17)+100*(exp(params(45))-1);
residual(43)= lhs-rhs;
lhs =y(30);
rhs =y(9)+params(47);
residual(44)= lhs-rhs;
lhs =y(29);
rhs =y(8)+100*(params(42)-1);
residual(45)= lhs-rhs;
lhs =y(33);
rhs =y(15)-y(9)+100*log(params(43));
residual(46)= lhs-rhs;
lhs =y(27);
rhs =y(6)+params(22);
residual(47)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(47, 47);

  %
  % Jacobian matrix
  %

  g1(1,2)=1-(T26+T31);
  g1(1,8)=T19;
  g1(1,9)=(-T19);
  g1(1,17)=(-(T31+(-T26)));
  g1(1,19)=(-1);
  g1(2,17)=(-(T31+(-T26)));
  g1(2,19)=(-1);
  g1(2,35)=1-(T26+T31);
  g1(2,40)=(-T19);
  g1(3,3)=(-(T64*(1-T66-T70)));
  g1(3,14)=1;
  g1(3,17)=(-(T64*(T66-T70)));
  g1(3,24)=T64;
  g1(4,17)=(-(T64*(T66-T70)));
  g1(4,24)=T64;
  g1(4,36)=(-(T64*(1-T66-T70)));
  g1(4,44)=1;
  g1(5,8)=(-1);
  g1(5,10)=(-T95);
  g1(5,14)=(-(T99-1));
  g1(5,15)=1;
  g1(6,5)=(-params(9));
  g1(6,9)=(-1);
  g1(6,14)=(-params(9));
  g1(6,15)=1;
  g1(6,16)=params(9);
  g1(6,19)=(-T106);
  g1(6,23)=(-1);
  g1(7,5)=(-params(93));
  g1(7,8)=(-((-params(91))-(-params(92))));
  g1(7,9)=params(92);
  g1(7,14)=(-params(93));
  g1(7,15)=(-params(91));
  g1(7,16)=1-params(94);
  g1(7,17)=params(10)*params(76)/params(75);
  g1(7,23)=params(96)/params(84);
  g1(8,19)=T147;
  g1(8,40)=(-1);
  g1(8,41)=T95;
  g1(8,44)=T99-1;
  g1(9,1)=1;
  g1(9,4)=(-(params(13)*params(12)));
  g1(9,6)=(-(params(13)*(1-params(12))));
  g1(9,18)=(-((params(13)-1)/(1-params(12))));
  g1(10,18)=(-((params(13)-1)/(1-params(12))));
  g1(10,34)=1;
  g1(10,37)=(-(params(13)*params(12)));
  g1(10,39)=(-(params(13)*(1-params(12))));
  g1(11,4)=1;
  g1(11,5)=(-1);
  g1(11,11)=(-1);
  g1(11,17)=1;
  g1(12,17)=1;
  g1(12,37)=1;
  g1(12,38)=(-1);
  g1(12,42)=(-1);
  g1(13,10)=(-((1-params(21))/params(21)));
  g1(13,11)=1;
  g1(14,41)=(-((1-params(21))/params(21)));
  g1(14,42)=1;
  g1(15,3)=(-T192);
  g1(15,5)=1-(1-T192);
  g1(15,17)=1-T192;
  g1(15,24)=(-T201);
  g1(16,17)=1-T192;
  g1(16,24)=(-T201);
  g1(16,36)=(-T192);
  g1(16,38)=1-(1-T192);
  g1(17,4)=params(12);
  g1(17,6)=(-params(12));
  g1(17,7)=1;
  g1(17,12)=(-1);
  g1(18,37)=params(12);
  g1(18,39)=(-params(12));
  g1(18,43)=(-1);
  g1(19,7)=(-T237);
  g1(19,8)=1-(params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))+T242);
  g1(19,21)=(-1);
  g1(20,4)=1;
  g1(20,6)=(-1);
  g1(20,10)=1;
  g1(20,12)=(-1);
  g1(21,37)=1;
  g1(21,39)=(-1);
  g1(21,41)=1;
  g1(21,43)=(-1);
  g1(22,2)=(-(T256+T258));
  g1(22,6)=params(15);
  g1(22,12)=(-1);
  g1(22,13)=1;
  g1(22,17)=T258;
  g1(23,17)=T258;
  g1(23,35)=(-(T256+T258));
  g1(23,39)=params(15);
  g1(23,43)=(-1);
  g1(24,8)=(-(T70+(-T295)+T66*(-params(8))));
  g1(24,12)=1-(T66+T70);
  g1(24,13)=(-T289);
  g1(24,17)=(-(T70+(-T66)));
  g1(24,22)=(-1);
  g1(25,1)=(-((1-params(4))*params(2)));
  g1(25,8)=(-((1-params(4))*params(1)));
  g1(25,9)=1-params(4);
  g1(25,25)=(-1);
  g1(25,34)=(-((1-params(4))*(-params(2))));
  g1(26,1)=1;
  g1(26,2)=(-(params(55)/params(54)));
  g1(26,3)=(-(params(53)/params(54)));
  g1(26,11)=(-(params(48)*params(51)/params(54)));
  g1(26,18)=(-(params(24)*1/(1-params(12))));
  g1(26,20)=(-params(24));
  g1(27,18)=(-(params(24)*1/(1-params(12))));
  g1(27,20)=(-params(24));
  g1(27,34)=1;
  g1(27,35)=(-(params(55)/params(54)));
  g1(27,36)=(-(params(53)/params(54)));
  g1(27,42)=(-(params(48)*params(51)/params(54)));
  g1(28,17)=1;
  g1(28,18)=(-(1/(1-params(12))*(params(30)-1)));
  g1(29,18)=1-params(30);
  g1(30,20)=1-params(35);
  g1(31,19)=1-params(31);
  g1(32,24)=1-params(34);
  g1(33,21)=1-params(32);
  g1(34,22)=1-params(33);
  g1(35,25)=1-params(40);
  g1(36,23)=1-params(39);
  g1(37,1)=(-1);
  g1(37,34)=1;
  g1(37,45)=1;
  g1(38,40)=(-1);
  g1(38,46)=0.25;
  g1(39,8)=1;
  g1(39,9)=(-1);
  g1(39,47)=0.25;
  g1(40,17)=(-1);
  g1(40,26)=1;
  g1(41,17)=(-1);
  g1(41,31)=1;
  g1(42,17)=(-1);
  g1(42,32)=1;
  g1(43,17)=(-1);
  g1(43,28)=1;
  g1(44,9)=(-1);
  g1(44,30)=1;
  g1(45,8)=(-1);
  g1(45,29)=1;
  g1(46,9)=1;
  g1(46,15)=(-1);
  g1(46,33)=1;
  g1(47,6)=(-1);
  g1(47,27)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],47,2209);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],47,103823);
end
end
end
end
