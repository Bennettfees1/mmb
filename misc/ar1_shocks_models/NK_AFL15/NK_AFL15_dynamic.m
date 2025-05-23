function [residual, g1, g2, g3] = NK_AFL15_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(79, 1);
T3 = (-1);
T266 = 1-params(76)*(y(34)/y(2)-params(78));
T279 = params(76)/2;
T281 = T279*(y(34)/y(2)-params(78))^2;
T282 = 1-params(78)+y(34)*params(76)*(y(34)/y(2)-params(78))/y(2)-T281;
T294 = y(2)^params(73);
T296 = y(32)^(1-params(73));
T300 = params(79)/params(68);
T304 = y(31)-(params(79)-1)/params(79);
T346 = 1-1/y(27)*(y(43)+params(81))/(2-params(80)+params(87)*(1+params(80)));
T347 = y(33)*T346;
T363 = (params(81)+y(109)-(params(81)+y(109))/(2-params(80)))^2/(params(81)*8);
T365 = T363*y(105);
T385 = (1+params(80))*.25*(1-params(87));
T434 = 1-params(76)*(y(57)/y(3)-params(78));
T446 = T279*(y(57)/y(3)-params(78))^2;
T447 = 1-params(78)+y(57)*params(76)*(y(57)/y(3)-params(78))/y(3)-T446;
T476 = exp(y(71))*y(3)^params(73);
T477 = y(55)^(1-params(73));
T485 = 1-1/y(50)*(params(81)+y(66))/(2-params(80)+params(87)*(1+params(80)));
T486 = y(56)*T485;
T499 = (params(81)+y(114)-(params(81)+y(114))/(2-params(80)))^2/(params(81)*8);
T501 = T499*y(110);
lhs =y(76);
rhs =400*(log(y(27))-log(params(44)));
residual(1)= lhs-rhs;
lhs =y(74);
rhs =100*(log(y(26))+log(y(1))+log(y(11))+log(y(12))-4*log(params(42)));
residual(2)= lhs-rhs;
lhs =y(75);
rhs =400*(log(y(26))-log(params(42)));
residual(3)= lhs-rhs;
lhs =y(78);
rhs =100*(log(y(30))-log(y(53))-(log(params(47))-(log(steady_state(29)))));
residual(4)= lhs-rhs;
lhs =y(77);
rhs =100*(log(y(30))-log(params(47)));
residual(5)= lhs-rhs;
lhs =y(79);
rhs =y(73);
residual(6)= lhs-rhs;
lhs =y(76);
rhs =params(32)*y(80)+params(31)*y(126)+params(30)*y(125)+params(29)*y(124)+params(28)*y(116)+params(27)*y(15)+params(26)*y(14)+params(25)*y(13)+params(24)*y(8)+y(77)*params(23)+params(22)*y(123)+params(21)*y(122)+params(20)*y(121)+params(19)*y(117)+params(18)*y(18)+params(17)*y(17)+params(16)*y(16)+params(15)*y(9)+y(78)*params(14)+params(13)*y(120)+params(12)*y(119)+params(11)*y(118)+params(10)*y(115)+params(6)*y(6)+y(75)*params(5)+params(1)*y(7)+params(2)*y(19)+params(3)*y(20)+params(4)*y(21)+params(7)*y(22)+params(8)*y(23)+params(9)*y(24);
residual(7)= lhs-rhs;
lhs =y(79);
rhs =params(34)*x(it_, 3);
residual(8)= lhs-rhs;
lhs =y(36);
rhs =y(25)^(-params(69));
residual(9)= lhs-rhs;
lhs =y(37);
rhs =params(70)*1/(y(32)-1);
residual(10)= lhs-rhs;
lhs =y(38);
rhs =y(30)*params(73)/y(2);
residual(11)= lhs-rhs;
lhs =y(39);
rhs =y(30)*(1-params(73))/y(32);
residual(12)= lhs-rhs;
lhs =y(71);
rhs =params(72)*y(4)+0.01*x(it_, 1);
residual(13)= lhs-rhs;
lhs =log(y(72))-log(params(53));
rhs =y(73)+params(74)*(log(y(5))-log(params(53)));
residual(14)= lhs-rhs;
lhs =y(36);
rhs =params(71)*y(107)*y(46);
residual(15)= lhs-rhs;
lhs =y(46);
rhs =y(27)*(1-y(45))/y(104);
residual(16)= lhs-rhs;
lhs =y(39)*y(31);
rhs =(-y(37))/y(36);
residual(17)= lhs-rhs;
lhs =y(38)*y(31);
rhs =y(29);
residual(18)= lhs-rhs;
lhs =y(33);
rhs =T266^T3;
residual(19)= lhs-rhs;
lhs =y(43)/y(104);
rhs =y(106)/y(33);
residual(20)= lhs-rhs;
lhs =y(35);
rhs =y(29)+y(33)*T282;
residual(21)= lhs-rhs;
lhs =y(26)*y(36)*(y(26)-params(42));
rhs =params(71)*y(107)*y(104)*(y(104)-params(42))+y(36)*exp(y(71))*T294*T296*T300*T304;
residual(22)= lhs-rhs;
lhs =y(28);
rhs =y(34)+y(2)*(1-params(78))-y(2)*T281;
residual(23)= lhs-rhs;
lhs =y(30);
rhs =y(72)+y(25)+y(34)+y(48)+y(47);
residual(24)= lhs-rhs;
lhs =y(48);
rhs =params(68)/2*(y(26)-params(42))^2;
residual(25)= lhs-rhs;
lhs =y(47);
rhs =y(28)*y(33)*y(43)*params(87)*y(44);
residual(26)= lhs-rhs;
lhs =y(30);
rhs =T296*exp(y(71))*T294;
residual(27)= lhs-rhs;
lhs =y(40);
rhs =y(2)*T347;
residual(28)= lhs-rhs;
lhs =y(40)+y(41);
rhs =y(2)*y(33);
residual(29)= lhs-rhs;
lhs =y(108);
rhs =params(77)*(y(40)+y(28)*T365)+params(36);
residual(30)= lhs-rhs;
lhs =y(42);
rhs =y(41)/(y(2)*y(33));
residual(31)= lhs-rhs;
lhs =y(44);
rhs =0.5*(1-(y(43)-y(27)*y(42))/params(81));
residual(32)= lhs-rhs;
lhs =y(45);
rhs =y(44)*T385*(y(27)+(y(43)-params(81))/y(42));
residual(33)= lhs-rhs;
lhs =y(59);
rhs =y(49)^(-params(69));
residual(34)= lhs-rhs;
lhs =y(60);
rhs =params(70)*1/(y(55)-1);
residual(35)= lhs-rhs;
lhs =y(61);
rhs =y(53)*params(73)/y(3);
residual(36)= lhs-rhs;
lhs =y(62);
rhs =y(53)*(1-params(73))/y(55);
residual(37)= lhs-rhs;
lhs =y(59);
rhs =params(71)*y(112)*y(69);
residual(38)= lhs-rhs;
lhs =y(69);
rhs =y(50)*(1-y(68));
residual(39)= lhs-rhs;
lhs =y(62)*y(54);
rhs =(-y(60))/y(59);
residual(40)= lhs-rhs;
lhs =y(61)*y(54);
rhs =y(52);
residual(41)= lhs-rhs;
lhs =y(56);
rhs =T434^T3;
residual(42)= lhs-rhs;
lhs =y(66);
rhs =y(111)/y(56);
residual(43)= lhs-rhs;
lhs =y(58);
rhs =y(52)+y(56)*T447;
residual(44)= lhs-rhs;
lhs =0;
rhs =y(53)*y(59)*(1-params(79)+params(79)*y(54));
residual(45)= lhs-rhs;
lhs =y(51);
rhs =y(57)+(1-params(78))*y(3)-y(3)*T446;
residual(46)= lhs-rhs;
lhs =y(53);
rhs =y(72)+y(48)+y(49)+y(57)+y(70);
residual(47)= lhs-rhs;
lhs =y(70);
rhs =y(51)*y(56)*y(66)*params(87)*y(67);
residual(48)= lhs-rhs;
lhs =y(53);
rhs =T476*T477;
residual(49)= lhs-rhs;
lhs =y(63);
rhs =y(3)*T486;
residual(50)= lhs-rhs;
lhs =y(63)+y(64);
rhs =y(3)*y(56);
residual(51)= lhs-rhs;
lhs =y(113);
rhs =params(36)+params(77)*(y(63)+y(51)*T501);
residual(52)= lhs-rhs;
lhs =y(65);
rhs =y(64)/(y(3)*y(56));
residual(53)= lhs-rhs;
lhs =y(67);
rhs =0.5*(1-(y(66)-y(50)*y(65))/params(81));
residual(54)= lhs-rhs;
lhs =y(68);
rhs =y(67)*T385*(y(50)+(y(66)-params(81))/y(65));
residual(55)= lhs-rhs;
lhs =y(80);
rhs =params(35)*y(10)+x(it_, 2);
residual(56)= lhs-rhs;
lhs =y(81);
rhs =y(115);
residual(57)= lhs-rhs;
lhs =y(82);
rhs =y(118);
residual(58)= lhs-rhs;
lhs =y(83);
rhs =y(119);
residual(59)= lhs-rhs;
lhs =y(84);
rhs =y(117);
residual(60)= lhs-rhs;
lhs =y(85);
rhs =y(121);
residual(61)= lhs-rhs;
lhs =y(86);
rhs =y(122);
residual(62)= lhs-rhs;
lhs =y(87);
rhs =y(116);
residual(63)= lhs-rhs;
lhs =y(88);
rhs =y(124);
residual(64)= lhs-rhs;
lhs =y(89);
rhs =y(125);
residual(65)= lhs-rhs;
lhs =y(90);
rhs =y(1);
residual(66)= lhs-rhs;
lhs =y(91);
rhs =y(11);
residual(67)= lhs-rhs;
lhs =y(92);
rhs =y(8);
residual(68)= lhs-rhs;
lhs =y(93);
rhs =y(13);
residual(69)= lhs-rhs;
lhs =y(94);
rhs =y(14);
residual(70)= lhs-rhs;
lhs =y(95);
rhs =y(9);
residual(71)= lhs-rhs;
lhs =y(96);
rhs =y(16);
residual(72)= lhs-rhs;
lhs =y(97);
rhs =y(17);
residual(73)= lhs-rhs;
lhs =y(98);
rhs =y(7);
residual(74)= lhs-rhs;
lhs =y(99);
rhs =y(19);
residual(75)= lhs-rhs;
lhs =y(100);
rhs =y(20);
residual(76)= lhs-rhs;
lhs =y(101);
rhs =y(6);
residual(77)= lhs-rhs;
lhs =y(102);
rhs =y(22);
residual(78)= lhs-rhs;
lhs =y(103);
rhs =y(23);
residual(79)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(79, 129);

  %
  % Jacobian matrix
  %

T712 = (-((y(43)+params(81))*T3/(y(27)*y(27))/(2-params(80)+params(87)*(1+params(80)))));
T713 = y(33)*T712;
T728 = (-y(34))/(y(2)*y(2));
T730 = (-(params(76)*T728));
T731 = getPowerDeriv(T266,T3,1);
T734 = y(34)*params(76)*T728;
T738 = 2*(y(34)/y(2)-params(78));
T740 = T279*T728*T738;
T741 = (y(2)*T734-y(34)*params(76)*(y(34)/y(2)-params(78)))/(y(2)*y(2))-T740;
T744 = getPowerDeriv(y(2),params(73),1);
T783 = getPowerDeriv(y(32),1-params(73),1);
T807 = 1/y(2);
T808 = params(76)*T807;
T809 = (-T808);
T813 = params(76)*(y(34)/y(2)-params(78))+y(34)*T808;
T816 = T279*T738*T807;
T858 = (-(1/y(27)/(2-params(80)+params(87)*(1+params(80)))));
T859 = y(33)*T858;
T871 = 1-1/(2-params(80));
T874 = T871*2*(params(81)+y(109)-(params(81)+y(109))/(2-params(80)))/(params(81)*8);
T875 = y(105)*T874;
T894 = (-((params(81)+y(66))*T3/(y(50)*y(50))/(2-params(80)+params(87)*(1+params(80)))));
T895 = y(56)*T894;
T910 = (-y(57))/(y(3)*y(3));
T912 = (-(params(76)*T910));
T913 = getPowerDeriv(T434,T3,1);
T916 = y(57)*params(76)*T910;
T920 = 2*(y(57)/y(3)-params(78));
T922 = T279*T910*T920;
T923 = (y(3)*T916-y(57)*params(76)*(y(57)/y(3)-params(78)))/(y(3)*y(3))-T922;
T931 = exp(y(71))*getPowerDeriv(y(3),params(73),1);
T964 = getPowerDeriv(y(55),1-params(73),1);
T984 = 1/y(3);
T985 = params(76)*T984;
T986 = (-T985);
T990 = params(76)*(y(57)/y(3)-params(78))+y(57)*T985;
T993 = T279*T920*T984;
T1028 = (-(1/y(50)/(2-params(80)+params(87)*(1+params(80)))));
T1029 = y(56)*T1028;
T1038 = T871*2*(params(81)+y(114)-(params(81)+y(114))/(2-params(80)))/(params(81)*8);
T1039 = y(110)*T1038;
  g1(1,27)=(-(400*1/y(27)));
  g1(1,76)=1;
  g1(2,1)=(-(100*1/y(1)));
  g1(2,26)=(-(100*1/y(26)));
  g1(2,74)=1;
  g1(2,11)=(-(100*1/y(11)));
  g1(2,12)=(-(100*1/y(12)));
  g1(3,26)=(-(400*1/y(26)));
  g1(3,75)=1;
  g1(4,30)=(-(100*1/y(30)));
  g1(4,53)=(-(100*(-(1/y(53)))));
  g1(4,78)=1;
  g1(5,30)=(-(100*1/y(30)));
  g1(5,77)=1;
  g1(6,73)=T3;
  g1(6,79)=1;
  g1(7,6)=(-params(6));
  g1(7,75)=(-params(5));
  g1(7,115)=(-params(10));
  g1(7,7)=(-params(1));
  g1(7,76)=1;
  g1(7,8)=(-params(24));
  g1(7,77)=(-params(23));
  g1(7,116)=(-params(28));
  g1(7,9)=(-params(15));
  g1(7,78)=(-params(14));
  g1(7,117)=(-params(19));
  g1(7,80)=(-params(32));
  g1(7,118)=(-params(11));
  g1(7,119)=(-params(12));
  g1(7,120)=(-params(13));
  g1(7,121)=(-params(20));
  g1(7,122)=(-params(21));
  g1(7,123)=(-params(22));
  g1(7,124)=(-params(29));
  g1(7,125)=(-params(30));
  g1(7,126)=(-params(31));
  g1(7,13)=(-params(25));
  g1(7,14)=(-params(26));
  g1(7,15)=(-params(27));
  g1(7,16)=(-params(16));
  g1(7,17)=(-params(17));
  g1(7,18)=(-params(18));
  g1(7,19)=(-params(2));
  g1(7,20)=(-params(3));
  g1(7,21)=(-params(4));
  g1(7,22)=(-params(7));
  g1(7,23)=(-params(8));
  g1(7,24)=(-params(9));
  g1(8,79)=1;
  g1(8,129)=(-params(34));
  g1(9,25)=(-(getPowerDeriv(y(25),(-params(69)),1)));
  g1(9,36)=1;
  g1(10,32)=(-(params(70)*T3/((y(32)-1)*(y(32)-1))));
  g1(10,37)=1;
  g1(11,2)=(-((-(y(30)*params(73)))/(y(2)*y(2))));
  g1(11,30)=(-(params(73)/y(2)));
  g1(11,38)=1;
  g1(12,30)=(-((1-params(73))/y(32)));
  g1(12,32)=(-((-(y(30)*(1-params(73))))/(y(32)*y(32))));
  g1(12,39)=1;
  g1(13,4)=(-params(72));
  g1(13,71)=1;
  g1(13,127)=(-0.01);
  g1(14,5)=(-(params(74)*1/y(5)));
  g1(14,72)=1/y(72);
  g1(14,73)=T3;
  g1(15,36)=1;
  g1(15,107)=(-(params(71)*y(46)));
  g1(15,46)=(-(params(71)*y(107)));
  g1(16,104)=(-((-(y(27)*(1-y(45))))/(y(104)*y(104))));
  g1(16,27)=(-((1-y(45))/y(104)));
  g1(16,45)=(-((-y(27))/y(104)));
  g1(16,46)=1;
  g1(17,31)=y(39);
  g1(17,36)=(-(y(37)/(y(36)*y(36))));
  g1(17,37)=(-(T3/y(36)));
  g1(17,39)=y(31);
  g1(18,29)=T3;
  g1(18,31)=y(38);
  g1(18,38)=y(31);
  g1(19,2)=(-(T730*T731));
  g1(19,33)=1;
  g1(19,34)=(-(T731*T809));
  g1(20,104)=(-y(43))/(y(104)*y(104));
  g1(20,33)=(-((-y(106))/(y(33)*y(33))));
  g1(20,106)=(-(1/y(33)));
  g1(20,43)=1/y(104);
  g1(21,2)=(-(y(33)*T741));
  g1(21,29)=T3;
  g1(21,33)=(-T282);
  g1(21,34)=(-(y(33)*(T813/y(2)-T816)));
  g1(21,35)=1;
  g1(22,26)=y(26)*y(36)+y(36)*(y(26)-params(42));
  g1(22,104)=(-(params(71)*y(107)*y(104)+params(71)*y(107)*(y(104)-params(42))));
  g1(22,2)=(-(T304*T300*T296*y(36)*exp(y(71))*T744));
  g1(22,31)=(-(y(36)*exp(y(71))*T294*T296*T300));
  g1(22,32)=(-(T304*T300*y(36)*exp(y(71))*T294*T783));
  g1(22,36)=y(26)*(y(26)-params(42))-T304*T300*T296*exp(y(71))*T294;
  g1(22,107)=(-((y(104)-params(42))*params(71)*y(104)));
  g1(22,71)=(-(y(36)*exp(y(71))*T294*T296*T300*T304));
  g1(23,2)=(-(1-params(78)-(T281+y(2)*T740)));
  g1(23,28)=1;
  g1(23,34)=(-(1-y(2)*T816));
  g1(24,25)=T3;
  g1(24,30)=1;
  g1(24,34)=T3;
  g1(24,47)=T3;
  g1(24,48)=T3;
  g1(24,72)=T3;
  g1(25,26)=(-(params(68)/2*2*(y(26)-params(42))));
  g1(25,48)=1;
  g1(26,28)=(-(y(33)*y(43)*params(87)*y(44)));
  g1(26,33)=(-(y(28)*y(43)*params(87)*y(44)));
  g1(26,43)=(-(y(28)*y(33)*params(87)*y(44)));
  g1(26,44)=(-(y(28)*y(33)*y(43)*params(87)));
  g1(26,47)=1;
  g1(27,2)=(-(T296*exp(y(71))*T744));
  g1(27,30)=1;
  g1(27,32)=(-(exp(y(71))*T294*T783));
  g1(27,71)=(-(T296*exp(y(71))*T294));
  g1(28,27)=(-(y(2)*T713));
  g1(28,2)=(-T347);
  g1(28,33)=(-(y(2)*T346));
  g1(28,40)=1;
  g1(28,43)=(-(y(2)*T859));
  g1(29,2)=(-y(33));
  g1(29,33)=(-y(2));
  g1(29,40)=1;
  g1(29,41)=1;
  g1(30,28)=(-(params(77)*T365));
  g1(30,105)=(-(params(77)*y(28)*T363));
  g1(30,40)=(-params(77));
  g1(30,108)=1;
  g1(30,109)=(-(params(77)*y(28)*T875));
  g1(31,2)=(-((-(y(33)*y(41)))/(y(2)*y(33)*y(2)*y(33))));
  g1(31,33)=(-((-(y(2)*y(41)))/(y(2)*y(33)*y(2)*y(33))));
  g1(31,41)=(-(1/(y(2)*y(33))));
  g1(31,42)=1;
  g1(32,27)=(-(0.5*(-((-y(42))/params(81)))));
  g1(32,42)=(-(0.5*(-((-y(27))/params(81)))));
  g1(32,43)=(-(0.5*(-(1/params(81)))));
  g1(32,44)=1;
  g1(33,27)=(-(y(44)*T385));
  g1(33,42)=(-(y(44)*T385*(-(y(43)-params(81)))/(y(42)*y(42))));
  g1(33,43)=(-(y(44)*T385*1/y(42)));
  g1(33,44)=(-(T385*(y(27)+(y(43)-params(81))/y(42))));
  g1(33,45)=1;
  g1(34,49)=(-(getPowerDeriv(y(49),(-params(69)),1)));
  g1(34,59)=1;
  g1(35,55)=(-(params(70)*T3/((y(55)-1)*(y(55)-1))));
  g1(35,60)=1;
  g1(36,3)=(-((-(y(53)*params(73)))/(y(3)*y(3))));
  g1(36,53)=(-(params(73)/y(3)));
  g1(36,61)=1;
  g1(37,53)=(-((1-params(73))/y(55)));
  g1(37,55)=(-((-(y(53)*(1-params(73))))/(y(55)*y(55))));
  g1(37,62)=1;
  g1(38,59)=1;
  g1(38,112)=(-(params(71)*y(69)));
  g1(38,69)=(-(params(71)*y(112)));
  g1(39,50)=(-(1-y(68)));
  g1(39,68)=y(50);
  g1(39,69)=1;
  g1(40,54)=y(62);
  g1(40,59)=(-(y(60)/(y(59)*y(59))));
  g1(40,60)=(-(T3/y(59)));
  g1(40,62)=y(54);
  g1(41,52)=T3;
  g1(41,54)=y(61);
  g1(41,61)=y(54);
  g1(42,3)=(-(T912*T913));
  g1(42,56)=1;
  g1(42,57)=(-(T913*T986));
  g1(43,56)=(-((-y(111))/(y(56)*y(56))));
  g1(43,111)=(-(1/y(56)));
  g1(43,66)=1;
  g1(44,3)=(-(y(56)*T923));
  g1(44,52)=T3;
  g1(44,56)=(-T447);
  g1(44,57)=(-(y(56)*(T990/y(3)-T993)));
  g1(44,58)=1;
  g1(45,53)=(-(y(59)*(1-params(79)+params(79)*y(54))));
  g1(45,54)=(-(params(79)*y(53)*y(59)));
  g1(45,59)=(-(y(53)*(1-params(79)+params(79)*y(54))));
  g1(46,3)=(-(1-params(78)-(T446+y(3)*T922)));
  g1(46,51)=1;
  g1(46,57)=(-(1-y(3)*T993));
  g1(47,48)=T3;
  g1(47,49)=T3;
  g1(47,53)=1;
  g1(47,57)=T3;
  g1(47,70)=T3;
  g1(47,72)=T3;
  g1(48,51)=(-(y(56)*y(66)*params(87)*y(67)));
  g1(48,56)=(-(y(51)*y(66)*params(87)*y(67)));
  g1(48,66)=(-(y(51)*y(56)*params(87)*y(67)));
  g1(48,67)=(-(y(51)*y(56)*params(87)*y(66)));
  g1(48,70)=1;
  g1(49,3)=(-(T477*T931));
  g1(49,53)=1;
  g1(49,55)=(-(T476*T964));
  g1(49,71)=(-(T476*T477));
  g1(50,50)=(-(y(3)*T895));
  g1(50,3)=(-T486);
  g1(50,56)=(-(y(3)*T485));
  g1(50,63)=1;
  g1(50,66)=(-(y(3)*T1029));
  g1(51,3)=(-y(56));
  g1(51,56)=(-y(3));
  g1(51,63)=1;
  g1(51,64)=1;
  g1(52,51)=(-(params(77)*T501));
  g1(52,110)=(-(params(77)*y(51)*T499));
  g1(52,63)=(-params(77));
  g1(52,113)=1;
  g1(52,114)=(-(params(77)*y(51)*T1039));
  g1(53,3)=(-((-(y(56)*y(64)))/(y(3)*y(56)*y(3)*y(56))));
  g1(53,56)=(-((-(y(3)*y(64)))/(y(3)*y(56)*y(3)*y(56))));
  g1(53,64)=(-(1/(y(3)*y(56))));
  g1(53,65)=1;
  g1(54,50)=(-(0.5*(-((-y(65))/params(81)))));
  g1(54,65)=(-(0.5*(-((-y(50))/params(81)))));
  g1(54,66)=(-(0.5*(-(1/params(81)))));
  g1(54,67)=1;
  g1(55,50)=(-(T385*y(67)));
  g1(55,65)=(-(y(67)*T385*(-(y(66)-params(81)))/(y(65)*y(65))));
  g1(55,66)=(-(y(67)*T385*1/y(65)));
  g1(55,67)=(-(T385*(y(50)+(y(66)-params(81))/y(65))));
  g1(55,68)=1;
  g1(56,10)=(-params(35));
  g1(56,80)=1;
  g1(56,128)=T3;
  g1(57,115)=T3;
  g1(57,81)=1;
  g1(58,118)=T3;
  g1(58,82)=1;
  g1(59,119)=T3;
  g1(59,83)=1;
  g1(60,117)=T3;
  g1(60,84)=1;
  g1(61,121)=T3;
  g1(61,85)=1;
  g1(62,122)=T3;
  g1(62,86)=1;
  g1(63,116)=T3;
  g1(63,87)=1;
  g1(64,124)=T3;
  g1(64,88)=1;
  g1(65,125)=T3;
  g1(65,89)=1;
  g1(66,1)=T3;
  g1(66,90)=1;
  g1(67,11)=T3;
  g1(67,91)=1;
  g1(68,8)=T3;
  g1(68,92)=1;
  g1(69,13)=T3;
  g1(69,93)=1;
  g1(70,14)=T3;
  g1(70,94)=1;
  g1(71,9)=T3;
  g1(71,95)=1;
  g1(72,16)=T3;
  g1(72,96)=1;
  g1(73,17)=T3;
  g1(73,97)=1;
  g1(74,7)=T3;
  g1(74,98)=1;
  g1(75,19)=T3;
  g1(75,99)=1;
  g1(76,20)=T3;
  g1(76,100)=1;
  g1(77,6)=T3;
  g1(77,101)=1;
  g1(78,22)=T3;
  g1(78,102)=1;
  g1(79,23)=T3;
  g1(79,103)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(255,3);
T1186 = getPowerDeriv(T266,T3,2);
T1187 = T730*T1186;
T1226 = T279*(T738*(-((-y(34))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2))+T728*2*T728);
T1254 = getPowerDeriv(y(2),params(73),2);
T1266 = getPowerDeriv(y(32),1-params(73),2);
T1426 = getPowerDeriv(T434,T3,2);
T1427 = T912*T1426;
T1462 = T279*(T920*(-((-y(57))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))+T910*2*T910);
  v2(1,1)=1;
  v2(1,2)=3381;
  v2(1,3)=(-(400*T3/(y(27)*y(27))));
  v2(2,1)=2;
  v2(2,2)=1;
  v2(2,3)=(-(100*T3/(y(1)*y(1))));
  v2(3,1)=2;
  v2(3,2)=3251;
  v2(3,3)=(-(100*T3/(y(26)*y(26))));
  v2(4,1)=2;
  v2(4,2)=1301;
  v2(4,3)=(-(100*T3/(y(11)*y(11))));
  v2(5,1)=2;
  v2(5,2)=1431;
  v2(5,3)=(-(100*T3/(y(12)*y(12))));
  v2(6,1)=3;
  v2(6,2)=3251;
  v2(6,3)=(-(400*T3/(y(26)*y(26))));
  v2(7,1)=4;
  v2(7,2)=3771;
  v2(7,3)=(-(100*T3/(y(30)*y(30))));
  v2(8,1)=4;
  v2(8,2)=6761;
  v2(8,3)=(-(100*(-(T3/(y(53)*y(53))))));
  v2(9,1)=5;
  v2(9,2)=3771;
  v2(9,3)=(-(100*T3/(y(30)*y(30))));
  v2(10,1)=9;
  v2(10,2)=3121;
  v2(10,3)=(-(getPowerDeriv(y(25),(-params(69)),2)));
  v2(11,1)=10;
  v2(11,2)=4031;
  v2(11,3)=(-(params(70)*(y(32)-1+y(32)-1)/((y(32)-1)*(y(32)-1)*(y(32)-1)*(y(32)-1))));
  v2(12,1)=11;
  v2(12,2)=131;
  v2(12,3)=(-((-((-(y(30)*params(73)))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2))));
  v2(13,1)=11;
  v2(13,2)=3743;
  v2(13,3)=(-((-params(73))/(y(2)*y(2))));
  v2(14,1)=11;
  v2(14,2)=159;
  v2(14,3)=  v2(13,3);
  v2(15,1)=12;
  v2(15,2)=4029;
  v2(15,3)=(-((-(1-params(73)))/(y(32)*y(32))));
  v2(16,1)=12;
  v2(16,2)=3773;
  v2(16,3)=  v2(15,3);
  v2(17,1)=12;
  v2(17,2)=4031;
  v2(17,3)=(-((-((-(y(30)*(1-params(73))))*(y(32)+y(32))))/(y(32)*y(32)*y(32)*y(32))));
  v2(18,1)=14;
  v2(18,2)=521;
  v2(18,3)=(-(params(74)*T3/(y(5)*y(5))));
  v2(19,1)=14;
  v2(19,2)=9231;
  v2(19,3)=T3/(y(72)*y(72));
  v2(20,1)=15;
  v2(20,2)=5912;
  v2(20,3)=(-params(71));
  v2(21,1)=15;
  v2(21,2)=13720;
  v2(21,3)=  v2(20,3);
  v2(22,1)=16;
  v2(22,2)=13391;
  v2(22,3)=(-((-((-(y(27)*(1-y(45))))*(y(104)+y(104))))/(y(104)*y(104)*y(104)*y(104))));
  v2(23,1)=16;
  v2(23,2)=3458;
  v2(23,3)=(-((-(1-y(45)))/(y(104)*y(104))));
  v2(24,1)=16;
  v2(24,2)=13314;
  v2(24,3)=  v2(23,3);
  v2(25,1)=16;
  v2(25,2)=5780;
  v2(25,3)=(-(y(27)/(y(104)*y(104))));
  v2(26,1)=16;
  v2(26,2)=13332;
  v2(26,3)=  v2(25,3);
  v2(27,1)=16;
  v2(27,2)=5703;
  v2(27,3)=(-(T3/y(104)));
  v2(28,1)=16;
  v2(28,2)=3399;
  v2(28,3)=  v2(27,3);
  v2(29,1)=17;
  v2(29,2)=4551;
  v2(29,3)=(-((-(y(37)*(y(36)+y(36))))/(y(36)*y(36)*y(36)*y(36))));
  v2(30,1)=17;
  v2(30,2)=4680;
  v2(30,3)=(-(1/(y(36)*y(36))));
  v2(31,1)=17;
  v2(31,2)=4552;
  v2(31,3)=  v2(30,3);
  v2(32,1)=17;
  v2(32,2)=4933;
  v2(32,3)=1;
  v2(33,1)=17;
  v2(33,2)=3909;
  v2(33,3)=  v2(32,3);
  v2(34,1)=18;
  v2(34,2)=4804;
  v2(34,3)=1;
  v2(35,1)=18;
  v2(35,2)=3908;
  v2(35,3)=  v2(34,3);
  v2(36,1)=19;
  v2(36,2)=131;
  v2(36,3)=(-(T731*(-(params(76)*(-((-y(34))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2))))+T730*T1187));
  v2(37,1)=19;
  v2(37,2)=4259;
  v2(37,3)=(-(T809*T1187+T731*(-(params(76)*T3/(y(2)*y(2))))));
  v2(38,1)=19;
  v2(38,2)=163;
  v2(38,3)=  v2(37,3);
  v2(39,1)=19;
  v2(39,2)=4291;
  v2(39,3)=(-(T809*T809*T1186));
  v2(40,1)=20;
  v2(40,2)=13391;
  v2(40,3)=(-((-y(43))*(y(104)+y(104))))/(y(104)*y(104)*y(104)*y(104));
  v2(41,1)=20;
  v2(41,2)=4161;
  v2(41,3)=(-((-((-y(106))*(y(33)+y(33))))/(y(33)*y(33)*y(33)*y(33))));
  v2(42,1)=20;
  v2(42,2)=13578;
  v2(42,3)=(-(T3/(y(33)*y(33))));
  v2(43,1)=20;
  v2(43,2)=4234;
  v2(43,3)=  v2(42,3);
  v2(44,1)=20;
  v2(44,2)=5522;
  v2(44,3)=T3/(y(104)*y(104));
  v2(45,1)=20;
  v2(45,2)=13330;
  v2(45,3)=  v2(44,3);
  v2(46,1)=21;
  v2(46,2)=131;
  v2(46,3)=(-(y(33)*((y(2)*y(2)*(T734+y(2)*y(34)*params(76)*(-((-y(34))*(y(2)+y(2))))/(y(2)*y(2)*y(2)*y(2))-T734)-(y(2)*T734-y(34)*params(76)*(y(34)/y(2)-params(78)))*(y(2)+y(2)))/(y(2)*y(2)*y(2)*y(2))-T1226)));
  v2(47,1)=21;
  v2(47,2)=4130;
  v2(47,3)=(-T741);
  v2(48,1)=21;
  v2(48,2)=162;
  v2(48,3)=  v2(47,3);
  v2(49,1)=21;
  v2(49,2)=4259;
  v2(49,3)=(-(y(33)*((y(2)*(params(76)*T728+y(34)*params(76)*T3/(y(2)*y(2)))-T813)/(y(2)*y(2))-T279*(T807*2*T728+T738*T3/(y(2)*y(2))))));
  v2(50,1)=21;
  v2(50,2)=163;
  v2(50,3)=  v2(49,3);
  v2(51,1)=21;
  v2(51,2)=4290;
  v2(51,3)=(-(T813/y(2)-T816));
  v2(52,1)=21;
  v2(52,2)=4162;
  v2(52,3)=  v2(51,3);
  v2(53,1)=21;
  v2(53,2)=4291;
  v2(53,3)=(-(y(33)*((T808+T808)/y(2)-T279*T807*2*T807)));
  v2(54,1)=22;
  v2(54,2)=3251;
  v2(54,3)=y(36)+y(36);
  v2(55,1)=22;
  v2(55,2)=13391;
  v2(55,3)=(-(params(71)*y(107)+params(71)*y(107)));
  v2(56,1)=22;
  v2(56,2)=131;
  v2(56,3)=(-(T304*T300*T296*y(36)*exp(y(71))*T1254));
  v2(57,1)=22;
  v2(57,2)=3872;
  v2(57,3)=(-(T300*T296*y(36)*exp(y(71))*T744));
  v2(58,1)=22;
  v2(58,2)=160;
  v2(58,3)=  v2(57,3);
  v2(59,1)=22;
  v2(59,2)=4001;
  v2(59,3)=(-(T304*T300*y(36)*exp(y(71))*T744*T783));
  v2(60,1)=22;
  v2(60,2)=161;
  v2(60,3)=  v2(59,3);
  v2(61,1)=22;
  v2(61,2)=4030;
  v2(61,3)=(-(T300*y(36)*exp(y(71))*T294*T783));
  v2(62,1)=22;
  v2(62,2)=3902;
  v2(62,3)=  v2(61,3);
  v2(63,1)=22;
  v2(63,2)=4031;
  v2(63,3)=(-(T304*T300*y(36)*exp(y(71))*T294*T1266));
  v2(64,1)=22;
  v2(64,2)=4541;
  v2(64,3)=y(26)+y(26)-params(42);
  v2(65,1)=22;
  v2(65,2)=3261;
  v2(65,3)=  v2(64,3);
  v2(66,1)=22;
  v2(66,2)=4517;
  v2(66,3)=(-(T304*T300*T296*exp(y(71))*T744));
  v2(67,1)=22;
  v2(67,2)=165;
  v2(67,3)=  v2(66,3);
  v2(68,1)=22;
  v2(68,2)=4546;
  v2(68,3)=(-(T300*T296*exp(y(71))*T294));
  v2(69,1)=22;
  v2(69,2)=3906;
  v2(69,3)=  v2(68,3);
  v2(70,1)=22;
  v2(70,2)=4547;
  v2(70,3)=(-(T304*T300*exp(y(71))*T294*T783));
  v2(71,1)=22;
  v2(71,2)=4035;
  v2(71,3)=  v2(70,3);
  v2(72,1)=22;
  v2(72,2)=13778;
  v2(72,3)=(-(params(71)*y(104)+params(71)*(y(104)-params(42))));
  v2(73,1)=22;
  v2(73,2)=13394;
  v2(73,3)=  v2(72,3);
  v2(74,1)=22;
  v2(74,2)=9032;
  v2(74,3)=(-(T304*T300*T296*y(36)*exp(y(71))*T744));
  v2(75,1)=22;
  v2(75,2)=200;
  v2(75,3)=  v2(74,3);
  v2(76,1)=22;
  v2(76,2)=9061;
  v2(76,3)=(-(y(36)*exp(y(71))*T294*T296*T300));
  v2(77,1)=22;
  v2(77,2)=3941;
  v2(77,3)=  v2(76,3);
  v2(78,1)=22;
  v2(78,2)=9062;
  v2(78,3)=(-(T304*T300*y(36)*exp(y(71))*T294*T783));
  v2(79,1)=22;
  v2(79,2)=4070;
  v2(79,3)=  v2(78,3);
  v2(80,1)=22;
  v2(80,2)=9066;
  v2(80,3)=(-(T304*T300*T296*exp(y(71))*T294));
  v2(81,1)=22;
  v2(81,2)=4586;
  v2(81,3)=  v2(80,3);
  v2(82,1)=22;
  v2(82,2)=9101;
  v2(82,3)=(-(y(36)*exp(y(71))*T294*T296*T300*T304));
  v2(83,1)=23;
  v2(83,2)=131;
  v2(83,3)=T740+T740+y(2)*T1226;
  v2(84,1)=23;
  v2(84,2)=4259;
  v2(84,3)=T816+y(2)*T279*(T807*2*T728+T738*T3/(y(2)*y(2)));
  v2(85,1)=23;
  v2(85,2)=163;
  v2(85,3)=  v2(84,3);
  v2(86,1)=23;
  v2(86,2)=4291;
  v2(86,3)=y(2)*T279*T807*2*T807;
  v2(87,1)=25;
  v2(87,2)=3251;
  v2(87,3)=(-(2*params(68)/2));
  v2(88,1)=26;
  v2(88,2)=4156;
  v2(88,3)=(-(y(43)*params(87)*y(44)));
  v2(89,1)=26;
  v2(89,2)=3516;
  v2(89,3)=  v2(88,3);
  v2(90,1)=26;
  v2(90,2)=5446;
  v2(90,3)=(-(y(33)*params(87)*y(44)));
  v2(91,1)=26;
  v2(91,2)=3526;
  v2(91,3)=  v2(90,3);
  v2(92,1)=26;
  v2(92,2)=5451;
  v2(92,3)=(-(y(28)*params(87)*y(44)));
  v2(93,1)=26;
  v2(93,2)=4171;
  v2(93,3)=  v2(92,3);
  v2(94,1)=26;
  v2(94,2)=5575;
  v2(94,3)=(-(y(33)*y(43)*params(87)));
  v2(95,1)=26;
  v2(95,2)=3527;
  v2(95,3)=  v2(94,3);
  v2(96,1)=26;
  v2(96,2)=5580;
  v2(96,3)=(-(y(28)*y(43)*params(87)));
  v2(97,1)=26;
  v2(97,2)=4172;
  v2(97,3)=  v2(96,3);
  v2(98,1)=26;
  v2(98,2)=5590;
  v2(98,3)=(-(y(28)*y(33)*params(87)));
  v2(99,1)=26;
  v2(99,2)=5462;
  v2(99,3)=  v2(98,3);
  v2(100,1)=27;
  v2(100,2)=131;
  v2(100,3)=(-(T296*exp(y(71))*T1254));
  v2(101,1)=27;
  v2(101,2)=4001;
  v2(101,3)=(-(exp(y(71))*T744*T783));
  v2(102,1)=27;
  v2(102,2)=161;
  v2(102,3)=  v2(101,3);
  v2(103,1)=27;
  v2(103,2)=4031;
  v2(103,3)=(-(exp(y(71))*T294*T1266));
  v2(104,1)=27;
  v2(104,2)=9032;
  v2(104,3)=(-(T296*exp(y(71))*T744));
  v2(105,1)=27;
  v2(105,2)=200;
  v2(105,3)=  v2(104,3);
  v2(106,1)=27;
  v2(106,2)=9062;
  v2(106,3)=(-(exp(y(71))*T294*T783));
  v2(107,1)=27;
  v2(107,2)=4070;
  v2(107,3)=  v2(106,3);
  v2(108,1)=27;
  v2(108,2)=9101;
  v2(108,3)=(-(T296*exp(y(71))*T294));
  v2(109,1)=28;
  v2(109,2)=3381;
  v2(109,3)=(-(y(2)*y(33)*(-((y(43)+params(81))*(y(27)+y(27))/(y(27)*y(27)*y(27)*y(27))/(2-params(80)+params(87)*(1+params(80)))))));
  v2(110,1)=28;
  v2(110,2)=156;
  v2(110,3)=(-T713);
  v2(111,1)=28;
  v2(111,2)=3356;
  v2(111,3)=  v2(110,3);
  v2(112,1)=28;
  v2(112,2)=4155;
  v2(112,3)=(-(y(2)*T712));
  v2(113,1)=28;
  v2(113,2)=3387;
  v2(113,3)=  v2(112,3);
  v2(114,1)=28;
  v2(114,2)=4130;
  v2(114,3)=(-T346);
  v2(115,1)=28;
  v2(115,2)=162;
  v2(115,3)=  v2(114,3);
  v2(116,1)=28;
  v2(116,2)=5445;
  v2(116,3)=(-(y(2)*y(33)*(-(T3/(y(27)*y(27))/(2-params(80)+params(87)*(1+params(80)))))));
  v2(117,1)=28;
  v2(117,2)=3397;
  v2(117,3)=  v2(116,3);
  v2(118,1)=28;
  v2(118,2)=5420;
  v2(118,3)=(-T859);
  v2(119,1)=28;
  v2(119,2)=172;
  v2(119,3)=  v2(118,3);
  v2(120,1)=28;
  v2(120,2)=5451;
  v2(120,3)=(-(y(2)*T858));
  v2(121,1)=28;
  v2(121,2)=4171;
  v2(121,3)=  v2(120,3);
  v2(122,1)=29;
  v2(122,2)=4130;
  v2(122,3)=T3;
  v2(123,1)=29;
  v2(123,2)=162;
  v2(123,3)=  v2(122,3);
  v2(124,1)=30;
  v2(124,2)=13444;
  v2(124,3)=(-(params(77)*T363));
  v2(125,1)=30;
  v2(125,2)=3588;
  v2(125,3)=  v2(124,3);
  v2(126,1)=30;
  v2(126,2)=13960;
  v2(126,3)=(-(params(77)*T875));
  v2(127,1)=30;
  v2(127,2)=3592;
  v2(127,3)=  v2(126,3);
  v2(128,1)=30;
  v2(128,2)=14037;
  v2(128,3)=(-(params(77)*y(28)*T874));
  v2(129,1)=30;
  v2(129,2)=13525;
  v2(129,3)=  v2(128,3);
  v2(130,1)=30;
  v2(130,2)=14041;
  v2(130,3)=(-(params(77)*y(28)*y(105)*T871*2*T871/(params(81)*8)));
  v2(131,1)=31;
  v2(131,2)=131;
  v2(131,3)=(-((-((-(y(33)*y(41)))*(y(33)*y(2)*y(33)+y(33)*y(2)*y(33))))/(y(2)*y(33)*y(2)*y(33)*y(2)*y(33)*y(2)*y(33))));
  v2(132,1)=31;
  v2(132,2)=4130;
  v2(132,3)=(-((y(2)*y(33)*y(2)*y(33)*(-y(41))-(-(y(2)*y(41)))*(y(33)*y(2)*y(33)+y(33)*y(2)*y(33)))/(y(2)*y(33)*y(2)*y(33)*y(2)*y(33)*y(2)*y(33))));
  v2(133,1)=31;
  v2(133,2)=162;
  v2(133,3)=  v2(132,3);
  v2(134,1)=31;
  v2(134,2)=4161;
  v2(134,3)=(-((-((-(y(2)*y(41)))*(y(2)*y(2)*y(33)+y(2)*y(2)*y(33))))/(y(2)*y(33)*y(2)*y(33)*y(2)*y(33)*y(2)*y(33))));
  v2(135,1)=31;
  v2(135,2)=5162;
  v2(135,3)=(-((-y(33))/(y(2)*y(33)*y(2)*y(33))));
  v2(136,1)=31;
  v2(136,2)=170;
  v2(136,3)=  v2(135,3);
  v2(137,1)=31;
  v2(137,2)=5193;
  v2(137,3)=(-((-y(2))/(y(2)*y(33)*y(2)*y(33))));
  v2(138,1)=31;
  v2(138,2)=4169;
  v2(138,3)=  v2(137,3);
  v2(139,1)=32;
  v2(139,2)=5316;
  v2(139,3)=(-(0.5*(-(T3/params(81)))));
  v2(140,1)=32;
  v2(140,2)=3396;
  v2(140,3)=  v2(139,3);
  v2(141,1)=33;
  v2(141,2)=5331;
  v2(141,3)=(-(y(44)*T385*(-((-(y(43)-params(81)))*(y(42)+y(42))))/(y(42)*y(42)*y(42)*y(42))));
  v2(142,1)=33;
  v2(142,2)=5460;
  v2(142,3)=(-(y(44)*T385*T3/(y(42)*y(42))));
  v2(143,1)=33;
  v2(143,2)=5332;
  v2(143,3)=  v2(142,3);
  v2(144,1)=33;
  v2(144,2)=5574;
  v2(144,3)=(-T385);
  v2(145,1)=33;
  v2(145,2)=3398;
  v2(145,3)=  v2(144,3);
  v2(146,1)=33;
  v2(146,2)=5589;
  v2(146,3)=(-(T385*(-(y(43)-params(81)))/(y(42)*y(42))));
  v2(147,1)=33;
  v2(147,2)=5333;
  v2(147,3)=  v2(146,3);
  v2(148,1)=33;
  v2(148,2)=5590;
  v2(148,3)=(-(T385*1/y(42)));
  v2(149,1)=33;
  v2(149,2)=5462;
  v2(149,3)=  v2(148,3);
  v2(150,1)=34;
  v2(150,2)=6241;
  v2(150,3)=(-(getPowerDeriv(y(49),(-params(69)),2)));
  v2(151,1)=35;
  v2(151,2)=7021;
  v2(151,3)=(-(params(70)*(y(55)-1+y(55)-1)/((y(55)-1)*(y(55)-1)*(y(55)-1)*(y(55)-1))));
  v2(152,1)=36;
  v2(152,2)=261;
  v2(152,3)=(-((-((-(y(53)*params(73)))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))));
  v2(153,1)=36;
  v2(153,2)=6711;
  v2(153,3)=(-((-params(73))/(y(3)*y(3))));
  v2(154,1)=36;
  v2(154,2)=311;
  v2(154,3)=  v2(153,3);
  v2(155,1)=37;
  v2(155,2)=7019;
  v2(155,3)=(-((-(1-params(73)))/(y(55)*y(55))));
  v2(156,1)=37;
  v2(156,2)=6763;
  v2(156,3)=  v2(155,3);
  v2(157,1)=37;
  v2(157,2)=7021;
  v2(157,3)=(-((-((-(y(53)*(1-params(73))))*(y(55)+y(55))))/(y(55)*y(55)*y(55)*y(55))));
  v2(158,1)=38;
  v2(158,2)=8884;
  v2(158,3)=(-params(71));
  v2(159,1)=38;
  v2(159,2)=14388;
  v2(159,3)=  v2(158,3);
  v2(160,1)=39;
  v2(160,2)=8693;
  v2(160,3)=1;
  v2(161,1)=39;
  v2(161,2)=6389;
  v2(161,3)=  v2(160,3);
  v2(162,1)=40;
  v2(162,2)=7541;
  v2(162,3)=(-((-(y(60)*(y(59)+y(59))))/(y(59)*y(59)*y(59)*y(59))));
  v2(163,1)=40;
  v2(163,2)=7670;
  v2(163,3)=(-(1/(y(59)*y(59))));
  v2(164,1)=40;
  v2(164,2)=7542;
  v2(164,3)=  v2(163,3);
  v2(165,1)=40;
  v2(165,2)=7923;
  v2(165,3)=1;
  v2(166,1)=40;
  v2(166,2)=6899;
  v2(166,3)=  v2(165,3);
  v2(167,1)=41;
  v2(167,2)=7794;
  v2(167,3)=1;
  v2(168,1)=41;
  v2(168,2)=6898;
  v2(168,3)=  v2(167,3);
  v2(169,1)=42;
  v2(169,2)=261;
  v2(169,3)=(-(T913*(-(params(76)*(-((-y(57))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))))+T912*T1427));
  v2(170,1)=42;
  v2(170,2)=7227;
  v2(170,3)=(-(T986*T1427+T913*(-(params(76)*T3/(y(3)*y(3))))));
  v2(171,1)=42;
  v2(171,2)=315;
  v2(171,3)=  v2(170,3);
  v2(172,1)=42;
  v2(172,2)=7281;
  v2(172,3)=(-(T986*T986*T1426));
  v2(173,1)=43;
  v2(173,2)=7151;
  v2(173,3)=(-((-((-y(111))*(y(56)+y(56))))/(y(56)*y(56)*y(56)*y(56))));
  v2(174,1)=43;
  v2(174,2)=14246;
  v2(174,3)=(-(T3/(y(56)*y(56))));
  v2(175,1)=43;
  v2(175,2)=7206;
  v2(175,3)=  v2(174,3);
  v2(176,1)=44;
  v2(176,2)=261;
  v2(176,3)=(-(y(56)*((y(3)*y(3)*(T916+y(3)*y(57)*params(76)*(-((-y(57))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))-T916)-(y(3)*T916-y(57)*params(76)*(y(57)/y(3)-params(78)))*(y(3)+y(3)))/(y(3)*y(3)*y(3)*y(3))-T1462)));
  v2(177,1)=44;
  v2(177,2)=7098;
  v2(177,3)=(-T923);
  v2(178,1)=44;
  v2(178,2)=314;
  v2(178,3)=  v2(177,3);
  v2(179,1)=44;
  v2(179,2)=7227;
  v2(179,3)=(-(y(56)*((y(3)*(params(76)*T910+y(57)*params(76)*T3/(y(3)*y(3)))-T990)/(y(3)*y(3))-T279*(T984*2*T910+T920*T3/(y(3)*y(3))))));
  v2(180,1)=44;
  v2(180,2)=315;
  v2(180,3)=  v2(179,3);
  v2(181,1)=44;
  v2(181,2)=7280;
  v2(181,3)=(-(T990/y(3)-T993));
  v2(182,1)=44;
  v2(182,2)=7152;
  v2(182,3)=  v2(181,3);
  v2(183,1)=44;
  v2(183,2)=7281;
  v2(183,3)=(-(y(56)*((T985+T985)/y(3)-T279*T984*2*T984)));
  v2(184,1)=45;
  v2(184,2)=6890;
  v2(184,3)=(-(params(79)*y(59)));
  v2(185,1)=45;
  v2(185,2)=6762;
  v2(185,3)=  v2(184,3);
  v2(186,1)=45;
  v2(186,2)=7535;
  v2(186,3)=(-(1-params(79)+params(79)*y(54)));
  v2(187,1)=45;
  v2(187,2)=6767;
  v2(187,3)=  v2(186,3);
  v2(188,1)=45;
  v2(188,2)=7536;
  v2(188,3)=(-(y(53)*params(79)));
  v2(189,1)=45;
  v2(189,2)=6896;
  v2(189,3)=  v2(188,3);
  v2(190,1)=46;
  v2(190,2)=261;
  v2(190,3)=T922+T922+y(3)*T1462;
  v2(191,1)=46;
  v2(191,2)=7227;
  v2(191,3)=T993+y(3)*T279*(T984*2*T910+T920*T3/(y(3)*y(3)));
  v2(192,1)=46;
  v2(192,2)=315;
  v2(192,3)=  v2(191,3);
  v2(193,1)=46;
  v2(193,2)=7281;
  v2(193,3)=y(3)*T279*T984*2*T984;
  v2(194,1)=48;
  v2(194,2)=7146;
  v2(194,3)=(-(y(66)*params(87)*y(67)));
  v2(195,1)=48;
  v2(195,2)=6506;
  v2(195,3)=  v2(194,3);
  v2(196,1)=48;
  v2(196,2)=8436;
  v2(196,3)=(-(y(56)*params(87)*y(67)));
  v2(197,1)=48;
  v2(197,2)=6516;
  v2(197,3)=  v2(196,3);
  v2(198,1)=48;
  v2(198,2)=8441;
  v2(198,3)=(-(y(51)*params(87)*y(67)));
  v2(199,1)=48;
  v2(199,2)=7161;
  v2(199,3)=  v2(198,3);
  v2(200,1)=48;
  v2(200,2)=8565;
  v2(200,3)=(-(y(56)*params(87)*y(66)));
  v2(201,1)=48;
  v2(201,2)=6517;
  v2(201,3)=  v2(200,3);
  v2(202,1)=48;
  v2(202,2)=8570;
  v2(202,3)=(-(y(51)*params(87)*y(66)));
  v2(203,1)=48;
  v2(203,2)=7162;
  v2(203,3)=  v2(202,3);
  v2(204,1)=48;
  v2(204,2)=8580;
  v2(204,3)=(-(y(51)*params(87)*y(56)));
  v2(205,1)=48;
  v2(205,2)=8452;
  v2(205,3)=  v2(204,3);
  v2(206,1)=49;
  v2(206,2)=261;
  v2(206,3)=(-(T477*exp(y(71))*getPowerDeriv(y(3),params(73),2)));
  v2(207,1)=49;
  v2(207,2)=6969;
  v2(207,3)=(-(T931*T964));
  v2(208,1)=49;
  v2(208,2)=313;
  v2(208,3)=  v2(207,3);
  v2(209,1)=49;
  v2(209,2)=7021;
  v2(209,3)=(-(T476*getPowerDeriv(y(55),1-params(73),2)));
  v2(210,1)=49;
  v2(210,2)=9033;
  v2(210,3)=(-(T477*T931));
  v2(211,1)=49;
  v2(211,2)=329;
  v2(211,3)=  v2(210,3);
  v2(212,1)=49;
  v2(212,2)=9085;
  v2(212,3)=(-(T476*T964));
  v2(213,1)=49;
  v2(213,2)=7037;
  v2(213,3)=  v2(212,3);
  v2(214,1)=49;
  v2(214,2)=9101;
  v2(214,3)=(-(T476*T477));
  v2(215,1)=50;
  v2(215,2)=6371;
  v2(215,3)=(-(y(3)*y(56)*(-((params(81)+y(66))*(y(50)+y(50))/(y(50)*y(50)*y(50)*y(50))/(2-params(80)+params(87)*(1+params(80)))))));
  v2(216,1)=50;
  v2(216,2)=308;
  v2(216,3)=(-T895);
  v2(217,1)=50;
  v2(217,2)=6324;
  v2(217,3)=  v2(216,3);
  v2(218,1)=50;
  v2(218,2)=7145;
  v2(218,3)=(-(y(3)*T894));
  v2(219,1)=50;
  v2(219,2)=6377;
  v2(219,3)=  v2(218,3);
  v2(220,1)=50;
  v2(220,2)=7098;
  v2(220,3)=(-T485);
  v2(221,1)=50;
  v2(221,2)=314;
  v2(221,3)=  v2(220,3);
  v2(222,1)=50;
  v2(222,2)=8435;
  v2(222,3)=(-(y(3)*y(56)*(-(T3/(y(50)*y(50))/(2-params(80)+params(87)*(1+params(80)))))));
  v2(223,1)=50;
  v2(223,2)=6387;
  v2(223,3)=  v2(222,3);
  v2(224,1)=50;
  v2(224,2)=8388;
  v2(224,3)=(-T1029);
  v2(225,1)=50;
  v2(225,2)=324;
  v2(225,3)=  v2(224,3);
  v2(226,1)=50;
  v2(226,2)=8441;
  v2(226,3)=(-(y(3)*T1028));
  v2(227,1)=50;
  v2(227,2)=7161;
  v2(227,3)=  v2(226,3);
  v2(228,1)=51;
  v2(228,2)=7098;
  v2(228,3)=T3;
  v2(229,1)=51;
  v2(229,2)=314;
  v2(229,3)=  v2(228,3);
  v2(230,1)=52;
  v2(230,2)=14112;
  v2(230,3)=(-(params(77)*T499));
  v2(231,1)=52;
  v2(231,2)=6560;
  v2(231,3)=  v2(230,3);
  v2(232,1)=52;
  v2(232,2)=14628;
  v2(232,3)=(-(params(77)*T1039));
  v2(233,1)=52;
  v2(233,2)=6564;
  v2(233,3)=  v2(232,3);
  v2(234,1)=52;
  v2(234,2)=14687;
  v2(234,3)=(-(params(77)*y(51)*T1038));
  v2(235,1)=52;
  v2(235,2)=14175;
  v2(235,3)=  v2(234,3);
  v2(236,1)=52;
  v2(236,2)=14691;
  v2(236,3)=(-(params(77)*y(51)*y(110)*T871*2*T871/(params(81)*8)));
  v2(237,1)=53;
  v2(237,2)=261;
  v2(237,3)=(-((-((-(y(56)*y(64)))*(y(56)*y(3)*y(56)+y(56)*y(3)*y(56))))/(y(3)*y(56)*y(3)*y(56)*y(3)*y(56)*y(3)*y(56))));
  v2(238,1)=53;
  v2(238,2)=7098;
  v2(238,3)=(-((y(3)*y(56)*y(3)*y(56)*(-y(64))-(-(y(3)*y(64)))*(y(56)*y(3)*y(56)+y(56)*y(3)*y(56)))/(y(3)*y(56)*y(3)*y(56)*y(3)*y(56)*y(3)*y(56))));
  v2(239,1)=53;
  v2(239,2)=314;
  v2(239,3)=  v2(238,3);
  v2(240,1)=53;
  v2(240,2)=7151;
  v2(240,3)=(-((-((-(y(3)*y(64)))*(y(3)*y(3)*y(56)+y(3)*y(3)*y(56))))/(y(3)*y(56)*y(3)*y(56)*y(3)*y(56)*y(3)*y(56))));
  v2(241,1)=53;
  v2(241,2)=8130;
  v2(241,3)=(-((-y(56))/(y(3)*y(56)*y(3)*y(56))));
  v2(242,1)=53;
  v2(242,2)=322;
  v2(242,3)=  v2(241,3);
  v2(243,1)=53;
  v2(243,2)=8183;
  v2(243,3)=(-((-y(3))/(y(3)*y(56)*y(3)*y(56))));
  v2(244,1)=53;
  v2(244,2)=7159;
  v2(244,3)=  v2(243,3);
  v2(245,1)=54;
  v2(245,2)=8306;
  v2(245,3)=(-(0.5*(-(T3/params(81)))));
  v2(246,1)=54;
  v2(246,2)=6386;
  v2(246,3)=  v2(245,3);
  v2(247,1)=55;
  v2(247,2)=8321;
  v2(247,3)=(-(y(67)*T385*(-((-(y(66)-params(81)))*(y(65)+y(65))))/(y(65)*y(65)*y(65)*y(65))));
  v2(248,1)=55;
  v2(248,2)=8450;
  v2(248,3)=(-(y(67)*T385*T3/(y(65)*y(65))));
  v2(249,1)=55;
  v2(249,2)=8322;
  v2(249,3)=  v2(248,3);
  v2(250,1)=55;
  v2(250,2)=8564;
  v2(250,3)=(-T385);
  v2(251,1)=55;
  v2(251,2)=6388;
  v2(251,3)=  v2(250,3);
  v2(252,1)=55;
  v2(252,2)=8579;
  v2(252,3)=(-(T385*(-(y(66)-params(81)))/(y(65)*y(65))));
  v2(253,1)=55;
  v2(253,2)=8323;
  v2(253,3)=  v2(252,3);
  v2(254,1)=55;
  v2(254,2)=8580;
  v2(254,3)=(-(T385*1/y(65)));
  v2(255,1)=55;
  v2(255,2)=8452;
  v2(255,3)=  v2(254,3);
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),79,16641);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],79,2146689);
end
end
end
end
