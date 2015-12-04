function MFCC = getmfcc (filename,varargin)
% This function is the feature extraction step in the speaker diarization task. For the Speech-Activity-Detection and Speaker-Clustering derivatives of MFCCs are used, whereas for the Speaker-Segmentation only the MFCC coefficients with the Short time energy are used.
%sig,fs,win_len,win_overlap,win_shape
[sig,fs] = audioread(filename);
if(nargin<2)
	win_length = 0.03;
else
	win_length = varargin{1};
end
if(nargin<3)
	win_overlap = 0.02;
else
	win_overlap = varargin{2};
end
if(nargin<4)
win_shape = '
win_shape = varargin{3};

end
