

%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program ilp_cluster.m is part of the MATLAB Speaker Diarization Toolkit 
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
 


%% Calculate distances
tic
WCCN = load('TIMIT_WCCN_75');
        
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\ivectors','segment_IVs')
    load([file_path 'Output_files' filesep  filename filesep 'ivectors'],'segment_IVs')

    D = zeros(length(segment_IVs));
    for i = 1:length(D)-1
        for j = i+1:length(D)
            D(i,j) = (segment_IVs{i} - segment_IVs{j})'/WCCN.W*(segment_IVs{i} - segment_IVs{j});
        end
    end
    D = D + transpose(D);
    
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\distances','D')
    save([file_path 'Output_files' filesep  filename filesep 'distances'],'D')

%% Cluster ILP on ivectors distances

        
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\distances','D')
    save([file_path 'Output_files' filesep  filename filesep 'distances'],'D')
    labels = new_ilp(D,75);
    
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\cluster_output','labels')
    save([file_path 'Output_files' filesep  filename filesep 'cluster_output'],'labels')
disp(['ILP Speaker clustering complete. Time taken = ' num2str(toc)])
