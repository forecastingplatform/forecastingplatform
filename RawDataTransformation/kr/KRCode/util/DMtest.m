function res  = DMtest(f0, f1, a, opt)

% f0, f1 - forecasts from M0,M1
% act    - actuals  
% one sided test
% H0: M0 is true (for Clark-West)
% H0: e0^2 = e1^2
% H1: e0^2 > e1$2
% opt = "CW" for Clark-West test, and DM test otherwise

T   = length(a);
e0  = a - f0;
e1  = a - f1;
d   = e0.^2 - e1.^2;
if opt == 'CW'
    adj = (f1 - f0).^2;
    d   = d + adj;
end
temp     = NeweyWestSE(d);
res.stat = temp.tstat;
res.prob = temp.prob; %/2; % one sided test
%{
dbar    = mean(d);
lambda  = ACF(d,0);
w       = 1;

for i = 1:h-1
    if opt2 == 'NW'
        w = 1 - (i/h);
    end
    lambda = lambda + 2*w*ACF(d,i);
end
stat    = abs(dbar / sqrt(lambda/T));
prob    = 2*(1 - normcdf(stat));
% HLN small sample correction
if opt1 == 'CW'
    res.stat = sqrt(T^(-1) * ( T+1-2*h + T^(-1)*h*(h-1) ) )*stat;
    res.prob = 2*(1 - tcdf(stat, T-1));
end

temp      = NeweyWestSE(x);


% Autocorrelation
function z  = ACF(y, k)

T = length(y);
yhat    = mean(y);
yk      = y(k+1:T);
y0      = y(1:T-k);
z       = 1/T * (yk-yhat)'*(y0-yhat);
%}
