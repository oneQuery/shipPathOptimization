%*************************************************************************%
% The EVALOBJ1 function evaluates example function #1                                          %
%                                                                                                                                %
% function objfunc= EvalObj1(x,npara,popsize)                                                          %
% Input:                                                                                                                      %
%    x- variables, matrix                                                                                              %
%    npara- number of the variables                                                                           %
%    popsize- population size                                                                                     %
% Output:                                                                                                                    %
%    objfunc- objective function value, vector                                                              %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function [objfunc]...
    = EvalObj1(popsize,TargetPoint,TargetRange,ObstacleNumber,...
    ObstaclePoint,ObstacleRange_e,P_Hor,P_Ver,cutvector,Sp,T)

%********************************************************************
% 가중치 & gamma 정해주기
    WeightObjFuncDist=0;        % 이동거리 목적함수 가중치
    WeightObjFuncTime=1;        % 이동소요시간 목적함수 가중치
    
    gamma_T=0;                 % 이동소요시간 목적함수 mapping gamma
    
%********************************************************************









%************************************************************************%
%   목적함수(작아야 좋은 것으로)
    
    % 계산에 쓰이는 행렬들 공간벡터 형성
%         objfunc=zeros(popsize,1);
%         objfuncTarget=zeros(popsize,1);
%         EachobjfuncObstacle=zeros(popsize,ObstacleNumber);
%         objfuncObstacle=zeros(popsize,1);
%         objfuncDistance=zeros(popsize,1);
%         objfuncTime=zeros(popsize,1);
        
        for i=1:popsize;
        
            % 목표점을 무조건 경유하는 목적함수 
                if sqrt((P_Hor(i,cutvector(i))-TargetPoint(1))^2+...
                        (P_Ver(i,cutvector(i))-TargetPoint(2))^2)<=TargetRange;
                     objfuncTarget(i)=0;
                else
                     objfuncTarget(i)=inf;
                end

           % 장애물을 무조건 회피하는 목적함수
        
            for Ob=1:ObstacleNumber
                
                for k=1:cutvector(i);
                    if sqrt((ObstaclePoint(Ob,1)-P_Hor(i,k))^2+...
                        (ObstaclePoint(Ob,2)-P_Ver(i,k))^2)<=ObstacleRange_e(Ob);                                               %  
                             EachobjfuncObstacle(i,Ob)=inf;   
                        break;
                    else
                        EachobjfuncObstacle(i,Ob)=0;     
                    end                                                          %
                end
            end

            objfuncObstacle(i)=max(EachobjfuncObstacle(i,:));

    % 목표점까지의 이동거리 목적함수
            objfuncDistance(i)=sum(Sp(i,1:cutvector(i)));


    % 목표점까지의 이동소요시간 목적함수
            objfuncTime(i)=T(i)-gamma_T;


   



% 최종 목적함수
            objfunc(i)=objfuncTarget(i)+objfuncObstacle(i)...
                +WeightObjFuncDist*objfuncDistance(i)+...
                WeightObjFuncTime*objfuncTime(i);



        end
% disp(objfuncDistance);
% disp(cutvector);
end

