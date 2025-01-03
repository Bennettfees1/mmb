function [residual, g1, g2, g3] = NK_CK08_static(y, x, params)
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

residual = zeros( 56, 1);

%
% Model equations
%

T182 = 1/(1+params(42)*params(36))*(1-params(41))*(1-params(36)*params(41))/params(41);
T252 = (-params(48))/(1-params(48));
T254 = 1/(1-params(48));
T256 = y(18)*T252+(y(20)+y(25))*T254;
T277 = params(68)*T254*params(72);
T284 = (1+params(40))/(1-params(48));
T289 = params(45)*params(36)*(1-params(47))/(1-params(45)*params(36)*(1-params(47)));
T299 = T289*(params(68)*params(78)*(params(48)/(1-params(48)))^2-params(68)*params(72)*(1+params(40))/(1-params(48))^2);
T334 = params(48)*params(78)*params(68)/(1-params(48))-T277;
T340 = params(68)*params(72)/(1+params(40));
T351 = T334*params(75)*params(36)*params(45)/(1-params(45)*params(36)*(1-params(47)));
T369 = params(68)*params(78)*params(36)*params(45)/(1-params(45)*params(36)*(1-params(47)));
lhs =y(28);
rhs =4*y(14);
residual(1)= lhs-rhs;
lhs =y(29);
rhs =y(12);
residual(2)= lhs-rhs;
lhs =y(30);
rhs =4*y(11);
residual(3)= lhs-rhs;
lhs =y(31);
rhs =y(21);
residual(4)= lhs-rhs;
lhs =y(32);
rhs =y(21);
residual(5)= lhs-rhs;
lhs =y(33);
rhs =y(26);
residual(6)= lhs-rhs;
lhs =y(28);
rhs =params(32)*y(27)+y(32)*params(31)+y(32)*params(30)+y(32)*params(29)+y(32)*params(28)+y(32)*params(27)+y(32)*params(26)+y(32)*params(25)+y(32)*params(24)+y(32)*params(23)+y(31)*params(22)+y(31)*params(21)+y(31)*params(20)+y(31)*params(19)+y(31)*params(18)+y(31)*params(17)+y(31)*params(16)+y(31)*params(15)+y(31)*params(14)+y(30)*params(13)+y(30)*params(12)+y(30)*params(11)+y(30)*params(10)+y(30)*params(6)+y(30)*params(5)+y(28)*params(1)+y(28)*params(2)+y(28)*params(3)+y(28)*params(4)+y(30)*params(7)+y(30)*params(8)+y(30)*params(9);
residual(7)= lhs-rhs;
lhs =y(33);
rhs =params(34)*x(4);
residual(8)= lhs-rhs;
lhs =y(7);
rhs =y(14)+y(7)+y(22)-y(11);
residual(9)= lhs-rhs;
lhs =y(7);
rhs =(-params(39))/(1-params(38))*(y(1)-params(38)*y(1));
residual(10)= lhs-rhs;
lhs =y(11);
rhs =y(11)*params(42)/(1+params(42)*params(36))+y(11)*params(36)/(1+params(42)*params(36))+T182*y(8);
residual(11)= lhs-rhs;
lhs =y(8);
rhs =y(20);
residual(12)= lhs-rhs;
lhs =y(9);
rhs =params(43)*y(16)+(1-params(43))*y(17);
residual(13)= lhs-rhs;
lhs =y(10);
rhs =y(10)*(1-params(47))+y(9)*params(70)/params(73);
residual(14)= lhs-rhs;
lhs =y(10);
rhs =y(16)*(-params(76))/(1-params(76));
residual(15)= lhs-rhs;
lhs =y(13);
rhs =y(9)-y(17);
residual(16)= lhs-rhs;
lhs =y(15);
rhs =y(9)-y(16);
residual(17)= lhs-rhs;
lhs =y(6)+y(3);
rhs =y(4)+y(2);
residual(18)= lhs-rhs;
lhs =y(19);
rhs =y(20)+y(25)+(params(48)-1)*y(5);
residual(19)= lhs-rhs;
lhs =y(19);
rhs =params(45)*(y(19)-y(11)+y(11)*params(46))+(1-params(45))*y(18);
residual(20)= lhs-rhs;
lhs =y(2);
rhs =(1-params(45)*params(36)*(1-params(47)))*T256+params(45)*params(36)*(1-params(47))*(y(7)+y(2)+T252*(y(11)*params(46)+y(18)-y(18)-y(11))-y(7));
residual(21)= lhs-rhs;
lhs =y(3)*params(66);
rhs =T256*T252*params(78)*params(68)+T277*(y(18)*(-(1+params(40)))/(1-params(48))-y(7)+(y(20)+y(25))*T284)+(y(11)*params(46)+y(18)-y(18)-y(11))*T299+y(3)*params(45)*params(36)*(1-params(47))*params(66);
residual(22)= lhs-rhs;
lhs =y(6)*params(69);
rhs =params(78)*params(68)/params(48)*(y(25)+y(20)+y(18)*(-params(48)))+params(68)*params(78)*T289*(y(11)+y(18)-y(18)-y(11)*params(46))+y(6)*params(36)*(1-params(47))*params(69);
residual(23)= lhs-rhs;
lhs =y(4)*params(65);
rhs =y(4)*params(65)*params(36)*(1-params(47)-params(75))+(y(11)+y(18)-y(18)-y(11)*params(46))*T289*T334+(y(25)+y(20)+y(18)*(-params(48)))*params(78)*params(68)/(1-params(48))-T340*(T284*(y(25)+y(20)-y(18))-y(7))-T351*(y(11)+y(18)-y(19)-y(11)*params(46))-y(15)*params(75)*params(36)*params(65);
residual(24)= lhs-rhs;
lhs =params(60)/params(74)*(-y(13));
rhs =T369*(y(11)+y(18)-y(19)-y(11)*params(46))+y(6)*params(36)*params(69);
residual(25)= lhs-rhs;
lhs =y(21)*params(79);
rhs =y(1)*params(64)+params(67)*y(24)+y(17)*params(60)*params(77)+y(10)*params(73)*params(61);
residual(26)= lhs-rhs;
lhs =y(21);
rhs =y(10)+y(25)+params(48)*y(5);
residual(27)= lhs-rhs;
lhs =y(12);
rhs =y(11)+y(11)+y(11)+y(11);
residual(28)= lhs-rhs;
lhs =y(22);
rhs =y(22)*params(49)+params(56)*x(1);
residual(29)= lhs-rhs;
lhs =y(24);
rhs =y(26)+y(24)*params(51);
residual(30)= lhs-rhs;
lhs =y(23);
rhs =y(23)*params(50)+params(57)*x(3);
residual(31)= lhs-rhs;
lhs =y(25);
rhs =y(25)*params(52)+params(59)*x(2);
residual(32)= lhs-rhs;
lhs =y(27);
rhs =x(3)+y(27)*params(35);
residual(33)= lhs-rhs;
lhs =y(34);
rhs =y(30);
residual(34)= lhs-rhs;
lhs =y(35);
rhs =y(30);
residual(35)= lhs-rhs;
lhs =y(36);
rhs =y(30);
residual(36)= lhs-rhs;
lhs =y(37);
rhs =y(31);
residual(37)= lhs-rhs;
lhs =y(38);
rhs =y(31);
residual(38)= lhs-rhs;
lhs =y(39);
rhs =y(31);
residual(39)= lhs-rhs;
lhs =y(40);
rhs =y(32);
residual(40)= lhs-rhs;
lhs =y(41);
rhs =y(32);
residual(41)= lhs-rhs;
lhs =y(42);
rhs =y(32);
residual(42)= lhs-rhs;
lhs =y(43);
rhs =y(32);
residual(43)= lhs-rhs;
lhs =y(44);
rhs =y(32);
residual(44)= lhs-rhs;
lhs =y(45);
rhs =y(32);
residual(45)= lhs-rhs;
lhs =y(46);
rhs =y(31);
residual(46)= lhs-rhs;
lhs =y(47);
rhs =y(31);
residual(47)= lhs-rhs;
lhs =y(48);
rhs =y(31);
residual(48)= lhs-rhs;
lhs =y(49);
rhs =y(28);
residual(49)= lhs-rhs;
lhs =y(50);
rhs =y(28);
residual(50)= lhs-rhs;
lhs =y(51);
rhs =y(28);
residual(51)= lhs-rhs;
lhs =y(52);
rhs =y(30);
residual(52)= lhs-rhs;
lhs =y(53);
rhs =y(30);
residual(53)= lhs-rhs;
lhs =y(54);
rhs =y(30);
residual(54)= lhs-rhs;
lhs =y(55);
rhs =y(11);
residual(55)= lhs-rhs;
lhs =y(56);
rhs =y(11);
residual(56)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(56, 56);

  %
  % Jacobian matrix
  %

  g1(1,14)=(-4);
  g1(1,28)=1;
  g1(2,12)=(-1);
  g1(2,29)=1;
  g1(3,11)=(-4);
  g1(3,30)=1;
  g1(4,21)=(-1);
  g1(4,31)=1;
  g1(5,21)=(-1);
  g1(5,32)=1;
  g1(6,26)=(-1);
  g1(6,33)=1;
  g1(7,27)=(-params(32));
  g1(7,28)=1-(params(4)+params(3)+params(1)+params(2));
  g1(7,30)=(-(params(13)+params(12)+params(11)+params(10)+params(9)+params(8)+params(7)+params(6)+params(5)));
  g1(7,31)=(-(params(22)+params(21)+params(20)+params(19)+params(18)+params(17)+params(16)+params(15)+params(14)));
  g1(7,32)=(-(params(31)+params(30)+params(29)+params(28)+params(27)+params(26)+params(25)+params(24)+params(23)));
  g1(8,33)=1;
  g1(9,11)=1;
  g1(9,14)=(-1);
  g1(9,22)=(-1);
  g1(10,1)=(-((1-params(38))*(-params(39))/(1-params(38))));
  g1(10,7)=1;
  g1(11,8)=(-T182);
  g1(11,11)=1-(params(42)/(1+params(42)*params(36))+params(36)/(1+params(42)*params(36)));
  g1(12,8)=1;
  g1(12,20)=(-1);
  g1(13,9)=1;
  g1(13,16)=(-params(43));
  g1(13,17)=(-(1-params(43)));
  g1(14,9)=(-(params(70)/params(73)));
  g1(14,10)=1-(1-params(47));
  g1(15,10)=1;
  g1(15,16)=(-((-params(76))/(1-params(76))));
  g1(16,9)=(-1);
  g1(16,13)=1;
  g1(16,17)=1;
  g1(17,9)=(-1);
  g1(17,15)=1;
  g1(17,16)=1;
  g1(18,2)=(-1);
  g1(18,3)=1;
  g1(18,4)=(-1);
  g1(18,6)=1;
  g1(19,5)=(-(params(48)-1));
  g1(19,19)=1;
  g1(19,20)=(-1);
  g1(19,25)=(-1);
  g1(20,11)=(-(params(45)*((-1)+params(46))));
  g1(20,18)=(-(1-params(45)));
  g1(20,19)=1-params(45);
  g1(21,2)=1-params(45)*params(36)*(1-params(47));
  g1(21,11)=(-(params(45)*params(36)*(1-params(47))*T252*(params(46)-1)));
  g1(21,18)=(-((1-params(45)*params(36)*(1-params(47)))*T252));
  g1(21,20)=(-((1-params(45)*params(36)*(1-params(47)))*T254));
  g1(21,25)=(-((1-params(45)*params(36)*(1-params(47)))*T254));
  g1(22,3)=params(66)-params(45)*params(36)*(1-params(47))*params(66);
  g1(22,7)=T277;
  g1(22,11)=(-(T299*(params(46)-1)));
  g1(22,18)=(-(T252*T252*params(78)*params(68)+T277*(-(1+params(40)))/(1-params(48))));
  g1(22,20)=(-(T254*T252*params(78)*params(68)+T277*T284));
  g1(22,25)=(-(T254*T252*params(78)*params(68)+T277*T284));
  g1(23,6)=params(69)-params(36)*(1-params(47))*params(69);
  g1(23,11)=(-(params(68)*params(78)*T289*(1-params(46))));
  g1(23,18)=(-((-params(48))*params(78)*params(68)/params(48)));
  g1(23,20)=(-(params(78)*params(68)/params(48)));
  g1(23,25)=(-(params(78)*params(68)/params(48)));
  g1(24,4)=params(65)-params(65)*params(36)*(1-params(47)-params(75));
  g1(24,7)=(-T340);
  g1(24,11)=(-(T289*T334*(1-params(46))-T351*(1-params(46))));
  g1(24,15)=params(75)*params(36)*params(65);
  g1(24,18)=(-((-params(48))*params(78)*params(68)/(1-params(48))-T340*(-T284)-T351));
  g1(24,19)=(-T351);
  g1(24,20)=(-(params(78)*params(68)/(1-params(48))-T284*T340));
  g1(24,25)=(-(params(78)*params(68)/(1-params(48))-T284*T340));
  g1(25,6)=(-(params(36)*params(69)));
  g1(25,11)=(-(T369*(1-params(46))));
  g1(25,13)=(-(params(60)/params(74)));
  g1(25,18)=(-T369);
  g1(25,19)=T369;
  g1(26,1)=(-params(64));
  g1(26,10)=(-(params(73)*params(61)));
  g1(26,17)=(-(params(60)*params(77)));
  g1(26,21)=params(79);
  g1(26,24)=(-params(67));
  g1(27,5)=(-params(48));
  g1(27,10)=(-1);
  g1(27,21)=1;
  g1(27,25)=(-1);
  g1(28,11)=(-4);
  g1(28,12)=1;
  g1(29,22)=1-params(49);
  g1(30,24)=1-params(51);
  g1(30,26)=(-1);
  g1(31,23)=1-params(50);
  g1(32,25)=1-params(52);
  g1(33,27)=1-params(35);
  g1(34,30)=(-1);
  g1(34,34)=1;
  g1(35,30)=(-1);
  g1(35,35)=1;
  g1(36,30)=(-1);
  g1(36,36)=1;
  g1(37,31)=(-1);
  g1(37,37)=1;
  g1(38,31)=(-1);
  g1(38,38)=1;
  g1(39,31)=(-1);
  g1(39,39)=1;
  g1(40,32)=(-1);
  g1(40,40)=1;
  g1(41,32)=(-1);
  g1(41,41)=1;
  g1(42,32)=(-1);
  g1(42,42)=1;
  g1(43,32)=(-1);
  g1(43,43)=1;
  g1(44,32)=(-1);
  g1(44,44)=1;
  g1(45,32)=(-1);
  g1(45,45)=1;
  g1(46,31)=(-1);
  g1(46,46)=1;
  g1(47,31)=(-1);
  g1(47,47)=1;
  g1(48,31)=(-1);
  g1(48,48)=1;
  g1(49,28)=(-1);
  g1(49,49)=1;
  g1(50,28)=(-1);
  g1(50,50)=1;
  g1(51,28)=(-1);
  g1(51,51)=1;
  g1(52,30)=(-1);
  g1(52,52)=1;
  g1(53,30)=(-1);
  g1(53,53)=1;
  g1(54,30)=(-1);
  g1(54,54)=1;
  g1(55,11)=(-1);
  g1(55,55)=1;
  g1(56,11)=(-1);
  g1(56,56)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],56,3136);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],56,175616);
end
end
end
end
