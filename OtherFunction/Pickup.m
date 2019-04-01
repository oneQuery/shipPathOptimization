%*************************************************************************%
% The PICKUP function picks up an integer random number between 1 and num      %
%                                                                                                                                %
% function rnum= Pickup(num)                                                                                   %
% Input:                                                                                                                      %
%    num- integer number greater than or equal to 1                                                  %
% Output:                                                                                                                    %
%    rnum- random number between 1 and num                                                        %
%                                                                                                                                %
% Copyright (c) 2000 by Prof. Gang-Gyoo Jin, Korea Maritime University                    % 
%*************************************************************************%
function rnum= Pickup(num)

if min(num) < 1
  disp('num is less than one !')
  return;
end
%**********************************************************************
% 1부터 num까지 랜덤 숫자 결정해줌
fr= rand(size(num));
rnum= floor(fr.*num)+1;
%**********************************************************************