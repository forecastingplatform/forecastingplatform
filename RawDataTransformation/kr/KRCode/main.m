clear all
format compact

addpath(genpath('dynare\4.2.4')); % Dynare
addpath('util');

% generates draws from posterior of parameters (uses dynare) and saves in
% noff, ff and hh folders. Important! The files use distributed computing toolbox.
run_dssw
run_dssw_ff
run_dssw_hh

% generates draws from predictive density, which are saved in noff, ff and hh yyqq folders
forecast_dssw
forecast_dssw_ff
forecast_dssw_hh

% calculates point forecasts, PITs and logScores and saves everything in
% file ALLfct.mat
forecasts_transform
forecasts_pooling

% Writes down everything in stats.xls file. Important! You need to set Obs object in
% RMSE_tables and PredLL_tables to choose pre-crisis and crisis periods.
% For ET_tables and PIT tables - effeiciency test and PIT charts for full
% sample
RMSE_tables
PredLL_tables
ET_tables
PIT_tables

% Plots rolling-window weights 
Weights_RMSE
Weights_GewAmis

% Figure fan chart for forecasts generated in 2007:3
FigureFanchart.m

