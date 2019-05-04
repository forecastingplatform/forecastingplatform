Vintages = {'Vintages','Available','Missing Variables'};

Vintages(2,:) = {[],[],[]};
temp = MMBEST.chosenmodels;
MMBEST.windowlength = MMBEST.windowlength+MMBEST.inspf;

% MMBEST.nvar = 3*MMBEST.inspf+(1-MMBEST.inspf)*MMBEST.nvar;

for vint = (2+(MMBEST.region(find(MMBEST.chosenmodels>0))==2)):size(DATAMAT{1}(1,:),2)-MMBEST.vintrev*(MMBEST.vintrev>1)-MMBEST.inspf
    
    a = cellstr(DATAMAT{1}(1,vint)); a = a{1}; m = size(a,2)-3; vintagename = get_vint_name(a);
    
    Vintages(vint,1) = {vintagename};
    
    l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1)-1-(MMBEST.region(find(MMBEST.chosenmodels>0))==2);
    
    position_LastObs = find(strcmp(DATAMAT{1}(:,1),OBSERVATION(l,:))==1);
    
    position_FirstObs = position_LastObs-MMBEST.windowlength+1;
    
    missing = zeros(1,MMBEST.nvar);
    
    for n = 1:MMBEST.nvar
        if (MMBEST.inspf == 1 && n<4) 
            for i = position_FirstObs:position_LastObs+MMBEST.inspf
                if ((cell2mat(DATAMAT{n}(i,vint))==-99)||(cell2mat(DATAMAT{n}(i,vint))==-999))
                    missing(n) = 1;
                end
            end
        else
            for i = position_FirstObs:position_LastObs
                if ((cell2mat(DATAMAT{n}(i,vint))==-99)||(cell2mat(DATAMAT{n}(i,vint))==-999))
                    missing(n) = 1;
                end
            end
        end
    end
    if isempty(find(missing(modelvars_index)==1))
        
        Vintages(vint,2) = cellstr('yes');
        VintData = DATAMAT{1}([1 position_FirstObs:position_LastObs+MMBEST.inspf],1);
        
        
        % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        VintData = regexprep(VintData,':','');
        VintData{1,1} = [];
        
        
        for i = 1:MMBEST.nvar
            if MMBEST.inspf == 1
                if ( MMBEST.modelvars(i) && i<4 )
                    VintData = [VintData [cell2mat(MMBEST.observables{i});DATAMAT{i}(position_FirstObs:position_LastObs++MMBEST.inspf,vint)]];
                elseif MMBEST.modelvars(i) 
                    VintData = [VintData [cell2mat(MMBEST.observables{i});[DATAMAT{i}(position_FirstObs:position_LastObs,vint); NaN ]]];
                end
            else
                if  MMBEST.modelvars(i)
                    VintData = [VintData [cell2mat(MMBEST.observables{i});DATAMAT{i}(position_FirstObs:position_LastObs,vint)]];
                end
            end
        end
        
        xlswrite([MMBEST.location '\ExcelFileVintages\' vintagename],VintData,1)
    else
        Vintages(vint,2) = cellstr('no');
        
        Vintages(vint,3) = get_missing_var(missing);
    end
end
MMBEST.chosenmodels = temp;
clear temp
xlswrite([MMBEST.location '\ExcelFileVintages\Vintages Available'], Vintages);
MMBEST.windowlength = MMBEST.windowlength-MMBEST.inspf;
