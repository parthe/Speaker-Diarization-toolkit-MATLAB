% This code trains the Universal Background Model

n_gaussians = 512; % number of Gaussian components (must be a power of 2)
final_iter = 10; % number of EM iterations in the final split
ds_factor = 1; % feature sub-sampling factor (every ds_factor frame)
nworkers = 4; % number of parallel MATLAB workers
UBM_filename = 'UBM_GMM_TIMIT'; % output is matfile "UBM_filename.mat" containing the UBM trained on given data

% Train GMM using MSR_Toolkit function "gmm_em(...)"
gmm_em({UBM_data'},n_gaussians,final_iter,ds_factor,nworkers,UBM_filename);

% UBM_data is a nFrames x nDim matrix containing MFCC features of the input
% data (without preprocessing)
% It is treated appropriately to use the gmm_em feature to generate the 
% diagonal covariance Universal Background Model (UBM)