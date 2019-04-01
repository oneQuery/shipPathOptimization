%*************************************************************************%
% The BINITPA1 function initializes the parameters of the SGA                                   %
%                                                                                                                                %
% function [rseed,maxmin,maxgen,popsize,npara,pcross,pmutat,lsubstr,...             %
%                xlb,xub,dmax,lchrom]= bInitPa1                                                               %
% Output:                                                                                                                    %
%    rseed- random seed                                                                                           %
%    maxmin= -1 for minimization, 1 for maximization                                                   %
%    maxgen-	maximum generation                                                                           %
%    popsize- population size(must be an even integer)                                             %
%    npara- number of variables to be decoded                                                         %
%    pcross- crossover probability                                                                             %
%    pmutat- mutation probability                                                                                 %
%    lsubstr- length of the substrings, vector                                                              %
%    xlb- lower bound  of variables                                                                             %
%    xub- upper bound of variables                                                                            %
%    dmax- maximum decimal number determined by substring lengths, vector        %
%    lchrom- chromosome length                                                                               %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                   % 
%*************************************************************************%
function [rseed,maxmin,maxgen,popsize,npara,pcross,pmutat,lsubstr,xlb,...
               xub,dmax,lchrom,Tu]= bInitPa1(T0,Tu,MaxLeftAngle,MaxRightAngle)

           

rseed=	     259; 
maxmin=      -1;             % -1 for minimization

% maxgen=    5;
% maxgen=    10;
% maxgen=    200;
% maxgen=    300;
maxgen=    1000;

% popsize=    250;
% popsize=    500;             % popsize should be even
popsize=    1000;

npara=	        T0/Tu;
pcross=      0.8;
pmutat=     0.8;
% pcross=      0.2;
% pmutat=     0.9;

global ResolvingPower ;
ResolvingPower=40;          % ºÐÇØ´É






lsubstr= ResolvingPower*ones(1,npara);
                                                
xlb= -MaxLeftAngle*ones(1,npara);                                             %   
xub= MaxRightAngle*ones(1,npara);                                              %

dmax= 2.^lsubstr-1;       % do not move 
lchrom= sum(lsubstr);   % do not move
if(rem(popsize, 2) ~= 0) % do not move
   popsize= popsize + 1;
end
