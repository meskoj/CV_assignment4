clear all
close all
clc
%% OPTICAL FLOW ALGORITHM

FIRST_IDX = 250; %index of first image
LAST_IDX = 320; % index of last image
Windowsize = 9;
% Let's use the first N  frames to initialize the background of change
% detection
N = 5;

filename = sprintf('../Data/videosurveillance/frame%4.4d.jpg', FIRST_IDX);
B = double(rgb2gray(imread(filename))); % Load first frame as background

for t = FIRST_IDX+1 : FIRST_IDX + N-1

    filename = sprintf('../Data/videosurveillance/frame%4.4d.jpg', t);
    B = B + double(rgb2gray(imread(filename)));

end

Bprev = B / N; % Put as background the average of the first 5 frames

for t = FIRST_IDX+N : LAST_IDX
    
     % Select the surveillance as images
     filename = sprintf('../Data/videosurveillance/frame0%d.jpg', t);
     filename_prev = sprintf('../Data/videosurveillance/frame0%d.jpg', t-1);

    TwoFramesLK_modified(filename_prev,filename,Windowsize);
    Bprev = Running_average(Bprev,filename,filename_prev);
    pause(0.5)
end


