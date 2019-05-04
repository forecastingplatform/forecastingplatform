function B=format_variables(filename, VintLabel,quarterly,obsformat, vintformat, posobservation,posrelease,transformation)
%formating_variables performs preleminary steps before the data
%transformation. Steps: 1) Raw-data loading, 2) Standardization of the
%format of observation's date 3) Extract quarterly vintages 4)Compute
%quarterly values from originally non-quarterly time series 5)Balance the
%time series to make their size match that of thedeflator matrix. This
%also includes taking into account the first date to be consider in the
%vintage construction.
 
global PGNP MMBDATA;

zone = MMBDATA.zone;

if ~strcmp(zone,'us')&&~isempty(posrelease) %load raw-data files
    
    M = rearrange(filename(1,:),VintLabel(1,:),posrelease);
    
    s = size(VintLabel,2);
    
    posrelease = [s+1 s+4;s+5 s+6;s+7 s+8];
    
    if  obsformat~=3
        M = generate_date_obs(M,1:4,[]);
    end
else
    M = read_data(filename);
end

if obsformat~=1
    if  obsformat == 2
        posobservation = [7 10; 4 5];
    end
    if ~strcmp(zone,'us')&&obsformat~=3
        B = generate_date_obs(M,posobservation(1,1):posobservation(1,2),[]);
    elseif obsformat==3||obsformat==2
        if numel(posobservation(2,1):posobservation(2,2))==1
        B = generate_date_obs(M,posobservation(1,1):posobservation(1,2),[]);
        else
            B = generate_date_obs(M,posobservation(1,1):posobservation(1,2),posobservation(2,1):posobservation(2,2));
        end 
    end
else
    B = M;
end
 
if transformation~=3&&transformation~=4
    if vintformat == 2
        if ~isempty(posrelease)
            B = extract_vintages(B,VintLabel,posrelease(1,1):posrelease(1,2),posrelease(2,1):posrelease(2,2),posrelease(3,1):posrelease(3,2));
        else
            C = B(:,1);
            
            for vint = 2:size(PGNP,2)
                a = cellstr(PGNP(1,vint));
                a = a{1};
                C = [C [[VintLabel a(2:end)];B(2:end,2)]];
            end            
            B = C;            
        end 
        if ~quarterly 
            B = extrac_quarterly_obs(B); 
        end       

        B = complete_missing(B);
        B = complete_balance(B);
    end

else
    if ~quarterly
        B = extrac_quarterly_obs(B);
    end 
    B = complete_balance(B); 
end  
end