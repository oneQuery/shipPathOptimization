%*************************************************************************%
% The EVALFIT1 function converts objective function values into fitness                     %
%                                                                                                                                %
% function fitness= EvalFit1(objfunc,popsize)                                                             %
% Input:                                                                                                                      %
%    objfunc- objective function value, vector                                                              %
%    popsize- population size                                                                                     %
% Output:                                                                                                                    %
%    fitness- fitness, vector                                                                                         %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function fitness= EvalFit1(objfunc,popsize)

gamma=0.002;
fitness= 1./(gamma+objfunc);

% fitness= objfunc;

fitmin= min(fitness);
if(fitmin < 0)
   disp('Fitness is negative  !');
end

