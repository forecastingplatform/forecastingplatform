function f = solve_k(k,g_star,alpha,gamma,beta,delta,h,chi,lambda_w,phi,nu_l,r_k,w,F2,R_e,pic_star)

f = 1/g_star*((1-alpha)/alpha*r_k/w)^(1-alpha)*k-w*(exp(gamma)-beta*h)/((1+lambda_w)*phi*((1-alpha)/alpha*r_k*k/w)^nu_l*(exp(gamma)-h))-(exp(gamma)-1+delta)*k-chi*F2*R_e*k/pic_star ;
 