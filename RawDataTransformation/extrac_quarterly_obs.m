function R=extrac_quarterly_obs(A)
%extrac_quarterly_obs returns in R a matrix of quarterly observations computed from the matrix of monthly obs A. 
%The function assumes that the first obs in A corresponds to that of first
%month of the quarter.
R(1,:) = A(1,:);
for vint = 2:size(R,2)    
    try
        l = max(find(cell2mat(A(2:end,vint))~=-999));
        nq = (l-mod(l,3))/3;
        for j = 1:nq
            if isempty(find(isnan(cell2mat(A(j*3-1:j*3+1,vint)) == 1)))&& isempty(find(cell2mat(A(j*3-1:j*3+1,vint))<0))
                if vint == size(R,2)
                    R(j+1,1) = A(3*j,1);
                    R(j+1,vint) = {mean(cell2mat(A(j*3-1:j*3+1,vint)))};
                else
                    R(j+1,vint) = {mean(cell2mat(A(j*3-1:j*3+1,vint)))};
                end
            end
        end
    catch
        l = size(A,1);
        nq = (l-mod(l,3))/3;
        for j = 1:nq
            if (3*j+1) <= l
                if vint == size(R,2)
                    
                    R(j+1,1) = A(3*j,1);
                    
                    R(j+1,vint) = {(str2num(cell2mat(A(j*3-1,vint)))+str2num(cell2mat(A(j*3,vint)))+str2num(cell2mat(A(j*3+1,vint))))/3};
                else
                    
                    R(j+1,vint) = {(str2num(cell2mat(A(j*3-1,vint)))+str2num(cell2mat(A(j*3,vint)))+str2num(cell2mat(A(j*3+1,vint))))/3};
                end
            end
        end
    end
end
end