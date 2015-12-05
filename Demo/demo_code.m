file_path = [pwd filesep];
filename = 'BLOOMBERG TV-20150105-180000-190000';

% Feature Extraction
extract_MFCC

% Speech Activity Detection
remove_silence
remove_music

% Speaker Segmentation
detect_speaker_change

% % Training UBM
% train_UBM

% % Training T-matrix for i-vector extraction
% train_T_matrix

% % Computing Within cluster covariance matrix WCCN (for Mahalanobis
% % distance computation)
% compute_WCCN

% Speaker Clustering
extract_ivectors
ilp_cluster

% View Diarization output on PRAAT TextGrid
debug_textgrid