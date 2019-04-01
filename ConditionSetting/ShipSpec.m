%************************************************************************%
% 무인선박 제원 설정                                   %
%************************************************************************%

function [m,Ac,Aw,Vs,Tu,T0,MaxLeftAngle,MaxRightAngle,g,breadth,draft,LWL]=ShipSpec

    
    %*********************************************************************
    % 가상의 무인선박 제원
        m=                    2600;          % 배수량 [kg]
        draft=                0.472;         % 흘수 [m]
        breadth=              5;             % 폭 [m]
        LWL=                  5;             % [m]
        Vs=                   10;            % 추진 선속 [m/s] (설계선속은 10m/s로)
        MaxLeftAngle_degree=  10;            % 초당 최대 좌선회각 [degree]
        MaxRightAngle_degree= 10;            % 초당 최대 우선회각 [degree]
        depthExtreme=         1;           % 최대높이 [m] (합당한 최대높이를 모르겠음)
        
        T0=         300;
%         T0=         150;        % 선박의 총 운용시간 [s]
                                % 운용시간 내 도달 못할 시 경로 찾지 못함
                                % 너무 크면 계산시간오래걸림
                                % 따라서 적당히
        Tu=         1;          % 침로를 변경하는 단위 시간 [s]
        g=9.81;                  % 중력가속도 [m/s]
    %********************************************************************
        MaxLeftAngle_degree=  MaxLeftAngle_degree*Tu;            % 단위시간 당 최대 좌선회각 [degree]
        MaxRightAngle_degree= MaxRightAngle_degree*Tu;            % 단위시간 당 최대 우선회각 [degree]

MaxLeftAngle=           MaxLeftAngle_degree*pi/180;          % 단위시간당 최대 좌선회각 [rad];
MaxRightAngle=          MaxRightAngle_degree*pi/180;        % 단위시간당 최대 우선회각 [rad];
    % 실린더 형태의 가상의 선박으로 가정
    Ac=breadth*draft;                   % 수면아랫부분은 투영면적. 모든방향의 투영면적 같음
    Aw=breadth*(depthExtreme-draft);    % 수면 윗부분의 투영면적. 
    
   
end
