% For all quarters and years the program:
% a/ runs dssw.mod
% b/ saves all results related to parameter estimation in dssw/yyqq
% c/ copies posterior MH draws in dssw/yyqq
% No forecasts as far

clear all
format compact 
format short


for i = 90:110
    for j = 1:4
       
       cl = clock;
       display(['day ', num2str(cl(3)), ' hour ', num2str(cl(4)), ' minute ', num2str(cl(5))])
       
       %mkdir('dssw');
       %copyfile(['noff/',num2str(i),'q',num2str(j),'/dssw_mh*'],'dssw/metropolis');
       
       nobs = 96 + 4*(i-94) + (j-1);
       save options_dssw.mat nobs i j;
       dynare dssw;
       
       copyfile('dssw/metropolis/dssw_mh*',['noff/',num2str(i),'q',num2str(j)]);
	   copyfile('dssw_mode.mat',['noff/',num2str(i),'q',num2str(j)]);
       copyfile('dssw_mh_mode.mat',['noff/',num2str(i),'q',num2str(j)]);
       global M_ dr1_test ex0_ it_ oo_recursive_  trend_coeff_ bayestopt_  estim_params_  fjac  oo_ options_ ys0_  
       save(['noff/',num2str(i),'q',num2str(j),'/results.mat']);   
       
       rmdir('dssw','s')
       %rmdir('dynareParallelLogFiles','s')
       close all
       
    end
end
