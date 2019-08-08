% For all quarters and years the program:
% a/ runs dssw_ff.mod
% b/ saves all results related to parameter estimation in ff/yyqq
% c/ copies posterior MH draws in ff/yyqq
% No forecasts as far

clear all
format compact 
format short


for i = 90:110
    for j = 1:4
       
       cl = clock;
       display(['day ', num2str(cl(3)), ' hour ', num2str(cl(4)), ' minute ', num2str(cl(5))])
       
       %mkdir('dssw_ff');       
       %copyfile(['ff/',num2str(i),'q',num2str(j),'/dssw_ff_mh*'],'dssw_ff/metropolis');
       
       nobs = 96 + 4*(i-94) + (j-1);
       save options_dssw_ff.mat nobs i j;
       dynare dssw_ff;
       
       copyfile('dssw_ff/metropolis/dssw_ff_mh*',['ff/',num2str(i),'q',num2str(j)]);
       copyfile('dssw_ff_mode.mat',['ff/',num2str(i),'q',num2str(j)]);
       copyfile('dssw_ff_mh_mode.mat',['ff/',num2str(i),'q',num2str(j)]);
       global M_ dr1_test ex0_ it_ oo_recursive_  trend_coeff_ bayestopt_  estim_params_  fjac  oo_ options_ ys0_  
       save(['ff/',num2str(i),'q',num2str(j),'/results.mat']);   
       
       rmdir('dssw_ff','s')
       %rmdir('dynareParallelLogFiles','s')
       close all
       
    end
end
