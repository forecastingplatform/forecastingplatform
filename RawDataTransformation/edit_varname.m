function edit_varname(List_Observables,variable,variables_a,Observables)
cd1 = cd;
cd('..\EstimationInterface\')
[~,~,M]=xlsread(List_Observables,1);
if isempty(find(strcmp(M(:,2),variable)==1))
    A_1=[num2str(cell2mat(M(end,1))+1),variable{:},Observables{:}];
    M=[M;A_1];
    xlswrite(List_Observables,M,1) 
end
[~,~,M]=xlsread(List_Observables,2);
if isempty(find(strcmp(M(:,2),variables_a)==1))
    A_1=[num2str(cell2mat(M(end,1))+1),variables_a{:},Observables{:}];
    M=[M;A_1];
    xlswrite(List_Observables,M,2)
end
cd(cd1)