function F = solve_k_di(x,r_k,w,R,gamma_star,delta,alpha,lambda_d,delta_o,pic_star,a,beta_i,gamma,m, ...
    lambda_w,phi,nu_l,n_p,lambda_l,g_star,beta,h,tau_i,chi,F2,R_e)

k   = x(1);
d_i = x(2);
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

F = [c_i+(R_i/exp(gamma)/pic_star-1)*d_i+t_i+o_i*(1-(1-delta_o)/exp(gamma))-w_i*L_i;
     1/g_star*y-n_p*c-(1-n_p)*c_i-i-i_o-chi*F2*R_e*k/pic_star];

 