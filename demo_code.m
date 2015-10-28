file_path = '.\Demo\';
filename = 'BLOOMBERG TV-20150105-180000-190000';

% Feature Extraction
extract_MFCC

% Speech Activity Detection
remove_silence
remove_music

% Speaker Segmentation
detect_speaker_change

% Speaker Clustering
extract_ivectors
ilp_cluster

% View Diarization output on PRAAT TextGrid
debug_textgrid