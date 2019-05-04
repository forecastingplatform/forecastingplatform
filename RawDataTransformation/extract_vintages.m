function MAT_Q = extract_vintages(MAT,VintName,posyear,posmonth,posday)
%extract_vintages takes a matrix data MAT, a label VintName, and
%information on years, months and days of releases and extract the real time vintages. 
%The match between the vintage retained for each quarter and the release is 
%saved in the folder GeneralReports. 
%The vintage format in the matrix MAT_Q is VintNameQN
global VINTAGES Start zone;
if max(size(posmonth)) == 1
    
    MAT_Q = [MAT(:,1) MAT(:,3:3:end)];    MAT_Q1=MAT_Q;
    
    a = cellstr(MAT_Q(1,2)); a = a{1};
    
    FirstVint = [a(posyear) 'Q1'];
    
    for vint = 2:size(MAT_Q,2)
        MAT_Q(1,vint) = {[VintName VINTAGES(strmatch(FirstVint,VINTAGES)+vint-2,:)]};
    end
    cd1 = cd;
    if ~strcmp(zone,'us')
        cd('..\DATA\EADATA\GeneralReports\')
    else
        cd('..\DATA\USDATA\GeneralReports\')
    end
    
    location1 = [cd '\'];
    
    cd(cd1)
    
    xlswrite([location1 'vintage_used'],[MAT_Q(1,2:end)'  MAT_Q1(1,2:end)'],VintName);
    
    pos_start=strmatch(Start,VINTAGES);
    
    a = cellstr(MAT_Q(1,2)); a = a{1}; m = size(a,2);
    
    pos_f = strmatch(a(m-3:end),VINTAGES);
    
    if pos_start < pos_f
        
        MissingVint = MAT_Q(:,1);
        
        for vint = pos_start:pos_f-1
            s = size(MAT_Q,1)-1;
            a = [{[VintName VINTAGES(vint,:)]};num2cell(-999*(ones(s,1)))];
            MissingVint = [MissingVint a];
        end
        
        MAT_Q = [MissingVint MAT_Q(:,2:end)];
    end
else
    MAT1 = MAT;
    for q=2:size(MAT,2);
        b=cellstr(MAT(1,q));
        b=b{1}; 
        switch b(posmonth)
            case '01'
                vintage_name = [VintName num2str(b(posyear)) 'Q1'];
            case '02'
                if str2num(b(posday))<=15
                    vintage_name = [VintName num2str(b(posyear)) 'Q1'];
                else
                    vintage_name = [VintName num2str(b(posyear)) 'Q2'];
                end
            case '03'
                vintage_name = [VintName num2str(b(posyear)) 'Q2'];
            case '04'
                vintage_name = [VintName num2str(b(posyear)) 'Q2'];
            case '05'
                if str2num(b(posday))<=15
                    vintage_name = [VintName num2str(b(posyear)) 'Q2'];
                else
                    vintage_name = [VintName num2str(b(posyear)) 'Q3'];
                end
            case '06'
                vintage_name = [VintName num2str(b(posyear)) 'Q3'];
            case '07'
                vintage_name = [VintName num2str(b(posyear)) 'Q3'];
            case '08'
                if str2num(b(posday))<=15
                    vintage_name = [VintName num2str(b(posyear)) 'Q3'];
                else
                    vintage_name = [VintName num2str(b(posyear)) 'Q4'];
                end
            case '09'
                vintage_name = [VintName num2str(b(posyear)) 'Q4'];
            case '10'
                vintage_name = [VintName num2str(b(posyear)) 'Q4'];
            case '11'
                if str2num(b(posday))<=15
                    vintage_name = [VintName num2str(b(posyear)) 'Q4'];
                else
                    vintage_name = [VintName num2str(str2num(b(posyear))+1) 'Q1'];
                end
            case '12'
                vintage_name = [VintName num2str(str2num(b(posyear))+1) 'Q1'];
        end
        m=size(vintage_name,2);
        MAT(1,q) = {vintage_name([1:m-6 m-3:m])};
    end
    
    a = cellstr(MAT(1,2)); a = a{1};
    
    m = size(a,2)-3;  
    pos_f = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1);
    
    b = cellstr(MAT(1,size(MAT,2))); b = b{1}; pos_l=find(strcmp(VINTAGES,{[b(m:m+1) 'Q' b(end)]})==1);
     
    q = 2; 
    
    vintage_used = 0; 
    
    for vint = pos_f:pos_l 
        PosVint = strmatch([VintName VINTAGES(vint,:)] , MAT(1,:));
        if ~isempty(PosVint)
            vintage_used(q) = max(PosVint);
        else
            vintage_used(q) = vintage_used(q-1);
        end
        q = q+1;
    end
    
    MAT_Q = [MAT(:,1)  MAT(:,vintage_used(2:end))];
    
    q = pos_f;
    
    for vint = 2:size(MAT_Q,2) 
        
        MAT_Q(1,vint) = {[VintName VINTAGES(q,:)]}; 
        
        q=q+1;
    end
    
    cd1 = cd;
    
    if ~strcmp(zone,'us')
        cd('..\DATA\EADATA\GeneralReports\')
    else
        cd('..\DATA\USDATA\GeneralReports\')
    end
    
    location1 = [cd '\'];
    
    cd(cd1)
    
    xlswrite([location1 'vintage_used'],[MAT(1,vintage_used(2:end))'  MAT1(1,vintage_used(2:end))'],VintName);
    
    for vint = 2:size(MAT_Q,2)
        a = cellstr(MAT_Q(1,vint)); a = a{1}; m = size(a,2);
        MAT_Q(1,vint) = {[VintName a(m-3:end)]};
    end
    
    pos_start = strmatch(Start,VINTAGES);
    
    a = cellstr(MAT_Q(1,2)); a = a{1}; m = size(a,2);
    
    pos_f = strmatch(a(m-3:end),VINTAGES);
    
    if pos_start<pos_f
        MissingVint = MAT_Q(:,1);
        for vint = pos_start:pos_f-1
            s = size(MAT_Q,1)-1;
            a = [{[VintName VINTAGES(vint,:)]};num2cell(-999*(ones(s,1)))];
            MissingVint = [MissingVint a];
        end
        MAT_Q = [MissingVint MAT_Q(:,2:end)];
    end
end
end