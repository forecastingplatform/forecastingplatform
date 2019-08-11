function [residual, g1, g2, g3] = US_DSSW07FF_20083_static(y, x, params)
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

beta__ = 1/(1+params(12)/400);
pic_star__ = 1+params(16)/400;
g_star__ = 1/(1-params(19));
gamma__ = params(17)/400;
T25 = exp(y(30));
T27 = beta__*y(1)/T25/y(1);
T39 = y(4)-y(4)*params(8)/T25;
T46 = exp(y(31))/T39-exp(y(31))*beta__*params(8)/(T25*y(4)-y(4)*params(8));
T66 = (1+params(2))*(1+params(9))/params(2);
T68 = exp(y(32))*y(6)^T66;
T70 = y(9)^(1+params(9));
T76 = (T25*y(3))^params(11);
T83 = (pic_star__*exp(gamma__))^(1-params(11));
T84 = y(3)/T76/T83;
T86 = beta__*params(10)*T84^T66;
T89 = T86*exp(y(30)*T66);
T94 = y(6)^((1+params(2))/params(2));
T97 = 1/params(2);
T99 = beta__*params(10)*T84^T97;
T101 = exp(y(30)*T97);
T102 = T99*T101;
T107 = y(6)/T25/y(3);
T110 = (-1)/params(2);
T116 = params(10)*(T83*T76*T107)^T110+(1-params(10))*y(5)^T110;
T131 = T25*y(12)/y(12);
T132 = T131-exp(gamma__);
T135 = 1-params(7)/2*T132^2;
T147 = T131^2;
T170 = params(24)/2*(y(18)-1)^2;
T194 = y(16)/y(2);
T202 = (1-y(20))/(1-y(20)-y(23)*params(22)*y(22));
T225 = exp(y(38))*(y(11)*y(13)*y(16)/T25-y(14)*(y(2)+y(11)*y(13)*y(16)*params(22)*y(21)/y(14))/T25);
T243 = (y(6)/(1-params(4)))^(1-params(4));
T244 = 1/exp(y(36))*T243;
T246 = (y(17)/params(4))^params(4);
T264 = y(3)^params(6);
T267 = pic_star__^(1-params(6));
T268 = y(3)/T264/T267;
T270 = T268^((1+exp(y(34)))/exp(y(34)));
T271 = beta__*params(5)*T270;
T277 = T268^(1/exp(y(34)));
T278 = beta__*params(5)*T277;
T282 = 1/y(3);
T285 = (-1)/exp(y(34));
T286 = (T267*T264*T282)^T285;
T289 = y(25)^T285;
T296 = (y(2)/(y(2)))^params(15);
T299 = (y(3)/pic_star__)^params(13);
T303 = (y(28)/(y(28)))^params(14);
T304 = T299*T303;
T306 = T304^(1-params(15));
T311 = exp(x(7)/100);
T328 = ((1-params(4))/params(4))^params(4);
T331 = T328*(y(17)/y(6))^params(4);
T338 = (params(4)/(1-params(4)))^(1-params(4));
T341 = T338*(y(6)/y(17))^(1-params(4));
T347 = (-(1+exp(y(34))))/exp(y(34));
T348 = y(25)^T347;
T352 = (T264*T267/y(3))^T347;
T353 = params(5)*T352;
T363 = log(y(23))+0.5*exp(y(37))^2;
T364 = T363/exp(y(37));
T370 = normpdf(T364,0,1);
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
rhs =y(11)*(1-params(3))/T25+y(12)*exp(y(33))*T135;
residual(7)= lhs-rhs;
lhs =1;
rhs =exp(y(33))*(T135-T132*params(7)*T131)*y(13)+y(13)*T132*params(7)*T27*exp(y(33))*T147;
residual(8)= lhs-rhs;
lhs =y(14);
rhs =y(11)*y(13)-y(15);
residual(9)= lhs-rhs;
lhs =y(16);
rhs =y(3)*(y(18)*y(17)-(y(17))*(y(18)-1)-T170+(1-params(3))*y(13))/y(13);
residual(10)= lhs-rhs;
lhs =y(17);
rhs =(y(17))+(y(18)-1)*params(24);
residual(11)= lhs-rhs;
lhs =y(11)*y(13)*y(16)*(y(23)*(1-y(20))+(1-params(22))*y(21));
rhs =y(2)*y(14);
residual(12)= lhs-rhs;
residual(13) = T194*(1-y(23)*(1-y(20))-y(21))+T202*((y(23)*(1-y(20))+(1-params(22))*y(21))*T194-1);
lhs =y(19);
rhs =y(11)*y(16)*y(23)/y(14);
residual(14)= lhs-rhs;
lhs =y(15);
rhs =T225/y(3)+params(23)*(y(14));
residual(15)= lhs-rhs;
lhs =T25*y(10);
rhs =y(11)*y(18);
residual(16)= lhs-rhs;
lhs =y(24);
rhs =T244*T246;
residual(17)= lhs-rhs;
lhs =y(25);
rhs =(1+exp(y(34)))*y(26)/y(27);
residual(18)= lhs-rhs;
lhs =y(26);
rhs =y(1)*y(24)*y(28)+y(26)*T271;
residual(19)= lhs-rhs;
lhs =y(27);
rhs =y(1)*y(28)+y(27)*T278;
residual(20)= lhs-rhs;
lhs =1;
rhs =params(5)*T286+(1-params(5))*T289;
residual(21)= lhs-rhs;
lhs =y(2)/(y(2));
rhs =T296*T306*T311;
residual(22)= lhs-rhs;
lhs =y(28)*1/exp(y(35));
rhs =y(4)+y(12)+y(11)*((y(17))*(y(18)-1)+T170)/T25+y(11)*y(13)*y(16)*params(22)*y(21)/T25/y(3);
residual(23)= lhs-rhs;
lhs =y(9);
rhs =y(28)*T331/exp(y(36))*y(29);
residual(24)= lhs-rhs;
lhs =y(10);
rhs =y(29)*y(28)*T341/exp(y(36));
residual(25)= lhs-rhs;
lhs =y(29);
rhs =(1-params(5))*T348+y(29)*T353;
residual(26)= lhs-rhs;
lhs =y(20);
rhs =normcdf(T364,0,1);
residual(27)= lhs-rhs;
lhs =y(21);
rhs =normcdf(T364-exp(y(37)),0,1);
residual(28)= lhs-rhs;
lhs =y(22);
rhs =T370/y(23)/exp(y(37));
residual(29)= lhs-rhs;
lhs =y(30);
rhs =gamma__*(1-params(25))+y(30)*params(25)+x(1)/100;
residual(30)= lhs-rhs;
lhs =y(31);
rhs =y(31)*params(26)+x(2)/100;
residual(31)= lhs-rhs;
lhs =y(32);
rhs =(1-params(27))*log(params(1))+y(32)*params(27)+x(3)/100;
residual(32)= lhs-rhs;
lhs =y(33);
rhs =y(33)*params(28)+x(4)/100;
residual(33)= lhs-rhs;
lhs =y(34);
rhs =(1-params(29))*log(params(18))+y(34)*params(29)+x(5)/100;
residual(34)= lhs-rhs;
lhs =y(35);
rhs =(1-params(30))*log(g_star__)+y(35)*params(30)+x(6)/100;
residual(35)= lhs-rhs;
residual(36) = y(36);
lhs =y(37);
rhs =(1-params(32))*log(params(20))+y(37)*params(32)+x(8)/100;
residual(37)= lhs-rhs;
lhs =y(38);
rhs =(1-params(33))*log(params(21))+y(38)*params(33)+x(9)/100;
residual(38)= lhs-rhs;
lhs =y(42);
rhs =y(30)*100;
residual(39)= lhs-rhs;
lhs =y(43);
rhs =y(30)*100;
residual(40)= lhs-rhs;
lhs =y(44);
rhs =y(30)*100;
residual(41)= lhs-rhs;
lhs =y(45);
rhs =y(30)*100;
residual(42)= lhs-rhs;
lhs =y(41);
rhs =100*log(y(3));
residual(43)= lhs-rhs;
lhs =y(40);
rhs =100*(y(2)-1);
residual(44)= lhs-rhs;
lhs =y(39);
rhs =params(36)*log(y(9))+params(34);
residual(45)= lhs-rhs;
lhs =y(46);
rhs =y(30)+log(y(3))+params(35)/100;
residual(46)= lhs-rhs;
lhs =y(47);
rhs =400*(y(19)-y(2));
residual(47)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(47, 47);

  %
  % Jacobian matrix
  %

T489 = (y(1)*beta__/T25-beta__*y(1)/T25)/(y(1)*y(1));
T530 = getPowerDeriv(T25*y(3),params(11),1);
T536 = (T76-y(3)*T25*T530)/(T76*T76)/T83;
T537 = getPowerDeriv(T84,T66,1);
T543 = getPowerDeriv(T84,T97,1);
T555 = getPowerDeriv(T83*T76*T107,T110,1);
T558 = getPowerDeriv(T116,(-params(2)),1);
T566 = getPowerDeriv(y(3),params(6),1);
T571 = (T264-y(3)*T566)/(T264*T264)/T267;
T595 = getPowerDeriv(T304,1-params(15),1);
T658 = getPowerDeriv(y(17)/y(6),params(4),1);
T666 = getPowerDeriv(y(6)/y(17),1-params(4),1);
T861 = 1/y(23)/exp(y(37));
T868 = exp((-(T364*T364))/2)/2.506628274631;
T875 = exp((-((T364-exp(y(37)))*(T364-exp(y(37)))))/2)/2.506628274631;
T927 = (-(beta__*y(1)*T25))/(T25*T25)/y(1);
T946 = (-(y(3)*T25*y(3)*T530))/(T76*T76)/T83;
T1063 = (exp(y(34))*(-exp(y(34)))-exp(y(34))*(-(1+exp(y(34)))))/(exp(y(34))*exp(y(34)));
T1101 = (exp(y(37))*0.5*exp(y(37))*2*exp(y(37))-exp(y(37))*T363)/(exp(y(37))*exp(y(37)));
  g1(1,1)=y(2)*T489/y(3);
  g1(1,2)=T27/y(3);
  g1(1,3)=(-(T27*y(2)))/(y(3)*y(3));
  g1(1,30)=y(2)*T927/y(3);
  g1(2,1)=1;
  g1(2,4)=(-((-(exp(y(31))*(1-params(8)/T25)))/(T39*T39)-(-(exp(y(31))*beta__*params(8)*(T25-params(8))))/((T25*y(4)-y(4)*params(8))*(T25*y(4)-y(4)*params(8)))));
  g1(2,30)=(-((-(exp(y(31))*(-((-(T25*y(4)*params(8)))/(T25*T25)))))/(T39*T39)-(-(exp(y(31))*beta__*params(8)*T25*y(4)))/((T25*y(4)-y(4)*params(8))*(T25*y(4)-y(4)*params(8)))));
  g1(2,31)=(-T46);
  g1(3,5)=getPowerDeriv(y(5),1+params(9)*(1+params(2))/params(2),1);
  g1(3,7)=(-((1+params(2))/y(8)));
  g1(3,8)=(-((-((1+params(2))*y(7)))/(y(8)*y(8))));
  g1(4,3)=(-(y(7)*exp(y(30)*T66)*beta__*params(10)*T536*T537));
  g1(4,6)=(-(T70*exp(y(32))*getPowerDeriv(y(6),T66,1)));
  g1(4,7)=1-T89;
  g1(4,9)=(-(T68*getPowerDeriv(y(9),1+params(9),1)));
  g1(4,30)=(-(y(7)*(exp(y(30)*T66)*beta__*params(10)*T537*T946+T86*T66*exp(y(30)*T66))));
  g1(4,32)=(-(T68*T70));
  g1(5,1)=(-(y(9)*T94));
  g1(5,3)=(-(y(8)*T101*beta__*params(10)*T536*T543));
  g1(5,6)=(-(y(9)*y(1)*getPowerDeriv(y(6),(1+params(2))/params(2),1)));
  g1(5,8)=1-T102;
  g1(5,9)=(-(y(1)*T94));
  g1(5,30)=(-(y(8)*(T101*beta__*params(10)*T543*T946+T99*T97*T101)));
  g1(6,3)=(-(params(10)*T83*(T107*T25*T530+T76*(-(y(6)/T25))/(y(3)*y(3)))*T555*T558));
  g1(6,5)=(-(T558*(1-params(10))*getPowerDeriv(y(5),T110,1)));
  g1(6,6)=1-T558*params(10)*T555*T83*T76*1/T25/y(3);
  g1(6,30)=(-(T558*params(10)*T555*T83*(T107*T25*y(3)*T530+T76*(-(T25*y(6)))/(T25*T25)/y(3))));
  g1(7,11)=1-(1-params(3))/T25;
  g1(7,12)=(-(exp(y(33))*T135));
  g1(7,30)=(-((-(T25*y(11)*(1-params(3))))/(T25*T25)+y(12)*exp(y(33))*(-(params(7)/2*T131*2*T132))));
  g1(7,33)=(-(y(12)*exp(y(33))*T135));
  g1(8,1)=(-(y(13)*T132*params(7)*T147*exp(y(33))*T489));
  g1(8,13)=(-(exp(y(33))*(T135-T132*params(7)*T131)+T132*params(7)*T27*exp(y(33))*T147));
  g1(8,30)=(-(y(13)*exp(y(33))*((-(params(7)/2*T131*2*T132))-(T132*params(7)*T131+T131*params(7)*T131))+y(13)*(T131*params(7)*T27*exp(y(33))*T147+T132*params(7)*(T147*exp(y(33))*T927+T27*exp(y(33))*T131*2*T131))));
  g1(8,33)=(-(exp(y(33))*(T135-T132*params(7)*T131)*y(13)+y(13)*T132*params(7)*T27*exp(y(33))*T147));
  g1(9,11)=(-y(13));
  g1(9,13)=(-y(11));
  g1(9,14)=1;
  g1(9,15)=1;
  g1(10,3)=(-((y(18)*y(17)-(y(17))*(y(18)-1)-T170+(1-params(3))*y(13))/y(13)));
  g1(10,13)=(-((y(13)*y(3)*(1-params(3))-y(3)*(y(18)*y(17)-(y(17))*(y(18)-1)-T170+(1-params(3))*y(13)))/(y(13)*y(13))));
  g1(10,16)=1;
  g1(10,17)=(-(y(3)*(y(18)-(y(18)-1))/y(13)));
  g1(10,18)=(-(y(3)*(y(17)-(y(17))-params(24)/2*2*(y(18)-1))/y(13)));
  g1(11,18)=(-params(24));
  g1(12,2)=(-y(14));
  g1(12,11)=y(13)*y(16)*(y(23)*(1-y(20))+(1-params(22))*y(21));
  g1(12,13)=(y(23)*(1-y(20))+(1-params(22))*y(21))*y(11)*y(16);
  g1(12,14)=(-y(2));
  g1(12,16)=y(11)*y(13)*(y(23)*(1-y(20))+(1-params(22))*y(21));
  g1(12,20)=y(11)*y(13)*y(16)*(-y(23));
  g1(12,21)=y(11)*y(13)*y(16)*(1-params(22));
  g1(12,23)=y(11)*y(13)*y(16)*(1-y(20));
  g1(13,2)=(1-y(23)*(1-y(20))-y(21))*(-y(16))/(y(2)*y(2))+T202*(y(23)*(1-y(20))+(1-params(22))*y(21))*(-y(16))/(y(2)*y(2));
  g1(13,16)=(1-y(23)*(1-y(20))-y(21))*1/y(2)+T202*(y(23)*(1-y(20))+(1-params(22))*y(21))*1/y(2);
  g1(13,20)=y(23)*T194+((y(23)*(1-y(20))+(1-params(22))*y(21))*T194-1)*((-(1-y(20)-y(23)*params(22)*y(22)))-(-(1-y(20))))/((1-y(20)-y(23)*params(22)*y(22))*(1-y(20)-y(23)*params(22)*y(22)))+T202*T194*(-y(23));
  g1(13,21)=(-T194)+T202*(1-params(22))*T194;
  g1(13,22)=((y(23)*(1-y(20))+(1-params(22))*y(21))*T194-1)*(-((1-y(20))*(-(y(23)*params(22)))))/((1-y(20)-y(23)*params(22)*y(22))*(1-y(20)-y(23)*params(22)*y(22)));
  g1(13,23)=T194*(-(1-y(20)))+((y(23)*(1-y(20))+(1-params(22))*y(21))*T194-1)*(-((1-y(20))*(-(params(22)*y(22)))))/((1-y(20)-y(23)*params(22)*y(22))*(1-y(20)-y(23)*params(22)*y(22)))+T202*(1-y(20))*T194;
  g1(14,11)=(-(y(16)*y(23)/y(14)));
  g1(14,14)=(-((-(y(11)*y(16)*y(23)))/(y(14)*y(14))));
  g1(14,16)=(-(y(11)*y(23)/y(14)));
  g1(14,19)=1;
  g1(14,23)=(-(y(11)*y(16)/y(14)));
  g1(15,2)=(-(exp(y(38))*(-(y(14)/T25))/y(3)));
  g1(15,3)=(-((-T225)/(y(3)*y(3))));
  g1(15,11)=(-(exp(y(38))*(y(13)*y(16)/T25-y(14)*y(13)*y(16)*params(22)*y(21)/y(14)/T25)/y(3)));
  g1(15,13)=(-(exp(y(38))*(y(11)*y(16)/T25-y(14)*y(11)*y(16)*params(22)*y(21)/y(14)/T25)/y(3)));
  g1(15,14)=(-(params(23)+exp(y(38))*(-((y(2)+y(11)*y(13)*y(16)*params(22)*y(21)/y(14)+y(14)*(-(y(11)*y(13)*y(16)*params(22)*y(21)))/(y(14)*y(14)))/T25))/y(3)));
  g1(15,15)=1;
  g1(15,16)=(-(exp(y(38))*(y(11)*y(13)/T25-y(14)*y(11)*y(13)*params(22)*y(21)/y(14)/T25)/y(3)));
  g1(15,21)=(-(exp(y(38))*(-(y(14)*y(11)*y(13)*y(16)*params(22)/y(14)/T25))/y(3)));
  g1(15,30)=(-(exp(y(38))*((-(T25*y(11)*y(13)*y(16)))/(T25*T25)-(-(T25*y(14)*(y(2)+y(11)*y(13)*y(16)*params(22)*y(21)/y(14))))/(T25*T25))/y(3)));
  g1(15,38)=(-(T225/y(3)));
  g1(16,10)=T25;
  g1(16,11)=(-y(18));
  g1(16,18)=(-y(11));
  g1(16,30)=T25*y(10);
  g1(17,6)=(-(T246*1/exp(y(36))*1/(1-params(4))*getPowerDeriv(y(6)/(1-params(4)),1-params(4),1)));
  g1(17,17)=(-(T244*1/params(4)*getPowerDeriv(y(17)/params(4),params(4),1)));
  g1(17,24)=1;
  g1(17,36)=(-(T246*T243*(-exp(y(36)))/(exp(y(36))*exp(y(36)))));
  g1(18,25)=1;
  g1(18,26)=(-((1+exp(y(34)))/y(27)));
  g1(18,27)=(-((-((1+exp(y(34)))*y(26)))/(y(27)*y(27))));
  g1(18,34)=(-(exp(y(34))*y(26)/y(27)));
  g1(19,1)=(-(y(24)*y(28)));
  g1(19,3)=(-(y(26)*beta__*params(5)*T571*getPowerDeriv(T268,(1+exp(y(34)))/exp(y(34)),1)));
  g1(19,24)=(-(y(1)*y(28)));
  g1(19,26)=1-T271;
  g1(19,28)=(-(y(1)*y(24)));
  g1(19,34)=(-(y(26)*beta__*params(5)*T270*(exp(y(34))*exp(y(34))-exp(y(34))*(1+exp(y(34))))/(exp(y(34))*exp(y(34)))*log(T268)));
  g1(20,1)=(-y(28));
  g1(20,3)=(-(y(27)*beta__*params(5)*T571*getPowerDeriv(T268,1/exp(y(34)),1)));
  g1(20,27)=1-T278;
  g1(20,28)=(-y(1));
  g1(20,34)=(-(y(27)*beta__*params(5)*T277*log(T268)*(-exp(y(34)))/(exp(y(34))*exp(y(34)))));
  g1(21,3)=(-(params(5)*T267*(T282*T566+T264*(-1)/(y(3)*y(3)))*getPowerDeriv(T267*T264*T282,T285,1)));
  g1(21,25)=(-((1-params(5))*getPowerDeriv(y(25),T285,1)));
  g1(21,34)=(-(params(5)*T286*exp(y(34))/(exp(y(34))*exp(y(34)))*log(T267*T264*T282)+(1-params(5))*T289*exp(y(34))/(exp(y(34))*exp(y(34)))*log(y(25))));
  g1(22,2)=((y(2))-y(2))/((y(2))*(y(2)))-T311*T306*((y(2))-y(2))/((y(2))*(y(2)))*getPowerDeriv(y(2)/(y(2)),params(15),1);
  g1(22,3)=(-(T311*T296*T303*1/pic_star__*getPowerDeriv(y(3)/pic_star__,params(13),1)*T595));
  g1(22,28)=(-(T311*T296*T595*T299*((y(28))-y(28))/((y(28))*(y(28)))*getPowerDeriv(y(28)/(y(28)),params(14),1)));
  g1(23,3)=(-((-(y(11)*y(13)*y(16)*params(22)*y(21)/T25))/(y(3)*y(3))));
  g1(23,4)=(-1);
  g1(23,11)=(-(((y(17))*(y(18)-1)+T170)/T25+y(13)*y(16)*params(22)*y(21)/T25/y(3)));
  g1(23,12)=(-1);
  g1(23,13)=(-(y(11)*y(16)*params(22)*y(21)/T25/y(3)));
  g1(23,16)=(-(y(11)*y(13)*params(22)*y(21)/T25/y(3)));
  g1(23,17)=(-(y(11)*(y(18)-1)/T25));
  g1(23,18)=(-(y(11)*((y(17))+params(24)/2*2*(y(18)-1))/T25));
  g1(23,21)=(-(y(11)*y(13)*y(16)*params(22)/T25/y(3)));
  g1(23,28)=1/exp(y(35));
  g1(23,30)=(-((-(T25*y(11)*((y(17))*(y(18)-1)+T170)))/(T25*T25)+(-(T25*y(11)*y(13)*y(16)*params(22)*y(21)))/(T25*T25)/y(3)));
  g1(23,35)=y(28)*(-exp(y(35)))/(exp(y(35))*exp(y(35)));
  g1(24,6)=(-(y(29)*y(28)*T328*(-y(17))/(y(6)*y(6))*T658/exp(y(36))));
  g1(24,9)=1;
  g1(24,17)=(-(y(29)*y(28)*T328*T658*1/y(6)/exp(y(36))));
  g1(24,28)=(-(y(29)*T331/exp(y(36))));
  g1(24,29)=(-(y(28)*T331/exp(y(36))));
  g1(24,36)=(-(y(29)*(-(exp(y(36))*y(28)*T331))/(exp(y(36))*exp(y(36)))));
  g1(25,6)=(-(y(29)*y(28)*T338*1/y(17)*T666/exp(y(36))));
  g1(25,10)=1;
  g1(25,17)=(-(y(29)*y(28)*T338*T666*(-y(6))/(y(17)*y(17))/exp(y(36))));
  g1(25,28)=(-(y(29)*T341/exp(y(36))));
  g1(25,29)=(-(y(28)*T341/exp(y(36))));
  g1(25,36)=(-(y(29)*(-(exp(y(36))*y(28)*T341))/(exp(y(36))*exp(y(36)))));
  g1(26,3)=(-(y(29)*params(5)*(y(3)*T267*T566-T264*T267)/(y(3)*y(3))*getPowerDeriv(T264*T267/y(3),T347,1)));
  g1(26,25)=(-((1-params(5))*getPowerDeriv(y(25),T347,1)));
  g1(26,29)=1-T353;
  g1(26,34)=(-((1-params(5))*T348*log(y(25))*T1063+y(29)*params(5)*T352*T1063*log(T264*T267/y(3))));
  g1(27,20)=1;
  g1(27,23)=(-(T861*T868));
  g1(27,37)=(-(T868*T1101));
  g1(28,21)=1;
  g1(28,23)=(-(T861*T875));
  g1(28,37)=(-(T875*(T1101-exp(y(37)))));
  g1(29,22)=1;
  g1(29,23)=(-((y(23)*T370*T364*(-T861)-T370)/(y(23)*y(23))/exp(y(37))));
  g1(29,37)=(-((exp(y(37))*T370*T364*(-T1101)/y(23)-exp(y(37))*T370/y(23))/(exp(y(37))*exp(y(37)))));
  g1(30,30)=1-params(25);
  g1(31,31)=1-params(26);
  g1(32,32)=1-params(27);
  g1(33,33)=1-params(28);
  g1(34,34)=1-params(29);
  g1(35,35)=1-params(30);
  g1(36,36)=1;
  g1(37,37)=1-params(32);
  g1(38,38)=1-params(33);
  g1(39,30)=(-100);
  g1(39,42)=1;
  g1(40,30)=(-100);
  g1(40,43)=1;
  g1(41,30)=(-100);
  g1(41,44)=1;
  g1(42,30)=(-100);
  g1(42,45)=1;
  g1(43,3)=(-(T282*100));
  g1(43,41)=1;
  g1(44,2)=(-100);
  g1(44,40)=1;
  g1(45,9)=(-(params(36)*1/y(9)));
  g1(45,39)=1;
  g1(46,3)=(-T282);
  g1(46,30)=(-1);
  g1(46,46)=1;
  g1(47,2)=400;
  g1(47,19)=(-400);
  g1(47,47)=1;
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
