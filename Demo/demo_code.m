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
