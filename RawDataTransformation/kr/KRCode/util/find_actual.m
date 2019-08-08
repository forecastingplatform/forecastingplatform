function actual = find_actual(options, actuals)
% options: see decription forecast_stats.m
% actual:  actual value (given date and forecast horizon in options):
% 2009q1 vintage (latest available)

i         =  options.year;   j     =  options.quarter;       % vintage date
i0        =  options.year0;  j0    =  options.quarter0;      % first obs. date
h         =  options.horizon;                                % forecasr horizon
var_name  =  options.var_name;

% loads actuals
actual    = eval(['actuals.',var_name]);
Tmax      = length(actual)-1;               % total number of observations in the sample
cnt       = (i-i0)*4 + (j-j0) + h + 1;      % number of observation
if cnt > Tmax
    error('Forecast for horizon beyond the sample')
end
actual    = actual(cnt);

% transformation (annualization, etc)
if isequal(var_name,'FEDFUNDS')
    actual      = 4*actual;          % annualization 
else
    actual      = ((exp(actual/100))^4-1)*100;
end


