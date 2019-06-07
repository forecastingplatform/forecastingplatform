function [residual, g1, g2, g3] = US_DSSW07_20094_static(y, x, params)
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

residual = zeros( 36, 1);

%
% Model equations
%

beta__ = 1/(1+params(12)/400);
pic_star__ = 1+params(16)/400;
g_star__ = 1/(1-params(19));
gamma__ = params(17)/400;
T25 = exp(y(23));
T27 = beta__*y(1)/T25/y(1);
T39 = y(4)-y(4)*params(8)/T25;
T46 = exp(y(24))/T39-exp(y(24))*beta__*params(8)/(T25*y(4)-y(4)*params(8));
T66 = (1+params(2))*(1+params(9))/params(2);
T68 = exp(y(25))*y(6)^T66;
T70 = y(9)^(1+params(9));
T76 = (T25*y(3))^params(11);
T83 = (pic_star__*exp(gamma__))^(1-params(11));
T84 = y(3)/T76/T83;
T86 = beta__*params(10)*T84^T66;
T89 = T86*exp(y(23)*T66);
T94 = y(6)^((1+params(2))/params(2));
T97 = 1/params(2);
T99 = beta__*params(10)*T84^T97;
T101 = exp(y(23)*T97);
T102 = T99*T101;
T107 = y(6)/T25/y(3);
T110 = (-1)/params(2);
T116 = params(10)*(T83*T76*T107)^T110+(1-params(10))*y(5)^T110;
T131 = T25*y(12)/y(12);
T132 = T131-exp(gamma__);
T135 = 1-params(7)/2*T132^2;
T147 = T131^2;
T165 = params(24)/2*(y(16)-1)^2;
T176 = beta__*y(1)/y(1)/T25;
T177 = y(14)*T176;
T191 = (y(6)/(1-params(4)))^(1-params(4));
T192 = 1/exp(y(29))*T191;
T194 = (y(15)/params(4))^params(4);
T212 = y(3)^params(6);
T215 = pic_star__^(1-params(6));
T216 = y(3)/T212/T215;
T218 = T216^((1+exp(y(27)))/exp(y(27)));
T219 = beta__*params(5)*T218;
T225 = T216^(1/exp(y(27)));
T226 = beta__*params(5)*T225;
T233 = (-1)/exp(y(27));
T234 = (T215*T212*1/y(3))^T233;
T237 = y(18)^T233;
T244 = (y(2)/(y(2)))^params(15);
T247 = (y(3)/pic_star__)^params(13);
T251 = (y(21)/(y(21)))^params(14);
T252 = T247*T251;
T254 = T252^(1-params(15));
T259 = exp(x(7)/100);
T273 = ((1-params(4))/params(4))^params(4);
T276 = T273*(y(15)/y(6))^params(4);
T283 = (params(4)/(1-params(4)))^(1-params(4));
T286 = T283*(y(6)/y(15))^(1-params(4));
T292 = (-(1+exp(y(27))))/exp(y(27));
T293 = y(18)^T292;
T297 = (T212*T215/y(3))^T292;
T298 = params(5)*T297;
lhs =T27*y(2)/y(3);
rhs =1;
residual(1)= lhs-rhs;
lhs =y(1);
rhs =T46;
residual(2)= lhs-rhs;
lhs =y(5)^(1+params(9)*(1+params(2))/params(2));
rhs =(1+params(2))*y(7)/y(8);
residual(3)= lhs-rhs;
lhs =y(7);
rhs =T68*T70+y(7)*T89;
residual(4)= lhs-rhs;
lhs =y(8);
rhs =y(9)*y(1)*T94+y(8)*T102;
residual(5)= lhs-rhs;
lhs =y(6);
rhs =T116^(-params(2));
residual(6)= lhs-rhs;
lhs =y(11);
rhs =y(11)*(1-params(3))/T25+y(12)*exp(y(26))*T135;
residual(7)= lhs-rhs;
lhs =1;
rhs =exp(y(26))*(T135-T132*params(7)*T131)*y(13)+y(13)*T132*params(7)*T27*exp(y(26))*T147;
residual(8)= lhs-rhs;
lhs =y(14);
rhs =y(3)*(y(16)*y(15)-(y(15))*(y(16)-1)-T165+(1-params(3))*y(13))/y(13);
residual(9)= lhs-rhs;
lhs =y(15);
rhs =(y(15))+(y(16)-1)*params(24);
residual(10)= lhs-rhs;
lhs =1;
rhs =T177/y(3);
residual(11)= lhs-rhs;
lhs =T25*y(10);
rhs =y(11)*y(16);
residual(12)= lhs-rhs;
lhs =y(17);
rhs =T192*T194;
residual(13)= lhs-rhs;
lhs =y(18);
rhs =(1+exp(y(27)))*y(19)/y(20);
residual(14)= lhs-rhs;
lhs =y(19);
rhs =y(1)*y(17)*y(21)+y(19)*T219;
residual(15)= lhs-rhs;
lhs =y(20);
rhs =y(1)*y(21)+y(20)*T226;
residual(16)= lhs-rhs;
lhs =1;
rhs =params(5)*T234+(1-params(5))*T237;
residual(17)= lhs-rhs;
lhs =y(2)/(y(2));
rhs =T244*T254*T259;
residual(18)= lhs-rhs;
lhs =y(21)*1/exp(y(28));
rhs =y(4)+y(12)+y(11)*((y(15))*(y(16)-1)+T165)/T25;
residual(19)= lhs-rhs;
lhs =y(9);
rhs =y(21)*T276/exp(y(29))*y(22);
residual(20)= lhs-rhs;
lhs =y(10);
rhs =y(22)*y(21)*T286/exp(y(29));
residual(21)= lhs-rhs;
lhs =y(22);
rhs =(1-params(5))*T293+y(22)*T298;
residual(22)= lhs-rhs;
lhs =y(23);
rhs =gamma__*(1-params(25))+y(23)*params(25)+x(1)/100;
residual(23)= lhs-rhs;
lhs =y(24);
rhs =y(24)*params(26)+x(2)/100;
residual(24)= lhs-rhs;
lhs =y(25);
rhs =(1-params(27))*log(params(1))+y(25)*params(27)+x(3)/100;
residual(25)= lhs-rhs;
lhs =y(26);
rhs =y(26)*params(28)+x(4)/100;
residual(26)= lhs-rhs;
lhs =y(27);
rhs =(1-params(29))*log(params(18))+y(27)*params(29)+x(5)/100;
residual(27)= lhs-rhs;
lhs =y(28);
rhs =(1-params(30))*log(g_star__)+y(28)*params(30)+x(6)/100;
residual(28)= lhs-rhs;
residual(29) = y(29);
lhs =y(33);
rhs =y(23)*100;
residual(30)= lhs-rhs;
lhs =y(34);
rhs =y(23)*100;
residual(31)= lhs-rhs;
lhs =y(35);
rhs =y(23)*100;
residual(32)= lhs-rhs;
lhs =y(36);
rhs =y(23)*100;
residual(33)= lhs-rhs;
lhs =y(32);
rhs =100*log(y(3));
residual(34)= lhs-rhs;
lhs =y(31);
rhs =100*(y(2)-1);
residual(35)= lhs-rhs;
lhs =y(30);
rhs =params(36)*log(y(9))+params(34);
residual(36)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(36, 36);

  %
  % Jacobian matrix
  %

T385 = (y(1)*beta__/T25-beta__*y(1)/T25)/(y(1)*y(1));
T412 = getPowerDeriv(T25*y(3),params(11),1);
T418 = (T76-y(3)*T25*T412)/(T76*T76)/T83;
T419 = getPowerDeriv(T84,T66,1);
T425 = getPowerDeriv(T84,T97,1);
T437 = getPowerDeriv(T83*T76*T107,T110,1);
T440 = getPowerDeriv(T116,(-params(2)),1);
T448 = getPowerDeriv(y(3),params(6),1);
T453 = (T212-y(3)*T448)/(T212*T212)/T215;
T477 = getPowerDeriv(T252,1-params(15),1);
T536 = getPowerDeriv(y(15)/y(6),params(4),1);
T544 = getPowerDeriv(y(6)/y(15),1-params(4),1);
T664 = (-(beta__*y(1)*T25))/(T25*T25)/y(1);
T683 = (-(y(3)*T25*y(3)*T412))/(T76*T76)/T83;
T791 = (exp(y(27))*(-exp(y(27)))-exp(y(27))*(-(1+exp(y(27)))))/(exp(y(27))*exp(y(27)));
  g1(1,1)=y(2)*T385/y(3);
  g1(1,2)=T27/y(3);
  g1(1,3)=(-(T27*y(2)))/(y(3)*y(3));
  g1(1,23)=y(2)*T664/y(3);
  g1(2,1)=1;
  g1(2,4)=(-((-(exp(y(24))*(1-params(8)/T25)))/(T39*T39)-(-(exp(y(24))*beta__*params(8)*(T25-params(8))))/((T25*y(4)-y(4)*params(8))*(T25*y(4)-y(4)*params(8)))));
  g1(2,23)=(-((-(exp(y(24))*(-((-(T25*y(4)*params(8)))/(T25*T25)))))/(T39*T39)-(-(exp(y(24))*beta__*params(8)*T25*y(4)))/((T25*y(4)-y(4)*params(8))*(T25*y(4)-y(4)*params(8)))));
  g1(2,24)=(-T46);
  g1(3,5)=getPowerDeriv(y(5),1+params(9)*(1+params(2))/params(2),1);
  g1(3,7)=(-((1+params(2))/y(8)));
  g1(3,8)=(-((-((1+params(2))*y(7)))/(y(8)*y(8))));
  g1(4,3)=(-(y(7)*exp(y(23)*T66)*beta__*params(10)*T418*T419));
  g1(4,6)=(-(T70*exp(y(25))*getPowerDeriv(y(6),T66,1)));
  g1(4,7)=1-T89;
  g1(4,9)=(-(T68*getPowerDeriv(y(9),1+params(9),1)));
  g1(4,23)=(-(y(7)*(exp(y(23)*T66)*beta__*params(10)*T419*T683+T86*T66*exp(y(23)*T66))));
  g1(4,25)=(-(T68*T70));
  g1(5,1)=(-(y(9)*T94));
  g1(5,3)=(-(y(8)*T101*beta__*params(10)*T418*T425));
  g1(5,6)=(-(y(9)*y(1)*getPowerDeriv(y(6),(1+params(2))/params(2),1)));
  g1(5,8)=1-T102;
  g1(5,9)=(-(y(1)*T94));
  g1(5,23)=(-(y(8)*(T101*beta__*params(10)*T425*T683+T99*T97*T101)));
  g1(6,3)=(-(params(10)*T83*(T107*T25*T412+T76*(-(y(6)/T25))/(y(3)*y(3)))*T437*T440));
  g1(6,5)=(-(T440*(1-params(10))*getPowerDeriv(y(5),T110,1)));
  g1(6,6)=1-T440*params(10)*T437*T83*T76*1/T25/y(3);
  g1(6,23)=(-(T440*params(10)*T437*T83*(T107*T25*y(3)*T412+T76*(-(T25*y(6)))/(T25*T25)/y(3))));
  g1(7,11)=1-(1-params(3))/T25;
  g1(7,12)=(-(exp(y(26))*T135));
  g1(7,23)=(-((-(T25*y(11)*(1-params(3))))/(T25*T25)+y(12)*exp(y(26))*(-(params(7)/2*T131*2*T132))));
  g1(7,26)=(-(y(12)*exp(y(26))*T135));
  g1(8,1)=(-(y(13)*T132*params(7)*T147*exp(y(26))*T385));
  g1(8,13)=(-(exp(y(26))*(T135-T132*params(7)*T131)+T132*params(7)*T27*exp(y(26))*T147));
  g1(8,23)=(-(y(13)*exp(y(26))*((-(params(7)/2*T131*2*T132))-(T132*params(7)*T131+T131*params(7)*T131))+y(13)*(T131*params(7)*T27*exp(y(26))*T147+T132*params(7)*(T147*exp(y(26))*T664+T27*exp(y(26))*T131*2*T131))));
  g1(8,26)=(-(exp(y(26))*(T135-T132*params(7)*T131)*y(13)+y(13)*T132*params(7)*T27*exp(y(26))*T147));
  g1(9,3)=(-((y(16)*y(15)-(y(15))*(y(16)-1)-T165+(1-params(3))*y(13))/y(13)));
  g1(9,13)=(-((y(13)*y(3)*(1-params(3))-y(3)*(y(16)*y(15)-(y(15))*(y(16)-1)-T165+(1-params(3))*y(13)))/(y(13)*y(13))));
  g1(9,14)=1;
  g1(9,15)=(-(y(3)*(y(16)-(y(16)-1))/y(13)));
  g1(9,16)=(-(y(3)*(y(15)-(y(15))-params(24)/2*2*(y(16)-1))/y(13)));
  g1(10,16)=(-params(24));
  g1(11,3)=(-((-T177)/(y(3)*y(3))));
  g1(11,14)=(-(T176/y(3)));
  g1(11,23)=(-(y(14)*(-(T25*beta__*y(1)/y(1)))/(T25*T25)/y(3)));
  g1(12,10)=T25;
  g1(12,11)=(-y(16));
  g1(12,16)=(-y(11));
  g1(12,23)=T25*y(10);
  g1(13,6)=(-(T194*1/exp(y(29))*1/(1-params(4))*getPowerDeriv(y(6)/(1-params(4)),1-params(4),1)));
  g1(13,15)=(-(T192*1/params(4)*getPowerDeriv(y(15)/params(4),params(4),1)));
  g1(13,17)=1;
  g1(13,29)=(-(T194*T191*(-exp(y(29)))/(exp(y(29))*exp(y(29)))));
  g1(14,18)=1;
  g1(14,19)=(-((1+exp(y(27)))/y(20)));
  g1(14,20)=(-((-((1+exp(y(27)))*y(19)))/(y(20)*y(20))));
  g1(14,27)=(-(exp(y(27))*y(19)/y(20)));
  g1(15,1)=(-(y(17)*y(21)));
  g1(15,3)=(-(y(19)*beta__*params(5)*T453*getPowerDeriv(T216,(1+exp(y(27)))/exp(y(27)),1)));
  g1(15,17)=(-(y(1)*y(21)));
  g1(15,19)=1-T219;
  g1(15,21)=(-(y(1)*y(17)));
  g1(15,27)=(-(y(19)*beta__*params(5)*T218*(exp(y(27))*exp(y(27))-exp(y(27))*(1+exp(y(27))))/(exp(y(27))*exp(y(27)))*log(T216)));
  g1(16,1)=(-y(21));
  g1(16,3)=(-(y(20)*beta__*params(5)*T453*getPowerDeriv(T216,1/exp(y(27)),1)));
  g1(16,20)=1-T226;
  g1(16,21)=(-y(1));
  g1(16,27)=(-(y(20)*beta__*params(5)*T225*log(T216)*(-exp(y(27)))/(exp(y(27))*exp(y(27)))));
  g1(17,3)=(-(params(5)*T215*(1/y(3)*T448+T212*(-1)/(y(3)*y(3)))*getPowerDeriv(T215*T212*1/y(3),T233,1)));
  g1(17,18)=(-((1-params(5))*getPowerDeriv(y(18),T233,1)));
  g1(17,27)=(-(params(5)*T234*exp(y(27))/(exp(y(27))*exp(y(27)))*log(T215*T212*1/y(3))+(1-params(5))*T237*exp(y(27))/(exp(y(27))*exp(y(27)))*log(y(18))));
  g1(18,2)=((y(2))-y(2))/((y(2))*(y(2)))-T259*T254*((y(2))-y(2))/((y(2))*(y(2)))*getPowerDeriv(y(2)/(y(2)),params(15),1);
  g1(18,3)=(-(T259*T244*T251*1/pic_star__*getPowerDeriv(y(3)/pic_star__,params(13),1)*T477));
  g1(18,21)=(-(T259*T244*T477*T247*((y(21))-y(21))/((y(21))*(y(21)))*getPowerDeriv(y(21)/(y(21)),params(14),1)));
  g1(19,4)=(-1);
  g1(19,11)=(-(((y(15))*(y(16)-1)+T165)/T25));
  g1(19,12)=(-1);
  g1(19,15)=(-(y(11)*(y(16)-1)/T25));
  g1(19,16)=(-(y(11)*((y(15))+params(24)/2*2*(y(16)-1))/T25));
  g1(19,21)=1/exp(y(28));
  g1(19,23)=(-((-(T25*y(11)*((y(15))*(y(16)-1)+T165)))/(T25*T25)));
  g1(19,28)=y(21)*(-exp(y(28)))/(exp(y(28))*exp(y(28)));
  g1(20,6)=(-(y(22)*y(21)*T273*(-y(15))/(y(6)*y(6))*T536/exp(y(29))));
  g1(20,9)=1;
  g1(20,15)=(-(y(22)*y(21)*T273*T536*1/y(6)/exp(y(29))));
  g1(20,21)=(-(y(22)*T276/exp(y(29))));
  g1(20,22)=(-(y(21)*T276/exp(y(29))));
  g1(20,29)=(-(y(22)*(-(exp(y(29))*y(21)*T276))/(exp(y(29))*exp(y(29)))));
  g1(21,6)=(-(y(22)*y(21)*T283*1/y(15)*T544/exp(y(29))));
  g1(21,10)=1;
  g1(21,15)=(-(y(22)*y(21)*T283*T544*(-y(6))/(y(15)*y(15))/exp(y(29))));
  g1(21,21)=(-(y(22)*T286/exp(y(29))));
  g1(21,22)=(-(y(21)*T286/exp(y(29))));
  g1(21,29)=(-(y(22)*(-(exp(y(29))*y(21)*T286))/(exp(y(29))*exp(y(29)))));
  g1(22,3)=(-(y(22)*params(5)*(y(3)*T215*T448-T212*T215)/(y(3)*y(3))*getPowerDeriv(T212*T215/y(3),T292,1)));
  g1(22,18)=(-((1-params(5))*getPowerDeriv(y(18),T292,1)));
  g1(22,22)=1-T298;
  g1(22,27)=(-((1-params(5))*T293*log(y(18))*T791+y(22)*params(5)*T297*T791*log(T212*T215/y(3))));
  g1(23,23)=1-params(25);
  g1(24,24)=1-params(26);
  g1(25,25)=1-params(27);
  g1(26,26)=1-params(28);
  g1(27,27)=1-params(29);
  g1(28,28)=1-params(30);
  g1(29,29)=1;
  g1(30,23)=(-100);
  g1(30,33)=1;
  g1(31,23)=(-100);
  g1(31,34)=1;
  g1(32,23)=(-100);
  g1(32,35)=1;
  g1(33,23)=(-100);
  g1(33,36)=1;
  g1(34,3)=(-(1/y(3)*100));
  g1(34,32)=1;
  g1(35,2)=(-100);
  g1(35,31)=1;
  g1(36,9)=(-(params(36)*1/y(9)));
  g1(36,30)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],36,1296);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],36,46656);
end
end
end
end
