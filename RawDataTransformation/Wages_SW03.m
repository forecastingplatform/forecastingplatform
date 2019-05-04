B=format_variables('\EARawData\WAGE', 'WDS',1,3,2, [1 4;0 0], [],3); 
C = B;
B = B(:,1);

for vint = 2:size(PGNP,2) %This loop just duplicate the time series as many as we have vintages
    a = PGNP(1,vint);
    a = a{1};
    B = [B [['WDS' a(2:end)];C(2:end,2)]];
end
 
A=complete_missing(B); % Eliminate the first observation because other variables start one observation later
 