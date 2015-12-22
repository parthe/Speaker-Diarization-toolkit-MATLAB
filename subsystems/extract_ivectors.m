%% Calculate all REPERE ivectors for all segments


%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program extract_ivectors.m is part of the MATLAB Speaker Diarization Toolkit 
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
UBM = load('UBM_GMM_TIMIT');
variability_subspace = load('TIMIT_T_matrix_75','T');


%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\segments','segments');
    load([file_path 'Output_files' filesep filename filesep 'segments'],'segments')

    segment_IVs = cell(length(segments),1);

    for seg_num = 1:length(segment_IVs)
        segment_IVs{seg_num} = get_ivector(segments{seg_num},UBM,variability_subspace.T);
    end
        
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\ivectors','segment_IVs')
    save([file_path 'Output_files' filesep filename filesep 'ivectors'],'segment_IVs')
disp(['i-vector extraction complete. Time taken = ' num2str(toc)])
