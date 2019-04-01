function GoingOnOrNot(gen)
%GOINGONORNOT Summary of this function goes here
%   Detailed explanation goes here

if gen == 2 
    prompt = '\nMake it going on: [Enter]\nMake it stop: [Ctrl]+[C]\n\n';
    diary off
    input(prompt,'s');
    diary on
%     if isempty(str)
%         str = 'Y';
%     end
    
%     if str == 'n' || 'N'
%         fprintf('\nRevise that you want and') ;
%              
%     end
    
end

end

