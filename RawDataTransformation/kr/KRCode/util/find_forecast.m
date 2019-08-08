function [forecast draws] = find_forecast(options)
% options: see forecast_evaluation.m
% forecast: median forecast at given date, horizon and model (all info in
% options)
% draws: all draws for density evaluation statistics

i         =  options.year;   j     =  options.quarter;       % vintage date
h         =  options.horizon;                                % forecasr horizon
var_name  =  options.var_name;


% loads estimation results
load([options.model,'/',num2str(i),'q',num2str(j),'/forecasts.mat']);
       
% forecast
if options.cond == 0                    % unconditional forecast
    for_draws = eval(['f.',var_name]);
elseif options.cond == 1                 % conditional forecast
    for_draws = eval(['cf.',var_name]);
elseif options.cond == 2                 % conditional forecast
    for_draws = eval(['spf_cf.',var_name]);
else
    error('set options.cond')
end
draws     = for_draws(h+2,:);             % all draws

% transformation (annualization)
if isequal(var_name,'FEDFUNDS')
    draws    = 4*draws';         
else
    draws     = ((exp(draws'/100)).^4-1)*100;
end

forecast  = median(draws);            % point forecast






