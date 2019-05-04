function list = get_missing_var(missing)

global basics;

missinglist = [];

b = find(missing == 1);
for i = 1:size(b,2)
    if i == 1
        missinglist = [missinglist cell2mat(basics.observables{b(i)})];
    else
        missinglist = [missinglist ', ' cell2mat(basics.observables{b(i)})];
    end
end
list = cellstr(missinglist);
end