clear
clc
format compact
figure1  = figure('Color',[1 1 1]);

%addpath('FanChart');

load(['Allfct']);
% loads actuals
load(['data']);
H  = 24;                   % forecast horizon
T  = 164;                  % total number of observations
T0 = 80;                   % observation for 90q1
varnames = [{'dlnY'}; {'dlnC'}; {'dlnI'}; {'lnL'}; {'dlnP'}; {'dlnw'};  {'FedFunds'};];
N        = size(varnames,1);      % number of variables
Names1 = [{'DSSW'} {'DSSW+FF'} {'DSSW+HF'} {'Pool'}];
Names2 = [{'Output'} {'Cons.'} {'Invest.'} {'Hours'} {'Prices'}  ...
           {'Wages'} {'Int. rate'}];


% Date of forecast 2007Q3
i = 107;
j = 3;
Tf    = T0 + 4*(i-90) + (j-1);   

%for m = 1:1 % loop for models
for n = 1:7;
for m = 3:-1:1;
model = modelNames{m};
fname = [model,'/',num2str(i),'q',num2str(j),'/forecasts.mat'];  
load(fname);                                                  % loads forecast draws  
       
vnm = varnames{n};
if n==4 || n==7  
     eval(['temp = ',vnm,';']);                      % variables in levels
     eval(['draws=f.',vnm,';']); 
     draws = draws(2:14,:);                          
     
else
     eval(['temp = cumsum(',vnm,');']);              % variables in growth rates changed for levels
     eval(['draws=f.',vnm,';']); 
     draws = temp(Tf)+ cumsum(draws(2:14,:)); 
end
     
% Fancharts
act  = temp(Tf-10:Tf+13);
H    = 13;
Ttot = 24;
T    = 11;
hist = act(1:T);

% Set relevant quantiles (in percent)
quantiles=[1 5 10 15 20 25 30 35 40 50 60 65 70 75 80 85 90 95 99];
mat_quant=NaN(H,19);
for h=1:H % loop over horizon
    for q=1:19 % loop over quantiles
        mat_quant(h,q)=quantile(draws(h,:),quantiles(1,q)/100);
    end
end

% Add hist. observations to the plot matrix
addv=[10^(-42) 10^(-43) 10^(-44) 10^(-45) 10^(-46) 10^(-47) 10^(-48) 10^(-49) 10^(-50) 0 10^(-50) 10^(-49) 10^(-48) 10^(-47) 10^(-46) 10^(-45) 10^(-44) 10^(-43) 10^(-42)];
hm=hist;
for ii=1:18
    hm=[hm hist]; %#ok<AGROW>
end
mat_quant=[hm;mat_quant];
for t=1:T
   mat_quant(t,:)=mat_quant(t,:)+addv; 
end

% Prepare plot matrix for its use with the area function
matm=mat_quant;
for ii=2:size(matm,2)
    matm(:,ii)=matm(:,ii)-mat_quant(:,ii-1);
end
%matm(:,1) = act;

%ToChart{m,n}.matm = matm;
%ToChart{m,n}.act  = act;



% Generate plot
%figure1  = figure('Color',[1 1 1]);
subplot1 = subplot(7,3,3*(n-1)+m,'Parent',figure1);
hold(subplot1,'all');


h=area(matm, 'LineStyle','none');
r=0;
b=0.8;
set(h,'LineStyle','none')
set(h(1),'FaceColor',[1 1 1]) % white
set(h(2),'FaceColor',[r .99 b])
set(h(3),'FaceColor',[r .975 b])
set(h(4),'FaceColor',[r .95 b])
set(h(5),'FaceColor',[r .9 b])
set(h(6),'FaceColor',[r .85 b])
set(h(7),'FaceColor',[r .8 b])
set(h(8),'FaceColor',[r .75 b])
set(h(9),'FaceColor',[r .7 b])
set(h(10),'FaceColor',[r .65 b]) %
set(h(11),'FaceColor',[r .65 b])%
set(h(12),'FaceColor',[r .7 b])
set(h(13),'FaceColor',[r .75 b])
set(h(14),'FaceColor',[r .8 b])
set(h(15),'FaceColor',[r .85 b])
set(h(16),'FaceColor',[r .9 b])
set(h(17),'FaceColor',[r .95 b])
set(h(18),'FaceColor',[r .975 b])
set(h(19),'FaceColor',[r .99 b])
hold on
plot(act,'LineWidth',3,'Color',[0 0 0]);  % median forecast in black
set(gcf,'Color','w')
xlim([1 24])
if m==3
    a0 = min([min(min(mat_quant)) min(act)])-1; 
    a1 = max([max(max(mat_quant)) max(act)])+1;
end
ylim([a0 a1]);
% Ticks x-axis
set(gca,'XTick',[])
set(gca,'YTick',[])
if n==7
    set(gca,'XTick',[1  9  17 ])
    set(gca,'XTickLabel',{'2005','2007','2009'})
end
if n==1
    title(Names1{m}, 'FontSize',12)
end
if m==1
    ylabel(Names2{n}, 'FontSize',12)
end

end
end         
           