% parameters
tic
DBIC_mode = 1;
lamda = 10;
thresh = 2000;

    S = MFCC{1};
    times = (1:length(S))';
    
    % load SAD results
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\music_removal_1000ms','J_start','J_stop')
    load([file_path filename '\music_removal_1000ms'],'J_start','J_stop')
    
    % remove non-speech frames for concatenation
    non_speech_indices = SAD_array2ind(J_start,J_stop);
    S(non_speech_indices,:) = [];
    times(non_speech_indices) = [];
    
    % detect changes
    temp_change_points = detect_change(S,DBIC_mode,lamda,thresh,0); % output of functions is in terms of frames not seconds
    
    % do correction for removing non-speech
    original = times(temp_change_points);
    
    % save frame number of change points
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\segmentation_2000_1','original')
    save([file_path filename '\segmentation'],'original')


    % load feature vectors
    S = MFCC{1};
    
    % load SAD results
    load([file_path filename '\music_removal_1000ms'],'J_start','J_stop')
    non_speech_indices = SAD_array2ind(J_start,J_stop);
    S(non_speech_indices,:) =  inf*ones(length(non_speech_indices),size(S,2));
    
    % load segmentation results
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\segmentation_2000_1','original')
    load([file_path filename '\segmentation'],'original')
    C = original;
    
    segments = cell(length(C) + 1,1);
    segments{1} = S(1:C(1),:);
    segments{1}(ismember(segments{1},inf*ones(1,20),'rows'),:) = [];
    if(size(segments{1},2)~=size(S,2))
        error('Error. Probably a problem with inf deletion')
    end
    for seg_num = 2:length(C)
        segments{seg_num} = S(C(seg_num-1):C(seg_num),:);
        segments{seg_num}(ismember(segments{seg_num},inf*ones(1,20),'rows'),:) = [];
        if(size(segments{seg_num},2)~=size(S,2))
            error('Error. Probably a problem with inf deletion')
        end
    end
    segments{length(C)+1} = S(C(end):end,:);
    segments{length(C)+1}(ismember(segments{length(C)+1},inf*ones(1,20),'rows'),:) = [];
    if(size(segments{length(C)+1},2)~=size(S,2))
        error('Error. Probably a problem with inf deletion')
    end
    
    
    % save segments
    save('G:\Parthe\Dropbox\Acads\DDP\Demo\segments','segments')
    save([file_path filename '\segments'],'segments')
disp(['Speaker segmentation complete. Time taken = ' num2str(toc)])
