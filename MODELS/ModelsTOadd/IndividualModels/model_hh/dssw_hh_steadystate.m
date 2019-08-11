function[ys,check]=dssw_hh_steadystate(ys,exe)

global M_

nparam_ss=0;
for jj=1:size(M_.param_names)-nparam_ss;
    eval([deblank(M_.param_names(jj,:)),'=',num2str(M_.params(jj,:),10),';'])
end

beta=1/(r_star/400+1);
pic_star=pi_star/400+1;
g_star=1/(1-gg_star);
gamma=gamma_star/400;
%sigma=M_.params(20);
alpha=M_.params(4);

check = 0;

%f_omega = @(omega)solve_omega(omega,beta,sigma,nu,chi,we);
%omega   = fzero(f_omega,0.9);
%F1      = normcdf((log(omega)+0.5*sigma^2)/sigma);
%F2      = normcdf((log(omega)+0.5*sigma^2)/sigma-sigma);
%F1_prim = normpdf((log(omega)+0.5*sigma^2)/sigma)/omega/sigma;
R       = exp((gamma_star/400))*(pi_star/400+1) /(1/(r_star/400+1));
R_e=R;%R_e     = R/(nu/(1/(r_star/400+1))*(1-omega*(1-F1)-F2)+(we+1)*(omega*(1-F1)+(1-chi)*F2));
r_k     = R_e/(pi_star/400+1) -1+delta;
w       = (1-alpha)*(1+lambda_f)^(-1/(1-alpha))*(r_k/alpha)^(-alpha/(1-alpha));
F2=0.1; 
f_k_di= @(x)solve_k_di(x,r_k,w,R,gamma_star,delta,alpha,lambda_d,delta_o,pic_star,a,beta_i,gamma,m, ...
    lambda_w,phi,nu_l,n_p,lambda_l,g_star,beta,h,tau_i,chi,F2,R_e);
options     = optimset('Display','off');
[x,fval]    = fsolve(f_k_di,[21,8],options);
k           = x(1);
d_i         = x(2);
i = (exp((gamma_star/400))-1+delta)*k;
L   = (1-alpha)/alpha*r_k*k/w;
y   = k^alpha*L^(1-alpha);
t_i = tau_i*(1-1/g_star)*y;
R_i = (1+lambda_d)*R;
o_i = R_i*d_i/m/(1-delta_o)/pic_star;
lambda_i = a/o_i/(1-beta_i*(1-delta_o)/exp(gamma)-1/R_i*(1-beta_i/pic_star/exp(gamma)*R_i)*m*(1-delta_o)*pic_star);
theta = lambda_i/R_i*(1-beta_i/pic_star/exp(gamma)*R_i);
w_i = ((1+lambda_w)*phi*L^nu_l*w^((1+lambda_l)*nu_l/lambda_l)/lambda_i)^(lambda_l/(lambda_l+(1+lambda_l)*nu_l));
L_i = (w_i/w)^(-(1+lambda_l)/lambda_l)*L;
w_p = n_p^lambda_l*(w^(-1/lambda_l)-(1-n_p)*w_i^(-1/lambda_l))^(-lambda_l);
L_p = (w_p/w)^(-(1+lambda_l)/lambda_l)*L;
lambda = (1+lambda_w)*phi*L_p^nu_l/w_p;
o_p = a/lambda/(1-beta*(1-delta_o)/exp(gamma));
c_i = 1/lambda_i/(1-h/exp(gamma))-beta_i*h/lambda_i/(exp(gamma)-h);
c = 1/lambda/(1-h/exp(gamma))-beta*h/lambda/(exp(gamma)-h);
o = n_p*o_p+(1-n_p)*o_i;
i_o = (1-(1-delta_o)/exp(gamma))*o;
k_bar   = exp((gamma_star/400))*k;
%d       = R_e/R*k_bar*(omega*(1-F1)+(1-chi)*F2);
%n       = k_bar-d;
%R_d     = omega*R_e*k_bar/d;
p_tilda = 1;
mc      = p_tilda/(1+lambda_f);
phi_w   = 1/(1-beta*zeta_w)*phi*w_p^((1+lambda_w)*(1+nu_l)/lambda_w)*L_p^(1+nu_l);
psi_w   = 1/(1-beta*zeta_w)*lambda*w_p^((1+lambda_w)/lambda_w)*L_p;
phi_w_i = 1/(1-beta_i*zeta_w)*phi*w_i^((1+lambda_w)*(1+nu_l)/lambda_w)*L_i^(1+nu_l);
psi_w_i = 1/(1-beta_i*zeta_w)*lambda_i*w_i^((1+lambda_w)/lambda_w)*L_i;
phi_f   = 1/(1-beta*zeta_p)*lambda*mc*y;
psi_f   = 1/(1-beta*zeta_p)*lambda*y;
w_i_tilda = w_i;
w_p_tilda = w_p;
Q       = 1;
Q_o     = 1;
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
%lsigma=log(sigma);
%lnu=log(nu);
la=log(a);
lm=log(m);
lmu_o=0;
llambda_d=log(lambda_d);

dlnY=100*z;
dlnC=100*z;
dlnI=100*z;
lnL=100*log(L)+L_adj;
dlnw=100*z;
dlnP=100*log(pic);
FedFunds=400*(R-1);
%dlnD=100*z+D_adj;
%dlnDn=100*(z+log(pic))+D_adj;
%Spread=400*(R_d-R);
dlnIf=100*z;
dlnIo=100*z;
dlnDin=100*(z+log(pic))+D_adj;
dlnPo=100*log(pic)+Q_o_adj;
Spreadi=400*(R_i-R);

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
