# Matlab-speaker-diarization-toolkit
An end-to-end MATLAB toolkit for completely unsupervised Speaker Diarization using state-of-the-art algorithms.
 
# About the System 
 The system is useful for researchers starting their work in Speaker Diarization esp. for segmentation of broadcast news.
  The speech activity detector (SAD) and speaker segmentation blocks are completely unsupervised and do not require external training data. The speaker clustering is equipped with i-vector based ILP clustering which is the current state-of-the-art.
 
 The sub-systems of the toolkit can also be plugged into other projects but have not been optimized for it. Eg: Time-series change detection, speech activity detection, Speaker recognition, Hard clustering, Soft Clustering, k-centres clustering
 
# How to run
 A few other open-source toolkits have been used. To run the system:
 1. Download the source code of this toolkit
 2. Download the dependencies by clicking the links next to names of toolkits mentioned below. They are all MATLAB codes and only need to be added to the MATLAB path. It runs smoothly on MATLAB 2013+
 
     i. Voicebox <http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.zip>

     ii. A speech/music discriminator based on RMS and zero-crossings <http://www.mathworks.com/matlabcentral/fileexchange/submissions/42092/v/7/download/zip>
     
     iii. MSR Identity toolbox <http://ftp.research.microsoft.com/downloads/2476c44a-1f63-4fe0-b805-8c2de395bb2c/MSR%20Identity%20Toolkit%20v1.0.zip?>
     
     iv. Cluster Toolbox (Purdue) <https://engineering.purdue.edu/~bouman/software/cluster/cluster-matlab/gaussmix-v1.2.zip>
3. Cite the following Thesis in your work <http://www.slideshare.net/ParthePandit/parthepandit10d070009ddpthesis-53767213> 
 
 This system was developped by Parthe Pandit as part of his Masters thesis. It is a Speaker Diarization system designed for segmention Broadcast News Audios. For details, please have a look at the following thesis. <THESIS LINK>

