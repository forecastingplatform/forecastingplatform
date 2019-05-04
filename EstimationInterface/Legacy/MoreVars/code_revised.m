Vintages = {'Vintages','Available','Missing Variables'};

Vintages(2,:) = {[],[],[]};

FirstObs1 = find(strcmp(cellstr(FirstObs),OBSERVATION)==1)-1;

position_FirstObs = find(strcmp(DATAMAT{1}(:,1), cellstr(FirstObs)));

last = position_FirstObs+MMBEST.rw-1;

for i = 1:MMBEST.nvar
    DATAFINAL{i}(:,1)=DATAMAT{1}(1:find(strcmp(DATAMAT{i}(:,1), LastObs)),1);
    DATAFINAL{i}(:,2)=DATAMAT{i}(1:find(strcmp(DATAMAT{i}(:,1), LastObs)),end);
end

window_num = 0;

while last<=size(DATAFINAL{1}(:,1),1)
    
    a = OBSERVATION(FirstObs1+MMBEST.rw,:);
    
    m = size(a,2);
    
    a = a([m-4:m-3 m-1:m]);
    
    vintagename = get_vint_name(a);
    
    Vintages(window_num+2,1) = {vintagename};
    
    window_num = window_num+1;
    
    missing = zeros(1,MMBEST.nvar);
    
    for n=1:MMBEST.nvar
        
        for i= position_FirstObs:last
            
            if ((cell2mat(DATAFINAL{n}(i,2))==-99)||(cell2mat(DATAFINAL{n}(i,2))==-999))
                
                missing(n)=1;
                
            end
        end
    end
    
    FirstObs1=FirstObs1+1; 
    
    if isempty(find(missing(modelvars_index) == 1))
        
        Vintages(window_num+2,2) = cellstr('yes'); 
        
        VintData = DATAFINAL{1}([1 position_FirstObs: last],1);
        % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        VintData = regexprep(VintData,':','');
        
        for i = 1:MMBEST.nvar            
            if MMBEST.modelvars(i)                
                VintData = [VintData [cell2mat(variables{i});DATAFINAL{i}(position_FirstObs:last,2)]];                
            end            
        end        
        xlswrite([MMBEST.location '\ExcelFileVintages\' vintagename],VintData,1)
    else        
        Vintages(vint,2) = cellstr('no');         
        Vintages(vint,3)=get_missing_var(missing); 
    end
    if ~expseriesvalue
        position_FirstObs = position_FirstObs+1;
    end
    last=last+1;
    clear DATAFINALwindow
end
xlswrite([MMBEST.location '\ExcelFileVintages\Vintages Available'], Vintages);
