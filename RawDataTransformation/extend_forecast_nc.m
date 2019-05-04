function A=extend_forecast_nc(DataInfos,SPFDATA)
%extend_forecast_nc performs the same task as formatting. Here however,
%we consider only the three first observables that and extend series with
%SPF now casts
global OBSERVATION VINTAGES PGNP;

filename      = DataInfos.filename{:};

spffilename   = DataInfos.spffilename{:};

VintLabel     = DataInfos.VintLabel{:};

transformation= cell2mat(DataInfos.transformation);

quarterly     = DataInfos.quarterly;

obsformat     = cell2mat(DataInfos.obsformat);

vintformat    = cell2mat(DataInfos.vintformat);

posobservation= cell2mat(DataInfos.posobservation{:});

posrelease    = cell2mat(DataInfos.posrelease{:});

if transformation~=3
    
       B1 = format_variables(cell2mat(filename(1,:)), cell2mat(VintLabel(1,:)), quarterly,obsformat, vintformat, posobservation, posrelease,transformation);
 
       [~,~,B2] = xlsread(spffilename);
    
       M=B2'; M=M(1:4,:);
    
       for i=2:size(M,2)
        
           a=num2str(cell2mat(M(1,i)));
        
           B(1,i)={[num2str(cell2mat(VintLabel(1,:))) a(3:4) 'Q' num2str(cell2mat(M(2,i)))]};
        
           l=size(M,1)-2;
        
           B(2:l,i)=M(4:end,i);
       end 
    l1=size(B1,1)+1;
    
    for vint=2:size(B1,2)
        
        a = cellstr(B1(1,vint));
        
        a = a{1}; m = size(a,2)-3;
        
        l = find(strcmp(VINTAGES,{[a(m:m+1) 'Q' a(end)]})==1);
        
        l0 = find(strcmp(B1(:,1),OBSERVATION(l,:))==1);
        
        if isempty(l0)
            l0 = l1; 
        end
        
        b0 = find(strcmp(B(1,:), {[num2str(cell2mat(VintLabel(1,:))) a(m:m+1) 'Q' a(end)]})==1);
        
        if ~isempty(b0)
            for j = l0:(l0+size(B,1)-2)
                B1(j,vint) = B(j-l0+2,b0);               
            end
        end
    end 
    q = [];
    for q0 = 1:size(B1(:,1),1) 
        if isempty(cell2mat(B1(q0,1)))&&isempty(q)
            q = q0;
        end
    end
    
    l1 = find(strcmp(OBSERVATION,B1(q-1,1))==1);     
    
    for j = q:size(B1,1) 
        B1(j,1) = cellstr(OBSERVATION(l1+j-q+1,:));                
    end 
    B1=complete_missing(B1,B);  
    if transformation == 1
        A = real_growth(B1,PGNP);
    elseif transformation == 2
        D = B1;
        D(2:size(B1,1),2:size(B1,2)) = {1}; 
        A = real_growth(B1,D);
    end
else
   [~,~,B2] = xlsread(spffilename);
   
    if  obsformat(1,:) == 2
        posobservation = [7 10; 4 5];
    end
    
    B2 = generate_date_obs(B2,posobservation(1,1):posobservation(1,2),posobservation(2,1):posobservation(2,2));  
    
    for q = 2:size(B2,1)
        if ~strcmp('double', class(cell2mat(B2(q,2))))
            B2(q,2) = {-999};
        end
        
        if ~isnan(cell2mat(B2(q,2)))
            if (cell2mat(B2(q,2))~=-99)&&(cell2mat(B2(q,2))~=-999)
                B2(q,2) = {cell2mat(B2(q,2))/4};
            end
        end
    end  
    
    B2 = complete_balance(B2);
    
    for q = size(B2,1)+1:size(SPFDATA,1)
        B2(q,:) = [SPFDATA(q,1) {-999}];
    end 
    
    A = [B2(1,1);B2(3:end,1)];
    
    for vint = 2:size(SPFDATA,2)
        A = [A [SPFDATA(1,vint);B2(3:end,2)]];
    end 
end