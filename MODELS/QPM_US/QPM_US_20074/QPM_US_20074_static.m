function [residual, g1, g2, g3] = QPM_US_20074_static(y, x, params)
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

residual = zeros( 50, 1);

%
% Model equations
%

lhs =y(4);
rhs =y(4)*params(3)+params(4)*y(8)+x(2);
residual(1)= lhs-rhs;
lhs =y(4);
rhs =y(5)-y(3);
residual(2)= lhs-rhs;
lhs =y(5);
rhs =y(5)+y(17)+x(3);
residual(3)= lhs-rhs;
lhs =y(17);
rhs =y(17)*(1-params(16))+x(9);
residual(4)= lhs-rhs;
lhs =y(9);
rhs =y(8)+y(10);
residual(5)= lhs-rhs;
lhs =y(12);
rhs =params(5)*params(6)+y(12)*(1-params(5))+x(5);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =y(10)+y(12)/4+x(7);
residual(7)= lhs-rhs;
lhs =y(8);
rhs =x(6)+y(8)*params(7)+y(8)*params(8)-params(9)*(y(1)-y(2))-params(18)*(0.04*(y(23)+y(23))+0.08*(y(23)+y(23))+0.12*(y(23)+y(23))+0.16*(y(23)+y(23))+y(23)*0.2);
residual(8)= lhs-rhs;
lhs =y(23);
rhs =x(10);
residual(9)= lhs-rhs;
lhs =y(21);
rhs =x(10)+y(22)-y(8)*params(17);
residual(10)= lhs-rhs;
lhs =y(22);
rhs =y(22)+x(11);
residual(11)= lhs-rhs;
lhs =y(27);
rhs =y(21)-y(22);
residual(12)= lhs-rhs;
residual(13) = y(18);
residual(14) = y(19);
residual(15) = y(25);
residual(16) = y(20);
lhs =y(6);
rhs =y(8)*params(11)+(1-params(10))*y(7)+params(10)*y(7)-x(8);
residual(17)= lhs-rhs;
lhs =y(11);
rhs =x(4)+y(11)*params(12)+(1-params(12))*(y(8)*params(14)+y(2)+y(7)+params(13)*(y(7)-params(15)));
residual(18)= lhs-rhs;
lhs =y(1);
rhs =y(11)-y(6);
residual(19)= lhs-rhs;
lhs =y(13);
rhs =y(13)+y(6)/4;
residual(20)= lhs-rhs;
lhs =y(2);
rhs =params(1)*params(2)+y(2)*(1-params(1))+x(1);
residual(21)= lhs-rhs;
lhs =y(7);
rhs =(y(6)+y(6)+y(6)+y(6))/4;
residual(22)= lhs-rhs;
lhs =y(26);
rhs =y(1)-y(2);
residual(23)= lhs-rhs;
lhs =y(14);
rhs =y(7);
residual(24)= lhs-rhs;
lhs =y(16);
rhs =y(6);
residual(25)= lhs-rhs;
lhs =y(15);
rhs =y(8);
residual(26)= lhs-rhs;
lhs =y(24);
rhs =params(18)*(0.04*(y(23)+y(23))+0.08*(y(23)+y(23))+0.12*(y(23)+y(23))+0.16*(y(23)+y(23))+y(23)*0.2);
residual(27)= lhs-rhs;
residual(28) = y(28);
lhs =y(29);
rhs =y(8);
residual(29)= lhs-rhs;
lhs =y(30);
rhs =y(8);
residual(30)= lhs-rhs;
lhs =y(31);
rhs =y(8);
residual(31)= lhs-rhs;
lhs =y(32);
rhs =y(7);
residual(32)= lhs-rhs;
lhs =y(33);
rhs =y(7);
residual(33)= lhs-rhs;
lhs =y(34);
rhs =y(7);
residual(34)= lhs-rhs;
lhs =y(35);
rhs =y(23);
residual(35)= lhs-rhs;
lhs =y(36);
rhs =y(23);
residual(36)= lhs-rhs;
lhs =y(37);
rhs =y(23);
residual(37)= lhs-rhs;
lhs =y(38);
rhs =y(23);
residual(38)= lhs-rhs;
lhs =y(39);
rhs =y(23);
residual(39)= lhs-rhs;
lhs =y(40);
rhs =y(23);
residual(40)= lhs-rhs;
lhs =y(41);
rhs =y(23);
residual(41)= lhs-rhs;
lhs =y(42);
rhs =y(23);
residual(42)= lhs-rhs;
lhs =y(43);
rhs =y(9);
residual(43)= lhs-rhs;
lhs =y(44);
rhs =y(9);
residual(44)= lhs-rhs;
lhs =y(45);
rhs =y(9);
residual(45)= lhs-rhs;
lhs =y(46);
rhs =y(10);
residual(46)= lhs-rhs;
lhs =y(47);
rhs =y(10);
residual(47)= lhs-rhs;
lhs =y(48);
rhs =y(10);
residual(48)= lhs-rhs;
lhs =y(49);
rhs =y(6);
residual(49)= lhs-rhs;
lhs =y(50);
rhs =y(6);
residual(50)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(50, 50);

  %
  % Jacobian matrix
  %

  g1(1,4)=1-params(3);
  g1(1,8)=(-params(4));
  g1(2,3)=1;
  g1(2,4)=1;
  g1(2,5)=(-1);
  g1(3,17)=(-1);
  g1(4,17)=1-(1-params(16));
  g1(5,8)=(-1);
  g1(5,9)=1;
  g1(5,10)=(-1);
  g1(6,12)=1-(1-params(5));
  g1(7,12)=(-0.25);
  g1(8,1)=params(9);
  g1(8,2)=(-params(9));
  g1(8,8)=1-(params(7)+params(8));
  g1(8,23)=params(18);
  g1(9,23)=1;
  g1(10,8)=params(17);
  g1(10,21)=1;
  g1(10,22)=(-1);
  g1(12,21)=(-1);
  g1(12,22)=1;
  g1(12,27)=1;
  g1(13,18)=1;
  g1(14,19)=1;
  g1(15,25)=1;
  g1(16,20)=1;
  g1(17,6)=1;
  g1(17,7)=(-(params(10)+1-params(10)));
  g1(17,8)=(-params(11));
  g1(18,2)=(-(1-params(12)));
  g1(18,7)=(-((1-params(12))*(1+params(13))));
  g1(18,8)=(-((1-params(12))*params(14)));
  g1(18,11)=1-params(12);
  g1(19,1)=1;
  g1(19,6)=1;
  g1(19,11)=(-1);
  g1(20,6)=(-0.25);
  g1(21,2)=1-(1-params(1));
  g1(22,6)=(-1);
  g1(22,7)=1;
  g1(23,1)=(-1);
  g1(23,2)=1;
  g1(23,26)=1;
  g1(24,7)=(-1);
  g1(24,14)=1;
  g1(25,6)=(-1);
  g1(25,16)=1;
  g1(26,8)=(-1);
  g1(26,15)=1;
  g1(27,23)=(-params(18));
  g1(27,24)=1;
  g1(28,28)=1;
  g1(29,8)=(-1);
  g1(29,29)=1;
  g1(30,8)=(-1);
  g1(30,30)=1;
  g1(31,8)=(-1);
  g1(31,31)=1;
  g1(32,7)=(-1);
  g1(32,32)=1;
  g1(33,7)=(-1);
  g1(33,33)=1;
  g1(34,7)=(-1);
  g1(34,34)=1;
  g1(35,23)=(-1);
  g1(35,35)=1;
  g1(36,23)=(-1);
  g1(36,36)=1;
  g1(37,23)=(-1);
  g1(37,37)=1;
  g1(38,23)=(-1);
  g1(38,38)=1;
  g1(39,23)=(-1);
  g1(39,39)=1;
  g1(40,23)=(-1);
  g1(40,40)=1;
  g1(41,23)=(-1);
  g1(41,41)=1;
  g1(42,23)=(-1);
  g1(42,42)=1;
  g1(43,9)=(-1);
  g1(43,43)=1;
  g1(44,9)=(-1);
  g1(44,44)=1;
  g1(45,9)=(-1);
  g1(45,45)=1;
  g1(46,10)=(-1);
  g1(46,46)=1;
  g1(47,10)=(-1);
  g1(47,47)=1;
  g1(48,10)=(-1);
  g1(48,48)=1;
  g1(49,6)=(-1);
  g1(49,49)=1;
  g1(50,6)=(-1);
  g1(50,50)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],50,2500);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],50,125000);
end
end
end
end
