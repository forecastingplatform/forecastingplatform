 function A=remove_trend(B,lambda) 
    
    C = B;
    
    for vint = 2:size(B,2)%Extract the trend in hours per capita
        
        if ~isempty(find(cell2mat(B(2:end,vint))~=-99))
            
            v = find(cell2mat(B(2:end,vint))~=-99);
            
            w = B(2:end,vint);
            
            if~isempty(find(cell2mat(w(v))~=-999))
                
                f_obs = find(cell2mat(B(2:end,vint))==-99,1,'last')+ 2;
                
                l = find(cell2mat(B(2:end,vint))~=-999,1,'last')+1;
                
                if isempty(l)
                    l = size(B,1);
                end
                
                if isempty(f_obs)
                    f_obs = 2;
                end
                
                S = cell2mat(B(f_obs:l,vint));
                
                Trend = hpfilter(S,lambda);
                
                for j = 1:size(S,1)
                    C(f_obs+j-1,vint) = mat2cell(Trend(j));
                end
            end
        end
    end     
    A=B;
    
    for vint = 2:size(C,2) %Compute the detrended series.
        for j = 2:size(C,1)
            if (cell2mat(C(j,vint))~=-999)&&(cell2mat(C(j,vint))~=-99)&&...
                    (cell2mat(B(j,vint))~=-999)&&(cell2mat(B(j,vint))~=-99) 
                A(j,vint) = {cell2mat(B(j,vint))-cell2mat(C(j,vint))};
            end
        end
    end 
 end
 