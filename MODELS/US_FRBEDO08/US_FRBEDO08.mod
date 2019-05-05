// Model: US_NFED08

// Last edited: 20/10/09 by M. Wolters: 
// 1.) Removed transcription error in one of the wage equations (line 344, equation 83); However, I still think there should be a minus (documentation and own derivations)
// 2.) Removed flex price version
// 3.) changed equations as in Email from August, 10th + change in equation 68 neccessary
// 4.) Steady States: we will need in setting the steady-state to follow the model files as opposed to the documentation 
//     - I adjusted the steady states to the changes proposed by LaForte. I think equations 81, and 82 were not right. I changed them, but I am not sure about the timing

var
// c is short for cbi (slow-growing "consumption" goods sector) and k for bk (fast-growing "capital" goods sector)
// stationary variables are denoted by a "tilde" in the paper, which we waive here (see p. 41 for the definitions)

xgdp_q_obs
pgdp_q_obs
rff_q_obs

rff_q_obs_frbedo
pgdp_q_obs_frbedo
xgdp_q_obs_frbedo
pecnn_q_obs_frbedo
pecd_q_obs_frbedo
per_q_obs_frbedo
penr_q_obs_frbedo
paipc_q_obs_frbedo
paipk_q_obs_frbedo
wage_obs_frbedo
hours_obs_frbedo
hgdp                    //growth rate of real (chain-weighted) gdp
paipgdp                 //inflation rate of the gdp deflator
xc xk                   //production
enr                     //expenditures on goods in the k sector for use in non-residential investment
ecd                     //expenditures on goods in the k sector for use in consumer durables investment
er                      //expenditure on goods in the c sector for use in residential investment
ecnn                    //expenditure on goods in the c sector for use in consumer non-durable goods and non-housing services
lambdacnn               //marginal utility of non-duravble goods and non-housing services consumption
lambdacd                //marginal utility of durable goods
lambdar                 //marginal utility of residential capital
lambdalc lambdalk       //marginal dis-utility of supplying labor
lc lk                   //labor
uc uk                   //utilization rate of non-residential capital
knrc knrk               //the physical amount of non-residential capital used in the c or k sector, respectively
kcd                     //the consumer durables capital stock
kr                      //the residential capital stock
xgf                     //stationary unmodelled output
thetaxc thetaxk         //elasticity of substituion between differentiated intermediate inputs
thetal                  //elasticity of substitution between the differentiated labor inputs into production
gammazksmall            //stochastic component of the growth rate of capital specific technology
gammazmsmall            //stochastic component of the growth rate of economy-wide technology
gammazk                 //growth rate of capital specific technology
gammazm                 //growth rate of economy-wide technology
anr                     //non-residential investment efficiency shock
acd                     //consumer durables investment efficiency shock
a_r                      //residential investment efficiency shock
xicnn                   //consumer non-durable goods and non-housing services consumption preference shock
xicd                    //consumer durable capital stock preference shock
xir                     //residential capital stock preference shock
xil                     //leisure preference shock
xicnnsmall              //shock process for preference shock to consumer non-durables and non-housing services
xicdsmall               //shock process for preference shock to consumer durables
xirsmall                //shock process for preference shock to residential capital
xilsmall                //shock process for preference shock to leisure
mcc mck                 //marginal cost
rnrc rnrk               //nominal rental rate on non-residential captial used in the c or k sector, respectively
rcd                     //nominal rental rate on consumer durables capital
rr                      //nominal rental rate on residential capital
qnr                     //price of installed non-residential capital
qcd                     //price of installed consumer durables capital
qr                      //price of installed residential capital
r                       //nominal interest rate
wc wk                   //nominal wage
pk                      //price level in the k sector
paipc paipk             //inflation rate of prices 
paiwc paiwk            //inflation rate of nominal wages
gammaxc gammaxk         //growth rate of output in the c or k sector, respectively, consistent with the growth rate of technology

//**************************************************************************
// Modelbase Variables                                                   //*    
    interest inflation output;  //(outputgap is already included above)  //*
//**************************************************************************

varexo  
epsilonr                //monetary policy shock
epsilongthetaxc         //shock to the elasticity of substituion between the differentiated intermediate goods inputs
epsilongthetaxk         //shock to the elasticity of substituion between the differentiated intermediate goods inputs
epsilongthetal          //shock to the elasticity of substituion between the differentitated labor inputs
epsilonzk               //shock to capital specific technology growth
epsilonzm               //shock to economy-wide technology growth
epsilonanr              //shock to efficiency of investment in non-residential capital
epsilonar               //shock to efficiency of investment in residential capital
epsilonacd               //shock to efficiency of investment in consumer durable goods
epsilonxicnnsmall       //shock to preferences over non-durables and non-housing services
epsilonxicdsmall        //shock to preferences over durables
epsilonxirsmall         //shock to preferences over residential capital
epsilonxilsmall         //shock to preferences over leisure
epsilonxgf              //shock to unmodelled output

// measurement errors
eta_xgdp
eta_pgdp
eta_pecnn
eta_pecd
eta_per
eta_penr
eta_paipc
eta_paipk
eta_wage;
 
parameters
ALPHA                   //the elasticity of output with respect to capital
BETA                    //household's discount factor
CHIp                    //reflecting the size of adjustement costs- in re-setting prices
CHIcd                   //investment adjustment costs in the consumer durables evolution equation
CHIl                    //reflecting the size of adjustment costs in the labor sectoral adjustment cost function
CHInr                   //investment adjustment costs in the non-residential capital evolution equation
CHIr                    //investment adjustment costs in the residential capital evolution equation
CHIw                    //reflecting the size of adjustment costs in re-setting wages
DELTAnr                 //quarterly depreciation rate of non-residential capital
DELTAcd                 //quarterly depreciation rate of consumer durables
DELTAr                  //quarterly depreciation rate of residential capital
ETAp                    //reflecting the relative importance of lagged price inflation in the adjustment cost function for prices
ETAl                    //reflecting the relative importnace of the lagged sectoral mix of labor in the labor sectoral adjustment cost function
ETAw                    //reflecting the relative importance of lagged wage inflation in the adjustment cost function for wages
Hcnn                    //habit-persistence parameter for the consumption of non-durable goods and non-housing services
Hcd                     //habit-persistence parameter for the consumption of durable goods
Hr                      //habit-persistence parameter for the consumption of housing services
KAPPA                   //variable capacity utilization scaling parameter
NU                      //inverse labor supply elasticity
PHIr                    //coefficient on lagged nominal interest rates in the monetary policy reaction function
PHIhgdp                 //coefficient on gdp growth in the monetary policy reaction function
PHIdeltahgdp            //coefficient on the change in gdp growth in the monetary policy reaction function
PHIpaigdp               //coefficient on gdp price inflation in the monetary policy reaction function
PHIdeltapaigdp          //coefficient on the change in gdp price inflation in the monetary policy reaction function
PSI                     //elasticity of utilization costs
SIGMAcnn                //coefficient on the consumer non-durable goods and non-housing services component of the utility function
SIGMAcd                 //coefficient on the consumer durable goods component of the utility function
SIGMAr                  //coefficient on the consumer housing services component of the utility function
SIGMAl                  //coefficient on leisure in the utility function

PAIpcstar PAIpkstar     //steady state inflation rate of prices
PAIwcstar PAIwkstar     //steady state inflation rate of nominal wages
Pcstar Pkstar           //steady state price level
Rstar                   //steady state nominal interest rate
Xgfstar                 //steady state of unmodelled output components

GAMMAzkstar             //steady state of the growth rate of capital specific technlogy
GAMMAzmstar             //steady state of the growth rate of economy-wide technlogy
RHOanr                  //AR(1) coefficient of shock process to efficiency of investment in non-residential capital
RHOar                   //AR(1) coefficient of shock process to efficiency of investment in residential capital
RHOacd                   //AR(1) coefficient of shock process to efficiency of investment in consumer durable goods
THETAxcstar             //steady state of the elasticity of substituion between differentiated intermediate inputs
THETAxkstar             //steady state of the elasticity of substituion between differentiated intermediate inputs
THETAlstar              //steady state of the elasticity of substituion between differentiated labor inputs
RHOxicnnsmall           //AR(1) coefficient of shock process to preferences of non-durables and non-housing services
RHOxicdsmall            //AR(1) coefficient of shock process to preferences of durables
RHOxirsmall             //AR(1) coefficient of shock process to preferences of residential capital
RHOxilsmall             //AR(1) coefficient of shock process to preferences of leisure
RHOxgf                  //AR(1) coefficient of exogenous process for unmodelled output
RHOzm                   //AR(1) coefficient of exogenous process for capital specific technology growth
RHOzk                   //AR(1) coefficient of exogenous process for economy-wide technology growth

//parameters needed for steady state computation, but not directly in the model
GAMMAxkstar             //steady state growth rate of the k sector
GAMMAxcstar             //steady state growth rate of the c sector
Rnrcbistar              //steady state aggregate nominal rental rate on non-residential capital
;                                                

//calibrated parameters: Table 3
BETA         = 0.99;
ALPHA        = 0.26;
PSI          = 5;
DELTAnr      = 0.03;
DELTAcd      = 0.055;
DELTAr       = 0.0035;
THETAxcstar  = 7;
THETAxkstar  = 7;
THETAlstar   = 7;
GAMMAzmstar  = 1.003;
GAMMAzkstar  = 1.004;
//Hxgfstar     = 0.25;    //how to include this parameter in the equations?

//posterior mode of estimated parameters (behavioral and policy parameters): Table 4
Hcnn           =  0.765997735188273;
Hcd            =  0.570758257036265;
Hr             =  0.500499572650289;
NU             =  1.28662724511407;
CHIp           =  2.33133764055832;
ETAp           =  0.257182580925403;
CHIw           =  1.55499946449095;
ETAw           =  0.295577498355445;
CHInr          =  0.831213240990633;
CHIcd          =  0.144597579683815;
CHIr           = 10.1979114360006;
CHIl           =  0.766262605233024;
ETAl           =  0.779368974304299;
PHIpaigdp      =  3.53246152082124;
PHIdeltapaigdp = -0.0411799063401708;
PHIhgdp        =  0.210344028107324;
PHIdeltahgdp   = -0.0839315435966207;
PHIr           =  0.899834548353492;

//posterior mode of estimated parameters (shock parameters): Table 5
RHOanr         =  0.894;
RHOacd         =  0.842;
RHOar          =  0.527;
RHOxicnnsmall  =  0.795;
RHOxicdsmall   =  0.899;
RHOxirsmall    =  0.793;
RHOxilsmall    =  0.94;
RHOzm          =  0.305;
RHOzk          =  0.927;
RHOxgf         =  0.982;

//adhoc calibrated parameters by modelbase team, as it is not clear what values these take
SIGMAcnn       =  1;
SIGMAcd        =  1;
SIGMAr         =  1;
SIGMAl         =  1; //even less sure about this one than about the other three

Pcstar  = 1; //not totally sure
Pkstar  = 1;

//some steady values that are implied
GAMMAxkstar = GAMMAzmstar*GAMMAzkstar;       //(87)
GAMMAxcstar = GAMMAzmstar*GAMMAzkstar^ALPHA; //(88)
PAIpcstar      =  1.006800; //not entirely sure, found it in the files
PAIpkstar      =  PAIpcstar*GAMMAxcstar/GAMMAxkstar;   //(97)
PAIwcstar      =  PAIpcstar*GAMMAxcstar;               //(98)
PAIwkstar      =  PAIpcstar*GAMMAxcstar;               //(98)

Rstar = 1/BETA*GAMMAxcstar*PAIpcstar;  //(90)
Rnrcbistar  = 1/BETA*GAMMAxkstar-(1-DELTAnr);       //(93)            
KAPPA = Rnrcbistar/Pkstar; // last line on p. 9 (we checked that this is also the right calibration in terms of stationary variables)
Xgfstar = 0.25; // this is totally adhoc, I have no clue which value is used by the authors; I use this value as maybe this is what the authors mean with Hxgfstar?

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

model;
//some auxiliary parameters to compute the steady state
#A = ALPHA/(GAMMAxkstar/BETA-(1-DELTAnr))*(THETAxkstar-1)/THETAxkstar;
#D = SIGMAcd/SIGMAcnn * (1-BETA*Hcd/GAMMAxkstar)/(1-BETA*Hcnn/GAMMAxcstar)*(1-Hcnn/GAMMAxcstar)/(1-Hcd/GAMMAxkstar)*(GAMMAxkstar-(1-DELTAcd))/GAMMAxkstar*BETA*GAMMAxkstar/(GAMMAxkstar-BETA*(1-DELTAcd));
#R_ = SIGMAr/SIGMAcnn * (1-BETA*Hr/GAMMAxcstar)/(1-BETA*Hcnn/GAMMAxcstar)*(1-Hcnn/GAMMAxcstar)/(1-Hr/GAMMAxcstar)*(GAMMAxcstar-(1-DELTAr))/GAMMAxcstar*BETA*GAMMAxcstar/(GAMMAxcstar-BETA*(1-DELTAr));
#B = (D+(1+R_)*(GAMMAxkstar-(1-DELTAnr))*A)/((1+R_)-(1+R_)*(GAMMAxkstar-(1-DELTAnr))*A);
#L = ((THETAlstar-1)/THETAlstar*(1-ALPHA)*((THETAxkstar-1)/THETAxkstar)^(1/(1-ALPHA))*(ALPHA/(GAMMAxkstar/BETA-(1-DELTAnr)))^(ALPHA/(1-ALPHA)) * (1+B)/A^(ALPHA/(1-ALPHA))*(1+R_)*SIGMAcnn/SIGMAl * (1-BETA*Hcnn/GAMMAxcstar)/(1-Hcnn/GAMMAxcstar))^(1/(NU+1));

//some more steady state values
#Lcstar = 1/(1+B)*L;
#Lkstar = B/(1+B)*L;
#Xcstar = Lcstar/((1/BETA*GAMMAxkstar-(1-DELTAnr))/ALPHA*THETAxkstar/(THETAxkstar-1))^(ALPHA/(1-ALPHA));
#Xkstar = Lkstar/((1/BETA*GAMMAxkstar-(1-DELTAnr))/ALPHA*THETAxkstar/(THETAxkstar-1))^(ALPHA/(1-ALPHA));


#Hgdpstar = GAMMAxcstar^((Pcstar*Xcstar+Pcstar*Xgfstar)/(Pcstar*Xcstar+Pkstar*Xkstar+Pcstar*Xgfstar))*GAMMAxkstar^((Pkstar*Xkstar)/(Pcstar*Xcstar+Pkstar*Xkstar+Pcstar*Xgfstar));
#PAIpgdpstar = 1/Hgdpstar*PAIpcstar * GAMMAxcstar;

//****************************************************************************
// Modelbase Variables                                                     //*
rff_q_obs_frbedo   = r;
pgdp_q_obs_frbedo  = paipgdp*exp(eta_pgdp);
xgdp_q_obs_frbedo  = hgdp*exp(eta_xgdp);
pecnn_q_obs_frbedo = paipc*ecnn/ecnn(-1)*gammaxc*exp(eta_pecnn);
pecd_q_obs_frbedo  = paipk*ecd/ecd(-1)*gammaxk*exp(eta_pecd);
per_q_obs_frbedo   = paipc*er/er(-1)*gammaxc*exp(eta_per);
penr_q_obs_frbedo  = paipk*enr/enr(-1)*gammaxk*exp(eta_penr);
paipc_q_obs_frbedo = paipc*exp(eta_paipc);
paipk_q_obs_frbedo = paipk*exp(eta_paipk);
wage_obs_frbedo    = paipc/paipgdp*gammaxc*(wc+wk)/(wc(-1)+wk(-1))*exp(eta_wage);
hours_obs_frbedo   = (lc+lk)/(Lcstar+Lkstar);

xgdp_q_obs = (hgdp*exp(eta_xgdp)-1)*100;
pgdp_q_obs  = (paipgdp*exp(eta_pgdp)-1)*100;
rff_q_obs = (r-1)*100;

interest   = r;                                                            //*
inflation  = paipgdp;                                                      //*
output = xc+xk+xgf;  //is this right?                                      //*
//****************************************************************************

// Output Gap Definitions
// removed with flex price allocation

//monetary authority (We substitute rbar in r)
r=r(-1)^(PHIr)*((paipgdp/PAIpgdpstar)^PHIpaigdp * (paipgdp/paipgdp(-1))^PHIdeltapaigdp * (hgdp/Hgdpstar)^PHIhgdp * (hgdp/hgdp(-1))^PHIdeltahgdp * Rstar)^(1-PHIr)*exp(epsilonr); //(29)


//optimal factor input
lc  = (1-ALPHA)*xc*mcc/wc;   //(60)
lk  = (1-ALPHA)*xk*mck/wk;   //(60)
knrc(-1)/gammaxk  = ALPHA*xc*mcc/rnrc; //(61) 
knrk(-1)/gammaxk  = ALPHA*xk*mck/rnrk; //(61)
xc = (knrc(-1)*uc/gammaxk)^ALPHA * lc^(1-ALPHA);     //(62)
xk = (knrk(-1)*uk/gammaxk)^ALPHA * lk^(1-ALPHA);     //(62)


//intermediate-goods firms profit maximization conditions
thetaxc * mcc * xc = (thetaxc-1)*xc + 100*CHIp*(paipc - ETAp*paipc(-1) - (1-ETAp)*PAIpcstar)*paipc*xc
                     - BETA * (lambdacnn(+1)/lambdacnn*100*CHIp*(paipc(+1)-ETAp*paipc-(1-ETAp)*PAIpcstar)*paipc(+1)*xc(+1)); //(63)
thetaxk * mck * xk = (thetaxk-1)*pk*xk + 100*CHIp*(paipk - ETAp*paipk(-1) - (1-ETAp)*PAIpkstar)*paipk*pk*xk
                                - BETA * (lambdacnn(+1)/lambdacnn*100*CHIp*(paipk(+1)-ETAp*paipk-(1-ETAp)*PAIpkstar)*paipk(+1)*pk(+1)*xk(+1)); //(64)


//foc of non-residential part of capital owners' profit-maximization
qnr = BETA*lambdacnn(+1)/lambdacnn*1/gammaxk(+1)*(rnrc(+1)*uc(+1)+(1-DELTAnr)*qnr(+1)); //(65)
qnr = BETA*lambdacnn(+1)/lambdacnn*1/gammaxk(+1)*(rnrk(+1)*uk(+1)+(1-DELTAnr)*qnr(+1)); //(65) (added)
uc= (1/KAPPA * rnrc/qnr)^(1/PSI); //(67)
uk = (1/KAPPA * rnrk/qnr)^(1/PSI); //(67)
pk = qnr*(anr - 100*CHInr*((enr-enr(-1))/(knrc(-1)+knrk(-1))*gammaxk))
     + BETA*lambdacnn(+1)/lambdacnn*qnr(+1)*100*CHInr*((enr(+1)-enr)/(knrc+knrk)*gammaxk(+1)); //(68) 
knrc + knrk = (1-DELTAnr)*(knrc(-1)+knrk(-1))/gammaxk+anr*enr-100*CHInr/2*((enr-enr(-1)))^2 / ((knrc(-1)+knrk (-1))/gammaxk); //(69)

//foc of consumer durables part of the capital owners' profit-maximization 
qcd = BETA * lambdacnn(+1)/lambdacnn*1/gammaxk(+1)*(rcd(+1)+(1-DELTAcd)*qcd(+1)); //(71)
pk = qcd*(acd - 100*CHIcd*((ecd-ecd(-1))/kcd(-1)*gammaxk))
     + BETA*lambdacnn(+1)/lambdacnn*qcd(+1)*100*CHIcd*((ecd(+1)-ecd)/kcd*gammaxk(+1)); //(72)
kcd = (1-DELTAcd)*kcd(-1)/(gammaxk)+acd*ecd-100*CHIcd/2*((ecd-ecd(-1)))^2/kcd(-1)*gammaxk ; //(73)

//foc residential part of the capital owners profit-maximization problem 
qr = BETA * lambdacnn(+1)/lambdacnn*1/gammaxc(+1)*(rr(+1)+(1-DELTAr)*qr(+1)); //(74)
1 = qr*(a_r - 100*CHIr*((er-er(-1))/kr(-1)*gammaxc))
    + BETA*lambdacnn(+1)/lambdacnn*qr(+1)*100*CHIr*((er(+1)-er)/kr*gammaxc(+1)); //(75) 
kr= (1-DELTAr)*kr(-1)/(gammaxc)+a_r*er-100*CHIr/2*((er-er(-1)))^2 / kr(-1)*(gammaxc); //(76) 

//household foc
lambdacnn = BETA*r * lambdacnn(+1) * 1/(paipc(+1)*gammaxc(+1));  //(77) 
lambdacnn = lambdacd / rcd;// (78) 
lambdacnn = lambdar  / rr; // (79) 
lambdacnn = SIGMAcnn*xicnn/(ecnn-(Hcnn/gammaxc)*ecnn(-1)) - BETA * SIGMAcnn * Hcnn/gammaxc(+1)*xicnn(+1)/(ecnn(+1)-Hcnn/gammaxc(+1)*ecnn); //(80)

lambdacd= SIGMAcd*xicd/(kcd(-1)/gammaxk-Hcd/(gammaxk*gammaxk(-1))*kcd(-2)) - BETA * SIGMAcd * (Hcd/gammaxk*xicd(+1))/(kcd/gammaxk-Hcd/(gammaxk*gammaxk)*kcd(-1)); //(81)
lambdar = SIGMAr* xir /(kr(-1) /gammaxc-Hr /(gammaxc*gammaxc(-1))*kr(-2))  - BETA * SIGMAr  * (Hr /gammaxc*xir(+1)) /(kr /gammaxc-Hr /(gammaxc*gammaxc)*kr(-1)); // (82) 


//households labor-supply decision:
thetal * lambdalc/lambdacnn  = (thetal-1)*wc
                                   -thetal * 100 * CHIl * (Lcstar/(Lcstar+Lkstar)*wc+Lkstar/(Lcstar+Lkstar)*wk)*(lc/lk-ETAl*lc(-1)/lk(-1)-(1-ETAl)*Lcstar/Lkstar) / lc
                                   +100*CHIw*(paiwc-ETAw*paiwc(-1)-(1-ETAw)*PAIwcstar)*paiwc*wc
                                   -BETA*(lambdacnn (+1)/lambdacnn*100*CHIw*(paiwc(+1)-ETAw*paiwc-(1-ETAw)*PAIwcstar)*paiwc(+1)*wc(+1)*lc(+1)/lc);  //(83)
thetal * lambdalk/lambdacnn  = (thetal-1)*wk
                                   +thetal * 100 * CHIl * (Lcstar/(Lcstar+Lkstar)*wc+Lkstar/(Lcstar+Lkstar)*wk)*(lc/lk-ETAl*lc(-1)/lk(-1)-(1-ETAl)*Lcstar/Lkstar) / lk
                                   +100*CHIw*(paiwk-ETAw*paiwk(-1)-(1-ETAw)*PAIwkstar)*paiwk*wk
                                   -BETA*(lambdacnn(+1)/lambdacnn*100*CHIw*(paiwk(+1)-ETAw*paiwk-(1-ETAw)*PAIwkstar)*paiwk(+1)*wk(+1)*lk(+1)/lk); //(84)
lambdalc = SIGMAl * xil * (lc+lk)^NU; //(59) 
lambdalk = SIGMAl * xil * (lc+lk)^NU; //(59)


//Market clearing conditions:
xc = ecnn+er; //(p.31)
xk = ecd+enr; //(p.31)


//Identities:
pk = paipk/paipc*gammaxk/gammaxc*pk(-1); //(p.31)
wc = paiwc/paipc*1/gammaxc*wc(-1);  //(p.31)
wk = paiwk/paipc*1/gammaxc*wk(-1);  //(p.31)



//growth rate of gdp and price inflation (I HAVE CHANGED HERE Pkstar to Pktildestar and Pcstar to Pctildestar)
hgdp = ((gammaxc*xc/xc(-1))^(Pcstar*Xcstar) * (gammaxk*xk/xk(-1))^(Pkstar*Xkstar) *(gammaxc*xgf/xgf(-1))^(Pcstar*Xgfstar))^(1/(Pcstar*Xcstar+Pkstar*Xkstar+Pcstar*Xgfstar)); //(85)
paipgdp*hgdp = paipc * gammaxc * (xc+pk*xk+xgf)/(xc(-1)+pk(-1)*xk(-1)+xgf(-1)); //(86)


///////////////////////////////////////////////////////////////////////////
//flexible price model
//removed for now

/////////////////////////////////////////////////////////////////

//growth variables:
gammaxc = gammazm*gammazk^ALPHA; //(62)
gammaxk = gammazm*gammazk;  

//exogenous processes
log(gammazk) = log(GAMMAzkstar) + gammazksmall;         //(8)         
log(gammazm) = log(GAMMAzmstar) + gammazmsmall;         //(8)       
gammazksmall = RHOzk*gammazksmall(-1)+epsilonzk;      //(9)
gammazmsmall = RHOzm*gammazmsmall(-1) + epsilonzm;              //(9)

log(thetaxc) = log(THETAxcstar) + epsilongthetaxc;      //(2)
log(thetaxk) = log(THETAxkstar) + epsilongthetaxk;      //(2)
log(thetal) = log(THETAlstar) + epsilongthetal;         //(6)
log(anr) = RHOanr*log(anr(-1))+epsilonanr;              //(10)
log(a_r) = RHOar*log(a_r(-1))+epsilonar;                //(10)
log(acd) = RHOacd*log(acd(-1))+epsilonacd;              //(10)

log(xicnn) = log(1)+ xicnnsmall;                        //(15)
log(xicd) = log(1)+ xicdsmall;                          //(15)
log(xir) = log(1)+ xirsmall;                            //(15)
log(xil) = log(1)+ xilsmall;                            //(15)
xicnnsmall = RHOxicnnsmall * xicnnsmall(-1) + epsilonxicnnsmall; //(16)
xicdsmall = RHOxicdsmall * xicdsmall(-1) + epsilonxicdsmall;     //(16)
xirsmall = RHOxirsmall * xirsmall(-1) + epsilonxirsmall;         //(16)
xilsmall = RHOxilsmall * xilsmall(-1) + epsilonxilsmall;         //(16)
log(xgf)-log(Xgfstar) = RHOxgf*(log(xgf(-1))-log(Xgfstar))+epsilonxgf; //(58)
end; 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//shocks; // table 5
//var epsilonanr;
//stderr 6.63100954970433;    
//var epsilonacd;
//stderr 1.79503611971936;
//var epsilonar;
//stderr 8.16818570125166;
//var epsilonxicnnsmall;
//stderr 1.55492485707048;
//var epsilonxicdsmall;
//stderr 3.30366121289546;
//var epsilonxirsmall;
//stderr 2.45289264491577;
//var epsilonxilsmall;
//stderr 2.17547894861637;
//var epsilonr;
//stderr 0.112204084587700;
//var epsilonzm;
//stderr 0.765900927066518;
//var epsilonzk;
//stderr 0.293957575265040;
//var epsilonxgf;
//stderr 1.50709795689467;
//var epsilongthetaxc;
//stderr 0.526018098824289;
//var epsilongthetaxk;
//stderr 0.394143298941564;
//var epsilongthetal;
//stderr 0.667023414236864;
//end;

//steady;
//check;

estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
Hcnn,0.765997735188273          ,    beta_pdf  ,   0.50,    0.122;  
Hcd,0.570758257036265           ,    beta_pdf  ,   0.50,    0.122;  
Hr,0.500499572650289            ,    beta_pdf  ,   0.50,    0.122;  
NU,1.28662724511407            ,    gamma_pdf ,   2.00,    1.000;  
CHIp,2.33133764055832          ,    gamma_pdf ,   2.00,    1.000;  
ETAp,0.257182580925403          ,    beta_pdf  ,   0.50,    0.224;  
CHIw,1.55499946449095          ,    gamma_pdf ,   2.00,    1.000;  
ETAw,0.295577498355445          ,    beta_pdf  ,   0.50,    0.224;  
CHInr,0.831213240990633         ,    gamma_pdf ,   2.00,    1.000;  
CHIcd,0.144597579683815         ,    gamma_pdf ,   2.00,    1.000;  
CHIr,10.1979114360006          ,    gamma_pdf ,   6.00,    1.000;  
CHIl,0.766262605233024          ,    gamma_pdf ,   2.00,    1.000;  
ETAl,0.779368974304299          ,    beta_pdf  ,   0.50,    0.224; 
PHIpaigdp,3.53246152082124     ,    normal_pdf,   2.00,    1.000;  
PHIdeltapaigdp,-0.0411799063401708,    normal_pdf,   0.50,    0.400;  
PHIhgdp,0.210344028107324       ,    normal_pdf,   0.50,    0.400;  
PHIdeltahgdp,-0.0839315435966207  ,    normal_pdf,   0.50,    0.400;  
PHIr,0.899834548353492          ,    beta_pdf  ,   0.75,    0.112;  

RHOanr,0.894        ,    beta_pdf  ,   0.75,    0.112;
RHOacd,0.842        ,    beta_pdf  ,   0.75,    0.112;
RHOar,0.527         ,    beta_pdf  ,   0.50,    0.150;
RHOxicnnsmall,0.795 ,    beta_pdf  ,   0.75,    0.112;
RHOxicdsmall,0.899  ,    beta_pdf  ,   0.75,    0.112;
RHOxirsmall,0.793   ,    beta_pdf  ,   0.75,    0.112;
RHOxilsmall,0.94   ,    beta_pdf  ,   0.75,    0.112;
RHOzm,0.305         ,    beta_pdf  ,   0.50,    0.150;
RHOzk,0.927         ,    beta_pdf  ,   0.50,    0.150;
RHOxgf,0.982        ,    beta_pdf  ,   0.75,    0.112;

stderr epsilonanr,0.0663100954970433       ,inv_gamma_pdf  ,0.040  ,0.020;
stderr epsilonacd,0.0179503611971936       ,inv_gamma_pdf  ,0.020  ,0.020;
stderr epsilonar,0.0816818570125166        ,inv_gamma_pdf  ,0.040  ,0.020;
stderr epsilonxicnnsmall,0.0155492485707048,inv_gamma_pdf  ,0.030  ,0.020;
stderr epsilonxicdsmall,0.0330366121289546 ,inv_gamma_pdf  ,0.030  ,0.020;
stderr epsilonxirsmall,0.0245289264491577  ,inv_gamma_pdf  ,0.030  ,0.020;
stderr epsilonxilsmall,0.0217547894861637  ,inv_gamma_pdf  ,0.030  ,0.020;
stderr epsilonr,0.00112204084587700         ,inv_gamma_pdf  ,0.002  ,0020;
stderr epsilonzm,0.00765900927066518        ,inv_gamma_pdf  ,0.005  ,0.020;
stderr epsilonzk,0.00293957575265040        ,inv_gamma_pdf  ,0.005  ,0.020;
stderr epsilonxgf,0.0150709795689467       ,inv_gamma_pdf  ,0.010  ,0.02;
stderr epsilongthetaxc,0.00526018098824289  ,inv_gamma_pdf  ,0.005  ,0.02;
stderr epsilongthetaxk,0.00394143298941564  ,inv_gamma_pdf  ,0.005  ,0.02;
stderr epsilongthetal,0.00667023414236864   ,inv_gamma_pdf  ,0.005  ,0.02;

// measurement errors
stderr eta_xgdp  ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_pgdp  ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_pecnn ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_pecd  ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_per   ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_penr  ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_paipc ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_paipk ,inv_gamma_pdf  ,0.005  ,2;
stderr eta_wage  ,inv_gamma_pdf  ,0.005  ,2;
end;

varobs xgdp_q_obs_frbedo pgdp_q_obs_frbedo rff_q_obs_frbedo pecnn_q_obs_frbedo pecd_q_obs_frbedo per_q_obs_frbedo penr_q_obs_frbedo paipc_q_obs_frbedo paipk_q_obs_frbedo wage_obs_frbedo hours_obs_frbedo;