function [first, last]=get_first_last_obs(A)
% from an array A, returns the first and last the first and the last non-missing observations. If there is no such ones, the corresponding output is set to zero.  
first=[]; f=0; last=[]; l=size(A,1)+1;

for i=1:size(A,1)
    if (isempty(A(i))||isnan(A(i))||(A(i)==-99)||(A(i)==-999)||strcmp('char',class(A(i))))
        if isempty(first)
            f = i;
        end
    else
        first = f;
    end
end

if isempty(first)
    first = 0;
end

for i = size(A,1):-1:1
    if (isempty(A(i))||isnan(A(i))||(A(i)==-99)||(A(i)==-999)||strcmp('char',class(A(i))))
        if isempty(last)
            l = i;
        end
    else
        last = l;
    end
end
if isempty(last)
    last = 0;
end
end