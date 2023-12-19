clear all
close all
clc
%% COMPARISON BETWEEN MOTION ALGORITHM

FIRST_IDX = 250; % Index of first image
LAST_IDX = 320;  % Index of last image
windowSize = 9;

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

    % Run the Lucas Kanade algorithm and the change detection with running
    % average
    TwoFramesLK_modified(filename_prev,filename,windowSize);
    Bprev = Running_average(Bprev,filename,filename_prev);
    
    pause(0.5)
end


