%% first, load the mat file that you want to plot agian
% clf ;
close all ;
%% map axis shift
shiftx = TargetPoint(1)/2;
shifty = TargetPoint(2)/2;

shiftx = 0;     % center value of x in the map
% shiftx = 400 ;
% shiftx = 600 ;

% shifty = 0 ;    % center value of y in the map
% shifty = 300 ;
shifty = 600 ;

%%
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
%%
    % 최우수 경로만 plot
        plot(P_Hor_best(1:cutbest),P_Ver_best(1:cutbest),'b.');
%           axis([-BestGeneRange-shiftx BestGeneRange-shiftx...
%               -BestGeneRange-shifty BestGeneRange-shifty]);
%     

        
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

            
            %%
            
          title('Best Route');                         %
          grid on; hold on;
          
%%
PlotStartTimeStr = datestr(now, 'yymmdd_HHMM') ;

PathResultFileNameJPEG = sprintf('PathResult_%s_%s.jpeg',...
    SimStartTimeStr, PlotStartTimeStr) ;
PathResultFileNameFIG = sprintf('PathResult_%s_%s',...
    SimStartTimeStr, PlotStartTimeStr) ;
% TravelTimeResultFileNameJPEG = sprintf('TravelTimeGragh_%s.jpeg',SimStartTimeStr) ;
% TravelTimeResultFileNameFIG = sprintf('TravelTimeGragh_%s', SimStartTimeStr);
ResultFileDir  = sprintf('%s', SimStartTimeStr) ;

CurrentDir = pwd ;

% if ~exist('output','dir') 
%     mkdir('output') ;
% end
    cd(ResultFileDir);
    saveas(fig1,PathResultFileNameJPEG);
    saveas(fig1,PathResultFileNameFIG);
%     saveas(fig2,TravelTimeResultFileNameJPEG);
%     saveas(fig2,TravelTimeResultFileNameFIG);

    cd(CurrentDir) ;    