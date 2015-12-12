%% Calculate all REPERE ivectors for all segments
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
