% For all quarters and years the program:
% a/ runs dssw_hh.mod
% b/ saves all results related to parameter estimation in hh/yyqq
% c/ copies posterior MH draws in hh/yyqq
% No forecasts as far

clear all
format compact 
format short


for i = 90:110
    for j = 1:4
       
       cl = clock;
       display(['day ', num2str(cl(3)), ' hour ', num2str(cl(4)), ' minute ', num2str(cl(5))])
       
       %mkdir('dssw_hh');       
       copyfile(['hh/',num2str(i),'q',num2str(j),'/dssw_hh_mode.mat'],'dssw_hh_mode.mat');
       
       nobs = 96 + 4*(i-94) + (j-1);
       save options_dssw_hh.mat nobs i j;
       dynare dssw_hh;
       
       copyfile('dssw_hh/metropolis/dssw_hh_mh*',['hh/',num2str(i),'q',num2str(j)]);
       copyfile('dssw_hh_mode.mat',['hh/',num2str(i),'q',num2str(j)]);
       copyfile('dssw_hh_mh_mode.mat',['hh/',num2str(i),'q',num2str(j)]);
       global M_ dr1_test ex0_ it_ oo_recursive_  trend_coeff_ bayestopt_  estim_params_  fjac  oo_ options_ ys0_  
       save(['hh/',num2str(i),'q',num2str(j),'/results.mat']);   
       
       %rmdir('dssw_hh','s')
       %rmdir('dynareParallelLogFiles','s')
       close all
       
    end
end
