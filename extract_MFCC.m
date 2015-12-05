tic
frame_length = 0.03; %30ms
frame_hop = 0.01; %10ms
n_MFCC = 19; number of cepstral coefficients excluding 0'th coefficient [default 19]
delta_feature = '0'; %0'th coefficient. Append any of the following for more options 'd': for single delta; 'D': for double delta; 'E': log energy

filename = [file_path filename '.wav'];
[sig,Fs] = audioread(filename);

S = melcepst(sig,Fs,'0',n_MFCC, floor(3*log(Fs)) ,frame_length * Fs, frame_hop * Fs);

MFCC{1} = S;
mkdir([file_path filename ])
save([file_path filename '\MFCC'],'MFCC')
disp(['Feature extraction complete. Time taken = ' num2str(toc)])
