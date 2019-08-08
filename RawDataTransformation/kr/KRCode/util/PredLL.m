function x  = PredLL(z, y)

% Calculates predictive Likelihood for univariate variables with Adolfson
% et al...
% z - empirical distribution for z (in our case draws, can be multivariate)
% y = realized observation
% PredLL - probability distribution function

%mu    = mean(z);
%Sigma = std(z);
%x = 1/Sigma * (2*pi)^(-0.5) * exp(-0.5 * (y-mu)^2 / Sigma^2);

mu    = mean(z)';
Sigma = cov(z);
k = size(y,1);

%x = mvnpdf(z,mu,Sigma); 
x = (2*pi)^(-k/2) * det(Sigma)^(-0.5) * exp(-0.5 * (y-mu)' * Sigma^(-1) * (y-mu));