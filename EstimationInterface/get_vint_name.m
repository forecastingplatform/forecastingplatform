function vintangename=get_vint_name(a)

global basics

if strcmp(basics.DataArea,'..\DATA\USDATA') 
             zone = 'us';
elseif strcmp(basics.DataArea,'..\DATA\EADATA') 
             zone = 'ea';
end

m = size(a,2)-3;

switch a(m)
    case '6'
        vintangename = [zone '196' a(m+1) a(end)];
    case '7'
        vintangename = [zone '197' a(m+1) a(end)];
    case '8'
        vintangename = [zone '198' a(m+1) a(end)];
    case '9'
        vintangename = [zone '199' a(m+1) a(end)];
    case '0'
        vintangename = [zone '200' a(m+1) a(end)];
    case '1'
        vintangename = [zone '201' a(m+1) a(end)];
end
end