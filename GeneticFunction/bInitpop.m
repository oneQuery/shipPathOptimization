%*************************************************************************%
% The BINITPOP function creates an initial population                                               %
%                                                                                                                                %
% function pop= bInitPop(rseed,popsize,lchrom)                                                       %
% Input:                                                                                                                      %
%    rseed- random seed                                                                                           %
%    popsize- population size                                                                                     %
%    lchrom- chromesome length                                                                               %
% Output:                                                                                                                    %
%    pop- population                                                                                                   %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                   % 
%*************************************************************************%
function pop= bInitpop(rseed,popsize,lchrom)

rand('seed', rseed); 
% rand('seed',sum(100*clock))  % sets the uniform generator seed to 
                                                   % a different value each time
pop= [(rand(popsize, lchrom) < 0.5)];

