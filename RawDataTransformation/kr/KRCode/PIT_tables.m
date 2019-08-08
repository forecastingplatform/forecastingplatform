% CHI SQUARE GOODNESS OF FIT TEST    
% http://www.itl.nist.gov/div898/software/dataplot/refman1/auxillar/chsqgood.htm

clear
load('ALLfct.mat');


% modelNames = [{'noff'} {'ff'} {'hh'} {'p110'} {'p101'} {'p011'} {'p111'}];
varNames = fieldnames(ALLfct{1});
M        = size(modelNames,2);
N        = size(varNames,1);   % number of variables
H        = 24;                 % forecast horizon


for n=1:N
    vnm     = varNames{n};
    GoF     = NaN(M,H);
    GoFp    = NaN(M,H);
        
    for m = 1:M
        eval(['y  = ALLfct{m}.', vnm ,';'])
        for h = 1:H
            pith        = y.pit(:,h); pith = pith(~isnan(pith));   % removing NaNs
            T           = length(pith);
            edges       = (0:11)/10;
            z           = histc(pith,edges); 
            z           = z(1:10)/T*100;    % in each bin there should be 10% of hits
            GoF(m,h)    = sum((z - 10*ones(10,1)).^2)/10;
            GoFp(m,h)   = 1-chi2cdf(GoF(m,h),9);
        end
    end
        
    eval(['stat.',vnm,'.GoF    = GoF;']);
    eval(['stat.',vnm,'.GoFp   = GoFp;']);
        
    horiz = [1 2 3 4 6 8 12 16 24];
    
%    xlswrite('stats', {'GoF Stat.'},             vnm, ['M' num2str(3*M+7)]);
%    xlswrite('stats', modelNames'  ,             vnm, ['M' num2str(3*M+8)]);
%    xlswrite('stats', GoF(:,horiz) ,             vnm, ['N' num2str(3*M+8)]);
    
%    xlswrite('stats', {'GoF Prob.'},             vnm, ['M' num2str(4*M+9)]);
%    xlswrite('stats', modelNames'  ,             vnm, ['M' num2str(4*M+10)]);
%    xlswrite('stats', GoFp(:,horiz) ,            vnm, ['N' num2str(4*M+10)]);
  
end

save('ALLfct.mat', 'stat', '-append');   


% Nine figures 7x3 for models, variables
% Figure for h = 4
        
H = 4;

Names1 = [{'DSSW'} {'DSSW+FF'} {'DSSW+HF'} {'Pool'}];
Names2 = [{'Output'} {'Cons.'} {'Invest.'} {'Hours'} {'Prices'}  ...
           {'Wages'} {'Int. rate'}];

figure1 = figure('Color',[1 1 1]);
axes1 = axes('Parent',figure1,'XTickLabel',{'0-10','10-20','20-30','30-40','40-50','50-60','60-70','70-80','80-90','90-100'},...
    'XTick',[5 15 25 35 45 55 65 75 85 95],'FontName','Times New Roman');
hold(axes1,'all');           

ncnt = -1;
for n =  [8 10 11 7 9 12 1];
    vnm     = varNames{n};
    ncnt = ncnt + 1;
    mcnt = 0;
    for m = [1 2 3 4]; 
        mcnt = mcnt + 1;
        mnm = Names1{mcnt}; 
        
        eval(['y  = ALLfct{m}.', vnm ,';'])
        if m==4
            eval(['y  = ALLfct{7}.', vnm ,';'])
        end
        pith  = y.pit(:,H); pith = pith(~isnan(pith));   % removing NaNs
        T           = length(pith);
        edges       = (0:11)/10;
        z           = histc(pith,edges); 
        z           = z(1:10)/T*100;    % in each bin there should be 10% of hits
                
        %subplot1 = subplot(7,3,ncnt*3+mcnt,'Parent',figure1);
        subplot1 = subplot(7,4,ncnt*4+mcnt,'Parent',figure1);
        hold(subplot1,'all');
        ylim([0 30])
        
        bar(5:10:95,z, 'FaceColor',[0.4 0.4 0.4],'BarWidth',0.6);
        hline = refline([0 10]);
        set(hline,'Color', [0 0 0], 'LineWidth',4);
        
        if m == 1; ylabel(Names2{ncnt+1}); end;
        if n == 8, title(mnm, 'VerticalAlignment','bottom', 'FontSize', 12); end
     end
end



