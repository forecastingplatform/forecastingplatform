function ModelOutput = BVAR_GLP(basics,vint)

addpath([basics.thispath '\ALGORITHMS\GLP']); %Add GLP routines to Matlab
cd([basics.thispath '\MODELS\' basics.currentmodel '\' basics.currentmodel '_' basics.vintage(vint,:)]); %Enter MODEL/GLP subfolder
%% Load in data
data = xlsread([basics.datalocation '\ExcelFileVintages\' basics.zone deblank(num2str(basics.vintage(basics.vintagenr,:)))],1)/100;
%              FORECASTING PLATFORM DENOTES ALL VARIABLES IN PERCENTAGES,
%              THUS ALL VARIABLES ARE DIVIDED BY 100 BEFORE RUNNING THE
%              ESTIMATION- TO MAKE THEM CONSISTENT WITH GLP NOTATION!
if basics.fnc
res = bvarGLP(data(1:end-1,:),4,'mcmc',1,'MCMCconst',1,'Ndraws',basics.bvarNdraws,'hz',basics.forecasthorizon,'MCMCfcast',1);
     for i =1:basics.bvarNdraws/2 % loop through draws 
      if i==100*floor(.01*i);
                        disp(['Now running the conditioning on ',num2str(i),'th mcmc iteration (out of ',num2str(basics.bvarNdraws/2),')'])
      end
            temp=squeeze(res.mcmc.beta(:,:,i));
            Gamma=[temp(2:end,:);temp(1,:)];
            Su=squeeze(res.mcmc.sigma(:,:,i));
            datakf = [data; NaN(basics.forecasthorizon-1,size(data,2))];
            [~,datacf(:,:,i)] = conforekf_glp(datakf,Gamma,Su,4,size(datakf,1)-1,1);  % conditinoal forecasts
            res.mcmc.Dforecast= datacf(end-basics.forecasthorizon+1:end,:,i);
      end

else
res = bvarGLP(data,4,'mcmc',1,'MCMCconst',1,'Ndraws',basics.bvarNdraws,'hz',basics.forecasthorizon,'MCMCfcast',1);
end
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


