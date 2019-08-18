//DelNegro-Schorfheide-Smets-Wouters model from JBES augmented with financial frictions a la BGG

close all;

var lambda, R, pic, c, w_tilda, w, phi_w, psi_w, L, k, k_bar, i, Q, d, n, R_e, r_k, u, R_d, 
    F1, F2, F1_prim, omega, mc, p_tilda, phi_f, psi_f, y, Delta,
    z, lb, lphi, lmu, llambda_f, lg, lA, lsigma, lnu,
    dlnY, dlnC, dlnI, lnL, dlnw, dlnP, FedFunds, dlnD, dlnDn, Spread;

varexo eps_z, eps_b, eps_phi, eps_mu, eps_lambda_f, eps_g, eps_R, eps_sigma, eps_nu;
// eps_A

parameters phi, lambda_w, delta, alpha, zeta_p, iota_p, s_bis, h, nu_l, zeta_w, iota_w, r_star, psi_1, psi_2,
rho_R, pi_star, gamma_star, lambda_f, gg_star, sigma, nu, chi, we, a_bis,
rho_z, rho_b, rho_phi, rho_mu, rho_lambda_f, rho_g, rho_A, rho_sigma, rho_nu,
L_adj, D_adj;

phi         = 0.8;
lambda_w    = 0.3;
delta       = 0.025;
alpha       = 0.33;
zeta_p      = 0.6;
iota_p      = 0.5;
s_bis       = 4;
h           = 0.7;
nu_l        = 2;
zeta_w      = 0.6;
iota_w      = 0.5;
r_star      = 2;
psi_1       = 1.5;
psi_2       = 0.2;
rho_R       = 0.5;
pi_star     = 3;
gamma_star  = 2;
lambda_f    = 0.15;
gg_star     = 0.2;
sigma       = 0.30;
nu          = 0.975;
chi         = 0.12;
we          = 0.01;
rho_z       = 0.9; 
rho_b       = 0.9;
rho_phi     = 0.9;
rho_mu      = 0.9;
rho_lambda_f= 0.9;
rho_g       = 0.9; 
rho_A       = 0.9; 
rho_sigma   = 0.9; 
rho_nu      = 0.9;

a_bis  = 0.2;
L_adj  = 662;
D_adj  = 0*0.3;

model;

# beta=1/(r_star/400+1);
# pic_star=pi_star/400+1;
# g_star=1/(1-gg_star);
# gamma=gamma_star/400;

beta*lambda(+1)/exp(z(+1))/lambda*R/pic(+1)=1;
lambda=exp(lb)/(c-h*c(-1)/exp(z))-beta*h*exp(lb(+1))/(exp(z(+1))*c(+1)-h*c);
w_tilda^(1+nu_l*(1+lambda_w)/lambda_w)=(1+lambda_w)*phi_w/psi_w;
phi_w=exp(lphi)*w^((1+lambda_w)*(1+nu_l)/lambda_w)*L^(1+nu_l)+beta*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^((1+lambda_w)*(1+nu_l)/lambda_w)*exp(((1+lambda_w)*(1+nu_l)/lambda_w)*z(+1))*phi_w(+1);
psi_w=lambda*w^((1+lambda_w)/lambda_w)*L+beta*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^(1/lambda_w)*exp(1/lambda_w*z(+1))*psi_w(+1);
w=(zeta_w*(w(-1)/exp(z)/pic*(pic(-1)*exp(z(-1)))^iota_w*(pic_star*exp(gamma))^(1-iota_w))^(-1/lambda_w)+(1-zeta_w)*w_tilda^(-1/lambda_w))^(-lambda_w);
k_bar=(1-delta)*k_bar(-1)/exp(z)+exp(lmu)*(1-s_bis/2*(exp(z)*i/i(-1)-exp(gamma))^2)*i;
1=exp(lmu)*(1-s_bis/2*(exp(z)*i/i(-1)-exp(gamma))^2-exp(z)*i/i(-1)*s_bis*(exp(z)*i/i(-1)-exp(gamma)))*Q+beta*lambda(+1)/exp(z(+1))/lambda*exp(lmu(+1))*(exp(z(+1))*i(+1)/i)^2*s_bis*(exp(z(+1))*i(+1)/i-exp(gamma))*Q(+1);
d=Q*k_bar-n;
R_e=(u*r_k-steady_state(r_k)*(u-1)-a_bis/2*(u-1)^2+(1-delta)*Q)*pic/Q(-1);
r_k=steady_state(r_k)+a_bis*(u-1);
R_e*Q(-1)*k_bar(-1)*(omega*(1-F1)+(1-chi)*F2)=R(-1)*d(-1);
R_e(+1)/R*(1-omega(+1)*(1-F1(+1))-F2(+1))+(1-F1(+1))/(1-F1(+1)-chi*omega(+1)*F1_prim(+1))*(R_e(+1)/R*(omega(+1)*(1-F1(+1))+(1-chi)*F2(+1))-1)=0;
R_d=omega*R_e*k_bar(-1)/d(-1);
n=exp(lnu)*(R_e*Q(-1)*k_bar(-1)/exp(z)-(R(-1)+chi*F2*R_e*Q(-1)*k_bar(-1)/d(-1))*d(-1)/exp(z))/pic+we*steady_state(d);
exp(z)*k=u*k_bar(-1);
mc=1/exp(lA)*(w/(1-alpha))^(1-alpha)*(r_k/alpha)^alpha;
p_tilda=(1+exp(llambda_f))*phi_f/psi_f;
phi_f=lambda*mc*y+beta*zeta_p*(pic(+1)/pic^iota_p/pic_star^(1-iota_p))^((1+exp(llambda_f))/exp(llambda_f))*phi_f(+1);
psi_f=lambda*y+beta*zeta_p*(pic(+1)/pic^iota_p/pic_star^(1-iota_p))^(1/exp(llambda_f))*psi_f(+1);
1=zeta_p*(1/pic*pic(-1)^iota_p*pic_star^(1-iota_p))^(-1/exp(llambda_f))+(1-zeta_p)*p_tilda^(-1/exp(llambda_f));
R/steady_state(R)=(R(-1)/steady_state(R))^rho_R*((pic/pic_star)^psi_1*(y/steady_state(y))^psi_2)^(1-rho_R)*exp(eps_R/100);
1/exp(lg)*y=c+i+(steady_state(r_k)*(u-1)+a_bis/2*(u-1)^2)*k_bar(-1)/exp(z)+chi*F2*R_e*Q(-1)*k_bar(-1)/exp(z)/pic;
L=((1-alpha)/alpha)^alpha*(r_k/w)^alpha*y/exp(lA)*Delta;
k=(alpha/(1-alpha))^(1-alpha)*(w/r_k)^(1-alpha)*y/exp(lA)*Delta;
Delta=(1-zeta_p)*p_tilda^(-(1+exp(llambda_f))/exp(llambda_f))+zeta_p*(pic(-1)^iota_p*pic_star^(1-iota_p)/pic)^(-(1+exp(llambda_f))/exp(llambda_f))*Delta(-1);
F1      = normcdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma));
F2      = normcdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma)-exp(lsigma));
F1_prim = normpdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma))/omega/exp(lsigma);

z=(1-rho_z)*gamma+rho_z*z(-1)+eps_z/100;
lb=rho_b*lb(-1)+eps_b/100;
lphi=(1-rho_phi)*log(phi)+rho_phi*lphi(-1)+eps_phi/100;
lmu=rho_mu*lmu(-1)+eps_mu/100;
llambda_f=(1-rho_lambda_f)*log(lambda_f)+rho_lambda_f*llambda_f(-1)+eps_lambda_f/100;
lg=(1-rho_g)*log(g_star)+rho_g*lg(-1)+eps_g/100;
lA=0; //lA=rho_A*lA(-1)+eps_A/100;
lsigma=(1-rho_sigma)*log(sigma)+rho_sigma*lsigma(-1)+eps_sigma/100;
lnu=(1-rho_nu)*log(nu)+rho_nu*lnu(-1)+eps_nu/100;

dlnY=100*(log(y/y(-1))+z);
dlnC=100*(log(c/c(-1))+z);
dlnI=100*(log(i/i(-1))+z);
lnL=100*log(L)+L_adj;
dlnw=100*(log(w/w(-1))+z);
dlnP=100*log(pic);
FedFunds=400*(R-1);
dlnD=100*(log(d/d(-1))+z)+D_adj;
dlnDn=100*(log(d/d(-1))+z+log(pic))+D_adj;
Spread=400*(R_d-R);

end;

steady;
check;


shocks;
var eps_z; stderr 1;
var eps_b; stderr 1;
var eps_phi; stderr 1;
var eps_mu; stderr 1;
var eps_lambda_f; stderr 1;
var eps_g; stderr 1;
var eps_R; stderr 1;
//var eps_A; stderr 1;
var eps_sigma; stderr 1;
var eps_nu; stderr 1;
end;


estimated_params;
alpha,              beta_pdf,       0.33,   0.05;
zeta_p,             beta_pdf,       0.6,    0.2;
iota_p,             beta_pdf,       0.5,    0.2;
s_bis,              gamma_pdf,      0.5,    0.1;
h,                  beta_pdf,       0.7,    0.05;
a_bis,              gamma_pdf,      0.2,    0.1;
nu_l,               gamma_pdf,      2,      0.75;
zeta_w,             beta_pdf,       0.6,    0.2;
iota_w,             beta_pdf,       0.5,    0.2;
r_star,             gamma_pdf,      2,      1;
psi_1,              gamma_pdf,      1.5,    0.4;
psi_2,              gamma_pdf,      0.2,    0.1;
rho_R,              beta_pdf,       0.5,    0.2;
pi_star,            normal_pdf,     3.01,   1.5;
gamma_star,         gamma_pdf,      2,      1;
lambda_f,           gamma_pdf,      0.15,   0.1;
gg_star,            gamma_pdf,      0.3,    0.1;
L_adj,              normal_pdf,    662,    1;//, 650, 670;
D_adj,              normal_pdf,    0.5,    0.1;//, 0, 1;
chi,                beta_pdf,       0.12,   0.01;
nu,                 beta_pdf,       0.975,  0.001;
sigma,              gamma_pdf,      0.3,    0.01;
rho_z,              beta_pdf,       0.2,    0.1;
rho_phi,            beta_pdf,       0.6,    0.2;
rho_lambda_f,       beta_pdf,       0.6,    0.2;
rho_mu,             beta_pdf,       0.8,    0.05;
rho_b,              beta_pdf,       0.6,    0.2;
rho_g,              beta_pdf,       0.8,    0.05;
//rho_A,              beta_pdf,       0.2,    0.1;
rho_sigma,          beta_pdf,       0.8,    0.2;
rho_nu,             beta_pdf,       0.8,    0.2;
stderr eps_z,       inv_gamma_pdf, 0.5, inf;
stderr eps_phi,     inv_gamma_pdf, 2, inf;
stderr eps_lambda_f,inv_gamma_pdf, 0.5, inf;
stderr eps_mu,      inv_gamma_pdf, 0.5, inf;
stderr eps_b,       inv_gamma_pdf, 0.5, inf;
stderr eps_g,       inv_gamma_pdf, 0.5, inf;
stderr eps_R,       inv_gamma_pdf, 0.25, inf;
//stderr eps_A,       inv_gamma_pdf, 0.5, inf;
stderr eps_sigma,   inv_gamma_pdf, 0.5, inf;
stderr eps_nu,      inv_gamma_pdf, 0.5, inf;

end;

estimated_params_init;
alpha,              0.2647;//0.154;
zeta_p,             0.5567;//0.77;
iota_p,             0.1332;//0.06;
s_bis,              0.3014;//0.5;
h,                  0.7427;//0.77;
a_bis,              0.2492;//0.24;
nu_l,               2.1929;//2.01;
zeta_w,             0.2223;//0.25;
iota_w,             0.0735;//0.12;
r_star,             1.7943;//1.01;
psi_1,              2.0128;//1.69;
psi_2,              0.1185;//0.03;
rho_R,              0.5849;//0.74;
pi_star,            3.3172;//3.90;
gamma_star,         1.3957;//1.54;
lambda_f,           0.1841;//0.24;
gg_star,            0.3022;//0.29;
L_adj,              661.8189;//659;
D_adj,              0.1877;//0.5;
chi,                0.12;
nu,                 0.9779;
sigma,              0.2847;
rho_z,              0.0998;//0.07;
rho_phi,            0.9802;//0.98;
rho_lambda_f,       0.8715;//0.91;
rho_mu,             0.8434;//0.80;
rho_b,              0.2005;//0.22;
rho_g,              0.9274;//0.96;
//rho_A,              0.1;
rho_sigma,          0.9125;//0.8;
rho_nu,             0.4349;//0.8;
stderr eps_z,       0.9362;
stderr eps_phi,     3.1353;
stderr eps_lambda_f,5.6197;
stderr eps_mu,      0.6273;
stderr eps_b,       2.4096;
stderr eps_g,       0.6698;
stderr eps_R,       0.4504;
//stderr eps_A,       ;
stderr eps_sigma,   9.0206;
stderr eps_nu,      0.8327;
end;


estimated_params_bounds;
alpha,              0.1,    0.5;
zeta_p,             0,      1;
iota_p,             0,      1;
s_bis,              0,      10;
h,                  0,      1;
a_bis,              0,      10;
nu_l,               0,      10;
zeta_w,             0,      1;
iota_w,             0,      1;
r_star,             0.5,      4;
psi_1,              1,      3;
psi_2,             -0.5,      1;
rho_R,              0,      1;
pi_star,            0,      6;
gamma_star,         0,      4;
lambda_f,           0,      1;
gg_star,            0.1,    0.4;
chi,                0.05,   0.25;
nu,                 0.9,    0.999;
sigma,              0.2,    0.5;
end;

varobs dlnY, dlnC, dlnI, lnL, dlnw, dlnP, FedFunds, dlnDn, Spread;

//load options_dssw_ff;
//options_.nobs      = nobs;
//options_.first_obs = 1;
//options_.dynatol=1.0000e-004;

//for multi-core computers - paralelization setting
//options_.parallel = struct('Local',1, 'ComputerName', 'localhost', 'CPUnbr', [1:4],'SingleCompThread',1,'MatlabOctavePath','matlab', 'DynarePath','C:\dynare\4.5.7\matlab');
//options_.parallel_info = struct('RemoteTmpFolder','', 'leaveSlaveOpen',0);
//parallel='c1';

//estimation(mode_compute=4,datafile=data,mode_file=dssw_ff_mh_mode,plot_priors=0,mode_check,nodiagnostic,mh_replic=125000,mh_nblocks=4,mh_jscale=0.32,mh_drop=0.2,bayesian_irf,irf=40) dlnY, dlnC, dlnI, dlnw, lnL, dlnP, FedFunds, dlnDn, Spread;
estimation(nograph,mode_compute=0,datafile=data,xls_range=A1:O165,nobs=157,mode_file=dssw_ff_mode,plot_priors=0,nodiagnostic,mh_replic=1000,mh_nblocks=2,mh_jscale=0.25,mh_drop=0.2,forecast=5) dlnY, dlnP, FedFunds;
//stoch_simul(order=1,irf=16) dlnY, dlnC, dlnI, dlnw, lnL, dlnP, FedFunds, dlnDn, Spread;
