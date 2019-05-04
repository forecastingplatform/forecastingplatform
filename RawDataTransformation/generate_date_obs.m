function A=generate_date_obs(M,posyear,posmonth) 
%generate_date_obs gets as in put a data matrix M, the position of the year
%and the month in the observation format and retruns observations with the format YYYY:QN 
A = M; 
for q = 2:size(M,1)
    a = cellstr(M(q,1));
    a = a{1};
    if size(posmonth,2) == 3
        if strcmpi('Jan', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('Feb', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('Mar', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('Apr', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('May' , a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('Jun', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('Jul', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('Aug', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('Sep', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('Oct', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        elseif strcmpi('Nov', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        elseif strcmpi('Dec', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        end
    elseif size(posmonth,2) == 2
        if strcmpi('01', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('02', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('03', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q1']);
        elseif strcmpi('04', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('05' , a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('06', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q2']);
        elseif strcmpi('07', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('08', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('09', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q3']);
        elseif strcmpi('10', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        elseif strcmpi('11', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        elseif strcmpi('12', a(posmonth))
            A(q,1) = cellstr([a(posyear) ':Q4']);
        end
    elseif isempty(posmonth)
        m = size(a,2);
        A(q,1) = cellstr([a(posyear) ':' a(m-1:m)]);
    end
end
end
