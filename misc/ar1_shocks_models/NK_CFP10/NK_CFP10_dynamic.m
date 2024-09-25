function [residual, g1, g2, g3] = NK_CFP10_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(58, 1);
T186 = (1+params(38))/(1+params(42));
T195 = (1-params(40)*params(41))/(1+params(42));
T204 = (1+params(38))*(params(37)-1)/((1+params(42))*(params(37)+params(38)));
T224 = 1/params(36);
lhs =y(55);
rhs =y(29)*4;
residual(1)= lhs-rhs;
lhs =y(56);
rhs =y(30)+y(1)+y(12)+y(13);
residual(2)= lhs-rhs;
lhs =y(57);
rhs =4*y(30);
residual(3)= lhs-rhs;
lhs =y(58);
rhs =y(26)-y(40);
residual(4)= lhs-rhs;
lhs =y(59);
rhs =y(26);
residual(5)= lhs-rhs;
lhs =y(55);
rhs =params(32)/100*y(60)+params(31)*y(104)+params(30)*y(103)+params(29)*y(102)+params(28)*y(95)+params(27)*y(16)+params(26)*y(15)+params(25)*y(14)+params(24)*y(10)+y(59)*params(23)+params(22)*y(101)+params(21)*y(100)+params(20)*y(99)+params(19)*y(94)+params(18)*y(19)+params(17)*y(18)+params(16)*y(17)+params(15)*y(9)+y(58)*params(14)+params(13)*y(98)+params(12)*y(97)+params(11)*y(96)+params(10)*y(93)+params(6)*y(8)+y(57)*params(5)+params(1)*y(7)+params(2)*y(20)+params(3)*y(21)+params(4)*y(22)+params(7)*y(23)+params(8)*y(24)+params(9)*y(25);
residual(6)= lhs-rhs;
lhs =y(26)*params(37)+params(38)*y(36);
rhs =y(39);
residual(7)= lhs-rhs;
lhs =y(26)*params(37)+params(38)*y(37);
rhs =y(38);
residual(8)= lhs-rhs;
lhs =params(37)*(y(84)-y(26));
rhs =y(29)-y(86);
residual(9)= lhs-rhs;
lhs =y(32);
rhs =T186*(y(85)-y(28))-T195*(y(87)-y(32))-T204*(y(91)-y(52))-1/(1+params(42))*y(92);
residual(10)= lhs-rhs;
lhs =y(33)+y(34);
rhs =y(26)+y(31)+y(32)*params(42);
residual(11)= lhs-rhs;
lhs =y(33);
rhs =T224*(y(2)-y(28)*(params(37)+params(38))*params(39)*(1-params(36))+y(32)*(1+params(42)*params(36)-params(41)*(1-params(36))*params(40)*params(39))+y(54));
residual(12)= lhs-rhs;
lhs =y(31);
rhs =y(28)*(params(37)+params(38))+y(32)*params(40)*params(41);
residual(13)= lhs-rhs;
lhs =y(26);
rhs =y(52)+y(37)*(1-params(40))+y(36)*params(40);
residual(14)= lhs-rhs;
lhs =y(30);
rhs =y(31)*params(44)+y(86)*params(36)+params(44)*y(53);
residual(15)= lhs-rhs;
lhs =y(35);
rhs =y(26)-y(31)*(params(39)-1);
residual(16)= lhs-rhs;
lhs =y(32)*params(41);
rhs =y(26)+y(31)-y(39)-y(36);
residual(17)= lhs-rhs;
lhs =y(27);
rhs =y(52)*(1+params(38))/(params(37)+params(38));
residual(18)= lhs-rhs;
lhs =y(28);
rhs =y(26)-y(27);
residual(19)= lhs-rhs;
lhs =y(40)*params(37)+params(38)*y(48);
rhs =y(51);
residual(20)= lhs-rhs;
lhs =y(40)*params(37)+params(38)*y(49);
rhs =y(50);
residual(21)= lhs-rhs;
lhs =params(37)*(y(88)-y(40));
rhs =y(42);
residual(22)= lhs-rhs;
lhs =y(44);
rhs =T186*(y(89)-y(41))-T195*(y(90)-y(44))-T204*(y(91)-y(52))-1/(1+params(42))*y(92);
residual(23)= lhs-rhs;
lhs =y(45)+y(46);
rhs =y(40)+y(43)+params(42)*y(44);
residual(24)= lhs-rhs;
lhs =y(45);
rhs =T224*(y(54)+y(3)-(params(37)+params(38))*params(39)*(1-params(36))*y(41)+(1+params(42)*params(36)-params(41)*(1-params(36))*params(40)*params(39))*y(44));
residual(25)= lhs-rhs;
lhs =y(43);
rhs =(params(37)+params(38))*y(41)+params(40)*params(41)*y(44);
residual(26)= lhs-rhs;
lhs =y(40);
rhs =y(52)+(1-params(40))*y(49)+params(40)*y(48);
residual(27)= lhs-rhs;
residual(28) = y(43);
lhs =y(47);
rhs =y(40)-(params(39)-1)*y(43);
residual(29)= lhs-rhs;
lhs =params(41)*y(44);
rhs =y(40)+y(43)-y(51)-y(48);
residual(30)= lhs-rhs;
lhs =y(41);
rhs =y(40)-y(27);
residual(31)= lhs-rhs;
lhs =y(52);
rhs =params(45)*y(4)+x(it_, 1);
residual(32)= lhs-rhs;
lhs =y(53);
rhs =params(47)*y(5)+x(it_, 2);
residual(33)= lhs-rhs;
lhs =y(54);
rhs =params(48)*y(6)+x(it_, 3);
residual(34)= lhs-rhs;
lhs =y(60);
rhs =params(35)*y(11)+x(it_, 4);
residual(35)= lhs-rhs;
lhs =y(61);
rhs =y(93);
residual(36)= lhs-rhs;
lhs =y(62);
rhs =y(96);
residual(37)= lhs-rhs;
lhs =y(63);
rhs =y(97);
residual(38)= lhs-rhs;
lhs =y(64);
rhs =y(94);
residual(39)= lhs-rhs;
lhs =y(65);
rhs =y(99);
residual(40)= lhs-rhs;
lhs =y(66);
rhs =y(100);
residual(41)= lhs-rhs;
lhs =y(67);
rhs =y(95);
residual(42)= lhs-rhs;
lhs =y(68);
rhs =y(102);
residual(43)= lhs-rhs;
lhs =y(69);
rhs =y(103);
residual(44)= lhs-rhs;
lhs =y(70);
rhs =y(1);
residual(45)= lhs-rhs;
lhs =y(71);
rhs =y(12);
residual(46)= lhs-rhs;
lhs =y(72);
rhs =y(10);
residual(47)= lhs-rhs;
lhs =y(73);
rhs =y(14);
residual(48)= lhs-rhs;
lhs =y(74);
rhs =y(15);
residual(49)= lhs-rhs;
lhs =y(75);
rhs =y(9);
residual(50)= lhs-rhs;
lhs =y(76);
rhs =y(17);
residual(51)= lhs-rhs;
lhs =y(77);
rhs =y(18);
residual(52)= lhs-rhs;
lhs =y(78);
rhs =y(7);
residual(53)= lhs-rhs;
lhs =y(79);
rhs =y(20);
residual(54)= lhs-rhs;
lhs =y(80);
rhs =y(21);
residual(55)= lhs-rhs;
lhs =y(81);
rhs =y(8);
residual(56)= lhs-rhs;
lhs =y(82);
rhs =y(23);
residual(57)= lhs-rhs;
lhs =y(83);
rhs =y(24);
residual(58)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(58, 108);

  %
  % Jacobian matrix
  %

T3 = (-1);
  g1(1,29)=(-4);
  g1(1,55)=1;
  g1(2,1)=T3;
  g1(2,30)=T3;
  g1(2,56)=1;
  g1(2,12)=T3;
  g1(2,13)=T3;
  g1(3,30)=(-4);
  g1(3,57)=1;
  g1(4,26)=T3;
  g1(4,40)=1;
  g1(4,58)=1;
  g1(5,26)=T3;
  g1(5,59)=1;
  g1(6,7)=(-params(1));
  g1(6,55)=1;
  g1(6,8)=(-params(6));
  g1(6,57)=(-params(5));
  g1(6,93)=(-params(10));
  g1(6,9)=(-params(15));
  g1(6,58)=(-params(14));
  g1(6,94)=(-params(19));
  g1(6,10)=(-params(24));
  g1(6,59)=(-params(23));
  g1(6,95)=(-params(28));
  g1(6,60)=(-(params(32)/100));
  g1(6,96)=(-params(11));
  g1(6,97)=(-params(12));
  g1(6,98)=(-params(13));
  g1(6,99)=(-params(20));
  g1(6,100)=(-params(21));
  g1(6,101)=(-params(22));
  g1(6,102)=(-params(29));
  g1(6,103)=(-params(30));
  g1(6,104)=(-params(31));
  g1(6,14)=(-params(25));
  g1(6,15)=(-params(26));
  g1(6,16)=(-params(27));
  g1(6,17)=(-params(16));
  g1(6,18)=(-params(17));
  g1(6,19)=(-params(18));
  g1(6,20)=(-params(2));
  g1(6,21)=(-params(3));
  g1(6,22)=(-params(4));
  g1(6,23)=(-params(7));
  g1(6,24)=(-params(8));
  g1(6,25)=(-params(9));
  g1(7,26)=params(37);
  g1(7,36)=params(38);
  g1(7,39)=T3;
  g1(8,26)=params(37);
  g1(8,37)=params(38);
  g1(8,38)=T3;
  g1(9,26)=(-params(37));
  g1(9,84)=params(37);
  g1(9,29)=T3;
  g1(9,86)=1;
  g1(10,28)=T186;
  g1(10,85)=(-T186);
  g1(10,32)=1-T195;
  g1(10,87)=T195;
  g1(10,52)=(-T204);
  g1(10,91)=T204;
  g1(10,92)=1/(1+params(42));
  g1(11,26)=T3;
  g1(11,31)=T3;
  g1(11,32)=(-params(42));
  g1(11,33)=1;
  g1(11,34)=1;
  g1(12,28)=(-(T224*(-((params(37)+params(38))*params(39)*(1-params(36))))));
  g1(12,32)=(-(T224*(1+params(42)*params(36)-params(41)*(1-params(36))*params(40)*params(39))));
  g1(12,2)=(-T224);
  g1(12,33)=1;
  g1(12,54)=(-T224);
  g1(13,28)=(-(params(37)+params(38)));
  g1(13,31)=1;
  g1(13,32)=(-(params(40)*params(41)));
  g1(14,26)=1;
  g1(14,36)=(-params(40));
  g1(14,37)=(-(1-params(40)));
  g1(14,52)=T3;
  g1(15,30)=1;
  g1(15,86)=(-params(36));
  g1(15,31)=(-params(44));
  g1(15,53)=(-params(44));
  g1(16,26)=T3;
  g1(16,31)=params(39)-1;
  g1(16,35)=1;
  g1(17,26)=T3;
  g1(17,31)=T3;
  g1(17,32)=params(41);
  g1(17,36)=1;
  g1(17,39)=1;
  g1(18,27)=1;
  g1(18,52)=(-((1+params(38))/(params(37)+params(38))));
  g1(19,26)=T3;
  g1(19,27)=1;
  g1(19,28)=1;
  g1(20,40)=params(37);
  g1(20,48)=params(38);
  g1(20,51)=T3;
  g1(21,40)=params(37);
  g1(21,49)=params(38);
  g1(21,50)=T3;
  g1(22,40)=(-params(37));
  g1(22,88)=params(37);
  g1(22,42)=T3;
  g1(23,41)=T186;
  g1(23,89)=(-T186);
  g1(23,44)=1-T195;
  g1(23,90)=T195;
  g1(23,52)=(-T204);
  g1(23,91)=T204;
  g1(23,92)=1/(1+params(42));
  g1(24,40)=T3;
  g1(24,43)=T3;
  g1(24,44)=(-params(42));
  g1(24,45)=1;
  g1(24,46)=1;
  g1(25,41)=(-(T224*(-((params(37)+params(38))*params(39)*(1-params(36))))));
  g1(25,44)=(-(T224*(1+params(42)*params(36)-params(41)*(1-params(36))*params(40)*params(39))));
  g1(25,3)=(-T224);
  g1(25,45)=1;
  g1(25,54)=(-T224);
  g1(26,41)=(-(params(37)+params(38)));
  g1(26,43)=1;
  g1(26,44)=(-(params(40)*params(41)));
  g1(27,40)=1;
  g1(27,48)=(-params(40));
  g1(27,49)=(-(1-params(40)));
  g1(27,52)=T3;
  g1(28,43)=1;
  g1(29,40)=T3;
  g1(29,43)=params(39)-1;
  g1(29,47)=1;
  g1(30,40)=T3;
  g1(30,43)=T3;
  g1(30,44)=params(41);
  g1(30,48)=1;
  g1(30,51)=1;
  g1(31,27)=1;
  g1(31,40)=T3;
  g1(31,41)=1;
  g1(32,4)=(-params(45));
  g1(32,52)=1;
  g1(32,105)=T3;
  g1(33,5)=(-params(47));
  g1(33,53)=1;
  g1(33,106)=T3;
  g1(34,6)=(-params(48));
  g1(34,54)=1;
  g1(34,107)=T3;
  g1(35,11)=(-params(35));
  g1(35,60)=1;
  g1(35,108)=T3;
  g1(36,93)=T3;
  g1(36,61)=1;
  g1(37,96)=T3;
  g1(37,62)=1;
  g1(38,97)=T3;
  g1(38,63)=1;
  g1(39,94)=T3;
  g1(39,64)=1;
  g1(40,99)=T3;
  g1(40,65)=1;
  g1(41,100)=T3;
  g1(41,66)=1;
  g1(42,95)=T3;
  g1(42,67)=1;
  g1(43,102)=T3;
  g1(43,68)=1;
  g1(44,103)=T3;
  g1(44,69)=1;
  g1(45,1)=T3;
  g1(45,70)=1;
  g1(46,12)=T3;
  g1(46,71)=1;
  g1(47,10)=T3;
  g1(47,72)=1;
  g1(48,14)=T3;
  g1(48,73)=1;
  g1(49,15)=T3;
  g1(49,74)=1;
  g1(50,9)=T3;
  g1(50,75)=1;
  g1(51,17)=T3;
  g1(51,76)=1;
  g1(52,18)=T3;
  g1(52,77)=1;
  g1(53,7)=T3;
  g1(53,78)=1;
  g1(54,20)=T3;
  g1(54,79)=1;
  g1(55,21)=T3;
  g1(55,80)=1;
  g1(56,8)=T3;
  g1(56,81)=1;
  g1(57,23)=T3;
  g1(57,82)=1;
  g1(58,24)=T3;
  g1(58,83)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],58,11664);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],58,1259712);
end
end
end
end
