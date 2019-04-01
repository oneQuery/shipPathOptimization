function ResultFileSave( fig1, fig2, SimStartTimeStr )
%   New folder is made to save the resluts
%

    
%     currentTime = datetime('now','TimeZone','local','Format','yyMMdd_HHmm') ;
%     currentTimeString = sprintf('%s',currentTime);
%     ResultFileName = sprintf('PathResult_%s.jpeg',currentTimeString);
    PathResultFileNameJPEG = sprintf('PathResult_%s.jpeg',SimStartTimeStr) ;
    PathResultFileNameFIG = sprintf('PathResult_%s',SimStartTimeStr) ;
    TravelTimeResultFileNameJPEG = sprintf('TravelTimeGragh_%s.jpeg',SimStartTimeStr) ;
    TravelTimeResultFileNameFIG = sprintf('TravelTimeGragh_%s', SimStartTimeStr);
    ResultFileDir  = sprintf('output/%s', SimStartTimeStr) ;
    
    CurrentDir = pwd ;
    
    if ~exist('output','dir') 
        mkdir('output') ;
    end
        cd(ResultFileDir);
        saveas(fig1,PathResultFileNameJPEG);
        saveas(fig1,PathResultFileNameFIG);
        saveas(fig2,TravelTimeResultFileNameJPEG);
        saveas(fig2,TravelTimeResultFileNameFIG);
        
        cd(CurrentDir) ;    
    
end

