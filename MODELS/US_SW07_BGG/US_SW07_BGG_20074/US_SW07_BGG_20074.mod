% SW07 with BGG Financial Frictions based on Villa(2014)
% Written by : Matyas Farkas, 2019


var 
//hours_obs rff_q_obs xgdp_q_obs pcer_q_obs fpi_q_obs wage_obs
	vc 		${c}$           (long_name='Consumption')
	vr 	  	${r}$           (long_name='real interest rate')
	vw 		${w}$           (long_name='real wage')
	vpinf 	${\pi}$         (long_name='Inflation')
	vlab 	${l}$           (long_name='hours worked')
	vk 		${k^{s}}$       (long_name='Capital services') 
	vinve 	${i}$           (long_name='Investment')
	vz 		${z}$           (long_name='Capital utilization rate') 
	vu 		${u}$           (long_name='Utilization rate') 
	vq 		${q}$           (long_name='real value of existing capital stock') 
	vrn 	${rn}$           (long_name='nominal interest rate')
	vemp 	${e}$           (long_name='Employment') 
	vn 		${n}$ 			(long_name='net worth of firms')
	vep 	${ep}$ 			(long_name='external finance premium')
	vrk 	${r^{k}}$       (long_name='rental rate of capital')
	vy  	${y}$           (long_name='Output')
    a        ${\varepsilon_a}$       (long_name='productivity process')
	b        ${\varepsilon_k}$       (long_name='Capital quality process')
	g        ${\varepsilon_g}$       (long_name='Government spending process')
	qs        ${\varepsilon_x}$       (long_name='Investment specific shock process')
	ms        ${\varepsilon_m}$       (long_name='Monetary policy shock process')
	ecps        ${\varepsilon_{ecps}}$       (long_name='Cost push (price mark-up) shock process')
	ecws        ${\varepsilon_{ewps}}$       (long_name='Wage push (wage mark-up) shock process')
	zcapf       ${z^{flex}}$    (long_name='Capital utilization rate flex price economy') 
    rkf         ${r^{k,flex}}$  (long_name='rental rate of capital flex price economy') 
    kf          ${k^{s,flex}}$  (long_name='Capital services flex price economy') 
    pkf         ${q^{flex}}$    (long_name='real value of existing capital stock flex price economy')  
    cf          ${c^{flex}}$    (long_name='Consumption flex price economy') 
    invef       ${i^{flex}}$    (long_name='Investment flex price economy') 
    yf          ${y^{flex}}$    (long_name='Output flex price economy') 
    labf        ${l^{flex}}$    (long_name='hours worked flex price economy') 
    wf          ${w^{flex}}$    (long_name='real wage flex price economy') 
    rrf         ${r^{flex}}$    (long_name='real interest rate flex price economy')
	kpf         ${k^{flex}}$            (long_name='Capital stock flex price economy')
	xgdp_q_obs          $\Delta y^{obs}$    %    => GDP growth, observed 
    hours_obs           $L^{obs}$           %    => hours worked, observed
    wage_obs            $wage^{obs}$        %    => real wage growth, observed
    pgdp_q_obs          $\pi^{obs}$         %    => inflation, observed
    rff_q_obs           $R^{obs}$           %    => policy rate, observed (shadow rate)
    pcer_q_obs          $\Delta c^{obs}$    %    => consumption growth, observed 
    fpi_q_obs           $\Delta i^{obs}$    %    => investment growth, observed 	
	;
varexo ew 	${\eta^{w}}$    (long_name='Wage markup shock')  
ex 		${\eta^{I}}$    (long_name='Investment shock')   // investment shock
ek 		${\eta^{K}}$    (long_name='Capital shock')   // capital shock
ea 		${\eta^{A}}$    (long_name='Technology shock')   // technology shock
ep 		${\eta^{P}}$    (long_name='Cost push shock - PC')   // capital shock	
eg 		${\eta^{G}}$    (long_name='Spending shock')   
emp     ${\eta^{MP}}$    (long_name='Monetary policy shock')   
;

parameters 
	chabb 	// Habit parameter , Beta 0.7, 0.1, post 0.69 [0,62:0.76], calibrated to 0.7
	cbeta 	// Discount factor calibrated to 0.99;
	ccwagei // Calvo wage indexation, Beta 0.75, 0.05, post 0.77 [0.71:0.84] calibrated 0.77
	ccwage 	// Calvo wages  Beta 0.5, 0.15, post 0.37 [0.17:0.56] calibrated 0.37
	celasw 	// Elasticity of substitution in labor market, set to target M^w = 1.2
	cinvfrisch 	// inverse of Frisch elasticity Gamma 0.33, 0.25, post 1.34 [0.81,:1.86] calibrated 1.34
	cecu // Elasticity of Capital Utilization, Beta 0.25, 0.15, post 0.95 [0.92:0.98]
	cdelta // Capital depreciation rate
	cinvadj // Investment adjustment cost , Normal 4, 1.5, post 4,59 [3.11:5.98]
	ccpricei // Calvo price indexation,Beta 0.5, 0.15, post 0.15 [0.06:0.24] calibrated 0.15
	ccprice // Calvo prices , Beta 0.75 0.05, post 0.82 [0.77:0.87]
	ccemp // Calvo employment Beta 0.5 0.15 0.81 [0.78:0.84] 
    csigl       ${\sigma_l}$        (long_name='Frisch elasticity')  

    % Next line included by Maik
    constelab 
		

// SS block
	//cgamma	//  SS growth rate of consumption 
	cgamma1 // SS growth rate of consumption in quarterly percentage points
	
	//cpie // inflation SS
	cpie1 // inflation SS in quarterly percentage pointses

	
	cfc // =1.5;
	csigma // = 1.5;
	calfa // =.24;
	//cbetabar // SS Discount Factor
	//cr // SS interest rate p.17 SW Appendix
	//crk // SS growth rate of capital
	//cik // SS of I/K 
	//cky // SS of K/Y
	//ciy // SS of I/Y
	//ccy // SS of C/Y
	cgy // SS of G/Y


// TR 
	crhoi // Taylor rule smoothing Beta 0.80 0.1 0.88 [0.86:0.91]
	crhopi // Taylor rule Normal 1.7 0.15 1.80 [1.61:2.00]
	crhoy // Taylor rule Gamma 0.125 0.05 0.09 [0.05:0.14]
	crhody //Taylor rule changes in y Normal 0.0625 0.05 0.06 [0.03:0.09]
	//crkp // SS real interest rate
	chi // elast. of external finance Beta 0 .05 0.05 0.04 [0.03:0.05]
	ctheta // Survival rate
	ckn // SS leverage ratio
	crhoa // pers. of tech shock Beta 0.5 0.2 0.87 [0.82:0.93]
	crhob // pers. of capital quality shock Beta 0.5 0.2 0.99 [0.98:0.99]
	crhog // pers. of governm shock Beta 0.5 0.2 0.92 [0.86:0.98]
	crhoqs // pers. of investment shock Beta 0.5 0.2 0.97 [0.95:0.99]
	crhoms // pers. of monetary shock Beta 0.5 0.2 0.25 [0.12:0.36]
	crhoecps // pers. of price mark-up shock Beta 0.5 0.2 0.81 [0.64:0.98]
	crhoecws // pers. of wage mark-up shock Beta 0.5 0.2 0.59 [0.42:0.74]
//Flex price
	czcap       ${\psi}$            (long_name='capacity utilization cost')  
    csadjcost   ${\varphi}$         (long_name='investment adjustment cost')  
    clandaw     ${\phi_w}$          (long_name='Gross markup wages')   
	//crkky
	//cikbar %k_1 in equation LOM capital, equation (8)
	//cwhlc
	// ctrend
;


// calibrated parameters for financial frictions
ctheta = 	0.972; % does not show up in original SW code as there are no financial crictions
ckn = 		2;


// estimated  parameters for financial frictions initialisation
chi = 		0.04; % does not show up in original SW code as there are no financial crictions



// calibrated parameters
cdelta = 	0.025;   % (=ctou in original SW file)
clandaw	=	1.5;     
% curvp=10;          % parameter from original SW file not showing up here
% curvw=10;          % parameter from original SW file not showing up here
cgy = 		0.2;     % this is cg in original SW file and set to 0.18 there
cbeta = 	0.99;    % in the original SW code constebeta is estimated (0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;) and then #cbeta=1/(1+constebeta/100); is computed. Here it is calibrated.
celasw = 	6;       % does not show up in the original SW code. Here it is multiplied with cinvfrisch in the wage equation. cinvfrisch is an estimated parameter that does not show up in the original code
% THERE COULD BE PROBLEMS WITH CZCAP
czcap=    	0.2696;  %In the original SW code czcap is estimated rather than calibrated. Why is there czcap in the flexible price equation, but cecu in the sticky price equation? 
% THERE COULD BE PROBLEMS WITH csadjcost
csadjcost= 	6.0144;  %In the original SW code csadjcost is estimated rather than calibrated. Why is there an additional cinvadj that is estimated? Is there a difference between the two?
calfa =		0.24;    % In the original SW code calfa is estimated! Here it is calibrated. Why?
csigma =	1.5;     % In the original SW code csigma is estimated! Here it is calibrated. Why?
csigl =    1.9423;   % In the original SW code csigl is estimated! Here it is calibrated. Why?


// estimated parameters initialisation
cfc = 		1.33;    % initialized with 1.5 in original SW file
chabb = 	0.7;     % initialized with 0.6361 in original SW file
ccwage =	0.77;    % (=cprobw in original SW file, initialized there with 0.8087)
ccprice=  	0.82;    % (=cprobp in original SW file, initialized there with 0.6)
ccwagei = 	0.37;    % (=cindw in original SW file, initialized there with 0.3243)
ccpricei= 	 0.15;   % (=cindp in original SW file, initialized there with 0.47)
crhopi = 	1.80;    % (=crpi in original SW file, initialized there with 1.488;)
crhoi =  	0.88;    % (=crr in original SW file, initialized there with 0.8762;)
crhoy = 	0.09;    % (=cry in original SW file, initialized there with 0.0593;)
crhody = 	0.06;    % (=crdy in original SW file, initialized there with 0.2347;)

crhoa =		0.87;    % initialized with 0.9977 in original SW file   
crhob = 	0.99;    % initialized with 0.5799 in original SW file   
crhog = 	0.92;    % initialized with 0.9957 in original SW file  
crhoqs= 	0.97;    % initialized with 0.7165 in original SW file  
crhoms= 	0.25;    % initialized with 0 n original SW file  
crhoecps =	0.81;    %(=crhopinf in original SW file, initialized there with 0)
crhoecws =  0.59;    %(=crhow in original SW file, initialized there with 0)
%cmap = 0;           % parameter from original SW file not showing up here, because the price-markup shock is modelled here as an AR rather than an ARMA process
%cmaw  = 0;          % parameter from original SW file not showing up here, because the wage-markup shock is modelled here as an AR rather than an ARMA process
% I have included the next line (Maik)
constelab=0;        % parameter from original SW file not showing up here. Here steady state labor in the measurement equation is therefore set to 0. Not sure whether this is a good idea. For sure one needs demeaned hours data in this case.

cgamma1 = 0.3;       % (=ctrend in original SW code. There it is not initialized in this part of the code, but later a starting value for the estimation is set to 0.3982).
ccemp = 	0.81;    % Not sure what this is. Does not show up in the original SW code
cpie1 = 	0.55;    % = constepinf in the original code. There it is not initialized in this part of the code, but later a starting value for the estimation is set to 0.7).


cinvfrisch = 1.34;   % does not show up in the original code. Enters the wage equation. I do not really understand, why in this code vc(-1) shows up in the wage equation, while it is current consumption in the original code
cecu = 		0.95;    % not sure about this parameter. It is estimated. Is this the same as czcap in the original code? In the original code czcap is estimated rather than calibrated. Why is there czcap in the flexible price equation, but cecu in the sticky price equation?
cinvadj = 	4.59;    % not sure about this parameter. It is estimated, but seems to be the same as csadjcost which is calibrated (though estimated in the original SW code)


model(linear);
//#usmodel_stst;
//the following lines were originally in usmodel_stst in the original SW file, but this does not work with Dynare 4
#cpie =    1 +cpie1/100; //in SW07 it is 1.005;
#cgamma =	1+ cgamma1/100; // in SW it was 1.004
//#cbeta=1/(1+constebeta/100);     % in the original SW code constebeta is estimated, but here cbeta is directly calibrated above to equal 0.99
//#clandap=cfc;                    % from original SW code. Not needed here. Everywhere cfc is used
#cbetabar=cbeta*cgamma^(-csigma);
#cr=cpie/(cbeta*cgamma^(-csigma));
#crk=(cbeta^(-1))*(cgamma^csigma) - (1-cdelta);  % same as in original SW code, except that cdelta is named ctou there
#cw = (calfa^calfa*(1-calfa)^(1-calfa)/(cfc*crk^calfa))^(1/(1-calfa));  % same as in original SW code, except that there clandap instead of cfc is used, but they are the same
#cikbar=(1-(1-cdelta)/cgamma);
#cik=(1-(1-cdelta)/cgamma)*cgamma;
#clk=((1-calfa)/calfa)*(crk/cw);
#cky = cfc*(clk)^(calfa-1);
#ciy=cik*cky;
#ccy=1-cgy-ciy; % same as in SW original, except that here ciy from the previous line is used, while in the original code cik*cky is used
#crkky = crk*cky;
#cwhlc=(1/clandaw)*(1-calfa)/calfa*crk*cky/ccy; %W^{h}_{*}*L_{*}/C_{*} used in c_2 in equation (2)
//#cwly=1-crk*cky;  % additional line in the original SW code, but cwly is never used in the model equations afterwards. So it is not needed.

% I have included the next line (Maik)
#conster=(cr-1)*100; % additional line in the original SW code. There conster is used as the steady state interest rate in the measurement equation. Here cr is used there. This could be a problem for the estimation.

#crkp = (1+cbeta/100)*(1+cgamma/100)^(csigma)+(1-cdelta); % Not sure about the diff to crk. Does not show up in original SW code




// Model parameter dependencies for Flex price

//EQ.1 - Euler Equation
[name='EQ.1 - Euler Equation']
(1+ chabb) / (1- chabb) * vc = 1/(1-chabb) * vc(+1) + chabb/(1-chabb)*vc(-1) - vr;
// Original SW model code:  c = (chabb/cgamma)/(1+chabb/cgamma)*c(-1) + (1/(1+chabb/cgamma))*c(+1) +((csigma-1)*cwhlc/(csigma*(1+chabb/cgamma)))*(lab-lab(+1)) - (1-chabb/cgamma)/(csigma*(1+chabb/cgamma))*(r-pinf(+1) + 0*b) +b ;

//EQ.2 PC - Wage equation
[name='EQ.2 PC - Wage equation']

vw = cbeta/ (1+cbeta) * vw(+1) 
     + 1/(1+cbeta)*vw(-1) 
     + cbeta/(1+cbeta)*vpinf(+1) 
     - (1+cbeta*ccwagei)/(1+cbeta) * vpinf 
	 + ccwagei/(1+cbeta)* vpinf(-1) 
     + 1/(1+cbeta)*(1-cbeta*ccwage)*(1-ccwage)/((1+celasw*cinvfrisch)*ccwage)*(cinvfrisch*vlab-chabb/(1-chabb)*vc(-1)
     + 1/(1-chabb)*vc -vw)
     + ecws;

/* Original SW model w =  (1/(1+cbetabar*cgamma))*w(-1)
               +(cbetabar*cgamma/(1+cbetabar*cgamma))*w(1)
			   +(cindw/(1+cbetabar*cgamma))*pinf(-1)
               -(1+cbetabar*cgamma*cindw)/(1+cbetabar*cgamma)*pinf
               +(cbetabar*cgamma)/(1+cbetabar*cgamma)*pinf(1)
               +(1-cprobw)*(1-cbetabar*cgamma*cprobw)/((1+cbetabar*cgamma)*cprobw)*(1/((clandaw-1)*curvw+1))* (csigl*lab + (1/(1-chabb/cgamma))*c 
               - ((chabb/cgamma)/(1-chabb/cgamma))*c(-1) -w) 
               + 1*sw ;
			   */

// EQ.3  - Capital accumulation
[name='EQ.3  - Capital accumulation']
vk(+1) = cdelta * (vinve + qs) + (1-cdelta) * (vk + b);

//EQ 4. - Optimal Capital utilization
[name='EQ 4. - Optimal Capital utilization']
vz =   cecu /(1-cecu) * vu;

// EQ 5. - Investment Euler Equation
[name='EQ 5. - Investment Euler Equation']
vinve = 1/(cinvadj*(1+cbeta)) * ( vq + qs ) + 1/(1+cbeta) * vinve(-1) + cbeta/(1+cbeta)* vinve(+1);

// EQ 6. - Resource constraints
[name='EQ 6. - Resource constraints']
vy = ccy*vc + ciy * vinve + cgy*g + crk*cky*vu ;

// EQ 7. - Production function
[name='EQ 7. - Production function']
 vy = cfc*( calfa*(vk+vu+b) + (1-calfa) * vlab + a );

// EQ 8. - Firms FOCs
[name='EQ 8. - Firms FOCs']
vw = vz - vlab +vk+vu;

// EQ 9. - Firms FOCs
[name='EQ 9. - PC - prices']
vpinf = ccpricei/ (1+ ccpricei*cbeta) * vpinf(-1) 
        + cbeta/ (1+ ccpricei*cbeta) * vpinf(+1) 
        - ((1-cbeta*ccprice)*(1-ccprice))/((1+ ccpricei*cbeta) * ccprice) *  ( a - calfa*vz - (1-calfa)*vw) 
        + ecps; 

/* Original SW code
pinf =  (1/(1+cbetabar*cgamma*cindp)) * ( cbetabar*cgamma*pinf(1)        
          +cindp*pinf(-1)   
        +((1-cprobp)*(1-cbetabar*cgamma*cprobp)/cprobp)/((cfc-1)*curvp+1)*(mc)  )  
        + spinf ; 
*/           


// EQ 10. - Taylor rule
[name='EQ 10. - Taylor rule']		   
vrn =  crhoi*vrn(-1)+ (1-crhoi)*( crhopi * vpinf + crhoy * (vy - yf) )
                +crhody*(vy - yf - vy(-1) + yf(-1)) + emp;
				          
// EQ 11. - Fisher Equation
[name='EQ 11. - Fisher Equation']		   
vrn =  vr + vpinf(+1);					
         
// EQ 12. - Phillips curve- Employment
[name='EQ 12. - Phillips curve- Employment']		   
vemp = 1 / (1+ cbeta ) * vemp(-1) + cbeta/(1+cbeta)*vemp(+1) - ((1-cbeta*ccemp)*(1-ccemp))/((1+cbeta)*ccemp)*(vlab-vemp);  
       
// EQ 13. - Price of capital
[name='EQ 13. - Price of capital']
vrk = crk/crkp *vz+ (1-cdelta)/crkp*(vq + b) - vq(-1); 
  
// EQ 14. - External finance premium
[name='EQ 14. - Spread']
vep = chi * (vq + vk(+1) -vn(+1));

// EQ 15. - Spread
[name='EQ 15. - Spread']
vrk(+1) = vr + vep;


// EQ 15. - Firms net worth accumulation
[name='EQ 15. - Firms net worth accumulation']
1/(ctheta *crkp)*vn(+1) = ckn * vrk - (ckn-1) *vr - chi * (ckn-1)*(vk+vq(-1))+ ((ckn-1)*chi+1)*vn; 
 

[name='Law of motion for productivity']             
		   a = crhoa*a(-1)  + ea;
 
[name='Law of motion for capital quality']              
	       b = crhob*b(-1) + ek;

[name='Law of motion for spending process']              
		   g = crhog*(g(-1)) + eg;    % The reaction to the technology shock is missing in comparison to the original SW code: g = crhog*(g(-1)) + eg + cgy*ea;  Attention: in this file cgy is used for the government spending share, while it is the reactio to ea in the original one.
		   
[name='Law of motion for investment specific technology shock process']              
          qs = crhoqs*qs(-1) + ex;
         
[name='Law of motion for monetary policy shock process']              
	      ms = crhoms*ms(-1) + emp;

[name='Law of motion for price mark-up shock process']              
	      ecps = crhoecps * ecps(-1) + ep;               % in the original SW code there is an ARMA-specification: spinf = crhopinf*spinf(-1) + epinfma - cmap*epinfma(-1);	          epinfma=epinf;
		  
[name='Law of motion for wage mark-up shock process']              
	      ecws = crhoecws * ecws(-1) + ew;               % in the original SW code there is an ARMA-specification: sw = crhow*sw(-1) + ewma - cmaw*ewma(-1) ; 	          ewma=ew; 

// flexible economy

          [name='FOC labor with mpl expressed as function of rk and w, flex price economy']
	      0*(1-calfa)*a + 1*a =  calfa*rkf+(1-calfa)*(wf)  ;
	      [name='FOC capacity utilization, flex price economy']
	      zcapf =  (1/(czcap/(1-czcap)))* rkf  ;
          [name='Firm FOC capital, flex price economy']
	      rkf =  (wf)+labf-kf ;
          [name='Definition capital services, flex price economy']
	      kf =  kpf(-1)+zcapf ;
          [name='Investment Euler Equation, flex price economy']
	      invef = (1/(1+cbetabar*cgamma))* (  invef(-1) + cbetabar*cgamma*invef(1)+(1/(cgamma^2*csadjcost))*pkf ) +qs ;
          [name='Arbitrage equation value of capital, flex price economy']
          pkf = -rrf-0*b+(1/((1-chabb/cgamma)/(csigma*(1+chabb/cgamma))))*b +(crk/(crk+(1-cdelta)))*rkf(1) +  ((1-cdelta)/(crk+(1-cdelta)))*pkf(1) ;
	      [name='Consumption Euler Equation, flex price economy']
	      cf = (chabb/cgamma)/(1+chabb/cgamma)*cf(-1) + (1/(1+chabb/cgamma))*cf(+1) +((csigma-1)*cwhlc/(csigma*(1+chabb/cgamma)))*(labf-labf(+1)) - (1-chabb/cgamma)/(csigma*(1+chabb/cgamma))*(rrf+0*b) + b ;
	      [name='Aggregate Resource Constraint, flex price economy']
	      yf = ccy*cf+ciy*invef+g  +  crkky*zcapf ;
	      [name='Aggregate Production Function, flex price economy']
          yf = cfc*( calfa*kf+(1-calfa)*labf +a );
          [name='Wage equation, flex price economy']
	      wf = cinvfrisch*labf 	+(1/(1-chabb/cgamma))*cf - (chabb/cgamma)/(1-chabb/cgamma)*cf(-1) ;
          [name='Law of motion for capital, flex price economy (see header notes)']              
	      kpf =  (1-cikbar)*kpf(-1)+(cikbar)*invef + (cikbar)*(cgamma^2*csadjcost)*qs ;

// measurement equations
[name='Observation equation output']              
xgdp_q_obs=vy-vy(-1)+cgamma1;   % I have replaced cgamma with cgamma1 (cgamma+ cgamma1/100; )   (Maik)
[name='Observation equation consumption']              
pcer_q_obs =vc-vc(-1)+cgamma1;   % I have replaced cgamma with cgamma1 (cgamma+ cgamma1/100; )   (Maik)
[name='Observation equation investment']              
fpi_q_obs=vinve-vinve(-1)+cgamma1;   % I have replaced cgamma with cgamma1 (cgamma+ cgamma1/100; )   (Maik)
[name='Observation equation real wage']              
wage_obs=vw-vw(-1)+cgamma1;     % I have replaced cgamma with cgamma1 (cgamma+ cgamma1/100; )   (Maik)
[name='Observation equation hours worked']              
hours_obs = vlab + constelab;  % I have added constelab (Maik)
[name='Observation equation inflation']              
pgdp_q_obs = vpinf + cpie1;   % I have replaced cpie with cpie1 (cpie =    1 +cpie1/100; )  (Maik)
[name='Observation equation interest rate']              
rff_q_obs =   vr + conster;   % I have replaced cr with conster (#conster=(cr-1)*100;)  (Maik)
	

	
end;

shocks;

var ea;
stderr 1.09; // IG 0.1 2 1.09 [0.84:1.33]
var ek;
stderr 0.24; //std of capital quality shock IG 0.1 2 0.24 [0.18:0.30]
var eg;
stderr 1.46; //std of government shock IG 0.1 2 1.46 [1.29:1.64]
var ex;
stderr 2.33; //std of investment shock IG 0.1 2 2.33 [1.27:3.43]
var emp;
stderr 0.11; //std of monetary shock IG 0.1 2 0.11 [0.09:0.13]
var ep;
stderr 0.07; // std of price mark-up shock IG 0.1 2 0.07 [0.05:0.10]
var ew;
stderr 0.12; // std of wage mark-up shock IG 0.1 2 0.12 [0.09:0.16]
end;

estimated_params;
// PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
// PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
ccprice,0.82, ,1,NORMAL_PDF,0.75, 0.05; 		// Calvo prices , Beta 0.75 0.05, post 0.82 [0.77:0.87]  (Matyas: As optimizet got to the boundary of 1 I have made the distribution unbounded replacing a beta with a Normal)
ccwage,0.77, , ,BETA_PDF,0.75, 0.05; 		// Calvo wages Beta 0.75, 0.05, post 0.77 [0.71:0.84] calibrated 0.77
ccpricei,0.15, , ,BETA_PDF,0.5, 0.15; 		// Calvo price indexation,Beta 0.5, 0.15, post 0.15 [0.06:0.24] calibrated 0.15
ccemp,0.81, , ,BETA_PDF,0.5, 0.15;  		// Calvo employment Beta 0.5 0.15 0.81 [0.78:0.84] 
ccwagei,0.37, , ,BETA_PDF,0.5, 0.15;       // Calvo wage indexation, Beta 0.5, 0.15, post 0.77 [0.17:0.56] calibrated 0.37 
cinvadj,4.59,,,NORMAL_PDF,4,1.5; 			// Investment adjustment cost , Normal 4, 1.5, post 4,59 [3.11:5.98]
cecu,0.95, , ,BETA_PDF,0.25, 0.15; 			// Elasticity of Capital Utilization, Beta 0.25, 0.15, post 0.95 [0.92:0.98]
chabb,0.69, , ,BETA_PDF,0.7, 0.1; 			// Habit parameter , Beta 0.7, 0.1, post 0.69 [0,62:0.76], calibrated to 0.69
cfc,1.33,,,NORMAL_PDF,1.25,0.125;			// fixed costs in production, Normal, 1.25, 0.125, post 1.33, [1.2:1.47] 
cinvfrisch,1.34, , ,GAMMA_PDF,0.33,0.25; 	// inverse of Frisch elasticity Gamma 0.33, 0.25, post 1.34 [0.81,:1.86] calibrated 1.34
chi,0.04,,,BETA_PDF,0.05,0.01; 				// Elasticity of external finance, Beta,0.05,0.05, post 0.04 [0.03:0.05] (Matyas: I replaced the beta  priors sd with 0.01 parameter to have a more proper distribution)
crhopi,1.8,,,NORMAL_PDF,1.7,0.15; 			// Taylor rule Normal 1.7 0.15 1.80 [1.61:2.00]
crhoy,0.09,,,GAMMA_PDF,0.125,0.05; 			// Taylor rule Gamma 0.125 0.05 0.09 [0.05:0.14]
crhody,0.06,,,NORMAL_PDF,0.0625,0.05;         // Taylor rule changes in y Normal 0.0625 0.05 0.06 [0.03:0.09] - ERROR 0.06 is out of parameter bounds
crhoi,0.88,,,BETA_PDF,0.8,0.1;				// Taylor rule smoothing Beta 0.80 0.1 0.88 [0.86:0.91]
cgamma1,0.4,,,NORMAL_PDF,0.4,0.1;			// Constant growth rate of consumption, Normal,0.4, 0.1, 0.3 [0.24:0.36]
cpie1,0.65,,,GAMMA_PDF,0.625,0.1;			// Constant inflation in SS, Gamma, 0.625, 0.1, 0.55

% I have included the next line (Maik)
constelab,0,,,NORMAL_PDF,0.0,1.0;

crhoa,0.87,,,BETA_PDF,0.5,0.2;				// pers. of tech shock Beta 0.5 0.2 0.87 [0.82:0.93]
crhob,0.99,,,BETA_PDF,0.5,0.2;				// pers. of capital quality shock Beta 0.5 0.2 0.99 [0.98:0.99]
crhog,0.92,,,BETA_PDF,0.5,0.2;				// pers. of governm shock Beta 0.5 0.2 0.92 [0.86:0.98]
crhoqs,0.97,,,BETA_PDF,0.5,0.2;			    // pers. of investment shock Beta 0.5 0.2 0.97 [0.95:0.99]
crhoms,0.25,,,BETA_PDF,0.5,0.2; 			// pers. of monetary shock Beta 0.5 0.2 0.25 [0.12:0.36]
crhoecps,0.81,,,BETA_PDF,0.5,0.2; 			// pers. of price mark-up shock Beta 0.5 0.2 0.81 [0.64:0.98]
crhoecws,0.59,,,BETA_PDF,0.5,0.2; 			// pers. of wage mark-up shock Beta 0.5 0.2 0.59 [0.42:0.74]

stderr ea,1.09,,,INV_GAMMA_PDF,0.1,2; 		// IG 0.1 2 1.09 [0.84:1.33]
stderr ek,0.24,,,INV_GAMMA_PDF,0.1,2; 		//std of capital quality shock IG 0.1 2 0.24 [0.18:0.30]
stderr eg,1.46,,,INV_GAMMA_PDF,0.1,2; 		//std of government shock IG 0.1 2 1.46 [1.29:1.64]
stderr ex,2.33,,,INV_GAMMA_PDF,0.1,2; 		//std of investment shock IG 0.1 2 2.33 [1.27:3.43]
stderr emp,0.11,,,INV_GAMMA_PDF,0.1,2; 		//std of monetary shock IG 0.1 2 0.11 [0.09:0.13]
stderr ep,0.07,,,INV_GAMMA_PDF,0.1,2; 		//std of price mark-up shock IG 0.1 2 0.07 [0.05:0.10]
stderr ew,0.12,,,INV_GAMMA_PDF,0.1,2; 		// std of wage mark-up shock IG 0.1 2 0.12 [0.09:0.16]

end;

varobs xgdp_q_obs hours_obs wage_obs pgdp_q_obs rff_q_obs pcer_q_obs fpi_q_obs;

steady;
//stoch_simul(periods = 1000);