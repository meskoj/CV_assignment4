
%% CHANGE DETECTION ALGORITHM
clear all
close all
clc
FIRST_IDX = 250; %index of first image
LAST_IDX = 320; % index of last image

% Let's use the first N  frames to initialize the background
N = 5;

filename = sprintf('videosurveillance/frame%4.4d.jpg', FIRST_IDX);
B = double(rgb2gray(imread(filename))); % Load first frame as background

for t = FIRST_IDX+1 : FIRST_IDX + N-1

    filename = sprintf('videosurveillance/frame%4.4d.jpg', t);
    B = B + double(rgb2gray(imread(filename)));

end

Bprev = B / N; % Put as background the average of the first 5 frames
% figure
% Running_average(B,FIRST_IDX,LAST_IDX,N)
%% OPTICAL FLOW ALGORITHM
Windowsize = 9;
for t = FIRST_IDX+N:LAST_IDX
    filename = sprintf('videosurveillance/frame%4.4d.jpg', t);
    filename_prev = sprintf('videosurveillance/frame%4.4d.jpg', t-1);
    figure(1)
    Bprev = Running_average(Bprev,filename,filename_prev);
    TwoFramesLK(filename_prev,filename,Windowsize);    
end
