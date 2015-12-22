

%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program extract_MFCC.m is part of the MATLAB Speaker Diarization Toolkit 
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
frame_length = 0.03; %30ms
frame_hop = 0.01; %10ms
n_MFCC = 19; %number of cepstral coefficients excluding 0'th coefficient [default 19]
delta_feature = '0'; %0'th coefficient. Append any of the following for more options 'd': for single delta; 'D': for double delta; 'E': log energy

wav_filename = [file_path 'Data_Files' filesep filename '.wav'];
[sig,Fs] = audioread(wav_filename);

S = melcepst(sig,Fs,'0',n_MFCC, floor(3*log(Fs)) ,frame_length * Fs, frame_hop * Fs);

MFCC{1} = S; clear S;
mkdir([file_path  'Output_files' filesep  filename ])
save([file_path  'Output_files' filesep  filename filesep 'MFCC'],'MFCC')
disp(['Feature extraction complete. Time taken = ' num2str(toc)])
