function [residual, g1, g2, g3] = US_DNGS14SW_20074_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(43, 1);
T19 = (-(1-params(11)*exp((-params(41)))))/(params(17)*(1+params(11)*exp((-params(41)))));
T26 = params(11)*exp((-params(41)))/(1+params(11)*exp((-params(41))));
T32 = 1/(1+params(11)*exp((-params(41))));
T41 = (params(17)-1)*params(52)/(params(17)*(1+params(11)*exp((-params(41)))));
T77 = params(16)*exp(2*params(41))*(1+params(37)*exp(params(41)*(1-params(17))));
T79 = 1/(1+params(37)*exp(params(41)*(1-params(17))));
T84 = params(37)*exp(params(41)*(1-params(17)))/(1+params(37)*exp(params(41)*(1-params(17))));
T110 = params(44)/(1+params(44)-params(20));
T114 = (1-params(20))/(1+params(44)-params(20));
T119 = params(17)*(1+params(11)*exp((-params(41))))/(1-params(11)*exp((-params(41))));
T120 = y(35)*T119;
T176 = params(49)/params(48);
T185 = (1+params(37)*exp(params(41)*(1-params(17))))*exp(2*params(41))*params(16)*params(49)/params(48);
T186 = y(39)*T185;
T223 = (1-exp(params(41)*(1-params(17)))*params(37)*params(5))*(1-params(5))/(params(5)*(1+(params(10)-1)*params(25)))/(1+exp(params(41)*(1-params(17)))*params(37)*params(6));
T229 = params(37)*exp(params(41)*(1-params(17)))/(1+exp(params(41)*(1-params(17)))*params(37)*params(6));
T243 = (-1)/(1-params(11)*exp((-params(41))));
T245 = params(11)*exp((-params(41)))/(1-params(11)*exp((-params(41))));
T276 = (-(1-exp(params(41)*(1-params(17)))*params(37)*params(7)))*(1-params(7))/(params(7)*(1+(params(22)-1)*params(26)))/(1+params(37)*exp(params(41)*(1-params(17))));
T282 = (1+exp(params(41)*(1-params(17)))*params(37)*params(8))/(1+params(37)*exp(params(41)*(1-params(17))));
T337 = 1/(1-params(9));
lhs =y(20);
rhs =T19*(y(27)-y(65))+y(35)+T26*(y(2)-y(33))+T32*(y(62)+y(69))+T41*(y(24)-y(64));
residual(1)= lhs-rhs;
lhs =y(49);
rhs =y(35)+T19*y(54)+T26*(y(16)-y(33))+T32*(y(69)+y(70))+T41*(y(53)-y(72));
residual(2)= lhs-rhs;
lhs =y(32);
rhs =T77*(y(21)-T79*(y(3)-y(33))-T84*(y(69)+y(63))-y(39));
residual(3)= lhs-rhs;
lhs =y(58);
rhs =T77*(y(50)-T79*(y(17)-y(33))-T84*(y(69)+y(71))-y(39));
residual(4)= lhs-rhs;
lhs =T110*y(66)+T114*y(68)-y(32);
rhs =y(27)-y(65)-T120;
residual(5)= lhs-rhs;
lhs =T110*y(73)+T114*y(74)-y(58);
rhs =y(54)-T120;
residual(6)= lhs-rhs;
lhs =y(19);
rhs =params(10)*(params(9)*y(22)+y(24)*(1-params(9)))+(params(10)-1)/(1-params(9))*y(34);
residual(7)= lhs-rhs;
lhs =y(48);
rhs =(params(10)-1)/(1-params(9))*y(34)+params(10)*(params(9)*y(51)+y(53)*(1-params(9)));
residual(8)= lhs-rhs;
lhs =y(22);
rhs =y(29)-y(33)+y(4);
residual(9)= lhs-rhs;
lhs =y(51);
rhs =y(56)-y(33)+y(18);
residual(10)= lhs-rhs;
lhs =y(29);
rhs =(1-params(18))/params(18)*y(28);
residual(11)= lhs-rhs;
lhs =y(56);
rhs =(1-params(18))/params(18)*y(55);
residual(12)= lhs-rhs;
lhs =y(23);
rhs =(1-T176)*(y(4)-y(33))+y(21)*T176+T186;
residual(13)= lhs-rhs;
lhs =y(52);
rhs =T186+(1-T176)*(y(18)-y(33))+y(50)*T176;
residual(14)= lhs-rhs;
lhs =y(25);
rhs =y(30)+y(24)*params(9)-params(9)*y(22);
residual(15)= lhs-rhs;
lhs =0;
rhs =y(57)+y(53)*params(9)-params(9)*y(51);
residual(16)= lhs-rhs;
lhs =y(26);
rhs =y(25)*T223+params(6)/(1+exp(params(41)*(1-params(17)))*params(37)*params(6))*y(5)+y(65)*T229+y(37);
residual(17)= lhs-rhs;
lhs =y(22);
rhs =y(24)+y(30)-y(28);
residual(18)= lhs-rhs;
lhs =y(51);
rhs =y(53)+y(57)-y(55);
residual(19)= lhs-rhs;
lhs =y(31)-y(30);
rhs =y(20)*T243+y(2)*T245-y(33)*T245-y(24)*params(12);
residual(20)= lhs-rhs;
lhs =0;
rhs =y(57)+y(49)*T243+y(16)*T245-y(33)*T245-y(53)*params(12);
residual(21)= lhs-rhs;
lhs =y(30);
rhs =y(31)*T276-y(26)*T282+T79*(y(7)-y(33)-y(5)*params(8))+T84*(y(65)+y(69)+y(67))+y(38);
residual(22)= lhs-rhs;
lhs =y(27);
rhs =params(4)*y(6)+(1-params(4))*(y(26)*params(1)+params(2)*(y(19)-y(48)))+params(3)*(y(19)-y(48)-(y(1)-y(15)))+y(40);
residual(23)= lhs-rhs;
lhs =y(19);
rhs =params(21)*y(36)+y(20)*params(51)/params(50)+y(21)*params(49)/params(50)+y(29)*params(44)*params(47)/params(50)+y(34)*params(21)*T337;
residual(24)= lhs-rhs;
lhs =y(48);
rhs =y(34)*params(21)*T337+params(21)*y(36)+y(49)*params(51)/params(50)+y(50)*params(49)/params(50)+y(56)*params(44)*params(47)/params(50);
residual(25)= lhs-rhs;
lhs =y(33);
rhs =T337*(params(27)-1)*y(8)+T337*x(it_, 1);
residual(26)= lhs-rhs;
lhs =y(34);
rhs =x(it_, 1)+params(27)*y(8);
residual(27)= lhs-rhs;
lhs =y(36);
rhs =params(32)*y(10)+x(it_, 2)+x(it_, 1)*params(35);
residual(28)= lhs-rhs;
lhs =y(35);
rhs =params(28)*y(9)+x(it_, 3);
residual(29)= lhs-rhs;
lhs =y(39);
rhs =params(31)*y(13)+x(it_, 4);
residual(30)= lhs-rhs;
lhs =y(37);
rhs =params(29)*y(11)+x(it_, 5)-params(33)*x(it_-1, 5);
residual(31)= lhs-rhs;
lhs =y(38);
rhs =params(30)*y(12)+x(it_, 6)-params(34)*x(it_-1, 6);
residual(32)= lhs-rhs;
lhs =y(40);
rhs =params(36)*y(14)+x(it_, 7);
residual(33)= lhs-rhs;
lhs =y(59);
rhs =y(19)-y(48);
residual(34)= lhs-rhs;
lhs =y(60)/4;
rhs =y(54)+params(43)-100*(params(38)-1);
residual(35)= lhs-rhs;
lhs =y(61)/4;
rhs =y(27)-y(65)+params(43)-100*(params(38)-1);
residual(36)= lhs-rhs;
lhs =y(41);
rhs =y(33)+y(19)-y(1)+100*(exp(params(41))-1);
residual(37)= lhs-rhs;
lhs =y(46);
rhs =100*(exp(params(41))-1)+y(33)+y(20)-y(2);
residual(38)= lhs-rhs;
lhs =y(47);
rhs =100*(exp(params(41))-1)+y(33)+y(21)-y(3);
residual(39)= lhs-rhs;
lhs =y(43);
rhs =100*(exp(params(41))-1)+y(33)+y(30)-y(7);
residual(40)= lhs-rhs;
lhs =y(45);
rhs =y(27)+params(43);
residual(41)= lhs-rhs;
lhs =y(44);
rhs =y(26)+100*(params(38)-1);
residual(42)= lhs-rhs;
lhs =y(42);
rhs =y(24)+params(19);
residual(43)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(43, 81);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-T26);
  g1(1,20)=1;
  g1(1,62)=(-T32);
  g1(1,24)=(-T41);
  g1(1,64)=T41;
  g1(1,65)=T19;
  g1(1,27)=(-T19);
  g1(1,33)=T26;
  g1(1,69)=(-T32);
  g1(1,35)=(-1);
  g1(2,33)=T26;
  g1(2,69)=(-T32);
  g1(2,35)=(-1);
  g1(2,16)=(-T26);
  g1(2,49)=1;
  g1(2,70)=(-T32);
  g1(2,53)=(-T41);
  g1(2,72)=T41;
  g1(2,54)=(-T19);
  g1(3,3)=(-(T77*(-T79)));
  g1(3,21)=(-T77);
  g1(3,63)=(-(T77*(-T84)));
  g1(3,32)=1;
  g1(3,33)=(-(T77*T79));
  g1(3,69)=(-(T77*(-T84)));
  g1(3,39)=T77;
  g1(4,33)=(-(T77*T79));
  g1(4,69)=(-(T77*(-T84)));
  g1(4,39)=T77;
  g1(4,17)=(-(T77*(-T79)));
  g1(4,50)=(-T77);
  g1(4,71)=(-(T77*(-T84)));
  g1(4,58)=1;
  g1(5,65)=1;
  g1(5,27)=(-1);
  g1(5,66)=T110;
  g1(5,32)=(-1);
  g1(5,68)=T114;
  g1(5,35)=T119;
  g1(6,35)=T119;
  g1(6,54)=(-1);
  g1(6,73)=T110;
  g1(6,58)=(-1);
  g1(6,74)=T114;
  g1(7,19)=1;
  g1(7,22)=(-(params(10)*params(9)));
  g1(7,24)=(-(params(10)*(1-params(9))));
  g1(7,34)=(-((params(10)-1)/(1-params(9))));
  g1(8,34)=(-((params(10)-1)/(1-params(9))));
  g1(8,48)=1;
  g1(8,51)=(-(params(10)*params(9)));
  g1(8,53)=(-(params(10)*(1-params(9))));
  g1(9,22)=1;
  g1(9,4)=(-1);
  g1(9,29)=(-1);
  g1(9,33)=1;
  g1(10,33)=1;
  g1(10,51)=1;
  g1(10,18)=(-1);
  g1(10,56)=(-1);
  g1(11,28)=(-((1-params(18))/params(18)));
  g1(11,29)=1;
  g1(12,55)=(-((1-params(18))/params(18)));
  g1(12,56)=1;
  g1(13,21)=(-T176);
  g1(13,4)=(-(1-T176));
  g1(13,23)=1;
  g1(13,33)=1-T176;
  g1(13,39)=(-T185);
  g1(14,33)=1-T176;
  g1(14,39)=(-T185);
  g1(14,50)=(-T176);
  g1(14,18)=(-(1-T176));
  g1(14,52)=1;
  g1(15,22)=params(9);
  g1(15,24)=(-params(9));
  g1(15,25)=1;
  g1(15,30)=(-1);
  g1(16,51)=params(9);
  g1(16,53)=(-params(9));
  g1(16,57)=(-1);
  g1(17,25)=(-T223);
  g1(17,5)=(-(params(6)/(1+exp(params(41)*(1-params(17)))*params(37)*params(6))));
  g1(17,26)=1;
  g1(17,65)=(-T229);
  g1(17,37)=(-1);
  g1(18,22)=1;
  g1(18,24)=(-1);
  g1(18,28)=1;
  g1(18,30)=(-1);
  g1(19,51)=1;
  g1(19,53)=(-1);
  g1(19,55)=1;
  g1(19,57)=(-1);
  g1(20,2)=(-T245);
  g1(20,20)=(-T243);
  g1(20,24)=params(12);
  g1(20,30)=(-1);
  g1(20,31)=1;
  g1(20,33)=T245;
  g1(21,33)=T245;
  g1(21,16)=(-T245);
  g1(21,49)=(-T243);
  g1(21,53)=params(12);
  g1(21,57)=(-1);
  g1(22,5)=(-(T79*(-params(8))));
  g1(22,26)=T282;
  g1(22,65)=(-T84);
  g1(22,7)=(-T79);
  g1(22,30)=1;
  g1(22,67)=(-T84);
  g1(22,31)=(-T276);
  g1(22,33)=T79;
  g1(22,69)=(-T84);
  g1(22,38)=(-1);
  g1(23,1)=params(3);
  g1(23,19)=(-(params(3)+(1-params(4))*params(2)));
  g1(23,26)=(-((1-params(4))*params(1)));
  g1(23,6)=(-params(4));
  g1(23,27)=1;
  g1(23,40)=(-1);
  g1(23,15)=(-params(3));
  g1(23,48)=(-((1-params(4))*(-params(2))-params(3)));
  g1(24,19)=1;
  g1(24,20)=(-(params(51)/params(50)));
  g1(24,21)=(-(params(49)/params(50)));
  g1(24,29)=(-(params(44)*params(47)/params(50)));
  g1(24,34)=(-(params(21)*T337));
  g1(24,36)=(-params(21));
  g1(25,34)=(-(params(21)*T337));
  g1(25,36)=(-params(21));
  g1(25,48)=1;
  g1(25,49)=(-(params(51)/params(50)));
  g1(25,50)=(-(params(49)/params(50)));
  g1(25,56)=(-(params(44)*params(47)/params(50)));
  g1(26,33)=1;
  g1(26,8)=(-(T337*(params(27)-1)));
  g1(26,75)=(-T337);
  g1(27,8)=(-params(27));
  g1(27,34)=1;
  g1(27,75)=(-1);
  g1(28,10)=(-params(32));
  g1(28,36)=1;
  g1(28,75)=(-params(35));
  g1(28,76)=(-1);
  g1(29,9)=(-params(28));
  g1(29,35)=1;
  g1(29,77)=(-1);
  g1(30,13)=(-params(31));
  g1(30,39)=1;
  g1(30,78)=(-1);
  g1(31,11)=(-params(29));
  g1(31,37)=1;
  g1(31,79)=params(33);
  g1(31,79)=(-1);
  g1(32,12)=(-params(30));
  g1(32,38)=1;
  g1(32,80)=params(34);
  g1(32,80)=(-1);
  g1(33,14)=(-params(36));
  g1(33,40)=1;
  g1(33,81)=(-1);
  g1(34,19)=(-1);
  g1(34,48)=1;
  g1(34,59)=1;
  g1(35,54)=(-1);
  g1(35,60)=0.25;
  g1(36,65)=1;
  g1(36,27)=(-1);
  g1(36,61)=0.25;
  g1(37,1)=1;
  g1(37,19)=(-1);
  g1(37,33)=(-1);
  g1(37,41)=1;
  g1(38,2)=1;
  g1(38,20)=(-1);
  g1(38,33)=(-1);
  g1(38,46)=1;
  g1(39,3)=1;
  g1(39,21)=(-1);
  g1(39,33)=(-1);
  g1(39,47)=1;
  g1(40,7)=1;
  g1(40,30)=(-1);
  g1(40,33)=(-1);
  g1(40,43)=1;
  g1(41,27)=(-1);
  g1(41,45)=1;
  g1(42,26)=(-1);
  g1(42,44)=1;
  g1(43,24)=(-1);
  g1(43,42)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],43,6561);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],43,531441);
end
end
end
end
