function [SimStartTimeStr] = SaveLogFile()
%SAVELOGFILE Summary of this function goes here
%   Detailed explanation goes here

% CurrentDir = pwd ;
    
    if ~exist('output','dir') 
        mkdir('output') ;
    end

SimStartTimeStr = datestr(now, 'yymmdd_HHMM') ;

mkdir('output', SimStartTimeStr) ;

LogFileName = sprintf('Log_%s.txt', SimStartTimeStr) ;
LogFileDir  = sprintf('output/%s', SimStartTimeStr) ;

LogFile = fullfile(pwd, LogFileDir,  LogFileName) ;
% LogFile = fullfile(
%     cd output ;

diary (LogFile) ;
% diary on

% cd(CurrentDir) ;   

end

