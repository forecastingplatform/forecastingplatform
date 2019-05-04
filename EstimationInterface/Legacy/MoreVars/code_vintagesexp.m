Vintages = {'Vintages','Available','Missing Variables'};

Vintages(2,:) = {[],[],[]}; 
temp = MMBEST.chosenmodels;
% MMBEST.chosenmodels(:,8:9)= 0;
modelvars_index = find(MMBEST.modelvars>0)';

first_var=0; 
for vint = (2+(MMBEST.region(find(MMBEST.chosenmodels>0))==2)):(size(DATAMAT{1}(1,:),2)-(MMBEST.vintrev+MMBEST.inspf)+1)
    for i = 1:MMBEST.nvar
        try
            first_var(i) = max(find(cell2mat(DATAMAT{i}(2:end,vint))==-99))+2;
        catch
            first_var(i) = 2;
        end
    end
end 
    FirstObsAll = max(first_var(modelvars_index'));

l0 = find(strcmp(DATAMAT{1}(FirstObsAll,1),OBSERVATION)==1)-1;

l1 = find(strcmp(cellstr(FirstObs),OBSERVATION)==1);

if l0>l1
    FirstObs = DATAMAT{1}(FirstObsAll,1);
end
position_LastObs = 0; l = 0; 
for vint = (2+(MMBEST.region(find(MMBEST.chosenmodels>0))==2)):size(DATAMAT{1}(1,:),2)-MMBEST.vintrev*(MMBEST.vintrev>1) 
    
    a = cellstr(DATAMAT{1}(1,vint)); a = a{1}; m = size(a,2)-3;
    
    vintagename = get_vint_name(a);
    Vintages(vint,1) = {vintagename};
     l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1)-(MMBEST.region(find(MMBEST.chosenmodels>0))==2);
   % l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1)-1;%-(MMBEST.region(find(MMBEST.chosenmodels>0))==2) 
    
    position_LastObs = find(strcmp(DATAMAT{1}(:,1), OBSERVATION(l,:)))-1+MMBEST.inspf; 
    if isempty(position_LastObs)
        position_LastObs=size(DATAMAT{1}(:,vint),1);
    end
    missing=zeros(1,MMBEST.nvar);
    
    for n = 1:MMBEST.nvar         
        for i = FirstObsAll:position_LastObs 
                if ((cell2mat(DATAMAT{n}(i,vint))==-99)||(cell2mat(DATAMAT{n}(i,vint))==-999))
                     missing(n) = 1; 
                end
        end        
    end   
    
    if isempty(find(missing(modelvars_index)==1))
        
        Vintages(vint,2) = cellstr('yes');
        
        VintData = DATAMAT{1}([1 FirstObsAll:position_LastObs],1);
         % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        VintData = regexprep(VintData,':','');

        for i = 1:MMBEST.nvar
            if  MMBEST.modelvars(i)
                VintData = [VintData [cell2mat(MMBEST.observables{i});DATAMAT{i}(FirstObsAll:position_LastObs,vint)]];
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


