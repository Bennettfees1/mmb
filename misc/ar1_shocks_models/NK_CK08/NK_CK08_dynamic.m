function [residual, g1, g2, g3] = NK_CK08_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(56, 1);
T197 = 1/(1+params(42)*params(36))*(1-params(41))*(1-params(36)*params(41))/params(41);
T270 = (-params(48))/(1-params(48));
T272 = 1/(1-params(48));
T274 = y(46)*T270+(y(48)+y(53))*T272;
T298 = params(68)*T272*params(72);
T305 = (1+params(40))/(1-params(48));
T310 = params(45)*params(36)*(1-params(47))/(1-params(45)*params(36)*(1-params(47)));
T320 = T310*(params(68)*params(78)*(params(48)/(1-params(48)))^2-params(68)*params(72)*(1+params(40))/(1-params(48))^2);
T356 = params(68)*params(72)/(1+params(40));
T366 = params(48)*params(78)*params(68)/(1-params(48))-T298;
T374 = T366*params(36)*params(45)*params(75)/(1-params(45)*params(36)*(1-params(47)));
T398 = params(68)*params(78)*params(36)*params(45)/(1-params(45)*params(36)*(1-params(47)));
lhs =y(56);
rhs =4*y(42);
residual(1)= lhs-rhs;
lhs =y(57);
rhs =y(40);
residual(2)= lhs-rhs;
lhs =y(58);
rhs =4*y(39);
residual(3)= lhs-rhs;
lhs =y(59);
rhs =y(49);
residual(4)= lhs-rhs;
lhs =y(60);
rhs =y(49);
residual(5)= lhs-rhs;
lhs =y(61);
rhs =y(54);
residual(6)= lhs-rhs;
lhs =y(56);
rhs =params(32)*y(55)+params(31)*y(103)+params(30)*y(102)+params(29)*y(101)+params(28)*y(94)+params(27)*y(17)+params(26)*y(16)+params(25)*y(15)+params(24)*y(14)+y(60)*params(23)+params(22)*y(100)+params(21)*y(99)+params(20)*y(98)+params(19)*y(93)+params(18)*y(20)+params(17)*y(19)+params(16)*y(18)+params(15)*y(13)+y(59)*params(14)+params(13)*y(97)+params(12)*y(96)+params(11)*y(95)+params(10)*y(92)+params(6)*y(12)+y(58)*params(5)+params(1)*y(11)+params(2)*y(21)+params(3)*y(22)+params(4)*y(23)+params(7)*y(24)+params(8)*y(25)+params(9)*y(26);
residual(7)= lhs-rhs;
lhs =y(61);
rhs =params(34)*x(it_, 4);
residual(8)= lhs-rhs;
lhs =y(35);
rhs =y(42)+y(89)+y(50)-y(90);
residual(9)= lhs-rhs;
lhs =y(35);
rhs =(-params(39))/(1-params(38))*(y(29)-params(38)*y(1));
residual(10)= lhs-rhs;
lhs =y(39);
rhs =params(42)/(1+params(42)*params(36))*y(4)+y(90)*params(36)/(1+params(42)*params(36))+T197*y(36);
residual(11)= lhs-rhs;
lhs =y(36);
rhs =y(48);
residual(12)= lhs-rhs;
lhs =y(37);
rhs =params(43)*y(44)+(1-params(43))*y(45);
residual(13)= lhs-rhs;
lhs =y(38);
rhs =(1-params(47))*y(3)+params(70)/params(73)*y(2);
residual(14)= lhs-rhs;
lhs =y(38);
rhs =y(44)*(-params(76))/(1-params(76));
residual(15)= lhs-rhs;
lhs =y(41);
rhs =y(37)-y(45);
residual(16)= lhs-rhs;
lhs =y(43);
rhs =y(37)-y(44);
residual(17)= lhs-rhs;
lhs =y(34)+y(31);
rhs =y(32)+y(30);
residual(18)= lhs-rhs;
lhs =y(47);
rhs =y(48)+y(53)+(params(48)-1)*y(33);
residual(19)= lhs-rhs;
lhs =y(47);
rhs =params(45)*(y(5)-y(39)+y(4)*params(46))+(1-params(45))*y(46);
residual(20)= lhs-rhs;
lhs =y(30);
rhs =(1-params(45)*params(36)*(1-params(47)))*T274+params(45)*params(36)*(1-params(47))*(y(89)+T270*(y(46)+y(39)*params(46)-y(91)-y(90))+y(85)-y(35));
residual(21)= lhs-rhs;
lhs =y(31)*params(66);
rhs =T274*T270*params(78)*params(68)+T298*(y(46)*(-(1+params(40)))/(1-params(48))-y(35)+(y(48)+y(53))*T305)+(y(46)+y(39)*params(46)-y(91)-y(90))*T320+params(45)*params(36)*(1-params(47))*params(66)*(y(89)-y(35)+y(86));
residual(22)= lhs-rhs;
lhs =y(34)*params(69);
rhs =params(78)*params(68)/params(48)*(y(53)+y(48)+y(46)*(-params(48)))+params(68)*params(78)*T310*(y(90)+y(91)-y(46)-y(39)*params(46))+params(36)*(1-params(47))*params(69)*(y(89)-y(35)+y(88));
residual(23)= lhs-rhs;
lhs =y(32)*params(65);
rhs =params(65)*params(36)*(1-params(47)-params(75))*(y(89)-y(35)+y(87))+(y(90)+y(91)-y(46)-y(39)*params(46))*T310*T366+(y(53)+y(48)+y(46)*(-params(48)))*params(78)*params(68)/(1-params(48))-T356*(T305*(y(53)+y(48)-y(46))-y(35))-T374*(y(90)+y(91)-y(47)-y(39)*params(46))-y(43)*params(75)*params(36)*params(65);
residual(24)= lhs-rhs;
lhs =params(60)/params(74)*(-y(41));
rhs =T398*(y(90)+y(91)-y(47)-y(39)*params(46))+(y(89)-y(35)+y(88))*params(36)*params(69);
residual(25)= lhs-rhs;
lhs =y(49)*params(79);
rhs =y(29)*params(64)+params(67)*y(52)+y(45)*params(60)*params(77)+y(38)*params(73)*params(61);
residual(26)= lhs-rhs;
lhs =y(49);
rhs =y(38)+y(53)+params(48)*y(33);
residual(27)= lhs-rhs;
lhs =y(40);
rhs =y(39)+y(4)+y(27)+y(28);
residual(28)= lhs-rhs;
lhs =y(50);
rhs =params(49)*y(6)+params(56)*x(it_, 1);
residual(29)= lhs-rhs;
lhs =y(52);
rhs =y(54)+params(51)*y(8);
residual(30)= lhs-rhs;
lhs =y(51);
rhs =params(50)*y(7)+params(57)*x(it_, 3);
residual(31)= lhs-rhs;
lhs =y(53);
rhs =params(52)*y(9)+params(59)*x(it_, 2);
residual(32)= lhs-rhs;
lhs =y(55);
rhs =x(it_, 3)+params(35)*y(10);
residual(33)= lhs-rhs;
lhs =y(62);
rhs =y(92);
residual(34)= lhs-rhs;
lhs =y(63);
rhs =y(95);
residual(35)= lhs-rhs;
lhs =y(64);
rhs =y(96);
residual(36)= lhs-rhs;
lhs =y(65);
rhs =y(93);
residual(37)= lhs-rhs;
lhs =y(66);
rhs =y(98);
residual(38)= lhs-rhs;
lhs =y(67);
rhs =y(99);
residual(39)= lhs-rhs;
lhs =y(68);
rhs =y(94);
residual(40)= lhs-rhs;
lhs =y(69);
rhs =y(101);
residual(41)= lhs-rhs;
lhs =y(70);
rhs =y(102);
residual(42)= lhs-rhs;
lhs =y(71);
rhs =y(14);
residual(43)= lhs-rhs;
lhs =y(72);
rhs =y(15);
residual(44)= lhs-rhs;
lhs =y(73);
rhs =y(16);
residual(45)= lhs-rhs;
lhs =y(74);
rhs =y(13);
residual(46)= lhs-rhs;
lhs =y(75);
rhs =y(18);
residual(47)= lhs-rhs;
lhs =y(76);
rhs =y(19);
residual(48)= lhs-rhs;
lhs =y(77);
rhs =y(11);
residual(49)= lhs-rhs;
lhs =y(78);
rhs =y(21);
residual(50)= lhs-rhs;
lhs =y(79);
rhs =y(22);
residual(51)= lhs-rhs;
lhs =y(80);
rhs =y(12);
residual(52)= lhs-rhs;
lhs =y(81);
rhs =y(24);
residual(53)= lhs-rhs;
lhs =y(82);
rhs =y(25);
residual(54)= lhs-rhs;
lhs =y(83);
rhs =y(4);
residual(55)= lhs-rhs;
lhs =y(84);
rhs =y(27);
residual(56)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(56, 107);

  %
  % Jacobian matrix
  %

  g1(1,42)=(-4);
  g1(1,56)=1;
  g1(2,40)=(-1);
  g1(2,57)=1;
  g1(3,39)=(-4);
  g1(3,58)=1;
  g1(4,49)=(-1);
  g1(4,59)=1;
  g1(5,49)=(-1);
  g1(5,60)=1;
  g1(6,54)=(-1);
  g1(6,61)=1;
  g1(7,55)=(-params(32));
  g1(7,11)=(-params(1));
  g1(7,56)=1;
  g1(7,12)=(-params(6));
  g1(7,58)=(-params(5));
  g1(7,92)=(-params(10));
  g1(7,13)=(-params(15));
  g1(7,59)=(-params(14));
  g1(7,93)=(-params(19));
  g1(7,14)=(-params(24));
  g1(7,60)=(-params(23));
  g1(7,94)=(-params(28));
  g1(7,95)=(-params(11));
  g1(7,96)=(-params(12));
  g1(7,97)=(-params(13));
  g1(7,98)=(-params(20));
  g1(7,99)=(-params(21));
  g1(7,100)=(-params(22));
  g1(7,101)=(-params(29));
  g1(7,102)=(-params(30));
  g1(7,103)=(-params(31));
  g1(7,15)=(-params(25));
  g1(7,16)=(-params(26));
  g1(7,17)=(-params(27));
  g1(7,18)=(-params(16));
  g1(7,19)=(-params(17));
  g1(7,20)=(-params(18));
  g1(7,21)=(-params(2));
  g1(7,22)=(-params(3));
  g1(7,23)=(-params(4));
  g1(7,24)=(-params(7));
  g1(7,25)=(-params(8));
  g1(7,26)=(-params(9));
  g1(8,61)=1;
  g1(8,107)=(-params(34));
  g1(9,35)=1;
  g1(9,89)=(-1);
  g1(9,90)=1;
  g1(9,42)=(-1);
  g1(9,50)=(-1);
  g1(10,1)=(-((-params(39))/(1-params(38))*(-params(38))));
  g1(10,29)=(-((-params(39))/(1-params(38))));
  g1(10,35)=1;
  g1(11,36)=(-T197);
  g1(11,4)=(-(params(42)/(1+params(42)*params(36))));
  g1(11,39)=1;
  g1(11,90)=(-(params(36)/(1+params(42)*params(36))));
  g1(12,36)=1;
  g1(12,48)=(-1);
  g1(13,37)=1;
  g1(13,44)=(-params(43));
  g1(13,45)=(-(1-params(43)));
  g1(14,2)=(-(params(70)/params(73)));
  g1(14,3)=(-(1-params(47)));
  g1(14,38)=1;
  g1(15,38)=1;
  g1(15,44)=(-((-params(76))/(1-params(76))));
  g1(16,37)=(-1);
  g1(16,41)=1;
  g1(16,45)=1;
  g1(17,37)=(-1);
  g1(17,43)=1;
  g1(17,44)=1;
  g1(18,30)=(-1);
  g1(18,31)=1;
  g1(18,32)=(-1);
  g1(18,34)=1;
  g1(19,33)=(-(params(48)-1));
  g1(19,47)=1;
  g1(19,48)=(-1);
  g1(19,53)=(-1);
  g1(20,4)=(-(params(45)*params(46)));
  g1(20,39)=params(45);
  g1(20,46)=(-(1-params(45)));
  g1(20,5)=(-params(45));
  g1(20,47)=1;
  g1(21,30)=1;
  g1(21,85)=(-(params(45)*params(36)*(1-params(47))));
  g1(21,35)=params(45)*params(36)*(1-params(47));
  g1(21,89)=(-(params(45)*params(36)*(1-params(47))));
  g1(21,39)=(-(params(45)*params(36)*(1-params(47))*params(46)*T270));
  g1(21,90)=(-(params(45)*params(36)*(1-params(47))*(-T270)));
  g1(21,46)=(-((1-params(45)*params(36)*(1-params(47)))*T270+params(45)*params(36)*(1-params(47))*T270));
  g1(21,91)=(-(params(45)*params(36)*(1-params(47))*(-T270)));
  g1(21,48)=(-((1-params(45)*params(36)*(1-params(47)))*T272));
  g1(21,53)=(-((1-params(45)*params(36)*(1-params(47)))*T272));
  g1(22,31)=params(66);
  g1(22,86)=(-(params(45)*params(36)*(1-params(47))*params(66)));
  g1(22,35)=(-((-T298)-params(45)*params(36)*(1-params(47))*params(66)));
  g1(22,89)=(-(params(45)*params(36)*(1-params(47))*params(66)));
  g1(22,39)=(-(params(46)*T320));
  g1(22,90)=T320;
  g1(22,46)=(-(T320+T270*T270*params(78)*params(68)+T298*(-(1+params(40)))/(1-params(48))));
  g1(22,91)=T320;
  g1(22,48)=(-(T272*T270*params(78)*params(68)+T298*T305));
  g1(22,53)=(-(T272*T270*params(78)*params(68)+T298*T305));
  g1(23,34)=params(69);
  g1(23,88)=(-(params(36)*(1-params(47))*params(69)));
  g1(23,35)=params(36)*(1-params(47))*params(69);
  g1(23,89)=(-(params(36)*(1-params(47))*params(69)));
  g1(23,39)=(-(params(68)*params(78)*T310*(-params(46))));
  g1(23,90)=(-(params(68)*params(78)*T310));
  g1(23,46)=(-((-params(48))*params(78)*params(68)/params(48)-params(68)*params(78)*T310));
  g1(23,91)=(-(params(68)*params(78)*T310));
  g1(23,48)=(-(params(78)*params(68)/params(48)));
  g1(23,53)=(-(params(78)*params(68)/params(48)));
  g1(24,32)=params(65);
  g1(24,87)=(-(params(65)*params(36)*(1-params(47)-params(75))));
  g1(24,35)=(-(T356+(-(params(65)*params(36)*(1-params(47)-params(75))))));
  g1(24,89)=(-(params(65)*params(36)*(1-params(47)-params(75))));
  g1(24,39)=(-(T310*T366*(-params(46))-T374*(-params(46))));
  g1(24,90)=(-(T310*T366-T374));
  g1(24,43)=params(75)*params(36)*params(65);
  g1(24,46)=(-((-(T310*T366))+(-params(48))*params(78)*params(68)/(1-params(48))-T356*(-T305)));
  g1(24,91)=(-(T310*T366-T374));
  g1(24,47)=(-T374);
  g1(24,48)=(-(params(78)*params(68)/(1-params(48))-T305*T356));
  g1(24,53)=(-(params(78)*params(68)/(1-params(48))-T305*T356));
  g1(25,88)=(-(params(36)*params(69)));
  g1(25,35)=params(36)*params(69);
  g1(25,89)=(-(params(36)*params(69)));
  g1(25,39)=(-(T398*(-params(46))));
  g1(25,90)=(-T398);
  g1(25,41)=(-(params(60)/params(74)));
  g1(25,91)=(-T398);
  g1(25,47)=T398;
  g1(26,29)=(-params(64));
  g1(26,38)=(-(params(73)*params(61)));
  g1(26,45)=(-(params(60)*params(77)));
  g1(26,49)=params(79);
  g1(26,52)=(-params(67));
  g1(27,33)=(-params(48));
  g1(27,38)=(-1);
  g1(27,49)=1;
  g1(27,53)=(-1);
  g1(28,4)=(-1);
  g1(28,39)=(-1);
  g1(28,40)=1;
  g1(28,27)=(-1);
  g1(28,28)=(-1);
  g1(29,6)=(-params(49));
  g1(29,50)=1;
  g1(29,104)=(-params(56));
  g1(30,8)=(-params(51));
  g1(30,52)=1;
  g1(30,54)=(-1);
  g1(31,7)=(-params(50));
  g1(31,51)=1;
  g1(31,106)=(-params(57));
  g1(32,9)=(-params(52));
  g1(32,53)=1;
  g1(32,105)=(-params(59));
  g1(33,10)=(-params(35));
  g1(33,55)=1;
  g1(33,106)=(-1);
  g1(34,92)=(-1);
  g1(34,62)=1;
  g1(35,95)=(-1);
  g1(35,63)=1;
  g1(36,96)=(-1);
  g1(36,64)=1;
  g1(37,93)=(-1);
  g1(37,65)=1;
  g1(38,98)=(-1);
  g1(38,66)=1;
  g1(39,99)=(-1);
  g1(39,67)=1;
  g1(40,94)=(-1);
  g1(40,68)=1;
  g1(41,101)=(-1);
  g1(41,69)=1;
  g1(42,102)=(-1);
  g1(42,70)=1;
  g1(43,14)=(-1);
  g1(43,71)=1;
  g1(44,15)=(-1);
  g1(44,72)=1;
  g1(45,16)=(-1);
  g1(45,73)=1;
  g1(46,13)=(-1);
  g1(46,74)=1;
  g1(47,18)=(-1);
  g1(47,75)=1;
  g1(48,19)=(-1);
  g1(48,76)=1;
  g1(49,11)=(-1);
  g1(49,77)=1;
  g1(50,21)=(-1);
  g1(50,78)=1;
  g1(51,22)=(-1);
  g1(51,79)=1;
  g1(52,12)=(-1);
  g1(52,80)=1;
  g1(53,24)=(-1);
  g1(53,81)=1;
  g1(54,25)=(-1);
  g1(54,82)=1;
  g1(55,4)=(-1);
  g1(55,83)=1;
  g1(56,27)=(-1);
  g1(56,84)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],56,11449);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],56,1225043);
end
end
end
end
