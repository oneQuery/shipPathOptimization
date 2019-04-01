                                                                    %
function [Vrc,Vrw,x_E,theta_s_S,theta_ic_S,theta_iw_S]=...
    DeriveVr(x,U_current_zeroSpeed,U_wind_zeroSpeed,Vs,CurrentAngle,WindAngle,Vc,Vw)

    %  지구고정좌표계에서의 각포인트 선회각 계산 [rad]
        x_E=cumsum(x,2);                   % 지구고정좌표계에서의 각포인트 선회각 [rad]. 12시 방향 기준
    
        
        
    %*******************************************************************
        % Current의 속도벡터 각도를 선체기준좌표 각도로 변환
            theta_ic_E=CurrentAngle+pi;        % 지구고정좌표에서 Current로 발생한 선속벡터의 각도
            theta_ic_S=theta_ic_E-x_E;         % 선체고정좌표에서 Current로 발생한 선속벡터의 각도

        % Wind의 속도벡터 각도를 선체기준좌표 각도로 변환
            theta_iw_E=WindAngle+pi;            % 지구고정좌표에서 Wind로 발생한 선속벡터의 각도
            theta_iw_S=theta_iw_E-x_E;          % 선체고정좌표에서 Wind로 발생한 선속벡터의 각도
    %*******************************************************************
        
        
    %*******************************************************************
        % 선체기준좌표의 추력방향 선속벡터 각도 도출
            theta_s_S=asin(1/Vs*(U_current_zeroSpeed*sin(theta_ic_S)+...
                U_wind_zeroSpeed*sin(theta_iw_S)));
    %*******************************************************************

    % Vp의 속도로 진행하는 선박이 느끼는 Vr 계산
      
        Vp=Vs.*cos(theta_s_S)+U_current_zeroSpeed.*cos(theta_ic_S)+...
            U_wind_zeroSpeed.*cos(theta_iw_S);    % 선박 진행방향의 속도벡터 계산

        u=Vp.*cos(x_E);      % 선박 zero speed의 x방향 속도 성분
        v=Vp.*sin(x_E);      % 선박 zero speed의 y방향 속도 성분
        u_c=Vc.*cos(x_E);    % current의 x방향 속도 성분
        v_c=Vc.*sin(x_E);    % current의 y방향 속도 성분
        u_w=Vw.*cos(x_E);    % current의 x방향 속도 성분
        v_w=Vw.*sin(x_E);    % current의 y방향 속도 성분
        
        Vrc=sqrt((u-u_c).^2+(v-v_c).^2);      % Vp의 속도로 진행하는 선박이
                                             % 느끼는 current velocity 크기
        Vrw=sqrt((u-u_w).^2+(v-v_w).^2);      % Vp의 속도로 진행하는 선박이
                                             % 느끼는 wind velocity 크기

    end


