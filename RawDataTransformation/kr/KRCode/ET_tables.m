% File to calculate Efficient Test

clear
load('ALLfct.mat');
load('data.mat');


% modelNames = [{'noff'} {'ff'} {'hh'} {'p110'} {'p101'} {'p011'} {'p111'}];
varNames = fieldnames(ALLfct{1});
M        = size(modelNames,2);
N        = size(varNames,1);   % number of variables
H        = 24;                 % forecast horizon

for n=1:N
    vnm     = varNames{n};
    %eval(['temp =',vnm,';'])
    ET      = NaN(M,H);
        
    for m = 1:M
        eval(['y  = ALLfct{m}.', vnm ,';'])
        fct        = y.fct;      % forecasts
        act        = y.act;      % actuals
        T     = size(act,1);
        if n==1 || n==7, eval(['ref =',vnm,'(end-T:end-1);']), end
        
        % correlation between forecast and actuals 
        for h = 1:H
           a    = act(:,h);             
           if n==1 || n==7  % for FedFunds and log hours: to calculate changes in level
               f    = fct(~isnan(a),h) - ref(~isnan(a));  
               a    = a(~isnan(a)) - ref(~isnan(a));
           else
               f    = fct(~isnan(a),h);  
               a    = a(~isnan(a));
           end
           ET(m,h)  = corr(a,f);
        end
    end
    
    eval(['stat.',vnm,'.ET   = ET;']);
        
    horiz = [1 2 3 4 6 8 12 16 24];
    
    xlswrite('stats', {'Efficiency Test Corr.'}, vnm, ['A' num2str(4*M+9)]);
    xlswrite('stats', modelNames'  ,             vnm, ['A' num2str(4*M+10)]);
    xlswrite('stats', ET(:,horiz)      ,         vnm, ['B' num2str(4*M+10)]);
  
end

%save('ALLfct.mat', 'stat', '-append');   

% Plot panel 7 x 4 of figures for the efficiency test


H = 4;

figure1 = figure('Color',[1 1 1]);
%axes1 = axes('Parent',figure1);
%hold(axes1,'all');        

Names1 = [{'DSSW'} {'DSSW+FF'} {'DSSW+HF'} {'Pool'}];
Names2 = [{'Output'} {'Consumption'} {'Investment'} {'Hours'} {'Price level'}  ...
           {'Wages'} {'Interest rate'}];

ncnt = -1;
%for n =  [8 10 11 7 9 12 1];
for n =  8
    vnm     = varNames{n};
    ncnt = ncnt + 1;
    mcnt = 0;
    for m = [1 2 3 7]; 
        mcnt = mcnt + 1;
        mnm = Names1{mcnt}; 
        
        eval(['y  = ALLfct{m}.', vnm ,';']); a = y.act(:,H); f = y.fct(:,H);         
        
        if n==1 || n==7  % for FedFunds and log hours: to calculate changes in level
           T = size(a,1); eval(['ref =',vnm,'(end-T:end-1);'])
           f = f(~isnan(a)) - ref(~isnan(a));  a = a(~isnan(a)) - ref(~isnan(a));
        else
           f = f(~isnan(a)); a = a(~isnan(a));
        end
                      
        xticks = [-0.4 -0.2 0.00 0.2 0.4];
        yticks = [-0.4 -0.2 0.00 0.2 0.4];
        
        subplot1 = subplot(7,4,ncnt*4+mcnt,'Parent',figure1, 'FontName','Times New Roman', 'FontSize', 10);
        hold(subplot1,'all');
            
        
        scatter(f,a,'filled','Marker','.','MarkerFaceColor',[0.3 0.3 0.3], 'MarkerEdgeColor',[0 0 0],'Parent', subplot1)
        if n == 8
            xlim([-8 5]); ylim([-8 5]);
        elseif n == 9
            xlim([0 6]); ylim([0 6]);
        elseif n == 1
            xlim([-5 5]); ylim([-5 5]);
        elseif n == 10
            xlim([-8 5]); ylim([-8 5]);
        elseif n == 11
            xlim([-30 15]); ylim([-30 15]);
        elseif n == 12
            xlim([-2 6]); ylim([-2 6]);
        elseif n == 7
            xlim([-8 5]); ylim([-8 5]);
        end
        
        hline = refline([1 0]);
        set(hline,'Color', [0 0 0], 'LineWidth',2);
        
        rline = lsline;
        set(rline,'LineStyle','--', 'Color', [0 0 0], 'LineWidth',1);
        
        if n == 8
            xlim([-8 5]); ylim([-8 5]);
        elseif n == 9
            xlim([0 6]); ylim([0 6]);
        elseif n == 1
            xlim([-5 5]); ylim([-5 5]);
        elseif n == 10
            xlim([-8 5]); ylim([-8 5]);
        elseif n == 11
            xlim([-30 15]); ylim([-30 15]);
        elseif n == 12
            xlim([-2 6]); ylim([-2 6]);
        elseif n == 7
            xlim([-8 5]); ylim([-8 5]);
        end

        if m == 1; ylabel(Names2{ncnt+1}); end;
        if n == 8, title(mnm, 'VerticalAlignment','bottom', 'FontSize', 12); end
    end
end    
  


H = 4;

figure1 = figure('Color',[1 1 1]);
%axes1 = axes('Parent',figure1);
%hold(axes1,'all');        

Names1 = [{'DSSW'} {'DSSW+FF'} {'DSSW+HF'} {'Pool'}];
Names2 = [{'GDP'} {'consumption'} {'investment'} {'hours worked'} {'GDP deflator'}  ...
           {'nominal wages'} {'Fed rate'}];

ncnt = -1;
for n =  [8 10 11 7 9 12 1];
    vnm     = varNames{n};
    ncnt = ncnt + 1;
    mcnt = 0;
    for m = [1 2 3 7]; % loop for models (m=2 for BVAR(1), m=4 for SBVAR(1), m=6 for LSBVAR(1)
        mcnt = mcnt + 1;
        mnm = Names1{mcnt}; 
        
        eval(['y  = ALLfct{m}.', vnm ,';']); a = y.act(:,H); f = y.fct(:,H);         
        
        if n==1 || n==7  % for FedFunds and log hours: to calculate changes in level
           T = size(a,1); eval(['ref =',vnm,'(end-T:end-1);'])
           f = f(~isnan(a)) - ref(~isnan(a));  a = a(~isnan(a)) - ref(~isnan(a));
        else
           f = f(~isnan(a)); a = a(~isnan(a));
        end
                      
        xticks = [-0.4 -0.2 0.00 0.2 0.4];
        yticks = [-0.4 -0.2 0.00 0.2 0.4];
        
        subplot1 = subplot(7,4,ncnt*4+mcnt,'Parent',figure1, 'FontName','Times New Roman', 'FontSize', 10);
        hold(subplot1,'all');
            
        
        scatter(f,a,'filled','Marker','.','MarkerFaceColor',[0.3 0.3 0.3], 'MarkerEdgeColor',[0 0 0],'Parent', subplot1)
        
        if n == 8
            xlim([-8 10]); ylim([-8 10]);
        elseif n == 10
            xlim([-8 10]); ylim([-8 10]);
        elseif n == 11
            xlim([-40 20]); ylim([-40 20]);
        elseif n == 7
            xlim([-15 5]); ylim([-15 5]);    
        elseif n == 9
            xlim([0 10]); ylim([0 10]);
        elseif n == 12
            xlim([-5 10]); ylim([-5 10]);
        elseif n == 1
            xlim([-10 5]); ylim([-10 5]);
        end
             
        hline = refline([1 0]);
        set(hline,'Color', [0 0 0], 'LineWidth',2);
        
        rline = lsline;
        set(rline,'LineStyle','--', 'Color', [0 0 0], 'LineWidth',1);
        
        if n == 8
            xlim([-8 10]); ylim([-8 10]);
        elseif n == 10
            xlim([-8 10]); ylim([-8 10]);
        elseif n == 11
            xlim([-40 20]); ylim([-40 20]);
        elseif n == 7
            xlim([-15 5]); ylim([-15 5]);    
        elseif n == 9
            xlim([0 10]); ylim([0 10]);
        elseif n == 12
            xlim([-5 10]); ylim([-5 10]);
        elseif n == 1
            xlim([-10 5]); ylim([-10 5]);
        end
        
              
        if m == 1; ylabel(Names2{ncnt+1}); end;
        if n == 8, title(mnm, 'VerticalAlignment','bottom', 'FontSize', 12); end
    end
end    
  