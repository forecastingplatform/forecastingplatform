
%% Perform out of sample forecasting with Minnesota Prior BVAR 
%bvar_forecast(datafile = temp, bvar_prior_tau=0.2, bvar_prior_decay=1, bvar_prior_omega=1,  bvar_prior_train=0, first_obs = 20, forecast = 20, bvar_replic = 10000, conf_sig = 0.9 ) 8;
%% Write mod file
% clear all
% close all 
function bvar(basics)
bvar_forecasting = fopen('bvar_forecasting.mod','w+');
% Vars
fprintf(bvar_forecasting,'var ');
for i = 1:3
   fprintf(bvar_forecasting, cell2mat(basics.observables{i}));
   fprintf(bvar_forecasting, ' ');
end
fprintf(bvar_forecasting,'; \n');
%varexo
fprintf(bvar_forecasting,'varobs ');
for i = 1: 3
   fprintf(bvar_forecasting, cell2mat(basics.observables{i}));
   fprintf(bvar_forecasting, ' ');
end
fprintf(bvar_forecasting,'; \n');
%Data loading
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1);
% Lag length estimation
fprintf(bvar_forecasting,'// Load Forecast Interface Parameters \n');
fprintf(bvar_forecasting,'cd .. ; \n');
fprintf(bvar_forecasting,'cd .. ; \n');
fprintf(bvar_forecasting,'load variables.mat; \n');
fprintf(bvar_forecasting,'cd BVAR; \n');
fprintf(bvar_forecasting,'cd BVAR_forecast; \n');
fprintf(bvar_forecasting,'eval([''options_.datafile = '''''' basics.datalocation ''\\ExcelFileVintages\\'' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:))) '''''';'']);' );
fprintf(bvar_forecasting,'options_.bvar_prior_tau = %e; \n',basics.bvarmpriors(1) );
fprintf(bvar_forecasting,'options_.bvar_prior_decay = %e; \n',basics.bvarmpriors(2));
fprintf(bvar_forecasting,'options_.bvar_prior_omega = %e; \n', basics.bvarmpriors(3));
fprintf(bvar_forecasting,'options_.bvar_prior_train= %e;\n',basics.bvarmpriors(end));
fprintf(bvar_forecasting,'options_.first_obs = %d; \n', 20);
fprintf(bvar_forecasting,'options_.forecast = %d; \n', basics.forecasthorizon);
fprintf(bvar_forecasting,'options_.bvar_replic = 10000; \n' );
fprintf(bvar_forecasting,'options_.nograph = 1; \n' );
fprintf(bvar_forecasting,'bvar_forecast  %d; \n', basics.bvar.optlag);
fclose(bvar_forecasting);

end
