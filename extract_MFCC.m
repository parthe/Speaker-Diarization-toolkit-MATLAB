tic
S = getmfcc([file_path filename '.wav']);
MFCC{1} = S;
mkdir([file_path filename ])
save([file_path filename '\MFCC'],'MFCC')
disp(['Feature extraction complete. Time taken = ' num2str(toc)])