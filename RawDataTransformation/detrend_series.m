function [A,Rate]=detrend_series(Series_PER_CAPITA)
global PGNP MMBDATA
MATINF=MMBDATA.MATINF;
m = size(Series_PER_CAPITA,1);
if size(MATINF)~=size(Series_PER_CAPITA)
    Series_PER_CAPITA=Series_PER_CAPITA([1 3:m],:);
end
Series_OBS = Series_PER_CAPITA;
Rate       = Series_PER_CAPITA;

for vint = 2:size(Series_PER_CAPITA,2)%Extract the trend in Series per capita
    
    if ~isempty(find(cell2mat(Series_PER_CAPITA(2:end,vint))~=-99))
        
        v = find(cell2mat(Series_PER_CAPITA(2:end,vint))~=-99);
        
        w = Series_PER_CAPITA(2:end,vint);
        
        if~isempty(find(cell2mat(w(v))~=-999))
            
            f_obs1 = find(cell2mat(Series_PER_CAPITA(2:end,vint))==-99,1,'last')+ 2;
            
            l1 = find(cell2mat(Series_PER_CAPITA(2:end,vint))~=-999,1,'last')+1;
            if isempty(l1)
                l1 = size(Series_PER_CAPITA,1);
            end
            
            if isempty(f_obs1)
                f_obs1 = 2;
            end
            if MMBDATA.EONIA==1
                f_obs2 = find(cell2mat(MATINF(2:end,vint))==-99,1,'last')+ 2;
                
                l2 = find(cell2mat(MATINF(2:end,vint))~=-999,1,'last')+1;
                if isempty(l2)
                    l2 = size(Series_PER_CAPITA,1);
                end
                
                if isempty(f_obs2)
                    f_obs2 = 2;
                end
                f_obs=max(f_obs1,f_obs2);
                l=min(l1,l2);
            else
                f_obs=f_obs1;
                l=l1;
            end
            
            S = cell2mat(Series_PER_CAPITA(f_obs:l,vint));
            Inflation = cell2mat(MATINF(f_obs:l,vint));
            Detrend = detrend(S); 
            Detrend_Inf = detrend(Inflation); 
            Trend_Inf   = Inflation  - Detrend_Inf;
            S = S - Trend_Inf;
            for j = 1:size(S,1)
                Series_OBS(f_obs+j-1,vint) = mat2cell(Detrend(j));
                Rate(f_obs+j-1,vint) = mat2cell(S(j)-mean(S));
            end
        end
    end
end 
A = Series_OBS;
