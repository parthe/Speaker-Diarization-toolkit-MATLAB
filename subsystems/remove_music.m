

%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program remove_music.m is part of the MATLAB Speaker Diarization Toolkit 
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
% folder = 'F:\Parthe MediaEval Test set\';
% wavlist = dir([folder 'audio\*.wav']);

nG.nnG = 16;     nG.snG = 32;

% load('G:\Parthe\Dropbox\Acads\DDP\Demo\silence_removal_1000ms','J_start','J_stop');
load([file_path 'Output_files' filesep  filename filesep 'silence_removal_1000ms'],'J_start','J_stop')

[sig,fs]=audioread(wav_filename);
classif = trmszc(wav_filename,0,[0 (length(sig)/fs)]);
classif = [classif ; classif];
classif = classif(:);

Z = zeros(length(MFCC{1}),1);
for i = 1:length(MFCC{1})
    Z(i) = length(zerocros(sig(1+(i-1)*fs/100:(i-1)*fs/100 + 3*fs/100),'b'));
end

S = [MFCC{1} Z];
times = (1:length(S))';

times(SAD_array2ind(J_start',J_stop')) = [];
S(SAD_array2ind(J_start',J_stop'),:) = [];
temp = SAD_array2ind(J_start',J_stop');
temp(temp>length(classif)) = [];
classif(temp) = [];

nsp = S(classif==1,:);
sp = S(classif==2,:);

% bootstrap music
[~,zcr_sort_d] = sort(nsp(:,end),'descend');
nsp_mus = nsp(zcr_sort_d(1:round(length(nsp)*.4)),2:end);
nsp = nsp_mus; % Uncommented for bootstrap 3

% bootstrap speech
[~,energy_sort_d] = sort(sp(:,1),'descend');
sp = sp(energy_sort_d(1:min(length(nsp),length(sp))),2:end);

S = S(:,2:end);

nG.nnG = 4;     nG.snG = 4;
[~,Msp] = evalc('GMM_matlab2cluster(GMM_MSR2matlab(gmm_em({transpose(sp)},nG.snG,10,1,4)))');
[~,Mnsp] = evalc('GMM_matlab2cluster(GMM_MSR2matlab(gmm_em({transpose(nsp)},nG.nnG,10,1,4)))');

I_old = length(sp);
J_old = length(nsp);
percent_change = 100;
counter = 0;

while(percent_change > 1)
    counter = counter + 1;
    LLsp = GMClassLikelihood(Msp,S);
    LLnsp = GMClassLikelihood(Mnsp,S);
    I = find(LLsp > LLnsp);
    J = find(LLnsp > LLsp);    
    sp = S(I,:);
    nsp = S(J,:);
    nG.nnG = 16;     nG.snG = 32;
    [~,Msp] = evalc('GMM_matlab2cluster(GMM_MSR2matlab(gmm_em({transpose(sp)},nG.snG,10,1,4)))');
    [~,Mnsp] = evalc('GMM_matlab2cluster(GMM_MSR2matlab(gmm_em({transpose(nsp)},nG.nnG,10,1,4)))');
    I_new = length(I);
    J_new = length(J);
    percent_change = abs((I_new - I_old)/I_old)*100;
    I_old = I_new;
    J_old = J_new;
%         disp(['counter = ' num2str(counter) ' percentage change ' num2str(percent_change)]);
end


T = times;
% save('G:\Parthe\Dropbox\Acads\DDP\Demo\music_removal_LL','LLsp','LLnsp','T')
save([file_path  'Output_files' filesep filename filesep 'music_removal_LL'],'LLsp','LLnsp','T')

% Continuity constraint
% A = load('G:\Parthe\Dropbox\Acads\DDP\Demo\silence_removal_1000ms','J_start','J_stop');
A = load([file_path 'Output_files' filesep  filename filesep 'silence_removal_1000ms'],'J_start','J_stop');
min_length = 100;
[J_start,J_stop] = SAD_boolind2array(LLnsp>LLsp,min_length);
temp = T(J_start);
J_start = sort([temp(:); A.J_start(:)])';
temp = T(J_stop);
J_stop = sort([temp(:); A.J_stop(:)])';
% save('G:\Parthe\Dropbox\Acads\DDP\Demo\music_removal_1000ms','J_start','J_stop')
save([file_path  'Output_files' filesep filename filesep 'music_removal_1000ms'],'J_start','J_stop')
disp(['Music removal complete. Time taken = ' num2str(toc)])

