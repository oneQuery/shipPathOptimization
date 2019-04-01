%*************************************************************************%
% The SGA1 implements the simple genetic algorithm(SGA) for finding the solution   
%    of example function 1                                                                                         
%                                                                                                                                % 
% Encoding:                                                                                                           
%    - Binary                                                                                                           
%                                                                                                                                % 
% Genetic operators:                                                                                            
%    - Roulette-wheel selection                                                                                
%    - One-point crossover                                                                                       
%    - Simple mutation                                                                                           
%                                                                                                                                % 
% Other strategies:                                                                                               
%    - Not used                                                                                                          
%                                                                                                                                % 
% Remarks:                                                                                                                
%                                                                                                                                % 
% Revision 1.2  1999/12/01                                                                                         
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    
%*************************************************************************%
function PathOptimisationDemo()

%%
clear;
close all;
clc ; 
addpath(genpath(pwd)) ;
[SimStartTimeStr] = SaveLogFile() ;


% %% add path of GNCtoolboxVers3.3 and HYDROtoolboxVers1.1
% GNCToolboxPath = 'E:\MATLAB\GNCtoolboxVers3.3' ;
% HYDROToolboxPath = 'E:\MATLAB\HYDROtoolboxVers1.1' ;
% addpath(genpath(GNCToolboxPath));
% addpath(genpath(HYDROToolboxPath));
 
%%
load fpso;



%% 초기 설정
%--------------------------------------------------------------------------
    % 무인선박 제원, 운용시간 등 설정
        [m,Ac,Aw,Vs,Tu,T0,MaxLeftAngle,MaxRightAngle,g,breadth,draft,LWL]=ShipSpec;
%--------------------------------------------------------------------------
    % Environment(Current, Wind, Wave) 설정
        [Vc,Vw,Hs,T_0,CurrentAngle,WindAngle,WaveAngle,CurrentAngleDirection_E,...
        WindAngleDirection_E,WaveAngleDirection_E,spectrum,w,CurrentAngle_degree,...
        WindAngle_degree,WaveAngle_degree]=EvironmentalForces(vessel,Vs,LWL);
%--------------------------------------------------------------------------
    % 목표점 범위 설정    
        [TargetPoint,TargetRange,TargetRoundx,TargetRoundyu,TargetRoundyl]...
            =DetTarget;
%--------------------------------------------------------------------------
    % 장애물 범위 설정
        [ObstacleNumber,ObstaclePoint,ObstacleRange,ObstacleRoundx,ObstacleRoundyu,...
            ObstacleRoundyl,ObstacleRange_e,e,ObstacleRoundx_e,ObstacleRoundyu_e,...
            ObstacleRoundyl_e]=DetObstacle;
%--------------------------------------------------------------------------
                                            
%--------------------------------------------------------------------------

    %% 지구고정좌표 Environmental Forces(Current force, Wind force)
        % 로 인해 발생하는 무인선박의 속도(zerospeed)
            [U_current_zeroSpeed, U_wind_zeroSpeed,rho_sea,rho_air,Cc,Cw]=...
                ShipZeroSpeedByEnvForce(m,Tu,Ac,Aw,Vc,Vw);

%% 1세대

 
%--------------------------------------------------------------------------
    % initializes the generation counter
        gen= 1;
%--------------------------------------------------------------------------
    % initializes the parameters of the SGA
        [rseed,maxmin,maxgen,popsize,npara,pcross,pmutat,lsubstr,xlb,xub,dmax,...
            lchrom]= bInitPa1(T0,Tu,MaxLeftAngle,MaxRightAngle);

%--------------------------------------------------------------------------
    % creates a polulation randomly
        pop= bInitpop(rseed,popsize,lchrom);
%--------------------------------------------------------------------------
    % decodes chromosomes into variables
        x= bDecode(pop,popsize,npara,lsubstr,xub,xlb,dmax);
%--------------------------------------------------------------------------
    % Relative Current Velocity(Vrc), Relative Wind Velocity(Vrw) 계산
        [Vrc,Vrw,x_E,theta_s_S,theta_ic_S,theta_iw_S]=...
            DeriveVr(x,U_current_zeroSpeed,U_wind_zeroSpeed,Vs,CurrentAngle,WindAngle,Vc,Vw);
%--------------------------------------------------------------------------
    % Wave Force 계산
        [tau_wave_surge,tau_wave_sway]=...
            waveForce(m,w,spectrum,rho_sea,Tu,T0,Vs,g,...
            WaveAngle,x_E,vessel,rseed,popsize,breadth,draft);
        
%--------------------------------------------------------------------------
    % 추력에 의한 선속과 environmental force (current force, wind force)로 발생한
    % 속도를 이용한 x(선박 진행각)에 따른 포인트 좌표
        [P_Hor,P_Ver,Sp,theta_s_S,Vp]=Position(npara,popsize,Vs,Tu,...
            Vrc,Vrw,m,Ac,Aw,rho_sea,rho_air,Cc,Cw,x_E,theta_s_S,...
            theta_ic_S,theta_iw_S,tau_wave_surge, tau_wave_sway);
%--------------------------------------------------------------------------
    % cut 잡아내기 + cut까지의 이동거리 + cut까지의 소요시간
        [cutvector,S,T]=CatchCut(npara,popsize,TargetPoint,TargetRange,P_Hor,P_Ver,Sp,Tu);
%--------------------------------------------------------------------------
    % calculates the objective function value
        [objfunc]...
            = EvalObj1(popsize,TargetPoint,TargetRange,ObstacleNumber,...
            ObstaclePoint,ObstacleRange_e,P_Hor,P_Ver,cutvector,Sp,T);
%--------------------------------------------------------------------------
    % calculates the fitness value
        fitness= EvalFit1(objfunc,popsize);
%--------------------------------------------------------------------------
    % computes statistics
        [chrombest,xbest,objbest,fitbest,objave,gam,cutbest,index,P_Hor_best,...
            P_Ver_best,S_best,T_best]...
            = bStatPop(pop,x,objfunc,fitness,maxmin,cutvector,P_Hor,P_Ver,S,T);
%--------------------------------------------------------------------------
    % builds a matrix storage for plotting line graphs
         stats(gen,:)=[gen objbest objave xbest fitbest ];
         stats2(gen,:)=[gen S_best T_best];
%--------------------------------------------------------------------------
%     %% 영상만들 때 활성화   
%         
%             % 영상 재생 속도설정                                                 
%                 VideoTime=20;       % 총 영상시간
%                 FrameRate=maxgen/VideoTime;       
%             
%             % 모든 개체
%             % vidObj=VideoWriter('AllGenes.avi')                                
%             % vidObj.FrameRate=FrameRate;                                       
%             % open(vidObj);                                                     
%         
%             % 최우수 개체                                                        
%                 vidObjBest=VideoWriter('BestGene.avi');                              
%                 vidObjBest.FrameRate=FrameRate;                                     
%                 open(vidObjBest);
%                 
%             % 이동 소요시간 영상 뜨기
%             
%                 vidTravelTime=VideoWriter('TravelTime.avi');                              
%                 vidTravelTime.FrameRate=FrameRate;                                     
%                 open(vidTravelTime);  
% 
%                 
%                 set(gca,'nextplot','replacechildren');
%% Initial property 
        PrintInitialProperty(maxgen, popsize, pcross, pmutat,...
            TargetPoint, TargetRange) ;

%% Genetic algorithm loop        
for gen= 2:maxgen

        %%        
              clf;                                                           %
              close all;                                                     %        
        
%--------------------------------------------------------------------------
        % prints the current generation
        if gen == 3
%             SimTimeStart = tic ;
            CurrentTimeStart = datetime('now') ;
        end
        if gen >= 3
%         SimTimeCatch = toc(SimTimeStart) ;
            CurrentTimeCatch = datetime('now') ;
            ElapsedTime = CurrentTimeCatch - CurrentTimeStart ;
            StringElapsedTime = sprintf('%s', ElapsedTime) ;
            fprintf('Elapsed Time = %s\t\t', StringElapsedTime) ;
        end
        fprintf('gen = (%d/%d)\t\t' ,gen, maxgen) ;
        fprintf('Travel Distance = %-8.2f[m]\t',S_best);
        fprintf('Travel Time = %-4.2f[sec]\n',T_best);


%--------------------------------------------------------------------------
        % applies roulette-wheel selection
            newpop= RwSel(pop,popsize,fitness); 
            pop=newpop;
%--------------------------------------------------------------------------

        % applies one-point crossover
           [pop,nxover]= bOpXover(pop,popsize,lchrom,pcross);
%--------------------------------------------------------------------------
        % applies simple mutation
           [pop,nmutat]= bSimpMut(pop,popsize,lchrom,pmutat);
%--------------------------------------------------------------------------
        % decodes chromosomes into variables
           x= bDecode(pop,popsize,npara,lsubstr,xub,xlb,dmax);  % x나옴
%--------------------------------------------------------------------------
        % relative current velocity(Vrc), relative wind velocity(Vrw) 계산
        [Vrc,Vrw,x_E,theta_s_S,theta_ic_S,theta_iw_S]=...
            DeriveVr(x,U_current_zeroSpeed,U_wind_zeroSpeed,Vs,CurrentAngle,WindAngle,Vc,Vw);
%--------------------------------------------------------------------------
        % 추력에 의한 선속과 environmental force (current force, wind force)로 발생한
        % 속도를 이용한 x(선박 진행각)에 따른 포인트 좌표
        [P_Hor,P_Ver,Sp,theta_s_S,Vp]=Position(npara,popsize,Vs,Tu,...
            Vrc,Vrw,m,Ac,Aw,rho_sea,rho_air,Cc,Cw,x_E,theta_s_S,...
            theta_ic_S,theta_iw_S,tau_wave_surge, tau_wave_sway);
%--------------------------------------------------------------------------
        % cut 잡아내기 + cut까지의 이동거리 + cut까지의 소요시간
        [cutvector,S,T]=CatchCut(npara,popsize,TargetPoint,TargetRange,P_Hor,P_Ver,Sp,Tu);
%--------------------------------------------------------------------------
        % calculates the objective function value
        [objfunc]...
            = EvalObj1(popsize,TargetPoint,TargetRange,ObstacleNumber,...
            ObstaclePoint,ObstacleRange_e,P_Hor,P_Ver,cutvector,Sp,T);
%--------------------------------------------------------------------------
        % 엘리트전략
          [pop,x,objfunc,cutvector,P_Hor,P_Ver,S,T]=...
              bElitism(pop,x,objfunc,chrombest,xbest,objbest,maxmin,...
              cutbest,P_Hor_best,P_Ver_best,cutvector,P_Hor,P_Ver,S,S_best,T,T_best);
%--------------------------------------------------------------------------
        % calculates the fitness value
           fitness= EvalFit1(objfunc,popsize);
%--------------------------------------------------------------------------
        % computes statistics
        [chrombest,xbest,objbest,fitbest,objave,gam,cutbest,index,P_Hor_best,...
            P_Ver_best,S_best,T_best]...
            = bStatPop(pop,x,objfunc,fitness,maxmin,cutvector,P_Hor,P_Ver,S,T);
%--------------------------------------------------------------------------
        % builds a matrix storage for plotting line graphs
           stats(gen,:)=[gen objbest objave xbest fitbest];
            stats2(gen,:)=[gen S_best T_best];
%--------------------------------------------------------------------------

%% 경로 plot
%--------------------------------------------------------------------------
    % 각 세대의 모든 경로 plot                                              %
    %     figure(1)                                                          %
    %       plot(0,0,'bo');                                                  %
    %       hold on;                                                         %
    %       plot(TargetPoint(1),TargetPoint(2),'ro');                        %
    %       hold on;                                                         %
    %     for i=1:popsize;                                                   %
    %       plot(HorDisp(i,:),VerDisp(i,:));                                 %
    %       axis([-AllGeneRange AllGeneRange -AllGeneRange AllGeneRange]);   %
    %       title('All Route for each Generation');                          % 
    %       grid on;                                                         %
    %     end                                                                %

    % 모든 유전자 영상 만들때 활성화                                                         
    %       currFrame=getframe;                                            %
    %       writeVideo(vidObj,currFrame);                                  %
    %                                                                      %
    %       clf;                                                           %
%--------------------------------------------------------------------------
    
%% plot only initial and final condition

    if gen == 2 || gen == maxgen
%     if gen == 2 && maxgen
%             fig1=figure(1);
%             set(fig1,'position',[100 550 700*2/3 600*2/3]) 
          fig1 = figure(1) ;
          plot(0,0,'r^');
          xlabel('[m]'); ylabel('[m]');%
          hold on;                                                         %

        % 목표점, 범위 plot                                             %
              plot(TargetPoint(1),TargetPoint(2),'rv');                    %
              hold on;                                                     %

        % 장애물 plot
            for Ob=1:ObstacleNumber
                    plot(ObstacleRoundx(Ob,:), ObstacleRoundyu(Ob,:),'k');                       
                     hold on;                                                      
                    plot(ObstacleRoundx(Ob,:), ObstacleRoundyl(Ob,:),'k');                       
                     hold on;
                      plot(ObstacleRoundx_e(Ob,:), ObstacleRoundyu_e(Ob,:),'r:');                       
                     hold on;                                                      
                    plot(ObstacleRoundx_e(Ob,:), ObstacleRoundyl_e(Ob,:),'r:');                       
                     hold on;
            end

            
%--------------------------------------------------------------------------
    % 모든 경로와 최우수 경로 plot
    % if gen<maxgen;
    %         plot(P_Hor_best(1:cutbest),P_Ver_best(1:cutbest),'c.');
    %       axis([-BestGeneRange-shiftx BestGeneRange-shiftx...
    %           -BestGeneRange-shifty BestGeneRange-shifty]);%
    %       title('Best Route');                         %
    %       grid on; hold on;
    % %       drawnow; 
    % else
    %             plot(P_Hor_best(1:cutbest),P_Ver_best(1:cutbest),'r.');
    %       axis([-BestGeneRange-shiftx BestGeneRange-shiftx...
    %           -BestGeneRange-shifty BestGeneRange-shifty]);%
    %       title('Best Route');                         %
    %       grid on; hold on;
    % %       drawnow; 
    % 
    % end
%% plot axis property
    %                                                 
        Range=0.7*max(abs(TargetPoint));
        shiftx = TargetPoint(1)/2;
        shifty = TargetPoint(2)/2;
        AllGeneRange=Range;
        BestGeneRange=Range;    
        
    %
        plot(P_Hor_best(1:cutbest),P_Ver_best(1:cutbest),'b.');
%           axis([-BestGeneRange-shiftx BestGeneRange-shiftx...
%               -BestGeneRange-shifty BestGeneRange-shifty]);
        
          axis([-BestGeneRange+shiftx BestGeneRange+shiftx...
              -BestGeneRange+shifty BestGeneRange+shifty]);

%% legends

    if Vc~=0
        labpos_x=12/20;      % 라벨 위치 (등분으로)
        labpos_y=4/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('V_c:',num2str(Vc),' [m/s]','   \beta_c_u_r_r_e_n_t:',...
              num2str(round(CurrentAngle_degree-180)),' [^\circ]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    else
        labpos_x=16/20;      % 라벨 위치 (등분으로)
        labpos_y=4/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('No Current');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    end
    
    if Vw~=0
        labpos_x=12/20;      % 라벨 위치 (등분으로)
        labpos_y=3/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('V_w:',num2str(Vw),' [m/s]','    \beta_w_i_n_d:',...
              num2str(round(WindAngle_degree-180)),' [^\circ]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    else
        labpos_x=16/20;      % 라벨 위치 (등분으로)
        labpos_y=3/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('No Wind');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    end
    
    if Hs~=0
        labpos_x=12/20;      % 라벨 위치 (등분으로)
        labpos_y=2/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('H_s:',num2str(Hs,2),' [m]',...
              '      \beta_w_a_v_e:',num2str(round(WaveAngle_degree-180)),' [^\circ]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=12/20;      % 라벨 위치 (등분으로)
        labpos_y=1/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('T_0:',num2str(T_0),' [sec]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    else
        labpos_x=16/20;      % 라벨 위치 (등분으로)
        labpos_y=2/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('No Wave');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
    end
        
%--------------------------------------------------------------------------
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=19/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('U_t_h_r_u_s_t: ',num2str(Vs),' [m/s]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=18/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('Obstacle Approach Limit: ',num2str(e),' [m]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=17/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('Max gen: ',num2str(maxgen));
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=16/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('Pop Size: ',num2str(popsize));
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
%--------------------------------------------------------------------------            
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=3/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('gen: ',num2str(gen));
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=2/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('Travel Distance: ',...
              num2str(round(S_best,2)),' [m]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=1/20;      % 라벨 위치 (등분으로)
        labpos_y=1/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('Travel Time: ',num2str(round(T_best,2)),' [s]');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);

%--------------------------------------------------------------------------
  
        labpos_x=15/20;      % 라벨 위치 (등분으로)
        labpos_y=19/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('\Delta:Starting Point');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
        labpos_x=15/20;      % 라벨 위치 (등분으로)
        labpos_y=18/20;      % 라벨 위치 (등분으로)
          tmpText = strcat('\nabla:Target Point');
            text((-BestGeneRange+shiftx)+(2*BestGeneRange)*(labpos_x),...
                (-BestGeneRange+shifty)+(2*BestGeneRange)*(labpos_y),tmpText);
            
          title('Best Route');                         %
          grid on; hold on;
         

          %%
%             drawnow;        % 실시간 경로 볼때 활성화


     %% Environmental Load 벡터장 Plot

%             RepVectNum=20;  % 표시할 벡터 갯수(1축으로만)
%             [x, y]=meshgrid(-BestGeneRange-shiftx:2*BestGeneRange/RepVectNum:BestGeneRange-shiftx,...
%                 -BestGeneRange-shifty:2*BestGeneRange/RepVectNum:BestGeneRange-shifty);
% 
%         % Current 벡터 Plot
%             u_c=Vc*sin(CurrentAngleDirection_E)*ones(RepVectNum+1);
%             v_c=Vc*cos(CurrentAngleDirection_E)*ones(RepVectNum+1);
%             quiver(x,y,u_c,v_c,0.5,'c');
%             hold on;
%             drawnow;
% %--------------------------------------------------------------------------
%         % Wind 벡터 Plot
%             u_w=Vw*sin(WindAngleDirection_E)*ones(RepVectNum+1);
%             v_w=Vw*cos(WindAngleDirection_E)*ones(RepVectNum+1);
%             quiver(x,y,u_w,v_w,0.5,'c');
%             hold on;
%             drawnow;
% %--------------------------------------------------------------------------
%         % Wave 벡터 Plot
%             u_wave=sin(WaveAngleDirection_E)*ones(RepVectNum+1);
%             v_wave=cos(WaveAngleDirection_E)*ones(RepVectNum+1);
%             quiver(x,y,u_wave,v_wave,0.5,'c');
%             hold on;
%             drawnow;
    %% Best Route 영상 만들기
%               currFrame=getframe;                                            %
%               writeVideo(vidObjBest,currFrame);                              %

%% 이동 소요시간 실시간 plot
            if gen==2
                T_best_int=T_best;
            end
            fig2=figure(2);
            set(fig2,'position',[1000 100 700 350])
            plot(stats2(:,1),stats2(:,3));
            axis([0 maxgen 0 T_best_int*1.2]);
            grid on;
            title('Travel Time According to Generation');
            xlabel('Generation'); ylabel('Travel Time[s]');
            
%             drawnow;

           


        %% 영상만들 때 주석처리 / 실시견 경로 plot 할 때 활성화
%               if gen<maxgen;
%                close all;%
%               end

        %% 이동소요시간 영상 만들 때 활성화                                                         %
%               currFrame=getframe;                                            %
% %               writeVideo(vidObjBest,currFrame);                              %
%                 writeVideo(vidTravelTime,currFrame);                                                     
% % clf;
    end
%% make sure process going on or not
GoingOnOrNot(gen) ;
   
end
                                                        %

%% presents the population report
% % % % bRepPop(gen,pop,popsize,npara,lsubstr,x,objfunc,fitness,3);

%% 유전알고리즘 결과 plot
%--------------------------------------------------------------------------

            fig3=figure(3);
            set(fig3,'position',[1200 550 700 350])
%     figure(3);
        % 선정된 경로의 출발점부터 목표점까지의 이동거리
            subplot(2,2,1);
            plot(stats2(:,1),stats2(:,2));
            title('출발점부터 목표점까지의 이동거리');
            xlabel('generation'); ylabel('[m]');
%             drawnow;
%--------------------------------------------------------------------------
        % 선정된 경로의 출발점부터 목표점까지의 소요시간
            subplot(2,2,2);
            plot(stats2(:,1),stats2(:,3));
            title('출발점부터 목표점까지의 소요시간');
            xlabel('generation'); ylabel('[s]');
%             drawnow;
%--------------------------------------------------------------------------

        % plots the best objective function values
            subplot(2,2,3);
            plot(stats(:,1),stats(:,2));
            title('Best Objective Function');
            xlabel('generation'); 
%             drawnow;
%--------------------------------------------------------------------------
        % plots the variables of the best fitness function
            subplot(2,2,4);
            plot(stats(:,1),stats(:,4+npara));
            title('Best Fitness Function')
            xlabel('generation');
%             drawnow;
%--------------------------------------------------------------------------
%         % % plots the variables of the best chromosome
%         % subplot(2,1,2)
%         % plot(stats(:,1),stats(:,4:npara+3))
%         % title('Best x_1 and x_2')
%--------------------------------------------------------------------------

%%
% close(vidObjBest);
% close(vidTravelTime);  

%% save the results
ResultFileSave(fig1, fig2, SimStartTimeStr) ;

%% done
fprintf('\nDone\n') ;

VariablesResultFileName = sprintf('VariablesResult_%s', SimStartTimeStr) ;
VariablesResultDir = sprintf('output/%s', SimStartTimeStr) ;
VariablesResult = fullfile(pwd, VariablesResultDir, VariablesResultFileName) ;  
save(VariablesResult) ;

for i = 1:5
    beep on
    beep
    beep off
    pause(1)
end
diary off

end