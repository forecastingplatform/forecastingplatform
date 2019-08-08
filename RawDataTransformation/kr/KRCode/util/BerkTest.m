function res = BerkTest(y)

% Berkowitz test for zN1 = a + bzN1(-1) + ut, ut~N(0,sig^2)
% LRind,  H0: rho = 0 LR~chi2(1)
% LRjoint,H0: a=0, rho=0, sig2=1 LR~chi2(3)

% Steps: 
% 1. estimate AR(1) exact ll :BT.PBFS.LL(1) 
% 2. estimate AR(0) exact ll :BT.PBFS.LL(2) 
% 3. calculates exact ll     :BT.PBFS.LL(3) 
% 4. calculates LRind test and prob:   BT.PBFS.LRind
% 5. calculates LRjoint test and prob: BT.PBFS.LRjoint

T = length(y)-1;

% Estimates AR(1) model
Y  = y(2:end);
X  = y(1:T);
z  = NeweyWestSE(Y,X);
b  = z.b;                       res.b    = b;
Se = z.Se;                      res.Se   = Se;
X = [ones(T,1) X];
sig2 = (Y-X*b)'*(Y-X*b)/(T-0);  res.sig2 = sig2;

LL_full  = LogLik(y, b(1), sig2, b(2));
LL_restr = LogLik(y, 0, 1, 0);

res.BTstat      = -2*(LL_restr - LL_full);
res.BTprob      = 1-chi2cdf(res.BTstat,3);


function ll  = LogLik(y, a, sig2, rho)
% computes exact logLik for AR(1) process 
% y = a + rho y(-1) + ut, ut~N(0,sig2)
T  = length(y)-1;
z  = NaN(1,T);
mu = a/(1-rho);    %unconditional mean
for i=1:T
    z(i) = (y(i+1) - a - rho*y(i))^2/sig2;
end
% see p. 12 of Berkovitz fo unconditional ll
ll = T*log(2*pi) +  log(sig2 / (1-rho^2)) + (T-1)*log(sig2)+ (y(1) - mu)^2/(sig2/(1-rho^2)) + sum(z);
% for conditional ll uncomment here
% ll = (T-1)*log(2*pi) +  (T-1)*log(sig2)+ sum(z);
ll = -ll/2;

