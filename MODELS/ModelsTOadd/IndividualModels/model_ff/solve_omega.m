function f = solve_omega(omega,beta,sigma,nu,chi,we)

F1      = normcdf((log(omega)+0.5*sigma^2)/sigma);
F2      = normcdf((log(omega)+0.5*sigma^2)/sigma-sigma);
F1_prim = normpdf((log(omega)+0.5*sigma^2)/sigma)/omega/sigma;

f = (1-omega*(1-F1)-F2)-(1-F1)/(1-F1-chi*omega*F1_prim)*(nu/beta*(1-omega*(1-F1)-F2)+we*(omega*(1-F1)+(1-chi)*F2));
 