function [residual, g1, g2, g3] = US_DSSW07FF_20092_dynamic(y, x, params, steady_state, it_)
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
beta__ = 1/(1+params(12)/400);
pic_star__ = 1+params(16)/400;
g_star__ = 1/(1-params(19));
gamma__ = params(17)/400;
T28 = beta__*y(66)/exp(y(80))/y(19);
T41 = exp(y(48));
T43 = y(22)-params(8)*y(3)/T41;
T74 = (1+params(2))*(1+params(9))/params(2);
T76 = exp(y(50))*y(24)^T74;
T78 = y(27)^(1+params(9));
T85 = (T41*y(21))^params(11);
T92 = (pic_star__*exp(gamma__))^(1-params(11));
T93 = y(67)/T85/T92;
T95 = beta__*params(10)*T93^T74;
T98 = T95*exp(y(80)*T74);
T104 = y(24)^((1+params(2))/params(2));
T107 = 1/params(2);
T109 = beta__*params(10)*T93^T107;
T111 = exp(y(80)*T107);
T112 = T109*T111;
T119 = y(4)/T41/y(21);
T124 = (y(2)*exp(y(11)))^params(11);
T126 = T92*T119*T124;
T127 = (-1)/params(2);
T133 = params(10)*T126^T127+(1-params(10))*y(23)^T127;
T146 = params(7)/2;
T150 = T41*y(30)/y(6);
T151 = T150-exp(gamma__);
T154 = 1-T146*T151^2;
T170 = exp(y(80))*y(71)/y(30);
T171 = T170^2;
T174 = T170-exp(gamma__);
T196 = params(24)/2*(y(36)-1)^2;
T224 = y(73)/y(20);
T237 = (1-y(74))/(1-y(74)-params(22)*y(77)*y(76));
T262 = exp(y(56))*(y(5)*y(34)*y(7)/T41-y(8)*(y(1)+y(5)*y(7)*y(34)*params(22)*y(39)/y(8))/T41);
T280 = (y(24)/(1-params(4)))^(1-params(4));
T281 = 1/exp(y(54))*T280;
T283 = (y(35)/params(4))^params(4);
T301 = y(21)^params(6);
T304 = pic_star__^(1-params(6));
T305 = y(67)/T301/T304;
T307 = T305^((1+exp(y(52)))/exp(y(52)));
T308 = beta__*params(5)*T307;
T315 = T305^(1/exp(y(52)));
T316 = beta__*params(5)*T315;
T321 = 1/y(21);
T322 = y(2)^params(6);
T325 = (-1)/exp(y(52));
T326 = (T304*T321*T322)^T325;
T329 = y(43)^T325;
T337 = (y(1)/(steady_state(2)))^params(15);
T340 = (y(21)/pic_star__)^params(13);
T344 = (y(46)/(steady_state(28)))^params(14);
T345 = T340*T344;
T347 = T345^(1-params(15));
T352 = exp(x(it_, 7)/100);
T369 = ((1-params(4))/params(4))^params(4);
T372 = T369*(y(35)/y(24))^params(4);
T379 = (params(4)/(1-params(4)))^(1-params(4));
T382 = T379*(y(24)/y(35))^(1-params(4));
T388 = (-(1+exp(y(52))))/exp(y(52));
T389 = y(43)^T388;
T393 = (T304*T322/y(21))^T388;
T394 = params(5)*T393;
T405 = log(y(41))+0.5*exp(y(55))^2;
T406 = T405/exp(y(55));
T413 = normpdf(T406,0,1);
lhs =T28*y(20)/y(67);
rhs =1;
residual(1)= lhs-rhs;
lhs =y(19);
rhs =exp(y(49))/T43-beta__*params(8)*exp(y(81))/(exp(y(80))*y(68)-y(22)*params(8));
residual(2)= lhs-rhs;
lhs =y(23)^(1+params(9)*(1+params(2))/params(2));
rhs =(1+params(2))*y(25)/y(26);
residual(3)= lhs-rhs;
lhs =y(25);
rhs =T76*T78+T98*y(69);
residual(4)= lhs-rhs;
lhs =y(26);
rhs =y(27)*y(19)*T104+T112*y(70);
residual(5)= lhs-rhs;
lhs =y(24);
rhs =T133^(-params(2));
residual(6)= lhs-rhs;
lhs =y(29);
rhs =(1-params(3))*y(5)/T41+y(30)*exp(y(51))*T154;
residual(7)= lhs-rhs;
lhs =1;
rhs =exp(y(51))*(T154-T151*params(7)*T150)*y(31)+params(7)*T28*exp(y(82))*T171*T174*y(72);
residual(8)= lhs-rhs;
lhs =y(32);
rhs =y(29)*y(31)-y(33);
residual(9)= lhs-rhs;
lhs =y(34);
rhs =y(21)*(y(36)*y(35)-(steady_state(17))*(y(36)-1)-T196+(1-params(3))*y(31))/y(7);
residual(10)= lhs-rhs;
lhs =y(35);
rhs =(steady_state(17))+(y(36)-1)*params(24);
residual(11)= lhs-rhs;
lhs =y(5)*y(34)*y(7)*(y(41)*(1-y(38))+(1-params(22))*y(39));
rhs =y(1)*y(8);
residual(12)= lhs-rhs;
residual(13) = T224*(1-y(77)*(1-y(74))-y(75))+T237*(T224*(y(77)*(1-y(74))+(1-params(22))*y(75))-1);
lhs =y(37);
rhs =y(5)*y(34)*y(41)/y(8);
residual(14)= lhs-rhs;
lhs =y(33);
rhs =T262/y(21)+params(23)*(steady_state(14));
residual(15)= lhs-rhs;
lhs =T41*y(28);
rhs =y(5)*y(36);
residual(16)= lhs-rhs;
lhs =y(42);
rhs =T281*T283;
residual(17)= lhs-rhs;
lhs =y(43);
rhs =(1+exp(y(52)))*y(44)/y(45);
residual(18)= lhs-rhs;
lhs =y(44);
rhs =y(19)*y(42)*y(46)+T308*y(78);
residual(19)= lhs-rhs;
lhs =y(45);
rhs =y(19)*y(46)+T316*y(79);
residual(20)= lhs-rhs;
lhs =1;
rhs =params(5)*T326+(1-params(5))*T329;
residual(21)= lhs-rhs;
lhs =y(20)/(steady_state(2));
rhs =T337*T347*T352;
residual(22)= lhs-rhs;
lhs =y(46)*1/exp(y(53));
rhs =y(22)+y(30)+y(5)*((steady_state(17))*(y(36)-1)+T196)/T41+y(5)*y(7)*y(34)*params(22)*y(39)/T41/y(21);
residual(23)= lhs-rhs;
lhs =y(27);
rhs =y(46)*T372/exp(y(54))*y(47);
residual(24)= lhs-rhs;
lhs =y(28);
rhs =y(47)*y(46)*T382/exp(y(54));
residual(25)= lhs-rhs;
lhs =y(47);
rhs =(1-params(5))*T389+T394*y(10);
residual(26)= lhs-rhs;
lhs =y(38);
rhs =normcdf(T406,0,1);
residual(27)= lhs-rhs;
lhs =y(39);
rhs =normcdf(T406-exp(y(55)),0,1);
residual(28)= lhs-rhs;
lhs =y(40);
rhs =T413/y(41)/exp(y(55));
residual(29)= lhs-rhs;
lhs =y(48);
rhs =gamma__*(1-params(25))+y(11)*params(25)+x(it_, 1)/100;
residual(30)= lhs-rhs;
lhs =y(49);
rhs =params(26)*y(12)+x(it_, 2)/100;
residual(31)= lhs-rhs;
lhs =y(50);
rhs =(1-params(27))*log(params(1))+params(27)*y(13)+x(it_, 3)/100;
residual(32)= lhs-rhs;
lhs =y(51);
rhs =params(28)*y(14)+x(it_, 4)/100;
residual(33)= lhs-rhs;
lhs =y(52);
rhs =(1-params(29))*log(params(18))+params(29)*y(15)+x(it_, 5)/100;
residual(34)= lhs-rhs;
lhs =y(53);
rhs =(1-params(30))*log(g_star__)+params(30)*y(16)+x(it_, 6)/100;
residual(35)= lhs-rhs;
residual(36) = y(54);
lhs =y(55);
rhs =(1-params(32))*log(params(20))+params(32)*y(17)+x(it_, 8)/100;
residual(37)= lhs-rhs;
lhs =y(56);
rhs =(1-params(33))*log(params(21))+params(33)*y(18)+x(it_, 9)/100;
residual(38)= lhs-rhs;
lhs =y(60);
rhs =100*(y(48)+log(y(46)/y(9)));
residual(39)= lhs-rhs;
lhs =y(61);
rhs =100*(y(48)+log(y(22)/y(3)));
residual(40)= lhs-rhs;
lhs =y(62);
rhs =100*(y(48)+log(y(30)/y(6)));
residual(41)= lhs-rhs;
lhs =y(63);
rhs =100*(y(48)+log(y(24)/y(4)));
residual(42)= lhs-rhs;
lhs =y(59);
rhs =100*log(y(21));
residual(43)= lhs-rhs;
lhs =y(58);
rhs =100*(y(20)-1);
residual(44)= lhs-rhs;
lhs =y(57);
rhs =params(36)*log(y(27))+params(34);
residual(45)= lhs-rhs;
lhs =y(64);
rhs =log(y(21))+y(48)+log(y(32)/y(8))+params(35)/100;
residual(46)= lhs-rhs;
lhs =y(65);
rhs =400*(y(37)-y(20));
residual(47)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(47, 91);

  %
  % Jacobian matrix
  %

T556 = (-(beta__*y(66)/exp(y(80))))/(y(19)*y(19));
T571 = beta__/exp(y(80))/y(19);
T602 = getPowerDeriv(y(2)*exp(y(11)),params(11),1);
T606 = getPowerDeriv(T126,T127,1);
T609 = getPowerDeriv(T133,(-params(2)),1);
T612 = getPowerDeriv(y(2),params(6),1);
T615 = getPowerDeriv(T304*T321*T322,T325,1);
T621 = getPowerDeriv(T304*T322/y(21),T388,1);
T626 = getPowerDeriv(T41*y(21),params(11),1);
T632 = (-(y(67)*T41*T626))/(T85*T85)/T92;
T633 = getPowerDeriv(T93,T74,1);
T639 = getPowerDeriv(T93,T107,1);
T664 = (-(y(67)*getPowerDeriv(y(21),params(6),1)))/(T301*T301)/T304;
T665 = getPowerDeriv(T305,(1+exp(y(52)))/exp(y(52)),1);
T670 = getPowerDeriv(T305,1/exp(y(52)),1);
T685 = getPowerDeriv(T345,1-params(15),1);
T706 = 1/T85/T92;
T718 = 1/T301/T304;
T793 = getPowerDeriv(y(35)/y(24),params(4),1);
T801 = getPowerDeriv(y(24)/y(35),1-params(4),1);
T849 = (-(T41*y(30)))/(y(6)*y(6));
T1056 = 1/y(41)/exp(y(55));
T1063 = exp((-(T406*T406))/2)/2.506628274631;
T1070 = exp((-((T406-exp(y(55)))*(T406-exp(y(55)))))/2)/2.506628274631;
T1157 = (-(y(67)*T41*y(21)*T626))/(T85*T85)/T92;
T1217 = (-(beta__*y(66)*exp(y(80))))/(exp(y(80))*exp(y(80)))/y(19);
T1287 = (exp(y(52))*(-exp(y(52)))-exp(y(52))*(-(1+exp(y(52)))))/(exp(y(52))*exp(y(52)));
T1327 = (exp(y(55))*0.5*exp(y(55))*2*exp(y(55))-exp(y(55))*T405)/(exp(y(55))*exp(y(55)));
  g1(1,19)=y(20)*T556/y(67);
  g1(1,66)=y(20)*T571/y(67);
  g1(1,20)=T28/y(67);
  g1(1,67)=(-(T28*y(20)))/(y(67)*y(67));
  g1(1,80)=y(20)*T1217/y(67);
  g1(2,19)=1;
  g1(2,3)=(-((-(exp(y(49))*(-(params(8)/T41))))/(T43*T43)));
  g1(2,22)=(-((-exp(y(49)))/(T43*T43)-(-(beta__*params(8)*exp(y(81))*(-params(8))))/((exp(y(80))*y(68)-y(22)*params(8))*(exp(y(80))*y(68)-y(22)*params(8)))));
  g1(2,68)=(-(exp(y(80))*beta__*params(8)*exp(y(81))))/((exp(y(80))*y(68)-y(22)*params(8))*(exp(y(80))*y(68)-y(22)*params(8)));
  g1(2,48)=(-((-(exp(y(49))*(-((-(params(8)*y(3)*T41))/(T41*T41)))))/(T43*T43)));
  g1(2,80)=(-(beta__*params(8)*exp(y(81))*exp(y(80))*y(68)))/((exp(y(80))*y(68)-y(22)*params(8))*(exp(y(80))*y(68)-y(22)*params(8)));
  g1(2,49)=(-(exp(y(49))/T43));
  g1(2,81)=beta__*params(8)*exp(y(81))/(exp(y(80))*y(68)-y(22)*params(8));
  g1(3,23)=getPowerDeriv(y(23),1+params(9)*(1+params(2))/params(2),1);
  g1(3,25)=(-((1+params(2))/y(26)));
  g1(3,26)=(-((-((1+params(2))*y(25)))/(y(26)*y(26))));
  g1(4,21)=(-(y(69)*exp(y(80)*T74)*beta__*params(10)*T632*T633));
  g1(4,67)=(-(y(69)*exp(y(80)*T74)*beta__*params(10)*T633*T706));
  g1(4,24)=(-(T78*exp(y(50))*getPowerDeriv(y(24),T74,1)));
  g1(4,25)=1;
  g1(4,69)=(-T98);
  g1(4,27)=(-(T76*getPowerDeriv(y(27),1+params(9),1)));
  g1(4,48)=(-(y(69)*exp(y(80)*T74)*beta__*params(10)*T633*T1157));
  g1(4,80)=(-(y(69)*T95*T74*exp(y(80)*T74)));
  g1(4,50)=(-(T76*T78));
  g1(5,19)=(-(y(27)*T104));
  g1(5,21)=(-(y(70)*T111*beta__*params(10)*T632*T639));
  g1(5,67)=(-(y(70)*T111*beta__*params(10)*T639*T706));
  g1(5,24)=(-(y(27)*y(19)*getPowerDeriv(y(24),(1+params(2))/params(2),1)));
  g1(5,26)=1;
  g1(5,70)=(-T112);
  g1(5,27)=(-(y(19)*T104));
  g1(5,48)=(-(y(70)*T111*beta__*params(10)*T639*T1157));
  g1(5,80)=(-(y(70)*T109*T107*T111));
  g1(6,2)=(-(params(10)*T92*T119*exp(y(11))*T602*T606*T609));
  g1(6,21)=(-(T609*params(10)*T606*T92*T124*(-(y(4)/T41))/(y(21)*y(21))));
  g1(6,23)=(-(T609*(1-params(10))*getPowerDeriv(y(23),T127,1)));
  g1(6,4)=(-(T609*params(10)*T606*T92*T124*1/T41/y(21)));
  g1(6,24)=1;
  g1(6,11)=(-(T609*params(10)*T606*T92*T119*y(2)*exp(y(11))*T602));
  g1(6,48)=(-(T609*params(10)*T606*T92*T124*(-(T41*y(4)))/(T41*T41)/y(21)));
  g1(7,5)=(-((1-params(3))/T41));
  g1(7,29)=1;
  g1(7,6)=(-(y(30)*exp(y(51))*(-(T146*T849*2*T151))));
  g1(7,30)=(-(exp(y(51))*T154+y(30)*exp(y(51))*(-(T146*2*T151*T41/y(6)))));
  g1(7,48)=(-((-(T41*(1-params(3))*y(5)))/(T41*T41)+y(30)*exp(y(51))*(-(T146*T150*2*T151))));
  g1(7,51)=(-(y(30)*exp(y(51))*T154));
  g1(8,19)=(-(y(72)*T174*params(7)*T171*exp(y(82))*T556));
  g1(8,66)=(-(y(72)*T174*params(7)*T171*exp(y(82))*T571));
  g1(8,6)=(-(y(31)*exp(y(51))*((-(T146*T849*2*T151))-(params(7)*T150*T849+T151*params(7)*T849))));
  g1(8,30)=(-(y(31)*exp(y(51))*((-(T146*2*T151*T41/y(6)))-(params(7)*T150*T41/y(6)+T151*params(7)*T41/y(6)))+y(72)*(T174*params(7)*T28*exp(y(82))*(-(exp(y(80))*y(71)))/(y(30)*y(30))*2*T170+params(7)*T28*exp(y(82))*T171*(-(exp(y(80))*y(71)))/(y(30)*y(30)))));
  g1(8,71)=(-(y(72)*(T174*params(7)*T28*exp(y(82))*2*T170*exp(y(80))/y(30)+params(7)*T28*exp(y(82))*T171*exp(y(80))/y(30))));
  g1(8,31)=(-(exp(y(51))*(T154-T151*params(7)*T150)));
  g1(8,72)=(-(params(7)*T28*exp(y(82))*T171*T174));
  g1(8,48)=(-(y(31)*exp(y(51))*((-(T146*T150*2*T151))-(T151*params(7)*T150+T150*params(7)*T150))));
  g1(8,80)=(-(y(72)*(T174*params(7)*(T171*exp(y(82))*T1217+T28*exp(y(82))*T170*2*T170)+T170*params(7)*T28*exp(y(82))*T171)));
  g1(8,51)=(-(exp(y(51))*(T154-T151*params(7)*T150)*y(31)));
  g1(8,82)=(-(params(7)*T28*exp(y(82))*T171*T174*y(72)));
  g1(9,29)=(-y(31));
  g1(9,31)=(-y(29));
  g1(9,32)=1;
  g1(9,33)=1;
  g1(10,21)=(-((y(36)*y(35)-(steady_state(17))*(y(36)-1)-T196+(1-params(3))*y(31))/y(7)));
  g1(10,7)=(-((-(y(21)*(y(36)*y(35)-(steady_state(17))*(y(36)-1)-T196+(1-params(3))*y(31))))/(y(7)*y(7))));
  g1(10,31)=(-(y(21)*(1-params(3))/y(7)));
  g1(10,34)=1;
  g1(10,35)=(-(y(21)*y(36)/y(7)));
  g1(10,36)=(-(y(21)*(y(35)-(steady_state(17))-params(24)/2*2*(y(36)-1))/y(7)));
  g1(11,35)=1;
  g1(11,36)=(-params(24));
  g1(12,1)=(-y(8));
  g1(12,5)=y(34)*y(7)*(y(41)*(1-y(38))+(1-params(22))*y(39));
  g1(12,7)=(y(41)*(1-y(38))+(1-params(22))*y(39))*y(5)*y(34);
  g1(12,8)=(-y(1));
  g1(12,34)=(y(41)*(1-y(38))+(1-params(22))*y(39))*y(5)*y(7);
  g1(12,38)=y(5)*y(34)*y(7)*(-y(41));
  g1(12,39)=y(5)*y(34)*y(7)*(1-params(22));
  g1(12,41)=y(5)*y(34)*y(7)*(1-y(38));
  g1(13,20)=(1-y(77)*(1-y(74))-y(75))*(-y(73))/(y(20)*y(20))+T237*(y(77)*(1-y(74))+(1-params(22))*y(75))*(-y(73))/(y(20)*y(20));
  g1(13,73)=(1-y(77)*(1-y(74))-y(75))*1/y(20)+T237*(y(77)*(1-y(74))+(1-params(22))*y(75))*1/y(20);
  g1(13,74)=T224*y(77)+(T224*(y(77)*(1-y(74))+(1-params(22))*y(75))-1)*((-(1-y(74)-params(22)*y(77)*y(76)))-(-(1-y(74))))/((1-y(74)-params(22)*y(77)*y(76))*(1-y(74)-params(22)*y(77)*y(76)))+T237*T224*(-y(77));
  g1(13,75)=(-T224)+T237*(1-params(22))*T224;
  g1(13,76)=(T224*(y(77)*(1-y(74))+(1-params(22))*y(75))-1)*(-((1-y(74))*(-(params(22)*y(77)))))/((1-y(74)-params(22)*y(77)*y(76))*(1-y(74)-params(22)*y(77)*y(76)));
  g1(13,77)=T224*(-(1-y(74)))+(T224*(y(77)*(1-y(74))+(1-params(22))*y(75))-1)*(-((1-y(74))*(-(params(22)*y(76)))))/((1-y(74)-params(22)*y(77)*y(76))*(1-y(74)-params(22)*y(77)*y(76)))+T237*T224*(1-y(74));
  g1(14,5)=(-(y(34)*y(41)/y(8)));
  g1(14,8)=(-((-(y(5)*y(34)*y(41)))/(y(8)*y(8))));
  g1(14,34)=(-(y(5)*y(41)/y(8)));
  g1(14,37)=1;
  g1(14,41)=(-(y(5)*y(34)/y(8)));
  g1(15,1)=(-(exp(y(56))*(-(y(8)/T41))/y(21)));
  g1(15,21)=(-((-T262)/(y(21)*y(21))));
  g1(15,5)=(-(exp(y(56))*(y(34)*y(7)/T41-y(8)*y(7)*y(34)*params(22)*y(39)/y(8)/T41)/y(21)));
  g1(15,7)=(-(exp(y(56))*(y(5)*y(34)/T41-y(8)*y(5)*y(34)*params(22)*y(39)/y(8)/T41)/y(21)));
  g1(15,8)=(-(exp(y(56))*(-((y(1)+y(5)*y(7)*y(34)*params(22)*y(39)/y(8)+y(8)*(-(y(5)*y(7)*y(34)*params(22)*y(39)))/(y(8)*y(8)))/T41))/y(21)));
  g1(15,33)=1;
  g1(15,34)=(-(exp(y(56))*(y(5)*y(7)/T41-y(8)*y(5)*y(7)*params(22)*y(39)/y(8)/T41)/y(21)));
  g1(15,39)=(-(exp(y(56))*(-(y(8)*y(5)*y(7)*y(34)*params(22)/y(8)/T41))/y(21)));
  g1(15,48)=(-(exp(y(56))*((-(T41*y(5)*y(34)*y(7)))/(T41*T41)-(-(T41*y(8)*(y(1)+y(5)*y(7)*y(34)*params(22)*y(39)/y(8))))/(T41*T41))/y(21)));
  g1(15,56)=(-(T262/y(21)));
  g1(16,28)=T41;
  g1(16,5)=(-y(36));
  g1(16,36)=(-y(5));
  g1(16,48)=T41*y(28);
  g1(17,24)=(-(T283*1/exp(y(54))*1/(1-params(4))*getPowerDeriv(y(24)/(1-params(4)),1-params(4),1)));
  g1(17,35)=(-(T281*1/params(4)*getPowerDeriv(y(35)/params(4),params(4),1)));
  g1(17,42)=1;
  g1(17,54)=(-(T283*T280*(-exp(y(54)))/(exp(y(54))*exp(y(54)))));
  g1(18,43)=1;
  g1(18,44)=(-((1+exp(y(52)))/y(45)));
  g1(18,45)=(-((-((1+exp(y(52)))*y(44)))/(y(45)*y(45))));
  g1(18,52)=(-(exp(y(52))*y(44)/y(45)));
  g1(19,19)=(-(y(42)*y(46)));
  g1(19,21)=(-(y(78)*beta__*params(5)*T664*T665));
  g1(19,67)=(-(y(78)*beta__*params(5)*T665*T718));
  g1(19,42)=(-(y(19)*y(46)));
  g1(19,44)=1;
  g1(19,78)=(-T308);
  g1(19,46)=(-(y(19)*y(42)));
  g1(19,52)=(-(y(78)*beta__*params(5)*T307*(exp(y(52))*exp(y(52))-exp(y(52))*(1+exp(y(52))))/(exp(y(52))*exp(y(52)))*log(T305)));
  g1(20,19)=(-y(46));
  g1(20,21)=(-(y(79)*beta__*params(5)*T664*T670));
  g1(20,67)=(-(y(79)*beta__*params(5)*T670*T718));
  g1(20,45)=1;
  g1(20,79)=(-T316);
  g1(20,46)=(-y(19));
  g1(20,52)=(-(y(79)*beta__*params(5)*T315*log(T305)*(-exp(y(52)))/(exp(y(52))*exp(y(52)))));
  g1(21,2)=(-(params(5)*T304*T321*T612*T615));
  g1(21,21)=(-(params(5)*T615*T304*T322*(-1)/(y(21)*y(21))));
  g1(21,43)=(-((1-params(5))*getPowerDeriv(y(43),T325,1)));
  g1(21,52)=(-(params(5)*T326*exp(y(52))/(exp(y(52))*exp(y(52)))*log(T304*T321*T322)+(1-params(5))*T329*exp(y(52))/(exp(y(52))*exp(y(52)))*log(y(43))));
  g1(22,1)=(-(T352*T347*1/(steady_state(2))*getPowerDeriv(y(1)/(steady_state(2)),params(15),1)));
  g1(22,20)=1/(steady_state(2));
  g1(22,21)=(-(T352*T337*T344*1/pic_star__*getPowerDeriv(y(21)/pic_star__,params(13),1)*T685));
  g1(22,46)=(-(T352*T337*T685*T340*1/(steady_state(28))*getPowerDeriv(y(46)/(steady_state(28)),params(14),1)));
  g1(22,89)=(-(T337*T347*T352*0.01));
  g1(23,21)=(-((-(y(5)*y(7)*y(34)*params(22)*y(39)/T41))/(y(21)*y(21))));
  g1(23,22)=(-1);
  g1(23,5)=(-(((steady_state(17))*(y(36)-1)+T196)/T41+y(7)*y(34)*params(22)*y(39)/T41/y(21)));
  g1(23,30)=(-1);
  g1(23,7)=(-(y(5)*y(34)*params(22)*y(39)/T41/y(21)));
  g1(23,34)=(-(y(5)*y(7)*params(22)*y(39)/T41/y(21)));
  g1(23,36)=(-(y(5)*((steady_state(17))+params(24)/2*2*(y(36)-1))/T41));
  g1(23,39)=(-(y(5)*y(7)*y(34)*params(22)/T41/y(21)));
  g1(23,46)=1/exp(y(53));
  g1(23,48)=(-((-(T41*y(5)*((steady_state(17))*(y(36)-1)+T196)))/(T41*T41)+(-(T41*y(5)*y(7)*y(34)*params(22)*y(39)))/(T41*T41)/y(21)));
  g1(23,53)=y(46)*(-exp(y(53)))/(exp(y(53))*exp(y(53)));
  g1(24,24)=(-(y(47)*y(46)*T369*(-y(35))/(y(24)*y(24))*T793/exp(y(54))));
  g1(24,27)=1;
  g1(24,35)=(-(y(47)*y(46)*T369*T793*1/y(24)/exp(y(54))));
  g1(24,46)=(-(y(47)*T372/exp(y(54))));
  g1(24,47)=(-(y(46)*T372/exp(y(54))));
  g1(24,54)=(-(y(47)*(-(exp(y(54))*y(46)*T372))/(exp(y(54))*exp(y(54)))));
  g1(25,24)=(-(y(47)*y(46)*T379*1/y(35)*T801/exp(y(54))));
  g1(25,28)=1;
  g1(25,35)=(-(y(47)*y(46)*T379*T801*(-y(24))/(y(35)*y(35))/exp(y(54))));
  g1(25,46)=(-(y(47)*T382/exp(y(54))));
  g1(25,47)=(-(y(46)*T382/exp(y(54))));
  g1(25,54)=(-(y(47)*(-(exp(y(54))*y(46)*T382))/(exp(y(54))*exp(y(54)))));
  g1(26,2)=(-(y(10)*params(5)*T304*T612/y(21)*T621));
  g1(26,21)=(-(y(10)*params(5)*T621*(-(T304*T322))/(y(21)*y(21))));
  g1(26,43)=(-((1-params(5))*getPowerDeriv(y(43),T388,1)));
  g1(26,10)=(-T394);
  g1(26,47)=1;
  g1(26,52)=(-((1-params(5))*T389*log(y(43))*T1287+y(10)*params(5)*T393*T1287*log(T304*T322/y(21))));
  g1(27,38)=1;
  g1(27,41)=(-(T1056*T1063));
  g1(27,55)=(-(T1063*T1327));
  g1(28,39)=1;
  g1(28,41)=(-(T1056*T1070));
  g1(28,55)=(-(T1070*(T1327-exp(y(55)))));
  g1(29,40)=1;
  g1(29,41)=(-((y(41)*T413*T406*(-T1056)-T413)/(y(41)*y(41))/exp(y(55))));
  g1(29,55)=(-((exp(y(55))*T413*T406*(-T1327)/y(41)-exp(y(55))*T413/y(41))/(exp(y(55))*exp(y(55)))));
  g1(30,11)=(-params(25));
  g1(30,48)=1;
  g1(30,83)=(-0.01);
  g1(31,12)=(-params(26));
  g1(31,49)=1;
  g1(31,84)=(-0.01);
  g1(32,13)=(-params(27));
  g1(32,50)=1;
  g1(32,85)=(-0.01);
  g1(33,14)=(-params(28));
  g1(33,51)=1;
  g1(33,86)=(-0.01);
  g1(34,15)=(-params(29));
  g1(34,52)=1;
  g1(34,87)=(-0.01);
  g1(35,16)=(-params(30));
  g1(35,53)=1;
  g1(35,88)=(-0.01);
  g1(36,54)=1;
  g1(37,17)=(-params(32));
  g1(37,55)=1;
  g1(37,90)=(-0.01);
  g1(38,18)=(-params(33));
  g1(38,56)=1;
  g1(38,91)=(-0.01);
  g1(39,9)=(-(100*(-y(46))/(y(9)*y(9))/(y(46)/y(9))));
  g1(39,46)=(-(100*1/y(9)/(y(46)/y(9))));
  g1(39,48)=(-100);
  g1(39,60)=1;
  g1(40,3)=(-(100*(-y(22))/(y(3)*y(3))/(y(22)/y(3))));
  g1(40,22)=(-(100*1/y(3)/(y(22)/y(3))));
  g1(40,48)=(-100);
  g1(40,61)=1;
  g1(41,6)=(-(100*(-y(30))/(y(6)*y(6))/(y(30)/y(6))));
  g1(41,30)=(-(100*1/y(6)/(y(30)/y(6))));
  g1(41,48)=(-100);
  g1(41,62)=1;
  g1(42,4)=(-(100*(-y(24))/(y(4)*y(4))/(y(24)/y(4))));
  g1(42,24)=(-(100*1/y(4)/(y(24)/y(4))));
  g1(42,48)=(-100);
  g1(42,63)=1;
  g1(43,21)=(-(T321*100));
  g1(43,59)=1;
  g1(44,20)=(-100);
  g1(44,58)=1;
  g1(45,27)=(-(params(36)*1/y(27)));
  g1(45,57)=1;
  g1(46,21)=(-T321);
  g1(46,8)=(-((-y(32))/(y(8)*y(8))/(y(32)/y(8))));
  g1(46,32)=(-(1/y(8)/(y(32)/y(8))));
  g1(46,48)=(-1);
  g1(46,64)=1;
  g1(47,20)=400;
  g1(47,37)=(-400);
  g1(47,65)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],47,8281);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],47,753571);
end
end
end
end
