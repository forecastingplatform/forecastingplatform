function ModelOutput = BVAR_GLP(basics,vint)

addpath([basics.thispath '\ALGORITHMS\GLP']); %Add GLP routines to Matlab
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' basics.vintage(vint,:)]); %Enter MODEL/GLP subfolder
%% Load in data
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1)/100;
%              FORECASTING PLATFORM DENOTES ALL VARIABLES IN PERCENTAGES,
%              THUS ALL VARIABLES ARE DIVIDED BY 100 BEFORE RUNNING THE
%              ESTIMATION- TO MAKE THEM CONSISTENT WITH GLP NOTATION!
res = bvarGLP(data,4,'mcmc',1,'MCMCconst',1,'Ndraws',basics.bvarNdraws,'hz',basics.forecasthorizon,'MCMCfcast',1);
display(['MCMC acceptance rate is: ' num2str(res.mcmc.ACCrate)]);
eval(['save ' basics.currentmodel '_' deblank(num2str(basics.vintage(basics.vintagenr,:))) 'res.mat']);

ModelOutput.Mean.xgdp_a_obs =  mean(res.mcmc.Dforecast(:,1,:),3)*400; % remultiplying with 100
ModelOutput.Mean.pgdp_a_obs =  mean(res.mcmc.Dforecast(:,2,:),3)*400;
ModelOutput.Mean.rff_a_obs  =  mean(res.mcmc.Dforecast(:,3,:),3)*400;

ModelOutput.Median.xgdp_a_obs =  median(res.mcmc.Dforecast(:,1,:),3)*400; 
ModelOutput.Median.pgdp_a_obs =  median(res.mcmc.Dforecast(:,2,:),3)*400;
ModelOutput.Median.rff_a_obs  =  median(res.mcmc.Dforecast(:,3,:),3)*400;

ModelOutput.Distribution.xgdp_a_obs =  (squeeze(quantile(res.mcmc.Dforecast(:,1,:),9,3)*400)); 
ModelOutput.Distribution.pgdp_a_obs =  (squeeze(quantile(res.mcmc.Dforecast(:,2,:),9,3)*400));
ModelOutput.Distribution.rff_a_obs  =  (squeeze(quantile(res.mcmc.Dforecast(:,3,:),9,3)*400));

end


