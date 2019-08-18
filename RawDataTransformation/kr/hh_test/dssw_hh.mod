//DelNegro-Schorfheide-Smets-Wouters model from JBES augmented with financial frictions a la BGG

close all;

var lambda, R, pic, c, w, phi_w, psi_w, L, k, k_bar, i, Q, R_e, r_k, u, 
    mc, p_tilda, phi_f, psi_f, y, Delta,
    z, lb, lphi, lmu, llambda_f, lg, lA, 
    dlnY, dlnC, dlnI, lnL, dlnw, dlnP, FedFunds,
    o, o_p, o_i, Q_o, c_i, d_i, R_i, t_i, L_i, w_i_tilda, w_i, phi_w_i, psi_w_i, w_p_tilda, w_p, L_p, lambda_i, theta, i_o,
    la, lm, lmu_o, llambda_d,
    dlnIf, dlnIo, dlnDin, dlnPo, Spreadi;
// dlnD, dlnDn, Spread, lsigma, lnu, n, R_d, F1, F2, F1_prim, omega, d,     w_tilda, 

varexo eps_z, eps_b, eps_phi, eps_mu, eps_lambda_f, eps_g, eps_R, 
        eps_a, eps_m, eps_mu_o, eps_lambda_d;
// eps_A, eps_sigma, eps_nu

parameters phi, lambda_w, delta, alpha, zeta_p, iota_p, s_bis, h, nu_l, zeta_w, iota_w, r_star, psi_1, psi_2,
rho_R, pi_star, gamma_star, lambda_f, gg_star, sigma, nu, chi, we, a_bis,
rho_z, rho_b, rho_phi, rho_mu, rho_lambda_f, rho_g, rho_A, rho_sigma, rho_nu,
L_adj, D_adj, Q_o_adj,
a, beta_i, delta_o, m, s_o_bis, lambda_d, n_p, lambda_l, tau_i,
rho_a, rho_m, rho_mu_o, rho_lambda_d;

phi         = 0.8;
lambda_w    = 0.3;
delta       = 0.025;
alpha       = 0.27;
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
sigma       = 0.27;
nu          = 0.977;
chi         = 0*0.1;
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
Q_o_adj= 0*0.2;

a           = 0.2;
beta_i      = 0.97;
delta_o     = 0.005;
m           = 0.85;
s_o_bis     = 4;
lambda_d    = 0.00625;
n_p         = 0.2;
lambda_l    = 0.3; 
tau_i       = 0;
rho_a       = 0.9;
rho_m       = 0.9;
rho_mu_o    = 0.9;
rho_lambda_d= 0.9;

model;

# beta=1/(r_star/400+1);
# pic_star=pi_star/400+1;
# g_star=1/(1-gg_star);
# gamma=gamma_star/400;

beta*lambda(+1)/exp(z(+1))/lambda*R/pic(+1)=1;
lambda=exp(lb)/(c-h*c(-1)/exp(z))-beta*h*exp(lb(+1))/(exp(z(+1))*c(+1)-h*c);
w_p_tilda^(1+nu_l*(1+lambda_w)/lambda_w)=(1+lambda_w)*phi_w/psi_w;
phi_w=exp(lphi)*w_p^((1+lambda_w)*(1+nu_l)/lambda_w)*L_p^(1+nu_l)+beta*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^((1+lambda_w)*(1+nu_l)/lambda_w)*exp(((1+lambda_w)*(1+nu_l)/lambda_w)*z(+1))*phi_w(+1);
psi_w=lambda*w_p^((1+lambda_w)/lambda_w)*L_p+beta*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^(1/lambda_w)*exp(1/lambda_w*z(+1))*psi_w(+1);
w_p=(zeta_w*(w_p(-1)/exp(z)/pic*(pic(-1)*exp(z(-1)))^iota_w*(pic_star*exp(gamma))^(1-iota_w))^(-1/lambda_w)+(1-zeta_w)*w_p_tilda^(-1/lambda_w))^(-lambda_w);
k_bar=(1-delta)*k_bar(-1)/exp(z)+exp(lmu)*(1-s_bis/2*(exp(z)*i/i(-1)-exp(gamma))^2)*i;
1=exp(lmu)*(1-s_bis/2*(exp(z)*i/i(-1)-exp(gamma))^2-exp(z)*i/i(-1)*s_bis*(exp(z)*i/i(-1)-exp(gamma)))*Q+beta*lambda(+1)/exp(z(+1))/lambda*exp(lmu(+1))*(exp(z(+1))*i(+1)/i)^2*s_bis*(exp(z(+1))*i(+1)/i-exp(gamma))*Q(+1);
//d=Q*k_bar-n;
R_e=(u*r_k-steady_state(r_k)*(u-1)-a_bis/2*(u-1)^2+(1-delta)*Q)*pic/Q(-1);
r_k=steady_state(r_k)+a_bis*(u-1);
//R_e*Q(-1)*k_bar(-1)*(omega*(1-F1)+(1-chi)*F2)=R(-1)*d(-1);
1=beta*lambda(+1)/lambda/exp(z(+1))*R_e(+1)/pic(+1);
//R_e(+1)/R*(1-omega(+1)*(1-F1(+1))-F2(+1))+(1-F1(+1))/(1-F1(+1)-chi*omega(+1)*F1_prim(+1))*(R_e(+1)/R*(omega(+1)*(1-F1(+1))+(1-chi)*F2(+1))-1)=0;
//R_d=omega*R_e*k_bar(-1)/d(-1);
//n=exp(lnu)*(R_e*Q(-1)*k_bar(-1)/exp(z)-(R(-1)+chi*F2*R_e*Q(-1)*k_bar(-1)/d(-1))*d(-1)/exp(z))/pic+we*steady_state(d);
exp(z)*k=u*k_bar(-1);
mc=1/exp(lA)*(w/(1-alpha))^(1-alpha)*(r_k/alpha)^alpha;
p_tilda=(1+exp(llambda_f))*phi_f/psi_f;
phi_f=lambda*mc*y+beta*zeta_p*(pic(+1)/pic^iota_p/pic_star^(1-iota_p))^((1+exp(llambda_f))/exp(llambda_f))*phi_f(+1);
psi_f=lambda*y+beta*zeta_p*(pic(+1)/pic^iota_p/pic_star^(1-iota_p))^(1/exp(llambda_f))*psi_f(+1);
1=zeta_p*(1/pic*pic(-1)^iota_p*pic_star^(1-iota_p))^(-1/exp(llambda_f))+(1-zeta_p)*p_tilda^(-1/exp(llambda_f));
R/steady_state(R)=(R(-1)/steady_state(R))^rho_R*((pic/pic_star)^psi_1*(y/steady_state(y))^psi_2)^(1-rho_R)*exp(eps_R/100);
//1/exp(lg)*y=c+i+(steady_state(r_k)*(u-1)+a_bis/2*(u-1)^2)*k_bar(-1)/exp(z);//+chi*F2*R_e*Q(-1)*k_bar(-1)/exp(z)/pic;
L=((1-alpha)/alpha)^alpha*(r_k/w)^alpha*y/exp(lA)*Delta;
k=(alpha/(1-alpha))^(1-alpha)*(w/r_k)^(1-alpha)*y/exp(lA)*Delta;
Delta=(1-zeta_p)*p_tilda^(-(1+exp(llambda_f))/exp(llambda_f))+zeta_p*(pic(-1)^iota_p*pic_star^(1-iota_p)/pic)^(-(1+exp(llambda_f))/exp(llambda_f))*Delta(-1);
//F1      = normcdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma));
//F2      = normcdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma)-exp(lsigma));
//F1_prim = normpdf((log(omega)+0.5*exp(lsigma)^2)/exp(lsigma))/omega/exp(lsigma);

exp(la)/o_p+beta*(1-delta_o)*lambda(+1)*Q_o(+1)/exp(z(+1))=Q_o*lambda;
c_i+R_i(-1)*d_i(-1)/exp(z)/pic+t_i+Q_o*(o_i-(1-delta_o)*o_i(-1)/exp(z))=w_i*L_i+d_i;
R_i*d_i=exp(lm)*(1-delta_o)*pic(+1)*Q_o(+1)*o_i;
beta_i*lambda_i(+1)/pic(+1)/exp(z(+1))*R_i+theta*R_i=lambda_i;
lambda_i=exp(lb)/(c_i-h*c_i(-1)/exp(z))-beta_i*h*exp(lb(+1))/(exp(z(+1))*c_i(+1)-h*c_i);
exp(la)/o_i+beta_i*(1-delta_o)*Q_o(+1)*lambda_i(+1)/exp(z(+1))+theta*exp(lm)*(1-delta_o)*pic(+1)*Q_o(+1)=Q_o*lambda_i;
o=(1-delta_o)*o(-1)/exp(z)+exp(lmu_o)*(1-s_o_bis/2*(exp(z)*i_o/i_o(-1)-exp(gamma))^2)*i_o;
1=exp(lmu_o)*(1-s_o_bis/2*(exp(z)*i_o/i_o(-1)-exp(gamma))^2-exp(z)*i_o/i_o(-1)*s_o_bis*(exp(z)*i_o/i_o(-1)-exp(gamma)))*Q_o+beta*lambda(+1)/exp(z(+1))/lambda*exp(lmu_o(+1))*(exp(z(+1))*i_o(+1)/i_o)^2*s_o_bis*(exp(z(+1))*i_o(+1)/i_o-exp(gamma))*Q_o(+1);
w_i_tilda^(1+nu_l*(1+lambda_w)/lambda_w)=(1+lambda_w)*phi_w_i/psi_w_i;
phi_w_i=exp(lphi)*w_i^((1+lambda_w)*(1+nu_l)/lambda_w)*L_i^(1+nu_l)+beta_i*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^((1+lambda_w)*(1+nu_l)/lambda_w)*exp(((1+lambda_w)*(1+nu_l)/lambda_w)*z(+1))*phi_w_i(+1);
psi_w_i=lambda_i*w_i^((1+lambda_w)/lambda_w)*L_i+beta_i*zeta_w*(pic(+1)/(pic*exp(z))^iota_w/(pic_star*exp(gamma))^(1-iota_w))^(1/lambda_w)*exp(1/lambda_w*z(+1))*psi_w_i(+1);
w_i=(zeta_w*(w_i(-1)/exp(z)/pic*(pic(-1)*exp(z(-1)))^iota_w*(pic_star*exp(gamma))^(1-iota_w))^(-1/lambda_w)+(1-zeta_w)*w_i_tilda^(-1/lambda_w))^(-lambda_w);
R_i=(1+exp(llambda_d))*R;
L_p=n_p*(w_p/w)^(-(1+lambda_l)/lambda_l)*L;
L_i=(1-n_p)*(w_i/w)^(-(1+lambda_l)/lambda_l)*L;
w=(n_p*(w_p)^(-1/lambda_l)+(1-n_p)*(w_i)^(-1/lambda_l))^(-lambda_l);
o=n_p*o_p+(1-n_p)*o_i;
t_i=tau_i*(1-1/exp(lg))*y;
1/exp(lg)*y=n_p*c+(1-n_p)*c_i+i+i_o+(steady_state(r_k)*(u-1)+a_bis/2*(u-1)^2)*k_bar(-1)/exp(z);//+chi*F2*R_e*Q(-1)*k_bar(-1)/exp(z)/pic;

z=(1-rho_z)*gamma+rho_z*z(-1)+eps_z/100;
lb=rho_b*lb(-1)+eps_b/100;
lphi=(1-rho_phi)*log(phi)+rho_phi*lphi(-1)+eps_phi/100;
lmu=rho_mu*lmu(-1)+eps_mu/100;
llambda_f=(1-rho_lambda_f)*log(lambda_f)+rho_lambda_f*llambda_f(-1)+eps_lambda_f/100;
lg=(1-rho_g)*log(g_star)+rho_g*lg(-1)+eps_g/100;
lA=0; //lA=rho_A*lA(-1)+eps_A/100;
//lsigma=(1-rho_sigma)*log(sigma)+rho_sigma*lsigma(-1)+eps_sigma/100;
//lnu=(1-rho_nu)*log(nu)+rho_nu*lnu(-1)+eps_nu/100;
la=(1-rho_a)*log(a)+rho_a*la(-1)+eps_a/100;
lm=(1-rho_m)*log(m)+rho_m*lm(-1)+eps_m/100;
lmu_o=rho_mu_o*lmu_o(-1)+eps_mu_o/100;
llambda_d=(1-rho_lambda_d)*log(lambda_d)+rho_lambda_d*llambda_d(-1)+eps_lambda_d/100;

dlnY=100*(log(y/y(-1))+z);
dlnC=100*(log(c/c(-1))+z);
dlnI=100*(log((i+i_o)/(i(-1)+i_o(-1)))+z);
lnL=100*log(L)+L_adj;
dlnw=100*(log(w/w(-1))+z);
dlnP=100*log(pic);
FedFunds=400*(R-1);
//dlnD=100*(log(d/d(-1))+z)+D_adj;
//dlnDn=100*(log(d/d(-1))+z+log(pic))+D_adj;
//Spread=400*(R_d-R);
dlnIf=100*(log(i/i(-1))+z);
dlnIo=100*(log(i_o/i_o(-1))+z);
dlnDin=100*(log(d_i/d_i(-1))+z+log(pic))+D_adj;
dlnPo=100*(log(Q_o/Q_o(-1))+log(pic))+Q_o_adj;
Spreadi=400*(R_i-R);
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
//var eps_sigma; stderr 1;
//var eps_nu; stderr 1;
var eps_a; stderr 1;
var eps_m; stderr 1;
var eps_mu_o; stderr 1;
var eps_lambda_d; stderr 1;
end;


estimated_params;
alpha,              beta_pdf,       0.27,   0.05;
zeta_p,             beta_pdf,       0.6,    0.2;
iota_p,             beta_pdf,       0.5,    0.2;
s_bis,              gamma_pdf,      4,      1.5;
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
L_adj,              normal_pdf,     662,    10;//, 650, 670;
//D_adj,              normal_pdf,     0.3,    0.1, 0, 1;
//chi,                beta_pdf,       0.12,   0.01;
//nu,                 beta_pdf,       0.97,   0.001;
//sigma,              gamma_pdf,      0.33,   0.01;
m,                  normal_pdf,     0.85,   0.01;
lambda_d,           gamma_pdf,      0.00625,0.001;
beta_i,             beta_pdf,       0.97,   0.01;
a,                  gamma_pdf,      0.2,    0.01;
n_p,                beta_pdf,       0.2,    0.01;
s_o_bis,              gamma_pdf,      4,      1.5;
D_adj,              normal_pdf,     0.5,    0.1;
Q_o_adj,            normal_pdf,     0.2,    0.1;
rho_z,              beta_pdf,       0.2,    0.1;
rho_phi,            beta_pdf,       0.6,    0.2;
rho_lambda_f,       beta_pdf,       0.6,    0.2;
rho_mu,             beta_pdf,       0.8,    0.05;
rho_b,              beta_pdf,       0.6,    0.2;
rho_g,              beta_pdf,       0.8,    0.05;
//rho_A,              beta_pdf,       0.2,    0.1;
//rho_sigma,          beta_pdf,       0.8,    0.2;
//rho_nu,             beta_pdf,       0.8,    0.2;
rho_a,              beta_pdf,       0.6,    0.2;
rho_m,              beta_pdf,       0.6,    0.2;
rho_mu_o,           beta_pdf,       0.8,    0.05;
rho_lambda_d,       beta_pdf,       0.6,    0.2;
stderr eps_z,       inv_gamma_pdf, 0.5, inf;
stderr eps_phi,     inv_gamma_pdf, 2, inf;
stderr eps_lambda_f,inv_gamma_pdf, 0.5, inf;
stderr eps_mu,      inv_gamma_pdf, 0.5, inf;
stderr eps_b,       inv_gamma_pdf, 0.5, inf;
stderr eps_g,       inv_gamma_pdf, 0.5, inf;
stderr eps_R,       inv_gamma_pdf, 0.25, inf;
//stderr eps_A,       inv_gamma_pdf, 0.5, inf;
//stderr eps_sigma,   inv_gamma_pdf, 0.5, inf;
//stderr eps_nu,      inv_gamma_pdf, 0.5, inf;
stderr eps_a,       inv_gamma_pdf, 0.5, inf;
stderr eps_m,       inv_gamma_pdf, 0.5, inf;
stderr eps_mu_o,    inv_gamma_pdf, 0.5, inf;
stderr eps_lambda_d,inv_gamma_pdf, 0.5, inf;
end;


estimated_params_init;
alpha,              0.2002;
zeta_p,             0.6227;
iota_p,             0.1736;
s_bis,              1.7973;
h,                  0.8022;
a_bis,              0.2294;
nu_l,               4.7154;
zeta_w,             0.3824;
iota_w,             0.0582;
r_star,             1.8258;
psi_1,              1.7017;
psi_2,              0.0114;
rho_R,              0.6796;
pi_star,            1.0645;
gamma_star,         1.3251;
lambda_f,           0.1031;
gg_star,            0.3410;
L_adj,              662.6654;
//chi,                0.12;
//nu,                 0.9779;
//sigma,              0.2847;
m,                  0.8226;
lambda_d,           0.0089;
beta_i,             0.9778;
a,                  0.2002;
n_p,                0.1923;
D_adj,              0.5183;
Q_o_adj,            0.2387;
rho_z,              0.0887;
rho_phi,            0.9989;
rho_lambda_f,       0.8261;
rho_mu,             0.7224;
rho_b,              0.1884;
rho_g,              0.9292;
//rho_A,              0.1;
//rho_sigma,          0.9125;//0.8;
//rho_nu,             0.4349;//0.8;
rho_a,              0.9569;
rho_m,              0.9820;
rho_mu_o,           0.8966;
rho_lambda_d,       0.9398;
stderr eps_z,       0.8836;
stderr eps_phi,     9.8113;
stderr eps_lambda_f,11.3411;
stderr eps_mu,      2.8241;
stderr eps_b,       3.4615;
stderr eps_g,       0.6935;
stderr eps_R,       0.3796;
//stderr eps_A,       ;
//stderr eps_sigma,   9.0206;
//stderr eps_nu,      0.8327;
stderr eps_a,       9.4868;
stderr eps_m,       1.7930;
stderr eps_mu_o,    4.3335;
stderr eps_lambda_d,31.5446;
end;


estimated_params_bounds;
alpha,              0.05,    0.5;
zeta_p,             0,      1;
iota_p,             0,      1;
s_bis,              0,      10;
h,                  0,      1;
a_bis,              0,      10;
nu_l,               0,      10;
zeta_w,             0,      1;
iota_w,             0,      1;
r_star,             0.05,      4;
psi_1,              0,      3;
psi_2,              -0.5,      1;
rho_R,              0,      1;
pi_star,            0,      6;
gamma_star,         0,      4;
lambda_f,           0,      1;
gg_star,            0.01,    0.4;
//chi,                0.05,   0.2;
//nu,                 0.9,    0.99;
//sigma,              0.2,    0.4;
end;


varobs dlnY, dlnC, dlnIf, lnL, dlnw, dlnP, FedFunds, dlnIo, dlnDin, dlnPo, Spreadi;

//load options_dssw_hh;
//options_.nobs      = nobs;
//options_.first_obs = 1;
//options_.dynatol=1.0000e-004;

//for multi-core computers - paralelization setting
//options_.parallel = struct('Local',1, 'ComputerName', 'localhost', 'CPUnbr', [1:4],'SingleCompThread',1,'MatlabOctavePath','matlab', 'DynarePath','D:\Marcin\4.2.4\matlab');
//options_.parallel_info = struct('RemoteTmpFolder','', 'leaveSlaveOpen',0);
//parallel='c1';




estimation(nograph,mode_compute=0,datafile=data,xls_range=A1:O165,nobs=157,plot_priors=0,mode_file=dssw_hh_mode,mode_check,nodiagnostic,mh_replic=1000,mh_nblocks=2,mh_jscale=0.25,mh_drop=0.2,forecast=5) dlnY, dlnP, FedFunds;
//estimation(mode_compute=0,datafile=data,mode_file=dssw_hh_mode,first_obs=1,nobs=152,plot_priors=0,nodiagnostic,mh_replic=125000,mh_nblocks=4,mh_jscale=0.25,mh_drop=0.2) dlnY, dlnC, dlnIf, lnL, dlnw, dlnP, FedFunds, dlnIo, dlnDin, dlnPo, Spreadi;
//stoch_simul(order=1,irf=0) dlnY, dlnC, dlnIf, lnL, dlnw, dlnP, FedFunds, dlnIo, dlnDin, dlnPo, Spreadi;