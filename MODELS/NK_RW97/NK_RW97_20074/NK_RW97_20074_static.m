function [residual, g1, g2, g3] = NK_RW97_20074_static(y, x, params)
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

residual = zeros( 16, 1);

%
% Model equations
%

beta__ = (1+params(2)/100)/(1+params(4)/100);
T38 = 1/params(1);
lhs =y(15);
rhs =params(2)+100*y(7);
residual(1)= lhs-rhs;
lhs =y(14);
rhs =params(3)+100*y(4);
residual(2)= lhs-rhs;
lhs =y(13);
rhs =params(4)+params(3)+100*y(5);
residual(3)= lhs-rhs;
lhs =y(16);
rhs =y(16)-T38*(y(5)-y(4)-y(9));
residual(4)= lhs-rhs;
lhs =y(8);
rhs =y(7)+y(4);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =y(8)-y(4);
residual(6)= lhs-rhs;
lhs =y(4);
rhs =y(4)*beta__+params(12)*y(12);
residual(7)= lhs-rhs;
lhs =y(12);
rhs =y(16)+T38*y(10);
residual(8)= lhs-rhs;
lhs =y(2);
rhs =y(6)+T38*y(11);
residual(9)= lhs-rhs;
lhs =y(5);
rhs =y(5)*params(7)+(1-params(7))*(y(4)*params(5)+y(16)*params(6))+x(1);
residual(10)= lhs-rhs;
lhs =y(3);
rhs =y(1)-y(6);
residual(11)= lhs-rhs;
lhs =y(16);
rhs =y(1)-y(2);
residual(12)= lhs-rhs;
lhs =y(7);
rhs =y(7)*params(9)+x(3);
residual(13)= lhs-rhs;
lhs =y(6);
rhs =y(6)*params(8)+x(2);
residual(14)= lhs-rhs;
lhs =y(11);
rhs =y(11)*params(10)+x(4);
residual(15)= lhs-rhs;
lhs =y(10);
rhs =y(10)*params(11)+x(5);
residual(16)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(16, 16);

  %
  % Jacobian matrix
  %

  g1(1,7)=(-100);
  g1(1,15)=1;
  g1(2,4)=(-100);
  g1(2,14)=1;
  g1(3,5)=(-100);
  g1(3,13)=1;
  g1(4,4)=(-T38);
  g1(4,5)=T38;
  g1(4,9)=(-T38);
  g1(5,4)=(-1);
  g1(5,7)=(-1);
  g1(5,8)=1;
  g1(6,4)=1;
  g1(6,8)=(-1);
  g1(6,9)=1;
  g1(7,4)=1-beta__;
  g1(7,12)=(-params(12));
  g1(8,10)=(-T38);
  g1(8,12)=1;
  g1(8,16)=(-1);
  g1(9,2)=1;
  g1(9,6)=(-1);
  g1(9,11)=(-T38);
  g1(10,4)=(-((1-params(7))*params(5)));
  g1(10,5)=1-params(7);
  g1(10,16)=(-((1-params(7))*params(6)));
  g1(11,1)=(-1);
  g1(11,3)=1;
  g1(11,6)=1;
  g1(12,1)=(-1);
  g1(12,2)=1;
  g1(12,16)=1;
  g1(13,7)=1-params(9);
  g1(14,6)=1-params(8);
  g1(15,11)=1-params(10);
  g1(16,10)=1-params(11);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],16,256);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],16,4096);
end
end
end
end
