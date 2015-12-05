function change_points = detect_change (filename,mode,lamda,thresh,verbose)
%
% Input: string filename that can be read using function 'audioread'
%        function can also take MFCC vectors of audio files as input
% Output: change_points are in seconds.%
%
% detect_change returns change_points which are points in file
% filename at which there was a change in the speaker. There is no
% indication as to which speaker spoke when. For that refer to function
% cluster_segments.
%
% Example: C = detect_change ('haal_behaal.wav')
%
% C = [ 9.01 16.70 43.55 ]
    if(nargin < 5)
        verbose = 0;
    end
    if (nargin < 4)
        thresh = 2000;
    end
    if (nargin < 3)
        lamda = 10;
    end
    if (nargin < 2)
        mode = 1;
    end

    % Read file and MFCC

    if ischar(filename)
%         disp('input is a string. Opening file to fetch MFCC. If MFCC already exist, give input as [X] = N x dim')
            [sig,Fs] = audioread(filename);

            frame_length = 30e-3;
            frame_hop = 10e-3;
            sig = sig(:,1);

            S = melcepst(sig,Fs,'0',19, floor(3*log(Fs)) ,frame_length * Fs, frame_hop * Fs);
    else
%         disp('input is matrix. Assuming matrix represents MFCCs..')

        frame_hop = 10e-3;
		S = filename;
    end
    
    % Initialize parameters

    start = 1;
    stop = 400;
    change_found = 0;
    change_points = [];
    
    
    
    % Main Loop

    while (stop < length(S))

    single_change_block = S(start:stop,:);
    del_BIC = zeros(length(single_change_block),1);
    
    % H0: There is no change from start:stop
    % H1: There is a change in start:stop at i
    
        for i = 50:length(single_change_block)-50 % keep each block in hypothesis H1 at least 500ms long

            A = single_change_block(1:i,:);
            B = single_change_block(i+1:length(single_change_block),:);
            
            if (mode == 1)
                del_BIC(i,:) = deltaBIC(A,B,lamda);
            elseif (mode == 2)
                del_BIC(i,:) = dBIC(A,B,lamda);
            end

        end
        
    % Find highest peaks in deltaBIC
     
        [pk,loc] = findpeaks(abs(del_BIC),'SortStr','descend');
    if numel(pk ~= 0)
        pk = pk(1);
        loc = loc(1);
        
    % Determine if peak is good enough to declare change
        if (pk > thresh)
            change_found = 1 ;
%             disp(pk)
%             disp(loc)
            change_points = [change_points (start - 1 + loc)];
        end
    end
    % Is there a change?     
        if (change_found==0) % No. So increase search block
            
        % Increase search block     
            stop = stop + 200;
%             disp(stop);
            if (stop - start > 4000)
                start = start + round((stop - start)/2);
                stop = start + 399;
            end

        elseif (change_found  == 1) % Yes. So restart search block
            if (verbose)
                disp(['change detected at ' num2str(change_points(end))]);
            end
        % Restart Block for searching next change point
            start = change_points(end);
            stop = change_points(end) + 400;
            
        % Reset flag indicating whether change found    
            change_found = 0;
        end

    end
      
    % Bringchange_points to scale of seconds
%     change_points = change_points * frame_hop;
    if(verbose)
        disp('Change Detection Complete');
    end
end