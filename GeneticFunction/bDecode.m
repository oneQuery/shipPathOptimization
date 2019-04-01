%*************************************************************************%
% The BDECODE function decodes binary number to real number                            %
%                                                                                                                               %
% function x= bDecode(pop,popsize,npara,lsubstr,xub,xlb,dmax)                            %
% Input:                                                                                                                      %
%    pop- population of chromesomes, matrix                                                           %
%    popsize- population size                                                                                    %
%    npara- number of variables to be decoded                                                       %
%    lsubstr- length of the substrings, vector                                                             %
%    xub- upper bound for variables, vector                                                              %
%    xlb- lower bound for variables, vector                                                                %
%    dmax- maximum decimal number determined by substring lengths, vector       %
% Output:                                                                                                                   %
%    x- variables, matrix                                                                                             %
%                                                                                                                               %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                   % 
%*************************************************************************%
function x= bDecode(pop,popsize,npara,lsubstr,xub,xlb,dmax)

xdiff= xub-xlb;
for i= 1:popsize
   first= 1;
   last= 0;
   for j= 1:npara
      last= last+lsubstr(j);
      str(1:lsubstr(j))= pop(i,first:last);
      first= first+lsubstr(j);
      xtemp= 0;
      bweight= 1;    
      %********************************************************************
      %2진수 서브스트링을 하나의 10진수로 변환                              %
      for k= 1:lsubstr(j)                                                 %
         xtemp= xtemp+bweight*str(lsubstr(j)-k+1);                        %
         bweight= bweight*2;                                              %
      end                                                                 %
      %********************************************************************
      x(i,j)= xtemp/dmax(j)*xdiff(j)+xlb(j);
   end
end
