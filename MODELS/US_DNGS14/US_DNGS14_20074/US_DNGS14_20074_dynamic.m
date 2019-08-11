function [residual, g1, g2, g3] = US_DNGS14_20074_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(47, 1);
T19 = (-(1-params(14)*exp((-params(45)))))/(params(20)*(1+params(14)*exp((-params(45)))));
T26 = params(14)*exp((-params(45)))/(1+params(14)*exp((-params(45))));
T32 = 1/(1+params(14)*exp((-params(45))));
T41 = (params(20)-1)*params(56)/(params(20)*(1+params(14)*exp((-params(45)))));
T77 = params(19)*exp(2*params(45))*(1+params(41)*exp(params(45)*(1-params(20))));
T79 = 1/(1+params(41)*exp(params(45)*(1-params(20))));
T84 = params(41)*exp(params(45)*(1-params(20)))/(1+params(41)*exp(params(45)*(1-params(20))));
T113 = params(48)/(1+params(48)-params(23));
T117 = (1-params(23))/(1+params(48)-params(23));
T126 = (-(params(20)*(1+params(14)*exp((-params(45))))))/(1-params(14)*exp((-params(45))));
T174 = params(20)*(1+params(14)*exp((-params(45))))/(1-params(14)*exp((-params(45))));
T220 = params(53)/params(52);
T229 = (1+params(41)*exp(params(45)*(1-params(20))))*exp(2*params(45))*params(19)*params(53)/params(52);
T230 = y(45)*T229;
T266 = (1-exp(params(45)*(1-params(20)))*params(41)*params(5))*(1-params(5))/(params(5)*(1+(params(13)-1)*params(28)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T272 = params(41)*exp(params(45)*(1-params(20)))/(1+exp(params(45)*(1-params(20)))*params(41)*params(6));
T286 = (-1)/(1-params(14)*exp((-params(45))));
T288 = params(14)*exp((-params(45)))/(1-params(14)*exp((-params(45))));
T319 = (-(1-exp(params(45)*(1-params(20)))*params(41)*params(7)))*(1-params(7))/(params(7)*(1+(params(25)-1)*params(29)))/(1+params(41)*exp(params(45)*(1-params(20))));
T325 = (1+exp(params(45)*(1-params(20)))*params(41)*params(8))/(1+params(41)*exp(params(45)*(1-params(20))));
T379 = 1/(1-params(12));
lhs =y(23);
rhs =T19*(y(30)-y(72))+y(40)+T26*(y(2)-y(38))+T32*(y(69)+y(75))+T41*(y(27)-y(71));
residual(1)= lhs-rhs;
lhs =y(56);
rhs =y(40)+T19*y(61)+T26*(y(19)-y(38))+T32*(y(75)+y(76))+T41*(y(60)-y(78));
residual(2)= lhs-rhs;
lhs =y(35);
rhs =T77*(y(24)-T79*(y(3)-y(38))-T84*(y(75)+y(70))-y(45));
residual(3)= lhs-rhs;
lhs =y(65);
rhs =T77*(y(57)-T79*(y(20)-y(38))-T84*(y(75)+y(77))-y(45));
residual(4)= lhs-rhs;
lhs =y(36)-y(29);
rhs =T113*y(31)+y(35)*T117-y(8);
residual(5)= lhs-rhs;
lhs =y(74)-y(30);
rhs =y(40)*T126+params(9)*(y(35)+y(26)-y(37))+y(44);
residual(6)= lhs-rhs;
lhs =y(37);
rhs =(y(36)-y(29))*params(91)-params(92)*(y(6)-y(29))+params(93)*(y(8)+y(4))+params(94)*y(9)-params(96)/params(84)*y(15)-y(38)*params(10)*params(76)/params(75);
residual(7)= lhs-rhs;
lhs =T113*y(79)+T117*y(80)-y(65);
rhs =y(61)-y(40)*T174;
residual(8)= lhs-rhs;
lhs =y(22);
rhs =params(13)*(params(12)*y(25)+y(27)*(1-params(12)))+(params(13)-1)/(1-params(12))*y(39);
residual(9)= lhs-rhs;
lhs =y(55);
rhs =(params(13)-1)/(1-params(12))*y(39)+params(13)*(params(12)*y(58)+y(60)*(1-params(12)));
residual(10)= lhs-rhs;
lhs =y(25);
rhs =y(4)+y(32)-y(38);
residual(11)= lhs-rhs;
lhs =y(58);
rhs =y(63)-y(38)+y(21);
residual(12)= lhs-rhs;
lhs =y(32);
rhs =y(31)*(1-params(21))/params(21);
residual(13)= lhs-rhs;
lhs =y(63);
rhs =(1-params(21))/params(21)*y(62);
residual(14)= lhs-rhs;
lhs =y(26);
rhs =(1-T220)*(y(4)-y(38))+y(24)*T220+T230;
residual(15)= lhs-rhs;
lhs =y(59);
rhs =T230+(1-T220)*(y(21)-y(38))+y(57)*T220;
residual(16)= lhs-rhs;
lhs =y(28);
rhs =y(33)+y(27)*params(12)-params(12)*y(25);
residual(17)= lhs-rhs;
lhs =0;
rhs =y(64)+y(60)*params(12)-params(12)*y(58);
residual(18)= lhs-rhs;
lhs =y(29);
rhs =y(28)*T266+params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))*y(5)+y(72)*T272+y(42);
residual(19)= lhs-rhs;
lhs =y(25);
rhs =y(27)+y(33)-y(31);
residual(20)= lhs-rhs;
lhs =y(58);
rhs =y(60)+y(64)-y(62);
residual(21)= lhs-rhs;
lhs =y(34)-y(33);
rhs =y(23)*T286+y(2)*T288-y(38)*T288-y(27)*params(15);
residual(22)= lhs-rhs;
lhs =0;
rhs =y(64)+y(56)*T286+y(19)*T288-y(38)*T288-y(60)*params(15);
residual(23)= lhs-rhs;
lhs =y(33);
rhs =y(34)*T319-y(29)*T325+T79*(y(7)-y(38)-y(5)*params(8))+T84*(y(72)+y(75)+y(73))+y(43);
residual(24)= lhs-rhs;
lhs =y(30);
rhs =y(6)*params(4)+(1-params(4))*(y(29)*params(1)+params(2)*(y(22)-y(55)))+params(3)*(y(22)-y(55)-(y(1)-y(18)))+y(46);
residual(25)= lhs-rhs;
lhs =y(22);
rhs =params(24)*y(41)+y(23)*params(55)/params(54)+y(24)*params(53)/params(54)+y(32)*params(48)*params(51)/params(54)+y(39)*params(24)*T379;
residual(26)= lhs-rhs;
lhs =y(55);
rhs =y(39)*params(24)*T379+params(24)*y(41)+y(56)*params(55)/params(54)+y(57)*params(53)/params(54)+y(63)*params(48)*params(51)/params(54);
residual(27)= lhs-rhs;
lhs =y(38);
rhs =T379*(params(30)-1)*y(10)+T379*x(it_, 1);
residual(28)= lhs-rhs;
lhs =y(39);
rhs =x(it_, 1)+params(30)*y(10);
residual(29)= lhs-rhs;
lhs =y(41);
rhs =params(35)*y(12)+x(it_, 2)+x(it_, 1)*params(38);
residual(30)= lhs-rhs;
lhs =y(40);
rhs =params(31)*y(11)+x(it_, 3);
residual(31)= lhs-rhs;
lhs =y(45);
rhs =params(34)*y(16)+x(it_, 4);
residual(32)= lhs-rhs;
lhs =y(42);
rhs =params(32)*y(13)+x(it_, 5)-params(36)*x(it_-1, 5);
residual(33)= lhs-rhs;
lhs =y(43);
rhs =params(33)*y(14)+x(it_, 6)-params(37)*x(it_-1, 6);
residual(34)= lhs-rhs;
lhs =y(46);
rhs =params(40)*y(17)+x(it_, 8);
residual(35)= lhs-rhs;
lhs =y(44);
rhs =y(15)*params(39)+x(it_, 7);
residual(36)= lhs-rhs;
lhs =y(66);
rhs =y(22)-y(55);
residual(37)= lhs-rhs;
lhs =y(67)/4;
rhs =y(61)+params(47)-100*(params(42)-1);
residual(38)= lhs-rhs;
lhs =y(68)/4;
rhs =y(30)-y(72)+params(47)-100*(params(42)-1);
residual(39)= lhs-rhs;
lhs =y(47);
rhs =y(38)+y(22)-y(1)+100*(exp(params(45))-1);
residual(40)= lhs-rhs;
lhs =y(52);
rhs =100*(exp(params(45))-1)+y(38)+y(23)-y(2);
residual(41)= lhs-rhs;
lhs =y(53);
rhs =100*(exp(params(45))-1)+y(38)+y(24)-y(3);
residual(42)= lhs-rhs;
lhs =y(49);
rhs =100*(exp(params(45))-1)+y(38)+y(33)-y(7);
residual(43)= lhs-rhs;
lhs =y(51);
rhs =y(30)+params(47);
residual(44)= lhs-rhs;
lhs =y(50);
rhs =y(29)+100*(params(42)-1);
residual(45)= lhs-rhs;
lhs =y(54);
rhs =y(74)-y(30)+100*log(params(43));
residual(46)= lhs-rhs;
lhs =y(48);
rhs =y(27)+params(22);
residual(47)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(47, 88);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-T26);
  g1(1,23)=1;
  g1(1,69)=(-T32);
  g1(1,27)=(-T41);
  g1(1,71)=T41;
  g1(1,72)=T19;
  g1(1,30)=(-T19);
  g1(1,38)=T26;
  g1(1,75)=(-T32);
  g1(1,40)=(-1);
  g1(2,38)=T26;
  g1(2,75)=(-T32);
  g1(2,40)=(-1);
  g1(2,19)=(-T26);
  g1(2,56)=1;
  g1(2,76)=(-T32);
  g1(2,60)=(-T41);
  g1(2,78)=T41;
  g1(2,61)=(-T19);
  g1(3,3)=(-(T77*(-T79)));
  g1(3,24)=(-T77);
  g1(3,70)=(-(T77*(-T84)));
  g1(3,35)=1;
  g1(3,38)=(-(T77*T79));
  g1(3,75)=(-(T77*(-T84)));
  g1(3,45)=T77;
  g1(4,38)=(-(T77*T79));
  g1(4,75)=(-(T77*(-T84)));
  g1(4,45)=T77;
  g1(4,20)=(-(T77*(-T79)));
  g1(4,57)=(-T77);
  g1(4,77)=(-(T77*(-T84)));
  g1(4,65)=1;
  g1(5,29)=(-1);
  g1(5,31)=(-T113);
  g1(5,8)=1;
  g1(5,35)=(-T117);
  g1(5,36)=1;
  g1(6,26)=(-params(9));
  g1(6,30)=(-1);
  g1(6,35)=(-params(9));
  g1(6,74)=1;
  g1(6,37)=params(9);
  g1(6,40)=(-T126);
  g1(6,44)=(-1);
  g1(7,4)=(-params(93));
  g1(7,29)=(-((-params(91))-(-params(92))));
  g1(7,6)=params(92);
  g1(7,8)=(-params(93));
  g1(7,36)=(-params(91));
  g1(7,9)=(-params(94));
  g1(7,37)=1;
  g1(7,38)=params(10)*params(76)/params(75);
  g1(7,15)=params(96)/params(84);
  g1(8,40)=T174;
  g1(8,61)=(-1);
  g1(8,79)=T113;
  g1(8,65)=(-1);
  g1(8,80)=T117;
  g1(9,22)=1;
  g1(9,25)=(-(params(13)*params(12)));
  g1(9,27)=(-(params(13)*(1-params(12))));
  g1(9,39)=(-((params(13)-1)/(1-params(12))));
  g1(10,39)=(-((params(13)-1)/(1-params(12))));
  g1(10,55)=1;
  g1(10,58)=(-(params(13)*params(12)));
  g1(10,60)=(-(params(13)*(1-params(12))));
  g1(11,25)=1;
  g1(11,4)=(-1);
  g1(11,32)=(-1);
  g1(11,38)=1;
  g1(12,38)=1;
  g1(12,58)=1;
  g1(12,21)=(-1);
  g1(12,63)=(-1);
  g1(13,31)=(-((1-params(21))/params(21)));
  g1(13,32)=1;
  g1(14,62)=(-((1-params(21))/params(21)));
  g1(14,63)=1;
  g1(15,24)=(-T220);
  g1(15,4)=(-(1-T220));
  g1(15,26)=1;
  g1(15,38)=1-T220;
  g1(15,45)=(-T229);
  g1(16,38)=1-T220;
  g1(16,45)=(-T229);
  g1(16,57)=(-T220);
  g1(16,21)=(-(1-T220));
  g1(16,59)=1;
  g1(17,25)=params(12);
  g1(17,27)=(-params(12));
  g1(17,28)=1;
  g1(17,33)=(-1);
  g1(18,58)=params(12);
  g1(18,60)=(-params(12));
  g1(18,64)=(-1);
  g1(19,28)=(-T266);
  g1(19,5)=(-(params(6)/(1+exp(params(45)*(1-params(20)))*params(41)*params(6))));
  g1(19,29)=1;
  g1(19,72)=(-T272);
  g1(19,42)=(-1);
  g1(20,25)=1;
  g1(20,27)=(-1);
  g1(20,31)=1;
  g1(20,33)=(-1);
  g1(21,58)=1;
  g1(21,60)=(-1);
  g1(21,62)=1;
  g1(21,64)=(-1);
  g1(22,2)=(-T288);
  g1(22,23)=(-T286);
  g1(22,27)=params(15);
  g1(22,33)=(-1);
  g1(22,34)=1;
  g1(22,38)=T288;
  g1(23,38)=T288;
  g1(23,19)=(-T288);
  g1(23,56)=(-T286);
  g1(23,60)=params(15);
  g1(23,64)=(-1);
  g1(24,5)=(-(T79*(-params(8))));
  g1(24,29)=T325;
  g1(24,72)=(-T84);
  g1(24,7)=(-T79);
  g1(24,33)=1;
  g1(24,73)=(-T84);
  g1(24,34)=(-T319);
  g1(24,38)=T79;
  g1(24,75)=(-T84);
  g1(24,43)=(-1);
  g1(25,1)=params(3);
  g1(25,22)=(-(params(3)+(1-params(4))*params(2)));
  g1(25,29)=(-((1-params(4))*params(1)));
  g1(25,6)=(-params(4));
  g1(25,30)=1;
  g1(25,46)=(-1);
  g1(25,18)=(-params(3));
  g1(25,55)=(-((1-params(4))*(-params(2))-params(3)));
  g1(26,22)=1;
  g1(26,23)=(-(params(55)/params(54)));
  g1(26,24)=(-(params(53)/params(54)));
  g1(26,32)=(-(params(48)*params(51)/params(54)));
  g1(26,39)=(-(params(24)*T379));
  g1(26,41)=(-params(24));
  g1(27,39)=(-(params(24)*T379));
  g1(27,41)=(-params(24));
  g1(27,55)=1;
  g1(27,56)=(-(params(55)/params(54)));
  g1(27,57)=(-(params(53)/params(54)));
  g1(27,63)=(-(params(48)*params(51)/params(54)));
  g1(28,38)=1;
  g1(28,10)=(-(T379*(params(30)-1)));
  g1(28,81)=(-T379);
  g1(29,10)=(-params(30));
  g1(29,39)=1;
  g1(29,81)=(-1);
  g1(30,12)=(-params(35));
  g1(30,41)=1;
  g1(30,81)=(-params(38));
  g1(30,82)=(-1);
  g1(31,11)=(-params(31));
  g1(31,40)=1;
  g1(31,83)=(-1);
  g1(32,16)=(-params(34));
  g1(32,45)=1;
  g1(32,84)=(-1);
  g1(33,13)=(-params(32));
  g1(33,42)=1;
  g1(33,85)=params(36);
  g1(33,85)=(-1);
  g1(34,14)=(-params(33));
  g1(34,43)=1;
  g1(34,86)=params(37);
  g1(34,86)=(-1);
  g1(35,17)=(-params(40));
  g1(35,46)=1;
  g1(35,88)=(-1);
  g1(36,15)=(-params(39));
  g1(36,44)=1;
  g1(36,87)=(-1);
  g1(37,22)=(-1);
  g1(37,55)=1;
  g1(37,66)=1;
  g1(38,61)=(-1);
  g1(38,67)=0.25;
  g1(39,72)=1;
  g1(39,30)=(-1);
  g1(39,68)=0.25;
  g1(40,1)=1;
  g1(40,22)=(-1);
  g1(40,38)=(-1);
  g1(40,47)=1;
  g1(41,2)=1;
  g1(41,23)=(-1);
  g1(41,38)=(-1);
  g1(41,52)=1;
  g1(42,3)=1;
  g1(42,24)=(-1);
  g1(42,38)=(-1);
  g1(42,53)=1;
  g1(43,7)=1;
  g1(43,33)=(-1);
  g1(43,38)=(-1);
  g1(43,49)=1;
  g1(44,30)=(-1);
  g1(44,51)=1;
  g1(45,29)=(-1);
  g1(45,50)=1;
  g1(46,30)=1;
  g1(46,74)=(-1);
  g1(46,54)=1;
  g1(47,27)=(-1);
  g1(47,48)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],47,7744);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],47,681472);
end
end
end
end
