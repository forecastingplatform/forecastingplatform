function [residual, g1, g2, g3] = QPM_US_20083_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(52, 1);
lhs =y(35);
rhs =params(3)*y(3)+params(4)*y(39)+x(it_, 2);
residual(1)= lhs-rhs;
lhs =y(35);
rhs =y(36)-y(34);
residual(2)= lhs-rhs;
lhs =y(36);
rhs =y(4)+y(48)+x(it_, 3);
residual(3)= lhs-rhs;
lhs =y(48);
rhs =(1-params(16))*y(13)+x(it_, 9);
residual(4)= lhs-rhs;
lhs =y(40);
rhs =y(39)+y(41);
residual(5)= lhs-rhs;
lhs =y(43);
rhs =params(5)*params(6)+(1-params(5))*y(11)+x(it_, 5);
residual(6)= lhs-rhs;
lhs =y(41);
rhs =y(9)+y(43)/4+x(it_, 7);
residual(7)= lhs-rhs;
lhs =y(39);
rhs =x(it_, 6)+params(7)*y(7)+params(8)*y(86)-params(9)*(y(1)-y(2))-params(18)*(0.04*(y(15)+y(23))+0.08*(y(16)+y(22))+0.12*(y(17)+y(21))+0.16*(y(18)+y(20))+0.2*y(19));
residual(8)= lhs-rhs;
lhs =y(54);
rhs =x(it_, 10);
residual(9)= lhs-rhs;
lhs =y(52);
rhs =x(it_, 10)+y(53)-params(17)*y(89);
residual(10)= lhs-rhs;
lhs =y(53);
rhs =y(14)+x(it_, 11);
residual(11)= lhs-rhs;
lhs =y(58);
rhs =y(52)-y(53);
residual(12)= lhs-rhs;
lhs =y(49);
rhs =4*(y(40)-y(8));
residual(13)= lhs-rhs;
lhs =y(50);
rhs =y(40)-y(26);
residual(14)= lhs-rhs;
lhs =y(56);
rhs =4*(y(41)-y(9));
residual(15)= lhs-rhs;
lhs =y(51);
rhs =y(41)-y(29);
residual(16)= lhs-rhs;
lhs =y(37);
rhs =y(7)*params(11)+(1-params(10))*y(6)+params(10)*y(92)-x(it_, 8);
residual(17)= lhs-rhs;
lhs =y(42);
rhs =x(it_, 4)+params(12)*y(10)+(1-params(12))*(y(39)*params(14)+y(33)+y(91)+params(13)*(y(91)-params(15)));
residual(18)= lhs-rhs;
lhs =y(32);
rhs =y(42)-y(84);
residual(19)= lhs-rhs;
lhs =y(44);
rhs =y(12)+y(37)/4;
residual(20)= lhs-rhs;
lhs =y(33);
rhs =params(1)*params(2)+y(2)*(1-params(1))+x(it_, 1);
residual(21)= lhs-rhs;
lhs =y(38);
rhs =(y(37)+y(5)+y(30)+y(31))/4;
residual(22)= lhs-rhs;
lhs =y(57);
rhs =y(32)-y(33);
residual(23)= lhs-rhs;
lhs =y(45);
rhs =y(92);
residual(24)= lhs-rhs;
lhs =y(47);
rhs =y(84);
residual(25)= lhs-rhs;
lhs =y(46);
rhs =y(86);
residual(26)= lhs-rhs;
lhs =y(55);
rhs =params(18)*(0.04*(y(15)+y(23))+0.08*(y(16)+y(22))+0.12*(y(17)+y(21))+0.16*(y(18)+y(20))+0.2*y(19));
residual(27)= lhs-rhs;
lhs =y(61);
rhs =y(49)/4-y(37);
residual(28)= lhs-rhs;
lhs =y(60);
rhs =y(37);
residual(29)= lhs-rhs;
lhs =y(59);
rhs =y(42);
residual(30)= lhs-rhs;
lhs =y(62);
rhs =y(86);
residual(31)= lhs-rhs;
lhs =y(63);
rhs =y(87);
residual(32)= lhs-rhs;
lhs =y(64);
rhs =y(88);
residual(33)= lhs-rhs;
lhs =y(65);
rhs =y(85);
residual(34)= lhs-rhs;
lhs =y(66);
rhs =y(90);
residual(35)= lhs-rhs;
lhs =y(67);
rhs =y(91);
residual(36)= lhs-rhs;
lhs =y(68);
rhs =y(15);
residual(37)= lhs-rhs;
lhs =y(69);
rhs =y(16);
residual(38)= lhs-rhs;
lhs =y(70);
rhs =y(17);
residual(39)= lhs-rhs;
lhs =y(71);
rhs =y(18);
residual(40)= lhs-rhs;
lhs =y(72);
rhs =y(19);
residual(41)= lhs-rhs;
lhs =y(73);
rhs =y(20);
residual(42)= lhs-rhs;
lhs =y(74);
rhs =y(21);
residual(43)= lhs-rhs;
lhs =y(75);
rhs =y(22);
residual(44)= lhs-rhs;
lhs =y(76);
rhs =y(8);
residual(45)= lhs-rhs;
lhs =y(77);
rhs =y(24);
residual(46)= lhs-rhs;
lhs =y(78);
rhs =y(25);
residual(47)= lhs-rhs;
lhs =y(79);
rhs =y(9);
residual(48)= lhs-rhs;
lhs =y(80);
rhs =y(27);
residual(49)= lhs-rhs;
lhs =y(81);
rhs =y(28);
residual(50)= lhs-rhs;
lhs =y(82);
rhs =y(5);
residual(51)= lhs-rhs;
lhs =y(83);
rhs =y(30);
residual(52)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(52, 103);

  %
  % Jacobian matrix
  %

T3 = (-1);
  g1(1,3)=(-params(3));
  g1(1,35)=1;
  g1(1,39)=(-params(4));
  g1(1,94)=T3;
  g1(2,34)=1;
  g1(2,35)=1;
  g1(2,36)=T3;
  g1(3,4)=T3;
  g1(3,36)=1;
  g1(3,48)=T3;
  g1(3,95)=T3;
  g1(4,13)=(-(1-params(16)));
  g1(4,48)=1;
  g1(4,101)=T3;
  g1(5,39)=T3;
  g1(5,40)=1;
  g1(5,41)=T3;
  g1(6,11)=(-(1-params(5)));
  g1(6,43)=1;
  g1(6,97)=T3;
  g1(7,9)=T3;
  g1(7,41)=1;
  g1(7,43)=(-0.25);
  g1(7,99)=T3;
  g1(8,1)=params(9);
  g1(8,2)=(-params(9));
  g1(8,7)=(-params(7));
  g1(8,39)=1;
  g1(8,86)=(-params(8));
  g1(8,15)=params(18)*0.04;
  g1(8,98)=T3;
  g1(8,16)=params(18)*0.08;
  g1(8,17)=params(18)*0.12;
  g1(8,18)=params(18)*0.16;
  g1(8,19)=params(18)*0.2;
  g1(8,20)=params(18)*0.16;
  g1(8,21)=params(18)*0.12;
  g1(8,22)=params(18)*0.08;
  g1(8,23)=params(18)*0.04;
  g1(9,54)=1;
  g1(9,102)=T3;
  g1(10,52)=1;
  g1(10,53)=T3;
  g1(10,102)=T3;
  g1(10,89)=params(17);
  g1(11,14)=T3;
  g1(11,53)=1;
  g1(11,103)=T3;
  g1(12,52)=T3;
  g1(12,53)=1;
  g1(12,58)=1;
  g1(13,8)=4;
  g1(13,40)=(-4);
  g1(13,49)=1;
  g1(14,40)=T3;
  g1(14,50)=1;
  g1(14,26)=1;
  g1(15,9)=4;
  g1(15,41)=(-4);
  g1(15,56)=1;
  g1(16,41)=T3;
  g1(16,51)=1;
  g1(16,29)=1;
  g1(17,37)=1;
  g1(17,6)=(-(1-params(10)));
  g1(17,7)=(-params(11));
  g1(17,100)=1;
  g1(17,92)=(-params(10));
  g1(18,33)=(-(1-params(12)));
  g1(18,39)=(-((1-params(12))*params(14)));
  g1(18,10)=(-params(12));
  g1(18,42)=1;
  g1(18,96)=T3;
  g1(18,91)=(-((1-params(12))*(1+params(13))));
  g1(19,32)=1;
  g1(19,84)=1;
  g1(19,42)=T3;
  g1(20,37)=(-0.25);
  g1(20,12)=T3;
  g1(20,44)=1;
  g1(21,2)=(-(1-params(1)));
  g1(21,33)=1;
  g1(21,93)=T3;
  g1(22,5)=(-0.25);
  g1(22,37)=(-0.25);
  g1(22,38)=1;
  g1(22,30)=(-0.25);
  g1(22,31)=(-0.25);
  g1(23,32)=T3;
  g1(23,33)=1;
  g1(23,57)=1;
  g1(24,45)=1;
  g1(24,92)=T3;
  g1(25,84)=T3;
  g1(25,47)=1;
  g1(26,86)=T3;
  g1(26,46)=1;
  g1(27,15)=(-(params(18)*0.04));
  g1(27,55)=1;
  g1(27,16)=(-(params(18)*0.08));
  g1(27,17)=(-(params(18)*0.12));
  g1(27,18)=(-(params(18)*0.16));
  g1(27,19)=(-(params(18)*0.2));
  g1(27,20)=(-(params(18)*0.16));
  g1(27,21)=(-(params(18)*0.12));
  g1(27,22)=(-(params(18)*0.08));
  g1(27,23)=(-(params(18)*0.04));
  g1(28,37)=1;
  g1(28,49)=(-0.25);
  g1(28,61)=1;
  g1(29,37)=T3;
  g1(29,60)=1;
  g1(30,42)=T3;
  g1(30,59)=1;
  g1(31,86)=T3;
  g1(31,62)=1;
  g1(32,87)=T3;
  g1(32,63)=1;
  g1(33,88)=T3;
  g1(33,64)=1;
  g1(34,85)=T3;
  g1(34,65)=1;
  g1(35,90)=T3;
  g1(35,66)=1;
  g1(36,91)=T3;
  g1(36,67)=1;
  g1(37,15)=T3;
  g1(37,68)=1;
  g1(38,16)=T3;
  g1(38,69)=1;
  g1(39,17)=T3;
  g1(39,70)=1;
  g1(40,18)=T3;
  g1(40,71)=1;
  g1(41,19)=T3;
  g1(41,72)=1;
  g1(42,20)=T3;
  g1(42,73)=1;
  g1(43,21)=T3;
  g1(43,74)=1;
  g1(44,22)=T3;
  g1(44,75)=1;
  g1(45,8)=T3;
  g1(45,76)=1;
  g1(46,24)=T3;
  g1(46,77)=1;
  g1(47,25)=T3;
  g1(47,78)=1;
  g1(48,9)=T3;
  g1(48,79)=1;
  g1(49,27)=T3;
  g1(49,80)=1;
  g1(50,28)=T3;
  g1(50,81)=1;
  g1(51,5)=T3;
  g1(51,82)=1;
  g1(52,30)=T3;
  g1(52,83)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],52,10609);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],52,1092727);
end
end
end
end
