%*************************************************************************%
% The BREPPOP function presents a population report                                             %
%                                                                                                                                %
% function bRepPop(gen,pop,popsize,npara,lsubstr,x,objfunc,fitness,opts)              %
% Input:                                                                                                                       %
%    gen- generation                                                                                                   %
%    pop- population of chromesomes, matrix                                                            %
%    popsize- population size                                                                                     %
%    npara- number of variables to be decoded                                                        %
%    lsubstr- length of the substrings, vector                                                              %
%    x- variables, matrix                                                                                              %
%    objfunc- objective function value, vector                                                              %
%    fitness- fitness, vector                                                                                         %
%    opts- options for the report(1~3)                                                                         %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                   % 
%*************************************************************************%
function RepPop(gen,pop,popsize,npara,lsubstr,x,objfunc,fitness,opts)

for i= 1:popsize
  fprintf('%3d) ',i);
  first= 1;
  last= 0;
  for j= 1:npara
    last= last+lsubstr(j);
    fprintf('%d',pop(i,first:last));
    fprintf(' ');
    first= first+lsubstr(j);
  end
  if(opts >= 2)
    fprintf('  %6.3f',x(i,1:npara));
  end
  if(opts >= 3)
    fprintf('  %6.3f  %6.3f',objfunc(i), fitness(i));
  end
  fprintf('\n');
end
fprintf('\n');
	