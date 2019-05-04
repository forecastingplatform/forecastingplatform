function A=complete_missing(A,varargin)
%complete_missing fills in the missing entries in matrix A. varargin is
%assigns when the function is called in the series extended by the SPF now
%casts.
global OBSERVATION VINTAGES
 
for vint = 2:size(A,2)
    for i=2:size(A,1)
        if strcmp('char',class(cell2mat(A(i,vint))))
            A(i,vint)={-999};
        end
    end  
    [first, last] = get_first_last_obs(cell2mat(A(2:end,vint)));     
    if first == last
        a = cellstr(A(1,vint)); a = a{1}; m = size(a,2)-3;
        l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1);
        l0= find(strcmp(OBSERVATION(l,:),A(:,1))==1)+length(varargin)*(size(varargin,1)-1);  
        if isempty(l0)
            l = size(A(:,vint),1)+length(varargin)*(size(varargin,1)-1);
        else
            l = l0;
        end
        
        for j = 2:(l-1+isempty(l0))
            A(j,vint) = {-99};
        end
        
        if ~isempty(l0)
             for j = l0:size(A(:,vint),1)+length(varargin)*(size(varargin,1)-1)
                A(j,vint) = {-999};
            end
        end
    else        
        if first~=0
            for j = 2:first+1
                A(j,vint) = {-99};
            end
        end
        if last<size(A,1) 
            for j = last+1:size(A,1)
                A(j,vint) = {-999};
            end
        else
            
        end
    end
end
end