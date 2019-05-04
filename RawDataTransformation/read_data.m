function A = read_data(filename)
% read_data reads all the Excel sheets in the Excel file filename. It assumes that time series have the same starting point. Sheets
% are then concatenated in the reading order and the missing entries of the matrix are fill in by -999   
[~,sheets] = xlsfinfo(filename);

[~,~,A] = xlsread(filename, size(sheets,2));

B = [];

for i = 1:size(sheets,2)
    
    [~,~,M] = xlsread(filename, i);
    
    if size(A,1)<size(M,1)
        for q = size(A,1)+1:size(M,1)
            A(q,1) = M(q,1);
        end
    elseif size(A,1)>size(M,1)
        for q = size(M,1)+1:size(A,1)
            M(q,1) = A(q,1);
        end
    end
    s = 1+(i~=1);
    B = [B M(:,s:end)];
end

A = B;

A(1,1) = {'DATE'};

for vint = 2:size(A,2)
    for q = 2:size(A,1)
        if ~strcmp('double', class(cell2mat(A(q,vint))))
            A(q,vint) = {-999};
        end
    end
end
end