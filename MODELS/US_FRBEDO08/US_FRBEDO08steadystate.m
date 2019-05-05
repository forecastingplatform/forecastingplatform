% computes the steady state of dog.mod (growthless deterministic growth model). 
% stephane [DOT] adjemian [AT] ens [DOT] fr

function [ys,check] = US_NFED_20024_steadystate(ys,exe)
global M_

%% DO NOT CHANGE THIS PART.
%%
%% Here we load the values of the deep parameters in a loop.
%%
NumberOfParameters = M_.param_nbr;                            % Number of deep parameters.
for i = 1:NumberOfParameters                                  % Loop...
  paramname = deblank(M_.param_names(i,:));                   %    Get the name of parameter i. 
  eval([ paramname ' = M_.params(' int2str(i) ');']);         %    Get the value of parameter i.
end                                                           % End of the loop.  
check = 0;
%%
%% END OF THE FIRST MODEL INDEPENDENT BLOCK.


%% THIS BLOCK IS MODEL SPECIFIC.
%%
%% Here the user has to define the steady state.
%%
% auxiliary parameters
A = ALPHA/(GAMMAxkstar/BETA-(1-DELTAnr))*(THETAxkstar-1)/THETAxkstar;
D = SIGMAcd/SIGMAcnn * (1-BETA*Hcd/GAMMAxkstar)/(1-BETA*Hcnn/GAMMAxcstar)*(1-Hcnn/GAMMAxcstar)/(1-Hcd/GAMMAxkstar)*(GAMMAxkstar-(1-DELTAcd))/GAMMAxkstar*BETA*GAMMAxkstar/(GAMMAxkstar-BETA*(1-DELTAcd));
R_ = SIGMAr/SIGMAcnn * (1-BETA*Hr/GAMMAxcstar)/(1-BETA*Hcnn/GAMMAxcstar)*(1-Hcnn/GAMMAxcstar)/(1-Hr/GAMMAxcstar)*(GAMMAxcstar-(1-DELTAr))/GAMMAxcstar*BETA*GAMMAxcstar/(GAMMAxcstar-BETA*(1-DELTAr));
B = (D+(1+R_)*(GAMMAxkstar-(1-DELTAnr))*A)/((1+R_)-(1+R_)*(GAMMAxkstar-(1-DELTAnr))*A);
L = ((THETAlstar-1)/THETAlstar*(1-ALPHA)*((THETAxkstar-1)/THETAxkstar)^(1/(1-ALPHA))*(ALPHA/(GAMMAxkstar/BETA-(1-DELTAnr)))^(ALPHA/(1-ALPHA)) * (1+B)/A^(ALPHA/(1-ALPHA))*(1+R_)*SIGMAcnn/SIGMAl * (1-BETA*Hcnn/GAMMAxcstar)/(1-Hcnn/GAMMAxcstar))^(1/(NU+1));
Lcstar = 1/(1+B)*L;
Lkstar = B/(1+B)*L;
Xcstar = Lcstar/((1/BETA*GAMMAxkstar-(1-DELTAnr))/ALPHA*THETAxkstar/(THETAxkstar-1))^(ALPHA/(1-ALPHA));
Xkstar = Lkstar/((1/BETA*GAMMAxkstar-(1-DELTAnr))/ALPHA*THETAxkstar/(THETAxkstar-1))^(ALPHA/(1-ALPHA));
Hgdpstar = GAMMAxcstar^((Pcstar*Xcstar+Pcstar*Xgfstar)/(Pcstar*Xcstar+Pkstar*Xkstar+Pcstar*Xgfstar))*GAMMAxkstar^((Pkstar*Xkstar)/(Pcstar*Xcstar+Pkstar*Xkstar+Pcstar*Xgfstar));
PAIpgdpstar = 1/Hgdpstar*PAIpcstar * GAMMAxcstar;


gammazk  = GAMMAzkstar;  
gammazm  = GAMMAzmstar;  
gammaxc  = GAMMAxcstar;  
gammaxk  = GAMMAxkstar;  
paipc    = PAIpcstar;    
paipk    = PAIpkstar;    
paiwc    = PAIwcstar;    
paiwk    = PAIwkstar;    
r        = Rstar;        
rbar     = Rstar;        
pk       = Pkstar;      
qnr      = 1;          
qcd      = 1;          
qr       = 1;           
mcc      = (THETAxcstar-1)/THETAxcstar;          
mck      = (THETAxkstar-1)/THETAxkstar*pk;       
uc       = 1;      
uk       = 1;                                     
rnrc     = Rnrcbistar;                              
rnrk     = Rnrcbistar;                              
wc       = (1-ALPHA)*mcc^(1/(1-ALPHA))*(ALPHA/(GAMMAxkstar/BETA-(1-DELTAnr)))^(ALPHA/(1-ALPHA)); 
wk       = wc;                                                                                   
rr       = 1/BETA*GAMMAxcstar-(1-DELTAr);            
rcd      = 1/BETA*GAMMAxkstar-(1-DELTAcd);           
lc       = Lcstar;       
lk       = Lkstar;       
xc       = Xcstar;       
xk       = Xkstar;       
knrc     = Xcstar*GAMMAxkstar*ALPHA*mcc/rnrc;        
knrk     = Xkstar*GAMMAxkstar*ALPHA*mck/rnrk;        
ecnn     = Xcstar/(1+R_);                            
er       = Xcstar*R_/(1+R_);                         
enr      = Xkstar*(GAMMAxkstar-(1-DELTAnr))*A*((1+B)/B); 
ecd      = Xkstar-enr;                               
kcd      = ecd*GAMMAxkstar/(GAMMAxkstar-(1-DELTAcd));
kr       = er*GAMMAxcstar/(GAMMAxcstar-(1-DELTAr));  
lambdacnn = SIGMAcnn/(ecnn-(Hcnn/GAMMAxcstar)*ecnn) - BETA * SIGMAcnn * (Hcnn/GAMMAxcstar)/(ecnn-Hcnn/GAMMAxcstar*ecnn); 
lambdacd  = GAMMAxkstar*(SIGMAcd/(kcd-(Hcd/GAMMAxkstar)*kcd) - BETA * SIGMAcd * (Hcd/GAMMAxkstar)/(kcd-Hcd/GAMMAxkstar*kcd));   
lambdar   = GAMMAxcstar*(SIGMAr /(kr- (Hr /GAMMAxcstar)*kr ) - BETA * SIGMAr  * (Hr/GAMMAxcstar )/(kr - Hr/GAMMAxcstar*kr ));  
lambdalc  = SIGMAl*(Lcstar+Lkstar)^NU;                
lambdalk  = lambdalc;                                 
hgdp      = Hgdpstar;                                 
paipgdp   = PAIpgdpstar;                              
xgdp_q_obs_frbedo= hgdp;
pgdp_q_obs_frbedo= paipgdp;
rff_q_obs_frbedo = r;
pecnn_q_obs_frbedo = paipc*gammaxc;
pecd_q_obs_frbedo  = paipk*gammaxk;
per_q_obs_frbedo   = paipc*gammaxc;
penr_q_obs_frbedo  = paipk*gammaxk;
paipc_q_obs_frbedo = paipc;
paipk_q_obs_frbedo = paipk;
wage_obs_frbedo    = paipc/paipgdp*gammaxc;
hours_obs_frbedo   = 1;
xgdp_q_obs = (hgdp-1)*100;
pgdp_q_obs = (paipgdp-1)*100;
rff_q_obs = (r-1)*100;

interest   = r;
inflation  = paipgdp;


thetaxc = THETAxcstar;  
thetaxk = THETAxkstar;  
thetal  = THETAlstar;   
xgf = Xgfstar;
anr   =  1;   
acd   =  1;   
a_r   =  1;   
xicnn =  1;
xicd  =  1;
xir   =  1;
xil   =  1;
xicnnsmall = 0;
xicdsmall = 0;
xirsmall = 0;
xilsmall = 0;
gammazksmall = 0;  
gammazmsmall = 0;  

output = xc+xk+xgf; 


%%
%% END OF THE MODEL SPECIFIC BLOCK.


%% DO NOT CHANGE THIS PART.
%%
%% Here we define the steady state values of the endogenous variables of
%% the model.
%%
NumberOfEndogenousVariables = M_.endo_nbr;                    % Number of endogenous variables.
ys = zeros(NumberOfEndogenousVariables,1);                    % Initialization of ys (steady state).
for i = 1:NumberOfEndogenousVariables                         % Loop...
  varname = deblank(M_.endo_names(i,:));                      %    Get the name of endogenous variable i.                     
  eval(['ys(' int2str(i) ') = ' varname ';']);                %    Get the steady state value of this variable.
end                                                           % End of the loop.
%%
%% END OF THE SECOND MODEL INDEPENDENT BLOCK.