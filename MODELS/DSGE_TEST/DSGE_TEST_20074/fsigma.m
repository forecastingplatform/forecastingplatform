function F = fsigma(F_bar, s, para_sp_b, sigmav)

z_bar = norminv(F_bar,0,1);
omega_bar = exp(sigmav*z_bar - 0.5*sigmav^2);
G_bar = normcdf(z_bar-sigmav,0,1);
Gamma_bar = omega_bar * (1- F_bar) + G_bar;
fp_bar = normpdf(z_bar,0,1);
muv = (1-1/s)/(G_bar + (1-Gamma_bar)*(fp_bar/sigmav)/(1-F_bar));
KN = 1/(1- (omega_bar*(1-F_bar) + (1-muv)*G_bar)*s);
para_b_omg = (muv/KN*omega_bar)*(-(fp_bar)^2 + z_bar*fp_bar*(1-F_bar))/...
            (omega_bar*sigmav^2*s * (1-F_bar - muv/sigmav*fp_bar)^2 *... 
            (1- Gamma_bar + (1-F_bar)*(Gamma_bar - muv*G_bar)/(1-F_bar - muv/sigmav*fp_bar)));
para_z_omg = (1-F_bar - muv/sigmav*fp_bar)/(Gamma_bar - muv*G_bar)*omega_bar;
F = para_sp_b + (para_b_omg/para_z_omg)/(1 - para_b_omg/para_z_omg)*(KN -1)^(-1);