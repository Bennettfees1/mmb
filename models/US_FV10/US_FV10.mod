//**************************************************************************
// A New Comparative Approach to Macroeconomic Modeling and Policy Analysis
//
// Volker Wieland, Tobias Cwik, Gernot J. Mueller, Sebastian Schmidt and
// Maik Wolters
//
// Working Paper, 2009
//**************************************************************************

// Model: US_FV10

// Model replication coded by: Philipp Lieberknecht,
//                             e_mail: philipp.lieberknecht@gmail.com
// based on code by Benjamin Born and Johannes Pfeifer, Copyright (C) 2013-2016 Dynare Team
// Last edited: 17/01/2018

// Further references:
// Jes�s Fern�ndez-Villaverde, 2010.
// "The econometrics of DSGE models"
// SERIEs: Journal of the Spanish Economic Association, Springer;Spanish Economic Association
// vol. 1(1), pages 3-49, March.
//**************************************************************************

var
    c       //consumption
    lambda  //Lagrange multiplier
    R       //Nominal Interest rate
    PI      //Inflation
    r       //rental rate of capital
    x       //investment
    u       //capacity utilization
    q       //Tobin's marginal q
    f       //variable for recursive formulation of wage setting
    ld      //aggregate labor demand
    w       //real wage
    wstar   //optimal real wage
    PIstarw //optimal wage inflation
    PIstar  //optimal price inflation
    g1      //variable 1 for recursive formulation of price setting
    g2      //variable 2 for recursive formulation of price setting
    yd      //aggregate output
    mc      //marginal costs
    k       //capital
    vp      //price dispersion term
    vw      //wage dispersion term
    l       //aggregate labor bundle
    phi     //labor disutility shock
    F       //firm profits

    cf       //consumption flex-price economy
    lambdaf  //Lagrange multiplier flex-price economy
    Rf       //Nominal Interest rate flex-price economy
    rf       //rental rate of capital flex-price economy
    xf       //investment flex-price economy
    uf       //capacity utilization flex-price economy
    qf       //Tobin's marginal qf flex-price economy
    ldf      //aggregate labor demand flex-price economy
    wf       //real wage flex-price economy
    ydf      //aggregate output flex-price economy
    kf       //capital flex-price economy
    Ff       //firm profits flex-price economy

    d       //preference shock
    mu_z 	//trend growth rate of the economy (from neutral and investment specific technology)
    mu_I    //growth rate of investment-specific technology growth
    mu_A    //growth rate of neutral technology

//**************************************************************************
// Modelbase Variables                                                   //*
        interest inflation inflationq outputgap output; //fispol         //*
//**************************************************************************

varexo epsd epsphi epsmu_I epsA  // epsm

//**************************************************************************
// Modelbase Shocks                                                      //*
       interest_; //fiscal_                                             //*
//**************************************************************************

predetermined_variables k kf;
parameters

//**************************************************************************
// Modelbase Parameters

        cofintintb1 cofintintb2 cofintintb3 cofintintb4
        cofintinf0 cofintinfb1 cofintinfb2 cofintinfb3 cofintinfb4
        cofintinff1 cofintinff2 cofintinff3 cofintinff4
        cofintout cofintoutb1 cofintoutb2 cofintoutb3 cofintoutb4
        cofintoutf1 cofintoutf2 cofintoutf3 cofintoutf4
        cofintoutp cofintoutpb1 cofintoutpb2 cofintoutpb3 cofintoutpb4
        cofintoutpf1 cofintoutpf2 cofintoutpf3 cofintoutpf4
        std_r_ std_r_quart coffispol
//**************************************************************************
           h            //consumption habits
           betta        //discount factor
           gammma1      //capital utilization, linear term
           gammma2      //capital utilization, quadratic term
           cdelta        //depreciation rate
           kappa        //capital adjustment costs parameter
           eta          //elasticity of substitution between labor varieties
           epsilon      //elasticity of substitution between goods varieties
           varpsi       //labor disutility parameter
           gammma       //inverse Frisch elasticity
           chiw         //wage indexation parameter
           chi          //price indexation
           thetap       //Calvo parameter prices
           thetaw       //Calvo parameter wages
           alppha       //capital share
           Rbar         //steady state interest rate
           PIbar        //steady state inflation
           gammmaR      //interest smoothing coefficient Taylor rule
           gammmaPI     //feedback coefficient to inflation monetary policy rule
           gammmay      //feedback coefficient to output growth deviation in monetary policy rule
           Phi          //firms fixed costs
           rhod         //autocorrelation preference shock
           rhophi       //autocorrelation labor disutility shock
           Lambdamu  	//steady state growth rate of investmentment-specific technology
           LambdaA      //steady state neutral technology growth
           Lambdax      //steady state growth rate of investment
           LambdaYd     //steady state growth rate of output
           sigma_d      //standard deviation preference shock
           sigma_phi    //standard deviation labor disutility shock
           sigma_mu     //standard deviation investment-specific technology
           sigma_A      //standard deviation neutral technology
           sigma_m;      //standard deviation preference shock

//Fixed parameters, taken from FV(2010), Table 2, p. 37
cdelta       = 0.025;
epsilon     = 10;
eta         = 10;
Phi         = 0;
gammma2     = 0.001;
//Estimated parameters, taken from FV(2010), Table 3, p. 38, median estimate parameters
betta       = 0.998;
h           = 0.97;
varpsi      = 8.92;
gammma      = 1.17;
kappa       = 9.51;
alppha      = 0.21;
thetap      = 0.82;
chi         = 0.63;
thetaw      = 0.68;
chiw        = 0.62;
gammmaR     = 0.77;
gammmay     = 0.19;
gammmaPI    = 1.29;
PIbar       = 1.01;
rhod        = 0.12;
rhophi      = 0.93;
sigma_A     = exp(-3.97);
sigma_d     = exp(-1.51);
sigma_phi   = exp(-2.36);
sigma_mu    = exp(-5.43);
sigma_m     = exp(-5.85);
Lambdamu    = 3.4e-3;
LambdaA     = 2.8e-3;


//**************************************************************************
// Specification of Modelbase Parameters                                 //*
                                                                         //*
// Load Modelbase Monetary Policy Parameters                             //*
thispath = pwd;
cd('..');
load policy_param.mat;
for i=1:33
    deep_parameter_name = M_.param_names(i,:);
    eval(['M_.params(i)  = ' deep_parameter_name ' ;'])
end
cd(thispath);
    std_r_=100;

// Definition of Discretionary Fiscal Policy Parameter                   //*
coffispol = 1;                                                           //*

//**************************************************************************


model;

//**************************************************************************
// Definition of Modelbase Variables in Terms of Original Model Variables//*
                                                                         //*
interest     = 400*(log(R) - log(steady_state(R)));                      //*
inflation    = 100*(log(PI) + log(PI(-1)) + log(PI(-2)) + log(PI(-3)) - 4*log(steady_state(PI)));   //*
inflationq   = 400*(log(PI) - log(steady_state(PI)));                    //*
outputgap    = 100*(log(yd) - log(ydf) - (log(steady_state(yd)) - log(steady_state(ydf))));
output       = 100*(log(yd) - log(steady_state(yd)));                    //*
//fispol       = epsG;                                                   //*
//**************************************************************************

//**************************************************************************
// Policy Rule                                                           //*
                                                                         //*
// Monetary Policy                                                       //*
                                                                        //*
interest =   cofintintb1*interest(-1)                                    //*
           + cofintintb2*interest(-2)                                    //*
           + cofintintb3*interest(-3)                                    //*
           + cofintintb4*interest(-4)                                    //*
           + cofintinf0*inflationq                                       //*
           + cofintinfb1*inflationq(-1)                                  //*
           + cofintinfb2*inflationq(-2)                                  //*
           + cofintinfb3*inflationq(-3)                                  //*
           + cofintinfb4*inflationq(-4)                                  //*
           + cofintinff1*inflationq(+1)                                  //*
           + cofintinff2*inflationq(+2)                                  //*
           + cofintinff3*inflationq(+3)                                  //*
           + cofintinff4*inflationq(+4)                                  //*
           + cofintout*outputgap 	                                     //*
           + cofintoutb1*outputgap(-1)                                   //*
           + cofintoutb2*outputgap(-2)                                   //*
           + cofintoutb3*outputgap(-3)                                   //*
           + cofintoutb4*outputgap(-4)                                   //*
           + cofintoutf1*outputgap(+1)                                   //*
           + cofintoutf2*outputgap(+2)                                   //*
           + cofintoutf3*outputgap(+3)                                   //*
           + cofintoutf4*outputgap(+4)                                   //*
           + cofintoutp*output 	                                         //*
           + cofintoutpb1*output(-1)                                     //*
           + cofintoutpb2*output(-2)                                     //*
           + cofintoutpb3*output(-3)                                     //*
           + cofintoutpb4*output(-4)                                     //*
           + cofintoutpf1*output(+1)                                     //*
           + cofintoutpf2*output(+2)                                     //*
           + cofintoutpf3*output(+3)                                     //*
           + cofintoutpf4*output(+4)                                     //*
           + std_r_/100 *interest_;                                      //*
                                                                         //*
// Discretionary Government Spending                                     //*
                                                                         //*
//fispol = coffispol*fiscal_;                                            //*
//**************************************************************************

// Sticky-Price Economy
//1. FOC consumption
d*(c-h*c(-1)*mu_z^(-1))^(-1)-h*betta*d(+1)*(c(+1)*mu_z(+1)-h*c)^(-1)=lambda;
//2. Euler equation
lambda=betta*lambda(+1)*mu_z(+1)^(-1)/PI(+1)*R;
//3. FOC capital utilization
r=gammma1+gammma2*(u-1);
//4. FOC capital
q=betta*lambda(+1)/lambda*mu_z(+1)^(-1)*mu_I(+1)^(-1)*((1-cdelta)*q(+1)+r(+1)*u(+1)-(gammma1*(u(+1)-1)+gammma2/2*(u(+1)-1)^2));
//5. FOC investment
1=q*(1-(kappa/2*(x/x(-1)*mu_z-Lambdax)^2)-(kappa*(x/x(-1)*mu_z-Lambdax)*x/x(-1)*mu_z))
  +betta*q(+1)*lambda(+1)/lambda*mu_z(+1)^(-1)*kappa*(x(+1)/x*mu_z(+1)-Lambdax)*(x(+1)/x*mu_z(+1))^2;
//6-7. Wage setting
f=(eta-1)/eta*wstar^(1-eta)*lambda*w^eta*ld+betta*thetaw*(PI^chiw/PI(+1))^(1-eta)*(wstar(+1)/wstar*mu_z(+1))^(eta-1)*f(+1);
f=varpsi*d*phi*PIstarw^(-eta*(1+gammma))*ld^(1+gammma)+betta*thetaw*(PI^chiw/PI(+1))^(-eta*(1+gammma))*(wstar(+1)/wstar*mu_z(+1))^(eta*(1+gammma))*f(+1);
//8-10. firm's price setting
g1=lambda*mc*yd+betta*thetap*(PI^chi/PI(+1))^(-epsilon)*g1(+1);
g2=lambda*PIstar*yd+betta*thetap*(PI^chi/PI(+1))^(1-epsilon)*PIstar/PIstar(+1)*g2(+1);
epsilon*g1=(epsilon-1)*g2;
//11-12. optimal inputs
u*k/ld=alppha/(1-alppha)*w/r*mu_z*mu_I;
mc=(1/(1-alppha))^(1-alppha)*(1/alppha)^alppha*w^(1-alppha)*r^alppha;
//13. law of motion wages
1=thetaw*(PI(-1)^chiw/PI)^(1-eta)*(w(-1)/w*mu_z^(-1))^(1-eta)+(1-thetaw)*PIstarw^(1-eta);
//14. law of motion prices
1=thetap*(PI(-1)^chi/PI)^(1-epsilon)+(1-thetap)*PIstar^(1-epsilon);
//15. Taylor Rule
//R/Rbar=(R(-1)/Rbar)^gammmaR*((PI/PIbar)^gammmaPI*((yd/yd(-1)*mu_z)/exp(LambdaYd))^gammmay)^(1-gammmaR)*exp(epsm)^sigma_m;
//16-17. Market clearing
yd=c+x+mu_z^(-1)*mu_I^(-1)*(gammma1*(u-1)+gammma2/2*(u-1)^2)*k;
yd=(mu_A*mu_z^(-1)*(u*k)^alppha*ld^(1-alppha)-Phi)/vp;
//18-20. Price and wage dispersion terms
l=vw*ld;
vp=thetap*(PI(-1)^chi/PI)^(-epsilon)*vp(-1)+(1-thetap)*PIstar^(-epsilon);
vw=thetaw*(w(-1)/w*mu_z^(-1)*PI(-1)^chiw/PI)^(-eta)*vw(-1)+(1-thetaw)*(PIstarw)^(-eta);
//21. Law of motion for capital
k(+1)*mu_z*mu_I-(1-cdelta)*k-mu_z*mu_I*(1-kappa/2*(x/x(-1)*mu_z-Lambdax)^2)*x=0;
//22. Profits
F=yd-1/(1-alppha)*w*ld;
//23. definition optimal wage inflation
PIstarw=wstar/w;

//exogenous processes
//24. Preference Shock
log(d)=rhod*log(d(-1))+sigma_d*epsd;
//25. Labor disutility Shock
log(phi)=rhophi*log(phi(-1))+sigma_phi*epsphi;
//26. Investment specific technology
log(mu_I)=Lambdamu+sigma_mu*epsmu_I;
//27. Neutral technology
log(mu_A)=LambdaA+sigma_A*epsA;
//28. Defininition composite technology
mu_z=mu_A^(1/(1-alppha))*mu_I^(alppha/(1-alppha));

// Flex-Price Economy
//29. FOC consumption
d*(cf-h*cf(-1)*mu_z^(-1))^(-1)-h*betta*d(+1)*(cf(+1)*mu_z(+1)-h*cf)^(-1)=lambdaf;
//30. Euler equation
lambdaf=betta*lambdaf(+1)*mu_z(+1)^(-1)/PIbar*Rf;
//31. FOC capital utilization
rf=gammma1+gammma2*(uf-1);
//32. FOC capital
qf=betta*lambdaf(+1)/lambdaf*mu_z(+1)^(-1)*mu_I(+1)^(-1)*((1-cdelta)*qf(+1)+rf(+1)*uf(+1)-(gammma1*(uf(+1)-1)+gammma2/2*(uf(+1)-1)^2));
//33. FOC investment
1=qf*(1-(kappa/2*(xf/xf(-1)*mu_z-Lambdax)^2)-(kappa*(xf/xf(-1)*mu_z-Lambdax)*xf/xf(-1)*mu_z))
  +betta*qf(+1)*lambdaf(+1)/lambdaf*mu_z(+1)^(-1)*kappa*(xf(+1)/xf*mu_z(+1)-Lambdax)*(xf(+1)/xf*mu_z(+1))^2;
//34. Wage setting
(eta-1)/eta*lambdaf*wf = varpsi*d*phi*ldf^gammma;
//35-36. optimal inputs
uf*kf/ldf=alppha/(1-alppha)*wf/rf*mu_z*mu_I;
(epsilon-1)/epsilon=(1/(1-alppha))^(1-alppha)*(1/alppha)^alppha*wf^(1-alppha)*rf^alppha;
//37-38. Market clearing
ydf=cf+xf+mu_z^(-1)*mu_I^(-1)*(gammma1*(uf-1)+gammma2/2*(uf-1)^2)*kf;
ydf=(mu_A*mu_z^(-1)*(uf*kf)^alppha*ldf^(1-alppha)-Phi);
//39. Law of motion for capital
kf(+1)*mu_z*mu_I-(1-cdelta)*kf-mu_z*mu_I*(1-kappa/2*(xf/xf(-1)*mu_z-Lambdax)^2)*xf=0;
//40. Profits
Ff=ydf-1/(1-alppha)*wf*ldf;

end;

shocks;
var epsd;       stderr 1;
var epsphi;     stderr 1;
var epsmu_I;    stderr 1;
var epsA;       stderr 1;
//var epsm;       stderr 0;
var interest_;  stderr 1;
end;

//stoch_simul(order=1,irf=20, noprint) inflation output outputgap interest;
