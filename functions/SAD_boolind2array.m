function [start_frame,stop_frame] = SAD_boolind2array(array,min_size)
    
    if (nargin < 2)
        min_size = 0;
    end
    
    start_frame = [];
    stop_frame = [];
    
%     nsp = zeros(length(array),1);
%     nsp(array) = 1;
    nsp = array;
    nsp_diff = diff(nsp);
    
    start_frame = find(nsp==1,1);
    stop_frame = find(nsp_diff==-1,1);
    temp = nsp_diff(stop_frame+1:end);
    old_temp = nsp_diff;
    while (~isequal(old_temp,temp) && ~isempty(find(temp==1,1)))
        old_temp = temp;
        start_frame = [start_frame ; 1 + stop_frame(end) + find(temp==1,1)];
        temp2 = nsp_diff(start_frame(end):end);
        stop_frame = [stop_frame ; start_frame(end) + find(temp2==-1,1) - 1];
        temp = nsp_diff(stop_frame(end)+1:end);
    end
%     stop_frame = [stop_frame ; array(end)];
    if (length(start_frame) - length(stop_frame) == 1)
        stop_frame = [stop_frame; length(nsp)];
    elseif (length(start_frame) - length(stop_frame) == 0)
%         disp('All OK. No correction needed')
    else
        disp('Error in Enforce Continuity. Needs URGENT Attention !')
        disp(length(start_frame) - length(stop_frame))
        return
    end
    ind = find((stop_frame - start_frame) < min_size);
%     disp([stop_frame start_frame stop_frame-start_frame])
    start_frame(ind) = [];
    stop_frame(ind) = [];
end