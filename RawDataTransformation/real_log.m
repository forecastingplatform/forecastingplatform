function A = real_log(B,C,trend, transformation)
% The function real_growth returns in A the real growth rate of the variable B deflated by the variable C
global MMBDATA
save MMBDATA 
B=[B(1,:);B(3:end,:)];C=[C(1,:);C(3:end,:)];
% [B(2,1) B(end,1);C(2,1) C(end,1);MMBDATA.LaborForce(2,1) MMBDATA.LaborForce(end,1)]
% The function real_growth returns in A the real growth rate of the variable B deflated by the variable C
l0 = min(size(B,2),size(C,2)); m = min(size(B,1),size(C,1));
if MMBDATA.percapita==0
    for vint = 2:l0
        for q = 2:m
            if (cell2mat(B(q,vint))~=-999)&&(cell2mat(C(q,vint))~=-999)&&(cell2mat(B(q,vint))~=-99)&&(cell2mat(C(q,vint))~=-99)
                A(q,vint) = {log(cell2mat(B(q,vint))/cell2mat(C(q,vint)))};
            else
                A(q,vint) = {-999};
            end
        end
    end
    
    A(1,:) = B(1,1:l0);
    A(:,1) = B(:,1);
    if transformation~=9
        A=remove_trend(A,trend);
    end
    A = complete_missing(A);
elseif MMBDATA.percapita==1
    MMBDATA.scale
    if MMBDATA.EONIA~=1 
        for vint = 2:l0
            for q = 2:m
               if (cell2mat(B(q,vint))~=-999)&&(cell2mat(C(q,vint))~=-999)&&(cell2mat(MMBDATA.LaborForce(q,vint))~=-999)&&...
                        (cell2mat(B(q,vint))~=-99 )&&(cell2mat(C(q,vint))~=-99 )&&(cell2mat(MMBDATA.LaborForce(q,vint))~=-99) 
                    if MMBDATA.wages==0
                    A(q,vint) = {log(cell2mat(B(q,vint))*MMBDATA.scale/(cell2mat(C(q,vint))*cell2mat(MMBDATA.LaborForce(q,vint))))*100};
                    elseif MMBDATA.wages==1
                    A(q,vint) = {log(cell2mat(B(q,vint))*MMBDATA.scale/(cell2mat(C(q,vint))))*100};
                        end
                else
                    A(q,vint) = {-999};
                end
            end
        end 
        A(1,:) = B(1,1:l0);
        A(:,1) = B([1:m],1);
        A = complete_missing(A);         
        A = detrend_series(A);
    else 
        B = complete_missing(B);
        [~,A] = detrend_series(B);
    end
end

end


