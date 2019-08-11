Vintages = {'Vintages','Available','Missing Variables'};
nowcast_observables = [1, 2, 14, 15];
financial_observables = [3, 8];
Vintages(2,:) = {[],[],[]}; 
temp = basics.chosenmodels;
modelvars_index = find(basics.modelvars>0)';
regioncontrol=basics.region(find(basics.chosenmodels>0))==2;
if size(regioncontrol,2) >1
    regioncontrol = regioncontrol(1);
end
first_var=0; 
for vint = (2+regioncontrol):(size(DATAMAT{1}(1,:),2)-(basics.vintrev+basics.inspf)+1)
    for i = 1:basics.nvar
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
for vint = (2+regioncontrol):size(DATAMAT{1}(1,:),2)-basics.vintrev*(basics.vintrev>1) -basics.inspf
    
    a = cellstr(DATAMAT{1}(1,vint)); a = a{1}; m = size(a,2)-3;
    
    vintagename = get_vint_name(a);
    Vintages(vint,1) = {vintagename};
     l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1)-(regioncontrol);
   % l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1)-1;%-(basics.region(find(basics.chosenmodels>0))==2) 
    
    position_LastObs = find(strcmp(DATAMAT{1}(:,1), OBSERVATION(l,:)))-1; 
    if isempty(position_LastObs)
        position_LastObs=size(DATAMAT{1}(:,vint),1);
    end
    missing=zeros(1,basics.nvar);
        
    for n = 1:basics.nvar
        if (basics.inspf == 1 && (ismember(n,nowcast_observables)))
            for i = FirstObsAll:position_LastObs+basics.inspf
                if ((cell2mat(DATAMAT{n}(i,vint))==-99)||(cell2mat(DATAMAT{n}(i,vint))==-999))
                    missing(n) = 1;
                end
            end
        else
            for i = FirstObsAll:position_LastObs
                if ((cell2mat(DATAMAT{n}(i,vint))==-99)||(cell2mat(DATAMAT{n}(i,vint))==-999))
                    missing(n) = 1;
                end
            end
        end
    end  
    
    if isempty(find(missing(modelvars_index)==1))
        
        Vintages(vint,2) = cellstr('yes');
        
        VintData = DATAMAT{1}([1 FirstObsAll:position_LastObs+basics.inspf+basics.fnc],1);
         % Here we need to delete the : in the date otherwise dynare cannot
        % find the dates!
        VintData = regexprep(VintData,':','');
        VintData{1}= nan;
%         for i = 1:basics.nvar
%             if  basics.modelvars(i)
%                 VintData = [VintData [cell2mat(basics.observables{i});DATAMAT{i}(FirstObsAll:position_LastObs,vint)]];
%             end
%         end

       for i = 1:basics.nvar
            if basics.inspf == 1
                if ( basics.modelvars(i) &&  (ismember(i, nowcast_observables)))
                    VintData = [VintData [cell2mat(basics.observables{i});DATAMAT{i}(FirstObsAll:position_LastObs+basics.inspf,vint)]];
                elseif basics.modelvars(i) 
                    VintData = [VintData [cell2mat(basics.observables{i});[DATAMAT{i}(FirstObsAll:position_LastObs,vint); NaN ]]];
                end
             elseif basics.fnc == 1
                if ( basics.modelvars(i) &&  (ismember(i, financial_observables))) % Short term rate and creadit spread
                    VintData = [VintData [cell2mat(basics.observables{i});DATAMAT{i}(FirstObsAll:position_LastObs+basics.fnc,vint)]];
                elseif basics.modelvars(i)
                    VintData = [VintData [cell2mat(basics.observables{i});[DATAMAT{i}(FirstObsAll:position_LastObs,vint); NaN ]]];
                end
            else
           
                if  basics.modelvars(i)
                    VintData = [VintData [cell2mat(basics.observables{i});DATAMAT{i}(FirstObsAll:position_LastObs,vint)]];
                end
            end
        end
        
        
        xlswrite([basics.location '\ExcelFileVintages\' vintagename],VintData,1)
    else
        
        Vintages(vint,2) = cellstr('no');
        
        Vintages(vint,3) = get_missing_var(missing); 
    end
end
% basics.chosenmodels = temp;
% clear temp
 xlswrite([basics.location '\ExcelFileVintages\Vintages Available'], Vintages);
