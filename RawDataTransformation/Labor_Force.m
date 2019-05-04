B=format_variables('\EARawData\Labor_Force', 'Labor_Force',1,3,2, [1 4;0 0], [],3); 
C = B;
B = B(:,1);

for vint = 2:size(PGNP,2) %This loop just duplicate the time series as many as we have vintages
    a = PGNP(1,vint);
    a = a{1};
    B = [B [['Labor_Force' a(2:end)];C(2:end,2)]];
end

A=complete_missing([B(1,:);B(3:end,:)]); % Eliminate the first observation because other variables start one observation later
 
MMBDATA.LaborForce=A;