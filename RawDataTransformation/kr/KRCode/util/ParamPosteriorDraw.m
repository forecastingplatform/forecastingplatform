function [xparams, logpost]=ParamPosteriorDraw(draw_, ChainNumber, DrawNumber)

% function [xparams, logpost]=ParamPosteriorDraw(init) 
% Builds draws from metropolis
%
% INPUTS:
%   init:              scalar equal to 1 (first call) or 0
%
% OUTPUTS:
%   xparams:           vector of estimated parameters
%   logpost:           log of posterior density
%   
% SPECIAL REQUIREMENTS
%   none

% Copyright (C) 2003-2009 Dynare Team
%
% This file is part of Dynare.
%
% Dynare is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% Dynare is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Dynare.  If not, see <http://www.gnu.org/licenses/>.

%global options_ estim_params_ M_

% Adjusted by Michal Rubaszek to take non-random draws

mh_nblck      = draw_.mh_nblck;
NumberOfDraws = draw_.NumberOfDraws;
fname         = draw_.fname;
FirstLine     = draw_.FirstLine;
FirstMhFile   = draw_.FirstMhFile; 
MAX_nruns     = draw_.MAX_nruns;

%ChainNumber = ceil(rand*mh_nblck);
%DrawNumber  = ceil(rand*NumberOfDraws);

if DrawNumber <= MAX_nruns-FirstLine+1
    MhFilNumber = FirstMhFile;
    MhLine = FirstLine+DrawNumber-1;
else
    DrawNumber  = DrawNumber-(MAX_nruns-FirstLine+1);
    MhFilNumber = FirstMhFile+ceil(DrawNumber/MAX_nruns); 
    MhLine = DrawNumber-(MhFilNumber-FirstMhFile-1)*MAX_nruns;
end

load( [ fname '_mh' int2str(MhFilNumber) '_blck' int2str(ChainNumber) '.mat' ],'x2','logpo2');
xparams = x2(MhLine,:);
logpost= logpo2(MhLine);