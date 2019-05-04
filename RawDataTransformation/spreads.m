function S=spreads(A,B,label)
%The function spreads returns in S the spread between variables A and B:
%A-B. 
S(1,:) = {'DATE',label};

l = min(size(A,1),size(B,1));

S(2:l,1) = A(2:l,1);

for vint = 2:size(A,2)
    
    S(1,vint) = {label};
    
    for i = 2:l
        if (cell2mat(A(i,vint))~=-999 && cell2mat(A(i,vint))~=-99 && cell2mat(B(i,vint))~=-999&&cell2mat(B(i,vint))~=-99)
            
            S(i,2) = {(cell2mat(A(i,vint))-cell2mat(B(i,vint)))/4};
            
        else
            
            S(i,2) = {-999};
        end
    end
end
end