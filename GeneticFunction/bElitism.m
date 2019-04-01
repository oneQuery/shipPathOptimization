%*************************************************************************%
% The BELITISM function performs elitism                                                                  %
%                                                                                                                                %
% function [pop,x,objfunc]=bElitism(pop,x,objfunc,chrombest,xbest,objbest,maxmin)%
% Input:                                                                                                                      %
%    pop- population of chromosomes, matrix                                                            %
%    x- variables, matrix                                                                                              %
%    objfunc- objective function value                                                                         %
%    chrombest- best chromosome, vector                                                                %
%    xbest- variables, vector                                                                                       %
%    objbest- best objective function value                                                                  %
%    maxmin= -1 for minimization, 1 for maximization                                                   %
% Output:                                                                                                                    %
%    pop- modified population of chromosomes, matrix                                              %
%    x- modified variables, matrix                                                                                %
%    objfunc- modified objective function value                                                           %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function [pop,x,objfunc,cutvector,P_Hor,P_Ver,S,T]...
    = bElitism(pop,x,objfunc,chrombest,xbest,objbest,maxmin,cutbest,...
    P_Hor_best,P_Ver_best,cutvector,P_Hor,P_Ver,S,S_best,T,T_best)

if(maxmin==1)
   cobjbest= max(objfunc);
   if(cobjbest < objbest)
      [objworst, index]= min(objfunc);
      pop(index,:)= chrombest;
      x(index,:)= xbest;
      objfunc(index)= objbest;
      cutvector(index)=cutbest;
      P_Hor(index,:)=P_Hor_best;
      P_Ver(index,:)=P_Ver_best;
      S(index)=S_best;
      T(index)=T_best;
   end
else
   cobjbest= min(objfunc);
   if(cobjbest > objbest)
     [objworst, index]= max(objfunc);
      pop(index,:)= chrombest;
      x(index,:)= xbest;
      objfunc(index)= objbest;
      cutvector(index)=cutbest;
      P_Hor(index,:)=P_Hor_best;
      P_Ver(index,:)=P_Ver_best;
      S(index)=S_best;
      T(index)=T_best;
   end
end
