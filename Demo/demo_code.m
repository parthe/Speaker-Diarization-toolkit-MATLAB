
%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program demo_code.m is part of the MATLAB Speaker Diarization Toolkit 
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
 


file_path = [pwd filesep];
% file_path should read something like 
% <your_home_folder_>.../Speaker-Diarization-toolkit-MATLAB/

filename = 'BLOOMBERG TV-20150105-180000-190000';

% Feature Extraction
run([file_path 'subsystems' filesep 'extract_MFCC.m'])

% Speech Activity Detection

run([file_path 'subsystems' filesep 'remove_silence.m'])
run([file_path 'subsystems' filesep 'remove_music.m'])



% Speaker Segmentation
run([file_path 'subsystems' filesep 'detect_speaker_change.m'])

% % Training UBM
% train_UBM

% % Training T-matrix for i-vector extraction
% train_T_matrix

% % Computing Within cluster covariance matrix WCCN (for Mahalanobis
% % distance computation)
% compute_WCCN

% Speaker Clustering
run([file_path 'subsystems' filesep 'extract_ivectors.m'])
run([file_path 'subsystems' filesep 'ilp_cluster.m'])



% View Diarization output on PRAAT TextGrid
run([file_path 'subsystems' filesep 'debug_textgrid.m']);
