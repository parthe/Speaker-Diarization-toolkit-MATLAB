function GMmodel_speech = GMM_MSR2matlab(gmm)
    GMmodel_speech = gmdistribution(gmm.mu',shiftdim(gmm.sigma,-1),gmm.w);
end