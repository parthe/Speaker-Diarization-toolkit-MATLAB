function music_mixture = GMM_matlab2cluster(GMmodel_music)




%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program GMM_matlab2cluster.m is part of the MATLAB Speaker Diarization Toolkit 
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
 

    music_mixture.K = length(GMmodel_music.PComponents);
    for i = 1:music_mixture.K
        music_mixture.cluster(i).mu = GMmodel_music.mu(i,:)';
        music_mixture.cluster(i).pb = GMmodel_music.PComponents(i);
        music_mixture.cluster(i).invR = diag(1./GMmodel_music.Sigma(1,:,i));
        music_mixture.cluster(i).const = -0.5*log(2*pi)*size(GMmodel_music.Sigma,2) -...
            0.5*log(det(diag(GMmodel_music.Sigma(1,:,i))));
    end
end