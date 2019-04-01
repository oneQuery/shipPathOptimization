%************************************************************************
% cut 잡아주기 + cut까지의 이동거리 + cut까지의 소요시간
%************************************************************************


function [cutvector,S,T]...
    = CatchCut(npara,popsize,TargetPoint,TargetRange,P_Hor,P_Ver,Sp,Tu)





    for i= 1:popsize



        %********************************************************************%
                % 포인트가 목표범위에 걸리는 포인트번호 cut를 잡는 것               %
                                                                                 %
                cut=1;                                                           %
                while sqrt((TargetPoint(1)-P_Hor(i,cut)).^2+...
                        (TargetPoint(2)-P_Ver(i,cut)).^2)>TargetRange;    %
                    if cut==npara;                                               %  
                        break;                                                   %
                    else                                                         %
                    cut=cut+1;                                                   %   
                    end                                                          %
                end
                cutvector(i)=cut;

                              %
        %********************************************************************%

        % cut 까지의 이동거리
            S(i,:)=sum(Sp(i,1:cutvector(i)));
        % cut 까지의 소요시간
            T(i,:)=Tu*cutvector(i);

    end

end
