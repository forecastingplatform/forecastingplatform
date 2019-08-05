clear

T  = 84;    % observation for 90q1
R  = 12;    % rolling window
h  = 1;     % pLL horizon
M  = 3;

% function that calculates MSE for pooled model
ppool           = inline('sqrt(mean((err*w).^2))','err','w'); % function that calculates log pLL of pooled model

load ALLfct.mat;

% univariate case

varnames = [{'FedFunds'}; {'dlnY'}; {'dlnP'}; {'dlnC'}; {'dlnI'}; {'dlnw'}; {'lnL'}];
N        = 7;

for n = 1:N; 
    fct  = NaN(T,M);
    act  = NaN(T,M);
    wgts = NaN(T-R+1,M);
    x0   = ones(3,1)/3;
    vnm  = varnames{n};
    for m = 1:M
        eval(['fct(:,m) = ALLfct{m}.',vnm,'.fct(:,h);'])
        eval(['act(:,m) = ALLfct{m}.',vnm,'.act(:,h);'])
    end
    err  = act - fct;
    for r = R:T
        eall            = err(r-R+1:r,:);
        x0              = fmincon(@(w)ppool(eall,w),x0,[],[],ones(1,3),1,zeros(1,3),ones(1,3));
        wgts(r-R+1,:)  = x0';
    end
        eval(['RMSEwgts.',vnm,'= wgts;'])
end
                      

% PLOTS

varnames = [{'dlnY'}; {'dlnC'}; {'dlnI'}; {'lnL'}; {'dlnP'};  {'dlnw'}; {'FedFunds'}];
Names    = [{'Output'}; {'Cons.'}; {'Invest.'}; {'Hours'}; {'Prices'}; {'Wages'}; {'Int. rate'}];
figure1 = figure('Color',[1 1 1]);
colormap('copper');

for n = 1:6
    vnm = varnames{n};
    subplot1 = subplot(7,1,n,'Parent',figure1, 'FontName','Times New Roman', 'FontSize', 12);
    hold(subplot1,'all');

    % plots
    eval(['Y = RMSEwgts.',vnm]);
    X = (1990.25 + R/4 : 0.25 : 1990.25 + T/4)';
    
    % Create figure
    area1 = area(X,Y, 'Parent', subplot1);
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    ylim([0 1]);
    xlim([X(1) X(length(X))] );
    ylabel(Names{n}, 'FontSize', 12);
    %legend('show');
end

n = 7;
vnm = varnames{n};
subplot1 = subplot(7,1,n,'Parent',figure1, 'FontName','Times New Roman', 'FontSize', 12);
hold(subplot1,'all');

% plots
eval(['Y = RMSEwgts.',vnm]);
X = (1990.25 + R/4 : 0.25 : 1990.25 + T/4)';

area1 = area(X,Y, 'Parent', subplot1);
set(gca,'ytick',[])
ylim([0 1]);
xlim([X(1) X(length(X))] );
set(area1(1),'DisplayName','DSSW');
set(area1(2),'DisplayName','DSSW+FF');
set(area1(3),'DisplayName','DSSW+HF');
ylabel(Names{n}, 'FontSize', 12);
legend('show');


