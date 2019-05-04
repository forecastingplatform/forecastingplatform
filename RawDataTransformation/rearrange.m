function MAT = rearrange(datafile,VintName,posrelease)
%The function rearrange is used to read Euro-area data.
%Steps are: 1)read the file datafile.
%           2)use VintName and posrelease to identify releases and generate vintage names
%           3)arrange vintages and observations in the same chronology as those for US data.
%           4)fill-in missing observations 
global PGNP MMBDATA;
DATARAW = read_data(datafile);

a = DATARAW(1,3:end);
 
for i = 1:size(a,2)
    dateDATA{i} = [VintName a{i}(posrelease(1,1):posrelease(1,2))  a{i}(posrelease(2,1):posrelease(2,2))  a{i}(posrelease(3,1):posrelease(3,2))];
end

DATEDATA = {'DATE'};

for i = size(dateDATA,2):-1:1
    DATEDATA = [DATEDATA,dateDATA{i}];
end

DATEDATA = [DATEDATA,dateDATA{i}];

DATA_Raw0 = DATARAW(2:end,:);

DATA_Raw1 = DATA_Raw0(:,1);

for i = size(DATA_Raw0,2):-1:3
    DATA_Raw1 = [DATA_Raw1 DATA_Raw0(:,i)];
end

DATA_Raw1 = [DATA_Raw1 DATA_Raw0(:,2)];

DATA_Raw2 = DATEDATA;

for i = size(DATA_Raw1,1):-1:1
    DATA_Raw2 = [DATA_Raw2; DATA_Raw1(i,:)];
end

EMPTYCELLARRAY(1,:) = DATA_Raw2(1,:);

for vint = 1:size(DATA_Raw2,2)
    for q = 2:size(DATA_Raw2,1)
        if vint == 1
            EMPTYCELLARRAY(q,vint) = DATA_Raw2(q,1);
        else
            EMPTYCELLARRAY(q,vint) = {-999};
        end
    end
end
MAT = EMPTYCELLARRAY;
for q = 2:size(MAT,1)
    for vint = 2:size(MAT,2)
        if iscellstr(DATA_Raw2(q,vint))
            if ~strcmp(cellstr(DATA_Raw2(q,vint)),'')
                if ~strcmp(cellstr(DATA_Raw2(q,vint)),'x')
                    MAT(q,vint) = {str2num(cell2mat(DATA_Raw2(q,vint)))};
                end
            end
        elseif ~isnan(cell2mat(DATA_Raw2(q,vint)))
            MAT(q,vint) = DATA_Raw2(q,vint);
        end
    end
    
end
 