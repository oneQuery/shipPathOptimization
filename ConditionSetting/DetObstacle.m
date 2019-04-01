%************************************************************************%
% 장애물 범위 설정 및 plot                                   %
%************************************************************************%

function [ObstacleNumber,ObstaclePoint,ObstacleRange,ObstacleRoundx,ObstacleRoundyu,...
    ObstacleRoundyl,ObstacleRange_e,e,ObstacleRoundx_e,ObstacleRoundyu_e,...
    ObstacleRoundyl_e]=DetObstacle
%% 
global rseed1
global nO1
global e

%% obstacle condition
% random seed & number of obstacles
% rseed1    = 13 ;     
% rseed1    = 14 ;     
rseed1    = 16 ;     
% rseed1    = 138 ;     % Fig 14

nO1       = 60 ;     
        
        

%%
    % 장애물 좌표, 범위 설정. [x좌표 y좌표 장애물 반지름]
    
    e=10;        % 장애물 접근 제한 거리
    
    %% 장애물 위치 상황들
%--------------------------------------------------------------------------
    % 장애물 회피 Case 1
%         r1=30;
%         n1=10;
%         rO1=4;
%         theta1=linspace(0,360,n1)-30;
%         theta1=theta1*pi/180;
%         xO1=r1*cos(theta1);
%         xO1=xO1';
%         yO1=r1*sin(theta1);
%         yO1=yO1';
%         yO1=yO1+50;
% 
% 
% 
%         r2=15;
%         n2=8;
%         rO2=4;
%         theta2=linspace(0,360,n2);
%         theta2=theta2*pi/180;
%         xO2=r2*cos(theta2);
%         xO2=xO2';
%         yO2=r2*sin(theta2);
%         yO2=yO2';
%         yO2=yO2+50;
% 
% 
%         r3=0;
%         n3=1;
%         rO3=5;
%         theta3=linspace(0,360,n3);
%         theta3=theta3*pi/180;
%         xO3=r3*cos(theta3);
%         xO3=xO3';
%         yO3=r3*sin(theta3);
%         yO3=yO3';
%         yO3=yO3+50;
% 
%              ObstaclePoint1(:,1)=xO1;
%              ObstaclePoint1(:,2)=yO1;
%              ObstaclePoint1(:,3)=rO1;
% 
%              ObstaclePoint2(:,1)=xO2;
%              ObstaclePoint2(:,2)=yO2;
%              ObstaclePoint2(:,3)=rO2;
% 
%             ObstaclePoint3(:,1)=xO3;
%              ObstaclePoint3(:,2)=yO3;
%              ObstaclePoint3(:,3)=rO3;
%          
%          
%                 ObstaclePoint=vertcat(ObstaclePoint1, ObstaclePoint2, ObstaclePoint3);
%--------------------------------------------------------------------------

%         % 장애물 회피 Case (원형장애물)
%         
%         xshift=300;
%         
%         r1=30*10;
%         n1=10;
%         rO1=4*10;
%         theta1=linspace(0,360,n1)-30;
%         theta1=theta1*pi/180;
%         xO1=r1*cos(theta1);
%         xO1=xO1';
%         yO1=r1*sin(theta1);
%         yO1=yO1';
%         yO1=yO1+50*10;
% 
% 
% 
%         r2=15*10;
%         n2=8;
%         rO2=4*10;
%         theta2=linspace(0,360,n2);
%         theta2=theta2*pi/180;
%         xO2=r2*cos(theta2);
%         xO2=xO2';
%         yO2=r2*sin(theta2);
%         yO2=yO2';
%         yO2=yO2+50*10;
% 
% 
%         r3=0;
%         n3=1;
%         rO3=5*10;
%         theta3=linspace(0,360,n3);
%         theta3=theta3*pi/180;
%         xO3=r3*cos(theta3);
%         xO3=xO3';
%         yO3=r3*sin(theta3);
%         yO3=yO3';
%         yO3=yO3+50*10;
% 
%              ObstaclePoint1(:,1)=xO1+xshift;
%              ObstaclePoint1(:,2)=yO1;
%              ObstaclePoint1(:,3)=rO1;
% 
%              ObstaclePoint2(:,1)=xO2+xshift;
%              ObstaclePoint2(:,2)=yO2;
%              ObstaclePoint2(:,3)=rO2;
% 
%             ObstaclePoint3(:,1)=xO3+xshift;
%              ObstaclePoint3(:,2)=yO3;
%              ObstaclePoint3(:,3)=rO3;
%          
%          
%                 ObstaclePoint=vertcat(ObstaclePoint1, ObstaclePoint2, ObstaclePoint3);
    
%--------------------------------------------------------------------------
%             ObstaclePoint=[-50/6*10 200/6*10 60/6*10; 50/6*10 350/6*10 60/6*10];
% ObstaclePoint=[150 250 40; 210 400 55; 240 530 35 ; 370 400 45; 450 320 30];

%--------------------------------------------------------------------------
    % 장애물 Case 3 (복잡한 장애물)
% ObstaclePoint=[15 86 7/2; 10 79 7/2;40 95 10/2;...
%     30 70+5 5/2; 55 70+5 5/2+5; 70 73+5 5/2;...
%     5 48+5 10/2; 18 45+5 13/2;  55 45+5 10/2 ;85 50+5 7/2;...
%     25 120 8; -20 60 8;...
%     60 100 2; 35 60 2];
%--------------------------------------------------------------------------
%% 
rand('seed', rseed1);     
xO1 = rand(nO1,1);
yO1 = rand(nO1,1);
xO1 = xO1*1800-900;
yO1 = yO1*1600/2+200/2;
xO1 = xO1';
yO1 = yO1';
rO1 = rand(nO1,1)*50*1.8;     %radius of obstacles

%         rseed2=573;
%         rand('seed', rseed2); 
%         nO2=20;
%         xO2=rand(nO2,1);
%         yO2=rand(nO2,1);
%         xO2=xO2*600+100;
%         yO2=yO2*800-300;
%         xO2=xO2';
%         yO2=yO2';
%         rO2=rand(nO2,1)*100;

        ObstaclePoint1(:,1)=xO1;
        ObstaclePoint1(:,2)=yO1;
        ObstaclePoint1(:,3)=rO1;
%         ObstaclePoint2(:,1)=xO2;
%         ObstaclePoint2(:,2)=yO2;
%         ObstaclePoint2(:,3)=rO2;
        ObstaclePoint=ObstaclePoint1;
%                         ObstaclePoint=vertcat(ObstaclePoint1, ObstaclePoint2);
%--------------------------------------------------------------------------
%     % 장애물 Case 4 (단순 장애물)

%         ObstaclePoint=[0 500 200];
%         ObstaclePoint=[0 300 160; 400 900 160];
    %%
    ObstacleNumber=length(ObstaclePoint(:,1));
    ObstacleRange=zeros(ObstacleNumber,1);
    ObstacleRange_e=ObstaclePoint(:,3)+e;
    
    for i=1:ObstacleNumber;
        ObstacleRange(i)=ObstaclePoint(i,3);
                
        x(i,:)=linspace(-ObstacleRange(i),ObstacleRange(i),50);
%         disp(x);
        
        yu(i,:)=sqrt(ObstacleRange(i).^2-x(i,:).^2);
        yl(i,:)=-sqrt(ObstacleRange(i).^2-x(i,:).^2);
        ObstacleRoundx(i,:)=x(i,:)+ObstaclePoint(i,1);
        ObstacleRoundyu(i,:)=yu(i,:)+ObstaclePoint(i,2);
        ObstacleRoundyl(i,:)=yl(i,:)+ObstaclePoint(i,2);
        
        x_e(i,:)=linspace(-ObstacleRange(i)-e,ObstacleRange(i)+e,50);
        
        yu_e(i,:)=sqrt((ObstacleRange(i)+e).^2-x_e(i,:).^2);
        yl_e(i,:)=-sqrt((ObstacleRange(i)+e).^2-x_e(i,:).^2);
        ObstacleRoundx_e(i,:)=x_e(i,:)+ObstaclePoint(i,1);
        ObstacleRoundyu_e(i,:)=yu_e(i,:)+ObstaclePoint(i,2);
        ObstacleRoundyl_e(i,:)=yl_e(i,:)+ObstaclePoint(i,2);
    end
end
