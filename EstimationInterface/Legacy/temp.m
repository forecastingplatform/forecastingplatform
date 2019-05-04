for n = 1:size(b,1)
    if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'RW'))==0)) %%Check if the RW model
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SPF'))==0))~=1
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                % simple RW 97 first model
                RMSE_plot(1,:)=  RMSE(n+1,2:6);
                RMSE_plot(1+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(1,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(1+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(1,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(1+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(1,:) = b(n,:);
            else % Simple RW GLP second
                RMSE_plot(2,:)=  RMSE(n+1,2:6);
                RMSE_plot(2+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(2,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(2+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(2,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(2+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(2,:) = b(n,:);
            end
        else
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                % RW with SPF 3rd
                RMSE_plot(3,:)=  RMSE(n+1,2:6);
                RMSE_plot(3+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(3,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(3+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(3,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(3+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(3,:) = b(n,:);
            else
                %RW GLP SPF 4th
                RMSE_plot(4,:)=  RMSE(n+1,2:6);
                RMSE_plot(4+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(4,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(4+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(4,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(4+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(4,:) = b(n,:);
            end
        end
    elseif  ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SW'))==0)) %%Check if the SW model is taken
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
            %SW 5th
            RMSE_plot(5,:)=  RMSE(n+1,2:6);
            RMSE_plot(5+m+1,:) =  RMSE(n+m+3,2:6);
            NONREC_RMSE_plot(5,:) = NONREC_RMSE(n+1,2:6);
            NONREC_RMSE_plot(5+m+1,:) = NONREC_RMSE(n+3+m,2:6);
            REC_RMSE_plot(5,:) =    NONREC_RMSE(m+n,2:6);
            REC_RMSE_plot(5+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
            L(5,:) = b(n,:);
        else
            %SW GLP 6th
            RMSE_plot(6,:)=  RMSE(n+1,2:6);
            RMSE_plot(6+m+1,:) =  RMSE(n+m+3,2:6);
            NONREC_RMSE_plot(6,:) = NONREC_RMSE(n+1,2:6);
            NONREC_RMSE_plot(6+m+1,:) = NONREC_RMSE(n+3+m,2:6);
            REC_RMSE_plot(6,:) =    NONREC_RMSE(m+n,2:6);
            REC_RMSE_plot(6+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
            L(6,:) = b(n,:);
        end
    elseif   ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'FA'))==0)) %%Check if the SW model is taken
        if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'SP'))==0))~=1
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                %FA 7th
                RMSE_plot(7,:)=  RMSE(n+1,2:6);
                RMSE_plot(7+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(7,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(7+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(7,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(7+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(7,:) = b(n,:);
            else
                %FA GLP 8th
                RMSE_plot(8,:)=  RMSE(n+1,2:6);
                RMSE_plot(8+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(8,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(8+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(8,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(8+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(8,:) = b(n,:);
            end
        else
            if ismember(n,find(cellfun(@isempty,strfind(cellstr(b),'GLP'))==0))~=1
                %FA SP 9th
                RMSE_plot(9,:)=  RMSE(n+1,2:6);
                RMSE_plot(9+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(9,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(9+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(9,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(9+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(9,:) = b(n,:);
            else
                %FA SP GLP 10th
                RMSE_plot(10,:)=  RMSE(n+1,2:6);
                RMSE_plot(10+m+1,:) =  RMSE(n+m+3,2:6);
                NONREC_RMSE_plot(10,:) = NONREC_RMSE(n+1,2:6);
                NONREC_RMSE_plot(10+m+1,:) = NONREC_RMSE(n+3+m,2:6);
                REC_RMSE_plot(10,:) =    NONREC_RMSE(m+n,2:6);
                REC_RMSE_plot(10+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
                L(10,:) = b(n,:);
            end
            
        end
    end
    RMSE_plot(11,:)=  RMSE(n+1,2:6);
    RMSE_plot(11+m+1,:) =  RMSE(n+m+3,2:6);
    NONREC_RMSE_plot(11,:) = NONREC_RMSE(n+1,2:6);
    NONREC_RMSE_plot(11+m+1,:) = NONREC_RMSE(n+3+m,2:6);
    REC_RMSE_plot(11,:) =    NONREC_RMSE(m+n,2:6);
    REC_RMSE_plot(11+m+1,:) =    NONREC_RMSE(m+3+n,2:6);
    L(11,:) = b(n,:);
end
