function non_speech_indices = SAD_array2ind(start_time_frames,end_time_frames)
% FUNCTION non_speech_indices = SAD_array2ind(start_time_frames,end_time_frames)
% converts the output of the SAD block from the [start stop] format to give frame indices of non-speech


%%%%%%%%%%%%%%%%%%%% LICENCE TEXT %%%%%%%%%%%%%%%%%%%%%%%%%%
% This program SAD_array2ind.m is part of the MATLAB Speaker Diarization Toolkit 
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
 

	non_speech_indices = [];
	for i = 1:length(end_time_frames)
		non_speech_indices = [non_speech_indices; (start_time_frames(i):end_time_frames(i))'];
	end
end