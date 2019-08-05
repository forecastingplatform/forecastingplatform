function result = NeweyWestSE(y, x)
% Returns reg stats with NW standard errors

T = size(y,1); 

if nargin == 1
    X = ones(T,1);
else
    X = [ones(T,1) x]; 
end
k = size(X,2);

% calculate stats
b     = inv(X'*X)*X'*y;
yhat  = X * b;
e     = y - yhat;
R2    = var(yhat)/var(y); result.R2 = R2;

% calculation of robust standard errors

nlags  = floor(4*(T/100)^(2/9));    % Newey-West bandwidth
u     = repmat(e,1,k).*X;           
Sig = zeros(k,k);                   % Inicialization of covariance matrix
  
for ii = 0:nlags
    w = 1 - (ii/(nlags+1));
    rho = u(1:T-ii,:)'*u(1+ii:T,:)/(T-k);  
    if ii >= 1, rho = rho + rho'; end
    Sig = Sig + w*rho;  
end
V             = inv(X'*X)*T*Sig*inv(X'*X);

result.b      = b;
Se            = sqrt(diag(V));           result.Se    = Se;
tstat         = abs(b./Se);              result.tstat = tstat;
prob          = 2*(1-tcdf(tstat,T-k));   result.prob  = prob;

% Eficiency test restictions
if (nargin == 2 && k == 2)
    chi2stat   = (b - [0;1])'*inv(V)*(b - [0;1]); result.chi2ET   = chi2stat;
    probET     = 1 - chi2cdf(chi2stat,2);         result.probET   = probET;
end
  
  
