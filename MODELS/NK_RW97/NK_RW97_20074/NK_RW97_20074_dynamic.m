function [residual, g1, g2, g3] = NK_RW97_20074_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(16, 1);
beta__ = (1+params(2)/100)/(1+params(4)/100);
T42 = 1/params(1);
lhs =y(21);
rhs =params(2)+100*(y(7)-y(1)+y(13));
residual(1)= lhs-rhs;
lhs =y(20);
rhs =params(3)+100*y(10);
residual(2)= lhs-rhs;
lhs =y(19);
rhs =params(4)+params(3)+100*y(11);
residual(3)= lhs-rhs;
lhs =y(22);
rhs =y(28)-T42*(y(11)-y(24)-y(15));
residual(4)= lhs-rhs;
lhs =y(14);
rhs =y(24)+params(1)*(y(23)-y(8))-(y(27)-y(17))-params(1)*(y(25)-y(12))+y(26);
residual(5)= lhs-rhs;
lhs =y(15);
rhs =y(14)-y(24);
residual(6)= lhs-rhs;
lhs =y(10);
rhs =y(24)*beta__+params(12)*y(18);
residual(7)= lhs-rhs;
lhs =y(18);
rhs =y(22)+T42*y(16);
residual(8)= lhs-rhs;
lhs =y(8);
rhs =y(12)+T42*y(17);
residual(9)= lhs-rhs;
lhs =y(11);
rhs =params(7)*y(2)+(1-params(7))*(y(10)*params(5)+y(22)*params(6))+x(it_, 1);
residual(10)= lhs-rhs;
lhs =y(9);
rhs =y(7)-y(12);
residual(11)= lhs-rhs;
lhs =y(22);
rhs =y(7)-y(8);
residual(12)= lhs-rhs;
lhs =y(13);
rhs =params(9)*y(4)+x(it_, 3);
residual(13)= lhs-rhs;
lhs =y(12);
rhs =params(8)*y(3)+x(it_, 2);
residual(14)= lhs-rhs;
lhs =y(17);
rhs =params(10)*y(6)+x(it_, 4);
residual(15)= lhs-rhs;
lhs =y(16);
rhs =params(11)*y(5)+x(it_, 5);
residual(16)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(16, 33);

  %
  % Jacobian matrix
  %

  g1(1,1)=100;
  g1(1,7)=(-100);
  g1(1,13)=(-100);
  g1(1,21)=1;
  g1(2,10)=(-100);
  g1(2,20)=1;
  g1(3,11)=(-100);
  g1(3,19)=1;
  g1(4,24)=(-T42);
  g1(4,11)=T42;
  g1(4,15)=(-T42);
  g1(4,22)=1;
  g1(4,28)=(-1);
  g1(5,8)=params(1);
  g1(5,23)=(-params(1));
  g1(5,24)=(-1);
  g1(5,12)=(-params(1));
  g1(5,25)=params(1);
  g1(5,26)=(-1);
  g1(5,14)=1;
  g1(5,17)=(-1);
  g1(5,27)=1;
  g1(6,24)=1;
  g1(6,14)=(-1);
  g1(6,15)=1;
  g1(7,10)=1;
  g1(7,24)=(-beta__);
  g1(7,18)=(-params(12));
  g1(8,16)=(-T42);
  g1(8,18)=1;
  g1(8,22)=(-1);
  g1(9,8)=1;
  g1(9,12)=(-1);
  g1(9,17)=(-T42);
  g1(10,10)=(-((1-params(7))*params(5)));
  g1(10,2)=(-params(7));
  g1(10,11)=1;
  g1(10,22)=(-((1-params(7))*params(6)));
  g1(10,29)=(-1);
  g1(11,7)=(-1);
  g1(11,9)=1;
  g1(11,12)=1;
  g1(12,7)=(-1);
  g1(12,8)=1;
  g1(12,22)=1;
  g1(13,4)=(-params(9));
  g1(13,13)=1;
  g1(13,31)=(-1);
  g1(14,3)=(-params(8));
  g1(14,12)=1;
  g1(14,30)=(-1);
  g1(15,6)=(-params(10));
  g1(15,17)=1;
  g1(15,32)=(-1);
  g1(16,5)=(-params(11));
  g1(16,16)=1;
  g1(16,33)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],16,1089);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],16,35937);
end
end
end
end
