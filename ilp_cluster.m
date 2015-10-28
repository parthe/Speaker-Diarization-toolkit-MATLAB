%% Calculate distances
tic
WCCN = load('TIMIT_WCCN_75');
        
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\ivectors','segment_IVs')
    load([file_path filename '\ivectors'],'segment_IVs')

    D = zeros(length(segment_IVs));
    for i = 1:length(D)-1
        for j = i+1:length(D)
            D(i,j) = (segment_IVs{i} - segment_IVs{j})'/WCCN.W*(segment_IVs{i} - segment_IVs{j});
        end
    end
    D = D + transpose(D);
    
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\distances','D')
    save([file_path filename '\distances'],'D')

%% Cluster ILP on ivectors distances

        
%     load('G:\Parthe\Dropbox\Acads\DDP\Demo\distances','D')
    save([file_path filename '\distances'],'D')
    labels = new_ilp(D,75);
    
%     save('G:\Parthe\Dropbox\Acads\DDP\Demo\cluster_output','labels')
    save([file_path filename '\cluster_output'],'labels')
disp(['ILP Speaker clustering complete. Time taken = ' num2str(toc)])
