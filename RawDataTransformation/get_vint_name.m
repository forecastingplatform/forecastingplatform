function namevint = get_vint_name(a)
%returns a vintage name using a
m = size(a,2)-3;

dataname = 'usspf'; m = size(a,2)-3;

switch a(m)
    case '6'
        namevint = [dataname '196' a(m+1) a(end)];
    case '7'
        namevint = [dataname '197' a(m+1) a(end)];
    case '8'
        namevint = [dataname '198' a(m+1) a(end)];
    case '9'
        namevint = [dataname '199' a(m+1) a(end)];
    case '0'
        namevint = [dataname '200' a(m+1) a(end)];
    case '1'
        namevint = [dataname '201' a(m+1) a(end)];
end
end