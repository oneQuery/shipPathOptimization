%% Wave 에 의한 Force 계산



function [tau_wave_surge,tau_wave_sway]=...
    waveForce(m,w,spectrum,rho_sea,Tu,T0,Vs,g,...
    WaveAngle,x_E,vessel,rseed,popsize,breadth,draft)

    %% From FPSO to 무인선박. 상사계수 계산
    % (실제론 맞지 않음. Open된 자료가 없어서 RAO를 근사하기 위해 구하는 것임)
        % 제공되는 FPSO의 질량 호출
            m_FPSO=vessel.main.m;
        % 상사 계수 계산
            % 인위적인 mapping 계수
%                 ArtMapCoeff=0.002;
            ArtMapCoeff=1;
            mMapCoeff=m/m_FPSO*ArtMapCoeff;

    %% FPSO의 Wave1 RAO 평균치 계산
        % MSS Toolbox 제공 FPSO의 Surge 방향 Wave1 RAO 호출
            surgeRAO1_FPSO=vessel.forceRAO.amp{1};   
        % Surge RAO 값 평균
            surgeRAO1_FPSO=mean(surgeRAO1_FPSO,2);
%--------------------------------------------------------------------------
        % MSS Toolbox 제공 FPSO의 Sway 방향 Wave1 RAO 호출
            swayRAO1_FPSO=vessel.forceRAO.amp{2};   
        % Sway RAO 값 평균
            swayRAO1_FPSO=mean(swayRAO1_FPSO,2);

    %% FPSO의 Wave2 RAO 평균치 계산
        % MSS Toolbox 제공 FPSO의 Surge 방향 Wave2 RAO 호출
            surgeRAO2_FPSO=vessel.driftfrc.amp{1};   
        % Surge RAO 값 평균
            surgeRAO2_FPSO=mean(surgeRAO2_FPSO,2);
%--------------------------------------------------------------------------
        % MSS Toolbox 제공 FPSO의 Sway 방향 Wave2 RAO 호출
            swayRAO2_FPSO=vessel.driftfrc.amp{2};   
        % Sway RAO 값 평균
            swayRAO2_FPSO=mean(swayRAO2_FPSO,2);
    
    %% 무인선박의 RAO 근사 계산
            surgeRAO1=surgeRAO1_FPSO*mMapCoeff;
            surgeRAO1=surgeRAO1(:,:,1);
            swayRAO1=swayRAO1_FPSO*mMapCoeff;
            swayRAO1=swayRAO1(:,:,1);
            surgeRAO2=surgeRAO2_FPSO*mMapCoeff;
            surgeRAO2=surgeRAO2(:,:,1);
            swayRAO2=swayRAO2_FPSO*mMapCoeff;
            swayRAO2= swayRAO2(:,:,1);
            
%             surgeRAO1=10*surgeRAO1_FPSO*mMapCoeff;
%             surgeRAO1=10*surgeRAO1(:,:,1);
%             swayRAO1=10*swayRAO1_FPSO*mMapCoeff;
%             swayRAO1=10*swayRAO1(:,:,1);
%             surgeRAO2=10*surgeRAO2_FPSO*mMapCoeff;
%             surgeRAO2=10*surgeRAO2(:,:,1);
%             swayRAO2=10*swayRAO2_FPSO*mMapCoeff;
%             swayRAO2= 10*swayRAO2(:,:,1);
    %% 무인선박의 RAO Phase 근사값 추출
            phaseRAO=vessel.forceRAO.phase{1};
            phaseRAO=phaseRAO(:,4);
    
    %% Wave Amplitude 계산
        dw(1)=w(2)-w(1);
        dw(length(w))=w(length(w))-w(length(w)-1);
        for i=2:length(w)-1
            dw(i)=(w(i+1)-w(i))/2+(w(i)-w(i-1))/2;
            A(i,:)=sqrt(2.*spectrum(i).*dw(i));
        end
        A(length(w))=sqrt(2.*spectrum(length(w)).*dw(length(w)));
    
    %% Time Domain 설정
        t=1:Tu:T0;
        
    %% Wave Force 계산
        for i=1:length(w)
            w_e{i,1}=(w(i)-w(i)^2/g*Vs*cos(WaveAngle-x_E));      % Encounter Frequency 계산
        end
        rand('seed',rseed);
        epsilon=max(w)*T0*rand(length(dw),1);       % 주파수의 랜덤위상
        
        % 주파수 별 단위시간마다 받는 Wave Force
            for i=1:length(w)
                for  j=1:popsize
%                     tau_wave1_surge{i,1}(j,:)=rho_sea*g*surgeRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
%                     tau_wave2_surge{i,1}(j,:)=rho_sea*g*surgeRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
%                     tau_wave1_sway{i,1}(j,:)=rho_sea*g*swayRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
%                     tau_wave2_sway{i,1}(j,:)=rho_sea*g*swayRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                    tau_wave1_surge{i,1}(j,:)=surgeRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
                    tau_wave2_surge{i,1}(j,:)=surgeRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                    tau_wave1_sway{i,1}(j,:)=swayRAO1(i)*A(i)*cos(w_e{i}(j,:).*t+phaseRAO(i)+epsilon(i));
                    tau_wave2_sway{i,1}(j,:)=swayRAO2(i)*A(i)^2*cos(w_e{i}(j,:).*t+epsilon(i));
                end
            end
        
        % 모든 주파수에 대해 sum
            tau_temp_wave1_surge=0;
            tau_temp_wave2_surge=0;
            tau_temp_wave1_sway=0;
            tau_temp_wave2_sway=0;
            for i=1:length(w)
                tau_temp_wave1_surge=tau_temp_wave1_surge+tau_wave1_surge{i};
                tau_temp_wave2_surge=tau_temp_wave2_surge+tau_wave2_surge{i};
                tau_temp_wave1_sway=tau_temp_wave1_sway+tau_wave1_sway{i};
                tau_temp_wave2_sway=tau_temp_wave2_sway+tau_wave2_sway{i};
            end
        
        
        % 1차 파랑강제력, 2차 파랑강제력 sum
            tau_wave_surge=tau_temp_wave1_surge+tau_temp_wave2_surge;
            tau_wave_sway=tau_temp_wave1_sway+tau_temp_wave2_sway;
%         tau_wave_surge=0;
%         tau_wave_sway=0;
        
end