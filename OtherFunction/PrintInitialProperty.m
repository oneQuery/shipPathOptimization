function PrintInitialProperty( maxgen, popsize, pcross, pmutat, TargetPoint, TargetRange )
%PRINTINITIALPROPERTY Summary of this function goes here
%   Detailed explanation goes here
    %%
    global ResolvingPower
    global Vc
    global betta_current
    global Vw
    global betta_wind
    global Hs
    global T_0
    global betta_wave
    global rseed1
    global nO1
    global e

    %%
    fprintf('\t\t\t\t========================Initial Property========================\n\n')

    fprintf('\t\t\t\tDirectory = %s\n\n', pwd);
    
    fprintf('\t\t\t\tMax Gen \t\t\t= %d\n',maxgen);
    fprintf('\t\t\t\tPop Size \t\t\t= %d\n',popsize);
    fprintf('\t\t\t\tProbability of Crossover \t= %.2f\n',pcross);
    fprintf('\t\t\t\tProbability of Mutation \t= %.2f\n',pmutat);
    fprintf('\t\t\t\tResolving Power \t\t= %d\n\n',ResolvingPower);

    fprintf('\t\t\t\tCurrent Speed \t\t\t= %.2f[m/s]\n\t\t\t\tCurrent Direction \t\t= %.2f[deg]\n' ,...
        Vc, betta_current) ;
    fprintf('\t\t\t\tWind Speed \t\t\t= %.2f[m/s]\n\t\t\t\tWind Direction \t\t\t= %.2f[deg]\n' ,...
        Vw, betta_wind) ;
    fprintf('\t\t\t\tSignificant Wave Height \t= %.2f[m]\n\t\t\t\tModal Peroid \t\t\t= %.2f[s]\n\t\t\t\tWave Direction \t\t\t= %.2f[deg]\n\n' ,...
        Hs, T_0, betta_wave) ;
    
    fprintf('\t\t\t\tObstacle Random Number Seed \t= %d\n', rseed1 ) ;
    fprintf('\t\t\t\tNumber of Obstacles \t\t= %d\n', nO1 ) ;
    fprintf('\t\t\t\tRestricted Approach range \t= %.2f\n\n', e ) ;
    
    fprintf('\t\t\t\tTarget Point \t\t\t= x: %d[m], y: %d[m]\n',...
        TargetPoint(1),TargetPoint(2)) ;
    fprintf('\t\t\t\tTarget Range \t\t\t= %d[m]\n', TargetRange) ;

    fprintf('\n\t\t\t\t================================================================\n\n')


end

