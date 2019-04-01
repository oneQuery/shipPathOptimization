%************************************************************************%
% 목표점 도달판단 허용 범위 설정 및 plot                                   %
%************************************************************************%

function [TargetPoint,TargetRange,TargetRoundx,TargetRoundyu,TargetRoundyl]...
    =DetTarget
    
%     xshift=300;

    % set target point
%     TargetPoint = [-600 1000];      % Case 1
%     TargetPoint = [-400 1000];      
    TargetPoint = [0 1000];  
%     TargetPoint = [400 1000];      
%     TargetPoint = [0+xshift 1000];        


    TargetRange=30;
    
    x=-TargetRange:0.01:TargetRange;
    yu=sqrt(TargetRange.^2-x.^2);
    yl=-sqrt(TargetRange.^2-x.^2);
    
    TargetRoundx=x+TargetPoint(1);
    TargetRoundyu=yu+TargetPoint(2);
    TargetRoundyl=yl+TargetPoint(2);

end
