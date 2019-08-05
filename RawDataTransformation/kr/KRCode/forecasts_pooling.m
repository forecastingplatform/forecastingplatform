clear
load('ALLfct.mat');

modelNames  = [{'noff'} {'ff'} {'hh'}];
varNames    = fieldnames(ALLfct{1}); 
MvarNames   = [{'v3'} {'v7'}];
poolNames   = [{'p110'} {'p101'} {'p011'} {'p111'}];
statNames   = [{'fct'} {'act'} {'pLL'} {'pit'} {'fctStd'}];

M        = 3;
N        = size(varNames,1);   % number of variables
K        = 5;                  % number of pools

for n=1:N
    vnm     = varNames{n};
    for k=1:K
        snm = statNames{k};
        eval(['ALLfct{M+1}.',vnm,'.',snm,'= 0.5*ALLfct{1}.',vnm,'.',snm,'+0.5*ALLfct{2}.',vnm,'.',snm,';'])
        eval(['ALLfct{M+2}.',vnm,'.',snm,'= 0.5*ALLfct{1}.',vnm,'.',snm,'+0.5*ALLfct{3}.',vnm,'.',snm,';'])
        eval(['ALLfct{M+3}.',vnm,'.',snm,'= 0.5*ALLfct{2}.',vnm,'.',snm,'+0.5*ALLfct{3}.',vnm,'.',snm,';'])
        eval(['ALLfct{M+4}.',vnm,'.',snm,'= 1/3*ALLfct{1}.',vnm,'.',snm,'+1/3*ALLfct{2}.',vnm,'.',snm,'+1/3*ALLfct{3}.',vnm,'.',snm,';'])
    end
end
   
for n=1:2
    vnm     = MvarNames{n};
    for k=1:K-2
        snm = statNames{k};
        eval(['MULTIfct{M+1}.',vnm,'.',snm,'= 0.5*MULTIfct{1}.',vnm,'.',snm,'+0.5*MULTIfct{2}.',vnm,'.',snm,';'])
        eval(['MULTIfct{M+2}.',vnm,'.',snm,'= 0.5*MULTIfct{1}.',vnm,'.',snm,'+0.5*MULTIfct{3}.',vnm,'.',snm,';'])
        eval(['MULTIfct{M+3}.',vnm,'.',snm,'= 0.5*MULTIfct{2}.',vnm,'.',snm,'+0.5*MULTIfct{3}.',vnm,'.',snm,';'])
        eval(['MULTIfct{M+4}.',vnm,'.',snm,'= 1/3*MULTIfct{1}.',vnm,'.',snm,'+1/3*MULTIfct{2}.',vnm,'.',snm,'+1/3*MULTIfct{3}.',vnm,'.',snm,';'])
    end
end

modelNames  = [modelNames poolNames];

save('ALLfct.mat', 'ALLfct', 'MULTIfct', 'modelNames');  