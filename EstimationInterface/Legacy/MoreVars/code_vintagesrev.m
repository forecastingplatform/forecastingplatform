clear Quarter;

Vintages = {'Vintages','Available','Missing Variables'};

Vintages(2,:)={[],[],[]};
temp = MMBEST.chosenmodels;


for vint = (2+(MMBEST.region(find(MMBEST.chosenmodels>0))==2)):size(DATAMAT{1}(1,:),2)-MMBEST.qh-1
    
    a = cellstr(DATAMAT{1}(1,vint)); a = a{1}; m = size(a,2)-3;  vintangename = get_vint_name(a);
    
    Vintages(vint,1) = {vintangename};
    
    l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1);
    
    position_FirstObs = find(strcmp(DATAMAT{1}(:,1),OBSERVATION(l,:))==1)-1+MMBEST.inspf-(MMBEST.region(find(MMBEST.chosenmodels>0))==2);
    
    if position_FirstObs+MMBEST.horizon <= (size(DATAMAT{1},1)-MMBEST.qh+1-MMBEST.inspf)
        NowCastRev=[];
        if MMBEST.inspf
            NowCastRev = [DATAMAT{1}(position_FirstObs,1)];
         % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        NowCastRev = regexprep(NowCastRev,':','');
            for n = 1:3 
                rev = get_revised(DATAMAT, n,position_FirstObs,MMBEST.qh+(MMBEST.region(find(MMBEST.chosenmodels>0))==2));
                if (cell2mat(rev)~=-99)&&(cell2mat(rev)~=-999)
                    NowCastRev = [NowCastRev {4*cell2mat(rev)}];
                end
            end
        end
        Quarter(:,1) = DATAMAT{1}(position_FirstObs+1:position_FirstObs+MMBEST.horizon,1);
        
        for n = 1:3
            DATAMATrev{n} = num2cell(-999*ones(MMBEST.horizon,1));
        end
        
        for i = 1:MMBEST.horizon
            for n = 1:3
                rev = get_revised(DATAMAT, n,position_FirstObs+i,MMBEST.qh+(MMBEST.region(find(MMBEST.chosenmodels>0))==2));
                if (cell2mat(rev)~=-99)&&(cell2mat(rev)~=-999)
                    DATAMATrev{n}(i,1) = {4*cell2mat(rev)};
                end
            end
        end
        for n = 1:3
            DATAMATrev{n} = [Quarter DATAMATrev{n}];
        end
    else
        horizon1 = size(DATAMAT{1},1)-position_FirstObs-MMBEST.qh+1-MMBEST.inspf;
        for n = 1:3
            DATAMATrev{n} = num2cell(-999*ones(horizon1,1));
        end
        
        clear Quarter;
        
        Quarter(:,1) = DATAMAT{1}(position_FirstObs+1:position_FirstObs+horizon1,1);
        NowCastRev=[];
        if MMBEST.inspf
            NowCastRev = [DATAMAT{1}(position_FirstObs,1)];
        % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        NowCastRev = regexprep(NowCastRev,':','');
            for n = 1:3
                rev = get_revised(DATAMAT, n,position_FirstObs,MMBEST.qh+(MMBEST.region(find(MMBEST.chosenmodels>0))==2));
                if (cell2mat(rev)~=-99)&&(cell2mat(rev)~=-999)
                    NowCastRev = [NowCastRev {4*cell2mat(rev)}];
                end
            end
        end
        for i = 1:horizon1
            for n = 1:3
                rev = get_revised(DATAMAT, n,position_FirstObs+i,MMBEST.qh+(MMBEST.region(find(MMBEST.chosenmodels>0))==2));
                if (cell2mat(rev)~=-99)&&(cell2mat(rev)~=-999)
                    DATAMATrev{n}(i,1) = {4*cell2mat(rev)};
                end
            end
        end
        for n = 1:3
            DATAMATrev{n} = [Quarter DATAMATrev{n}];
        end
    end
    missing = zeros(1,3);
    for n = 1:3
        for i = 1:size(DATAMATrev{n},1)
            if ((cell2mat(DATAMATrev{n}(i,2))==-99)||(cell2mat(DATAMATrev{n}(i,2))==-999))
                missing(n) = 1;
            end
        end
    end
    
    VintData = [DATAMAT{1}(1,1);DATAMATrev{1}(:,1)];
    % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        VintData = regexprep(VintData,':','');


    for i = 1:3
        VintData = [VintData [cell2mat(MMBEST.variables_a{i});DATAMATrev{i}(:,2)]];
    end 
    if isempty(find(cell2mat(DATAMATrev{n}(2:end,2:end))==-99))&& isempty(find(cell2mat(DATAMATrev{n}(2:end,2:end))==-999))
        try
            [~,~,data1] = xlsread([MMBEST.location '\ExcelFileVintages\' vintangename],1);
            data1 = [data1(:,1) [data1(1,2:end);num2cell(cell2mat(data1(2:end,2:end))*4)]];
            xlswrite([MMBEST.location '\RealTimePlusRev\' vintangename],[data1(1:end-MMBEST.inspf,1:4);NowCastRev;VintData(2:end,:)],1);
        catch
        end
    end
    if isempty(find(missing==1))
        if (size(VintData,1)==MMBEST.horizon+1)
            Vintages(vint,2) = cellstr('yes');
            xlswrite([MMBEST.location '\ExcelFileRev\' vintangename],VintData,1)
        else
            Vintages(vint,2)=cellstr('no');
            Vintages(vint,3)=cellstr('not enough observations');
        end
    else
        Vintages(vint,2)=cellstr('no');
        Vintages(vint,3)=get_missing_var(missing);
    end
end
MMBEST.chosenmodels = temp;
clear temp
xlswrite([MMBEST.location '\ExcelFileRev\Vintages Available'], Vintages);