%*************************************************************************%
% The BOPXOVER function performs one-point crossover                                        %
%                                                                                                                                %
% function [pop,nxover]= bOpXover(pop,popsize,lchrom,pcross)                            %
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    lchrom- chromosome length                                                                               %
%    pcross- crossover probability                                                                             %
% Output:                                                                                                                    %
%    pop- mated population, matrix                                                                             %
%    nxover- number of times crossover was performed                                            %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function [pop,nxover]= bOpXover(pop,popsize,lchrom,pcross)

nxover= 0;
halfpop= floor(popsize/2);
for i= 1:halfpop
  if (rand <= pcross)
    nxover= nxover+1;
    mate1= 2*i-1;
    mate2= 2*i;
    xpoint= Pickup(lchrom-1);
    temp= pop(mate1,xpoint+1:lchrom);
    pop(mate1,xpoint+1:lchrom)= pop(mate2,xpoint+1:lchrom);
    pop(mate2,xpoint+1:lchrom)= temp;
  end
end

