%*************************************************************************%
% The BSIMPMUT function performs simple mutation                                                 %
%                                                                                                                               %
% function [pop,nmutat]= bSimpMut(pop,popsize,lchrom,pmutat)                             %
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    lchrom- chromosome length                                                                               %
%    pmutat- mutation probability                                                                                 %
% Output:                                                                                                                    %
%    pop- mutated population, matrix                                                                           %
%    nmutat- number of times mutation was performed                                                %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function [pop,nmutat]= bSimpMut(pop,popsize,lchrom,pmutat)

nmutat= 0;
for i= 1:popsize
  for j= 1:lchrom
    if (rand <= pmutat)
      nmutat= nmutat+1;
      if (pop(i,j)  <= 0.5)
        pop(i,j)= 1;
      else
        pop(i,j)= 0;
      end
    end
  end
end