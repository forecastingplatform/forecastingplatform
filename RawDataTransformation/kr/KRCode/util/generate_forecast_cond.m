function [fmean fdraws]  = generate_forecast_cond(options_fcst)
% Computes conditional and unconditional forecasts.
% Based on imcforecast.m from Dynare
%
% INPUTS
%  o options_fcst    [structure]   containing the options. The fields are:
%      + replic        scalar, number of monte carlo simulations.
%      + parameter_set parameter draw
%      + periods       forecast horizon                                                              
%      + cond_path     [double]      m*p array, 
%                      m - number of constrained endogenous variables
%                      p - number of constrained periods.      
%      + cond_varexo   [char]  m*x array, list of controlled exogenous variables.
%      + cond_vars     [char]  m*x array holding the names of the controlled endogenous variables. 

global options_ oo_ M_ bayestopt_
xparam = options_fcst.parameter_set;

cL = 1; % conditional forecast
cond_path   =  options_fcst.cond_path;          
cond_varexo =  options_fcst.cond_varexo;       % controlled_varexo
cond_vars   =  options_fcst.cond_vars;         % constrained_vars


% How many replications
if ~isfield(options_fcst,'replic') || isempty(options_fcst.replic); options_fcst.replic = 100; end

% Forecast horizon
if ~isfield(options_fcst,'periods') || isempty(options_fcst.periods); options_fcst.periods = 40; end

set_parameters(xparam);
n_varobs  = size(options_.varobs,1);
rawdata   = read_variables(options_.datafile,options_.varobs,[],options_.xls_sheet,options_.xls_range);
options_  = set_default_option(options_,'nobs',size(rawdata,1)-options_.first_obs+1);
gend      = options_.nobs;
rawdata   = rawdata(options_.first_obs:options_.first_obs+gend-1,:);

% Transform the data.
if options_.loglinear
    if ~options_.logdata; rawdata = log(rawdata); end
end
% Test if the data set is real.
if ~isreal(rawdata); error('There are complex values in the data! Probably  a wrong transformation'); end

% Detrend the data.
options_.missing_data = any(any(isnan(rawdata)));
if options_.prefilter == 1
    if options_.missing_data
        bayestopt_.mean_varobs = zeros(n_varobs,1);
        for variable=1:n_varobs
            rdx                              = find(~isnan(rawdata(:,variable)));
            m                                = mean(rawdata(rdx,variable));
            rawdata(rdx,variable)            = rawdata(rdx,variable)-m;
            bayestopt_.mean_varobs(variable) = m;
        end
    else
        bayestopt_.mean_varobs = mean(rawdata,1)';
        rawdata = rawdata-repmat(bayestopt_.mean_varobs',gend,1);
    end
end
data = transpose(rawdata);

% Handle the missing observations.
[data_index,number_of_observations,no_more_missing_observations] = describe_missing_data(data,gend,n_varobs);
missing_value                                                    = ~(number_of_observations == gend*n_varobs);

[atT,innov,measurement_error,filtered_state_vector,ys,trend_coeff] = DsgeSmoother(xparam,gend,data,data_index,number_of_observations);
trend = repmat(ys,1,options_fcst.periods+1);

for i=1:M_.endo_nbr
    j = strmatch(deblank(M_.endo_names(i,:)),options_.varobs,'exact');
    if ~isempty(j); trend(i,:) = trend(i,:)+trend_coeff(j)*(gend+(0:options_fcst.periods)); end
end
trend = trend(oo_.dr.order_var,:);

InitState(:,1) = atT(:,end);
[T,R,ys,info]  = dynare_resolve;

NumberOfStates = length(InitState);
FORCS          = zeros(NumberOfStates,options_fcst.periods+1,options_fcst.replic);
for b=1:options_fcst.replic
    FORCS(:,1,b) = InitState;
end
EndoSize         = M_.endo_nbr;
ExoSize          = M_.exo_nbr;
sQ               = sqrt(M_.Sigma_e);

n1 = size(cond_vars,1);
n2 = size(cond_varexo,1);
if n1 ~= n2
    error(['imcforecast:: The number of constrained variables doesn''t match the number of controlled shocks'])
end

idx = []; jdx = [];

for i = 1:n1
    idx = [idx ; oo_.dr.inv_order_var(strmatch(deblank(cond_vars(i,:)),M_.endo_names,'exact'))];
    jdx = [jdx ; strmatch(deblank(cond_varexo(i,:)),M_.exo_names,'exact')];
end

mv = zeros(n1,NumberOfStates); mu = zeros(ExoSize,n2);
for i=1:n1
    mv(i,idx(i)) = 1;
    mu(jdx(i),i) = 1;
end

if (size(cond_path,2) == 1);
    cond_path = cond_path*ones(1,cL);
else
    cL = size(cond_path,2);
end

cond_path = bsxfun(@minus,cond_path,trend(idx,1:cL));


for b=1:options_fcst.replic
    shocks       = sQ*randn(ExoSize,options_fcst.periods);
    FORCS(:,:,b) = mcforecast3(cL,options_fcst.periods,cond_path,shocks,FORCS(:,:,b),T,R,mv,mu)+trend;
end
mFORCS = mean(FORCS,3);

for i = 1:EndoSize
    eval(['fmean.' deblank(M_.endo_names(oo_.dr.order_var(i),:)) ' = mFORCS(i,:)'';']);
    eval(['fdraws.' deblank(M_.endo_names(oo_.dr.order_var(i),:)) ' = permute(FORCS(i,:,:), [2 3 1]);']);
end
