
%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program detect_speaker_change.m is part of the MATLAB Speaker Diarization Toolkit 
% <https://github.com/parthe/Speaker-Diarization-toolkit-MATLAB>
% Copyright (C) 2015 Parthe Pandit
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or 
% any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
 


tic
DBIC_mode = 1;
lamda = 10;
thresh = 2000;
    load([file_path  'Output_files' filesep  filename filesep 'MFCC'],'MFCC')
    S = MFCC{1};
    times = (1:length(S))';
    
    % load SAD results
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\music_removal_1000ms','J_start','J_stop')
    load([file_path 'Output_files' filesep filename filesep 'music_removal_1000ms'],'J_start','J_stop')
    
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
    save([file_path  'Output_files' filesep filename filesep 'segmentation'],'original')


    % load feature vectors
    S = MFCC{1};
    
    % load SAD results
    load([file_path  'Output_files' filesep filename filesep 'music_removal_1000ms'],'J_start','J_stop')
    non_speech_indices = SAD_array2ind(J_start,J_stop);
    S(non_speech_indices,:) =  inf*ones(length(non_speech_indices),size(S,2));
    
    % load segmentation results
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\segmentation_2000_1','original')
    load([file_path 'Output_files' filesep  filename filesep 'segmentation'],'original')
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
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\segments','segments')
    save([file_path 'Output_files' filesep  filename filesep 'segments'],'segments')
disp(['Speaker segmentation complete. Time taken = ' num2str(toc)])
