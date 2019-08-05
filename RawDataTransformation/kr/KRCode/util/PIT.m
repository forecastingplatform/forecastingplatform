function pit  = PIT(z, y)

% Calculates probability integral transform 
% z - empirical distribution for z (in our case draws)
% y = realized observation
% pit - probability distribution function

pit = sum(y>z)/ length(z);

