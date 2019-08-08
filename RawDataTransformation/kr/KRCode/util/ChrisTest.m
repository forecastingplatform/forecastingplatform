function z = ChrisTest(I, p)
% Christofersen test
% I - series of hits
% p - confidence interval (from 0 to 100)
%
% z - field with the value of 3 tests with probability

T   = length(I);

% LR test of Unconsitional coverage
q           = mean(I);
p           = p/100;

n1          = sum(I);
n0          = T - n1;
Lp          = (1-p)^n0*p^n1;
Lq          = (1-q)^n0*q^n1; 
z.LRucStat  = -2*log(Lp/Lq);
z.LRucProb  = 1 - chi2cdf(z.LRucStat,1);

n00 = 0; n01 = 0; n10 = 0; n11 = 0;

for t=2:T
    if     (I(t-1)==0 && I(t)==0) n00=n00+1; 
    elseif (I(t-1)==0 && I(t)==1) n01=n01+1;
    elseif (I(t-1)==1 && I(t)==0) n10=n10+1;
    elseif (I(t-1)==1 && I(t)==1) n11=n11+1;
    end
end

if (n00 + n01) == 0     p01 = 0;
else                    p01 = n01 / (n00 + n01);
end

if (n10 + n11) == 0     p11 = 0;
else                    p11 = n11 / (n10 + n11);
end

Lpi1   = (1- p01)^n00*p01^n01 * (1-p11)^n10*p11^n11;
p2     = (n01 + n11) / (n00 + n01 + n10 + n11);
Lpi2   = (1-p2)^(n00+n10)*p2^(n01+n11);
z.LRindStat    = -2*log(Lpi2/Lpi1);
z.LRindProb    = 1 - chi2cdf(z.LRindStat,1);

% Joint test
z.LRccStat    = -2*log(Lp/Lpi1);
z.LRccProb    = 1 - chi2cdf(z.LRccStat,2);

