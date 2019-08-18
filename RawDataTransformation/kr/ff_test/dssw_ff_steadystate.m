function[ys,check]=dssw_ff_steadystate(ys,exe)

global M_

nparam_ss=0;
for jj=1:size(M_.param_names)-nparam_ss;
    eval([deblank(M_.param_names(jj,:)),'=',num2str(M_.params(jj,:),10),';'])
end

beta=1/(r_star/400+1);
pic_star=pi_star/400+1;
g_star=1/(1-gg_star);
gamma=gamma_star/400;
sigma=M_.params(20);
alpha=M_.params(4);

check = 0;

f_omega = @(omega)solve_omega(omega,beta,sigma,nu,chi,we);
omega   = fzero(f_omega,0.95);
F1      = normcdf((log(omega)+0.5*sigma^2)/sigma);
F2      = normcdf((log(omega)+0.5*sigma^2)/sigma-sigma);
F1_prim = normpdf((log(omega)+0.5*sigma^2)/sigma)/omega/sigma;
R       = exp((gamma_star/400))*(pi_star/400+1) /(1/(r_star/400+1));
R_e     = R/(nu/(1/(r_star/400+1))*(1-omega*(1-F1)-F2)+(we+1)*(omega*(1-F1)+(1-chi)*F2));
r_k     = R_e/(pi_star/400+1) -1+delta;
w       = (1-alpha)*(1+lambda_f)^(-1/(1-alpha))*(r_k/alpha)^(-alpha/(1-alpha));
f_k= @(k)solve_k(k,g_star,alpha,gamma,beta,delta,h,chi,lambda_w,phi,nu_l,r_k,w,F2,R_e,pic_star);
k       = fzero(f_k,25);
L       = (1-alpha)/alpha*r_k*k/w;
y       = k^alpha*L^(1-alpha);
lambda  = (1+lambda_w)*phi*L^nu_l/w;
c       = (exp((gamma_star/400))-(1/(r_star/400+1))*h)/(lambda*(exp((gamma_star/400))-h));
i       = (exp((gamma_star/400))-1+delta)*k;
k_bar   = exp((gamma_star/400))*k;
d       = R_e/R*k_bar*(omega*(1-F1)+(1-chi)*F2);
n       = k_bar-d;
R_d     = omega*R_e*k_bar/d;
p_tilda = 1;
mc      = p_tilda/(1+lambda_f);
phi_w   = 1/(1-(1/(r_star/400+1))*zeta_w)*phi*w^((1+lambda_w)*(1+nu_l)/lambda_w)*L^(1+nu_l);
psi_w   = 1/(1-(1/(r_star/400+1))*zeta_w)*lambda*w^((1+lambda_w)/lambda_w)*L;
phi_f   = 1/(1-(1/(r_star/400+1))*zeta_p)*lambda*mc*y;
psi_f   = 1/(1-(1/(r_star/400+1))*zeta_p)*lambda*y;
w_tilda = w;
Q       = 1;
Delta   = 1;
u       = 1;
pic     = (pi_star/400+1);

z=gamma;
lb=0;
lphi=log(phi);
lmu=0;
llambda_f=log(lambda_f);
lg=log((1/(1-gg_star)));
lA=0;
lsigma=log(sigma);
lnu=log(nu);

dlnY=100*z;
dlnC=100*z;
dlnI=100*z;
lnL=100*log(L)+L_adj;
dlnw=100*z;
dlnP=100*log(pic);
FedFunds=400*(R-1);
dlnD=100*z+D_adj;
dlnDn=100*(z+log(pic))+D_adj;
Spread=400*(R_d-R);


ys=[];
for jj=1:size(M_.endo_names);
    eval(['global  ',deblank(M_.endo_names(jj,:)),'_ss']);
    eval([deblank(M_.endo_names(jj,:)),'_ss=(',M_.endo_names(jj,:),');'])
    ys(jj,1)=eval(M_.endo_names(jj,:));
end

%{
for jj=1:size(M_.param_names,1)
    if exist(deblank(M_.param_names(jj,:)),'var');
        tmp=eval(M_.param_names(jj,:));
    else
        tmp=0;
    end
    if isempty(tmp);tmp=0;end
    M_.params(jj,1)=tmp;
end

assignin('base','M_',M_);
assignin('base','ys',ys);
%}


function f = solve_omega(omega,beta,sigma,nu,chi,we)

F1      = normcdf((log(omega)+0.5*sigma^2)/sigma);
F2      = normcdf((log(omega)+0.5*sigma^2)/sigma-sigma);
F1_prim = normpdf((log(omega)+0.5*sigma^2)/sigma)/omega/sigma;

f = (1-omega*(1-F1)-F2)-(1-F1)/(1-F1-chi*omega*F1_prim)*(nu/beta*(1-omega*(1-F1)-F2)+we*(omega*(1-F1)+(1-chi)*F2));

function f = solve_k(k,g_star,alpha,gamma,beta,delta,h,chi,lambda_w,phi,nu_l,r_k,w,F2,R_e,pic_star)

f = 1/g_star*((1-alpha)/alpha*r_k/w)^(1-alpha)*k-w*(exp(gamma)-beta*h)/((1+lambda_w)*phi*((1-alpha)/alpha*r_k*k/w)^nu_l*(exp(gamma)-h))-(exp(gamma)-1+delta)*k-chi*F2*R_e*k/pic_star ;
 