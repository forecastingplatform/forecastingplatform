function A = real_growth(B,C)
global MMBDATA
% The function real_growth returns in A the real growth rate of the variable B deflated by the variable C 
l0 = min(size(B,2),size(C,2)); m = min(size(B,1),size(C,1));
for vint = 2:l0
    for q = 3:m
        if (cell2mat(B(q,vint))~=-999)&&(cell2mat(C(q,vint))~=-999)&&(cell2mat(B(q-1,vint))~=-999)&&(cell2mat(C(q-1,vint))~=-999)&&...
                (cell2mat(B(q,vint))~=-99 )&&(cell2mat(C(q,vint))~=-99 )&&(cell2mat(B(q-1,vint))~=-99 )&&(cell2mat(C(q-1,vint))~=-99)
            
            A(q-1,vint) = {(log(cell2mat(B(q,vint))/cell2mat(C(q,vint)))-log(cell2mat(B(q-1,vint))/cell2mat(C(q-1,vint))))*100};
            
        else
            A(q-1,vint) = {-999};
        end
    end
end
A(1,:) = B(1,1:l0);
A(:,1) = B([1 3:m],1);
A = complete_missing(A); 
end