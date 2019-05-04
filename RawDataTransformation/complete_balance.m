function A=complete_balance(B)
%complete_balance returns in A a matrix computed from B by making sure
%that vintages and observations are the same as the the reference matrix
%PGNP. The missing values are replaced by -99 or -999
global OBSERVATION FirstObs PGNP Start;

if size(B,2)~=2
    header = B(1,:); header_q = header(1);
    for ii = 2:size(header,2)
        a = header(ii); a = a{1}; a = a(end-3:end);
        header_q = [header_q;a ];
    end
    B = [B(:,1) B(:,find(strcmp(header_q,  Start)):end)];
end

l = find(strcmp(B(2,1), OBSERVATION)==1);

if isempty(l)
    l = 0;
end

m = find(strcmp(PGNP(2,1), OBSERVATION)==1); 

nvint = min(size(PGNP,2),size(B,2));

if m<l
    A = [B(1,1:nvint);[cellstr(OBSERVATION(m:l-1,:)) num2cell(-99*(ones(l-m,nvint-1)))];B(2:end,1:nvint)];
elseif m>l
    A = B(:,1:nvint);
    A = [B(1,1:nvint);A(find(strcmp(A(:,1), FirstObs)==1):end,:)];
else
    A = B;
end
 
if size(A,1)<size(PGNP,1)
    for q = size(A,1)+1:size(PGNP,1)
        A(q,1) = PGNP(q,1);
        for vint = 2:nvint
            A(q,vint) = {-999};
        end
    end
else
    A = A(1:size(PGNP,1),:);
end

end