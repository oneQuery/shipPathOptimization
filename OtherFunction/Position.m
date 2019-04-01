%% 추력에 의한 선속과 environmental force (current force, wind force)로 발생한
 % 속도를 이용한 x(선박 진행각)에 따른 포인트 좌표


function [P_Hor,P_Ver,Sp,theta_s_S,Vp]=Position(npara,popsize,Vs,Tu,...
    Vrc,Vrw,m,Ac,Aw,rho_sea,rho_air,Cc,Cw,x_E,theta_s_S,theta_ic_S,...
    theta_iw_S,tau_wave_surge, tau_wave_sway)
%%
global Vc
global Vw
global Hs

%% Environmetal Load의 Relative Velocity로 인해 발생하는 선속

            % Relative Current Velocity로 인해 발생하는 선속 벡터
                U_rc=Tu./m./2.*rho_sea.*Ac.*Cc.*Vrc.^2;     
                                                                                  
            % Relative Wind Velocity로 인해 발생하는 선속 벡터
                U_rw=Tu./m./2.*rho_air.*Aw.*Cw.*Vrw.^2;         

        %% Wave Force
                
            U_iwave_surge=tau_wave_surge/m*Tu;                  % Surge 방향 선속
            U_iwave_sway=tau_wave_sway/m*Tu;                    % Sway 방향 선속
            U_iwave=sqrt(U_iwave_sway.^2+U_iwave_surge.^2);     % Wave로 인해 발생하는 선속
%             U_iwave=0;
            theta_iwave_S=atan2(U_iwave_surge, U_iwave_sway);   % Wave로 인해 발생하는 선속 방향 (선체 기준)
            
        
                

        %% 선속이 환경하중으로 인해 발생한 속도를 극복하지 못하는 개체 선별

                VsLackPop=zeros(1,popsize);
                for i=1:popsize

                        for j=1:npara

                            if imag(theta_s_S(i,j))>0
                               VsLackPop(i)=1;     % 해당 pop(i값) 1
                                break;
                            end
                        break;
                        end

                end
        
   

        %% ship velosity induced by thrust and environmental load
            % no environmental load
                if Vc == 0 && Vw == 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S);
                end
            % current, wind, wave
                if Vc ~= 0 && Vw ~= 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_rw.*cos(theta_iw_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % wind, wave
                if Vc == 0 && Vw ~= 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rw.*cos(theta_iw_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % current, wave
                if Vc ~= 0 && Vw == 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_iwave.*cos(theta_iwave_S); 
                end
            % current, wind
                if Vc ~= 0 && Vw ~= 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S)+U_rw.*cos(theta_iw_S); 
                end
            % current
                if Vc ~= 0 && Vw == 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rc.*cos(theta_ic_S); 
                end
            % wind
                if Vc == 0 && Vw ~= 0 && Hs == 0
                    Vp=Vs.*cos(theta_s_S)+U_rw.*cos(theta_iw_S); 
                end
            % wave
                if Vc == 0 && Vw == 0 && Hs ~= 0
                    Vp=Vs.*cos(theta_s_S)+U_iwave.*cos(theta_iwave_S); 
                end
                
                %%
                Sp=Vp.*Tu;                                   % 선박 진행방향의 이동거리 계산
                Sp_Hor=Sp.*sin(x_E);                           % 선박의 가로방향 이동거리 계산
                Sp_Ver=Sp.*cos(x_E);                           % 선박의 세로방향 이동거리 계산
                P_Hor=cumsum(Sp_Hor,2);                     % 선박의 가로방향 좌표 계산
                P_Ver=cumsum(Sp_Ver,2);                     % 선박의 세로방향 좌표 계산

        %% 선속이 환경하중으로 인해 발생한 속도를 극복하지 못할 경우 경로생성 제외(정지상태로 간주)
                for i=1:popsize
                    if VsLackPop(i)==1
                       P_Hor(i,:)=zeros;
                       P_Ver(i,:)=zeros;
                    end
                end
    end


