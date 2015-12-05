function i_vector = get_ivector(segment_matrix,UBM,T)
    [N,F] = compute_bw_stats(segment_matrix', UBM.gmm);
    stats = [N; F];
    i_vector = extract_ivector(stats,UBM.gmm,T);
end