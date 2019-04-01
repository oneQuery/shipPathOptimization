function [Vc,Vw,Hs,T_0,CurrentAngle,WindAngle,WaveAngle,CurrentAngleDirection_E,...
    WindAngleDirection_E,WaveAngleDirection_E,spectrum,w,CurrentAngle_degree,WindAngle_degree,WaveAngle_degree]=EvironmentalForces(vessel,Vs,LWL)
%% declare global
    global Vc
    global betta_current
    global Vw
    global betta_wind
    global Hs
    global T_0
    global betta_wave

%% evironmental loads property    
%% current
% Vc              = 0 ;        % [m/s]
Vc              = 5 ;       
betta_current   = -135 ;
% betta_current   = -90 ;      % clockwise from 12 direction
% betta_current   = -45 ;
% betta_current   = 45 ;
% betta_current   = 90 ;
% betta_current   = 135 ;

%% wind
% Vw              = 0 ;       % [m/s]
Vw              = 20 ;     
betta_wind      = -135 ;  
% betta_wind      = -90 ;        % clockwise from 12 direction
% betta_wind      = -45 ;  
% betta_wind      = 45 ;  
% betta_wind      = 90 ;  
% betta_wind      = 135 ;  

%% wave
% Hs              = 0 ;       % [m]
Hs              = 2.06*Vw^2/(9.81)^2 ;          
betta_wave      = -135 ;
% betta_wave      = -90 ;     % clockwise form 12 direction  
% betta_wave      = -45 ;
% betta_wave      = 45 ;
% betta_wave      = 90 ;
% betta_wave      = 135 ;
T_0             = 15 ;      % [s]


%%
        rseed=15;
        rand('seed', rseed); 

%%
%% Current
CurrentAngle_degree     = betta_current + 180 ;      
CurrentAngle            = CurrentAngle_degree*pi/180 ;    % [rad]
CurrentAngleDirection_E = CurrentAngle+pi ;                          
        
%% Wind
WindAngle_degree        = betta_wind+180 ;      
WindAngle               = WindAngle_degree*pi/180 ;       % [rad]
WindAngleDirection_E    = WindAngle+pi ;                                          

%% Wave
WaveAngle_degree        = betta_wave + 180 ;                             
WaveAngle               = WaveAngle_degree*pi/180 ;       % [rad]
w                       = (vessel.forceRAO.w)' ;                 
spectrum                = wavespec(3,[Hs,T_0],w,1) ;      % Wave Spectrum (Modified PM Spectrum)
WaveAngleDirection_E    = WaveAngle+pi ;    
%--------------------------------------------------------------------------
%        close all;
%         echo on;
end