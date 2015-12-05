function non_speech_indices = SAD_array2ind(start_time_frames,end_time_frames)
% FUNCTION non_speech_indices = SAD_array2ind(start_time_frames,end_time_frames)
% converts the output of the SAD block from the [start stop] format to give frame indices of non-speech

	non_speech_indices = [];
	for i = 1:length(end_time_frames)
		non_speech_indices = [non_speech_indices; (start_time_frames(i):end_time_frames(i))'];
	end
end