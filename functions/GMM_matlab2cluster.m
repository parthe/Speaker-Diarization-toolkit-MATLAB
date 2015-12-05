function music_mixture = GMM_matlab2cluster(GMmodel_music)
    music_mixture.K = length(GMmodel_music.PComponents);
    for i = 1:music_mixture.K
        music_mixture.cluster(i).mu = GMmodel_music.mu(i,:)';
        music_mixture.cluster(i).pb = GMmodel_music.PComponents(i);
        music_mixture.cluster(i).invR = diag(1./GMmodel_music.Sigma(1,:,i));
        music_mixture.cluster(i).const = -0.5*log(2*pi)*size(GMmodel_music.Sigma,2) -...
            0.5*log(det(diag(GMmodel_music.Sigma(1,:,i))));
    end
end