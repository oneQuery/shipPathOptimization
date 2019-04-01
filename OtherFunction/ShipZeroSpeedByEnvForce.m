%************************************************************************%
% 지구고정좌표 Environmental forces(Current force, Wind force)로 인해 
% 발생하는 무인선박의 속도 (zero speed)                                 %
%************************************************************************%

function [U_current_zeroSpeed, U_wind_zeroSpeed,rho_sea,rho_air,Cc,Cw]=...
    ShipZeroSpeedByEnvForce(m,Tu,Ac,Aw,Vc,Vw)

    
    %********************************************************************
    % Current force로 인해 발생하는 무인선박의 속도 (zero speed)
        rho_sea=1025;      % 해수밀도 [kg/m^3]
        Cc=0.44;           % 물의 Drag Coefficient (레이놀드 수 500~2000000 가정)
                           % 실제로는 레이놀드 수가 작은 가상의 선박
        U_current_zeroSpeed=Tu/m/2*rho_sea*Ac*Cc*Vc^2;  % Current로 인해 
                                                        % 발생하는 선속(zero speed)
    %*********************************************************************
    


    %********************************************************************
    % Wind force로 인해 발생하는 무인선박의 속도 (zero speed)
        rho_air=1.225;          % 공기밀도 [kg/m^3]. 해수면에서 15ºC일 때 
                                % 공기의 밀도
        Cw=0.44;                % 공기의 Drag Coefficient (공기는 동점성계수가 
                                % 낮아 레이놀드 수가매우 큼)
        U_wind_zeroSpeed=Tu/m/2*rho_air*Aw*Cw*Vw^2;     % Wind로 인해 
                                                        % 발생하는 선속(zero
                                                        % speed)
    %********************************************************************










end