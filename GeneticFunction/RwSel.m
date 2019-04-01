%*************************************************************************%
% The RWSEL function performs roulette wheel selection                                          %
%                                                                                                                                %
% function newpop= RwSel(pop,popsize,fitness)                                                       %
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    fitness- fitness, vector                                                                                         %
% Output:                                                                                                                    %
%    newpop- mating pool, matrix                                                                               %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function newpop= RwSel(pop,popsize,fitness)

fitsum= sum(fitness);
if(fitsum ~= 0)
  psel= fitness/fitsum;
  cumpsel= cumsum(psel);
%   disp('cumpsel');
%   disp(cumpsel);
  for i= 1:popsize
    k= 1;
    test= rand;
    while(test > cumpsel(k))
      k= k+1;
    end	
    newpop(i,:)= pop(k,:);
  end
else
  for i= 1:popsize
    k= Pickup(popsize);
    newpop(i,:)= pop(k,:);
  end
end