function rev=get_revised(DATA,n, pos,qh)

a = cellstr(DATA{n}(pos,1)); a = a{1}; m = size(a,2)-4;

rev_vint = find(strcmp(cellstr(DATA{1}(1,:)),{['ROUTPUT'  a(m:m+1) a(end-1:end)]})==1);

if ~isempty(rev_vint)
    try
        rev = DATA{n}(pos,rev_vint+qh);
    catch
        rev = {-999};
    end
else
    rev = {-999};
end
end