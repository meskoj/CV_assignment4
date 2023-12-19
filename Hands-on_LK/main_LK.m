% Select the indeces of the frames
FIRST_IDX = 0; %index of first image (sphere)
LAST_IDX = 19; % index of last image (sphere)
% FIRST_IDX = 250; %index of first image (surveillance)
% LAST_IDX = 320; % index of last image (surveillance)


for t = FIRST_IDX+1 : LAST_IDX

    % Select the sphere as images
    filename = sprintf('../../Data/sphere/sphere.%d.ppm', t);
    filename_prev = sprintf('../../Data/sphere/sphere.%d.ppm', t-1);

    % Select the surveillance as images
    % filename = sprintf('../../Data/videosurveillance/frame0%d.jpg', t);
    % filename_prev = sprintf('../../Data/videosurveillance/frame0%d.jpg', t-1);

    % Run Lucas Kanade algorithm on two frames with a window of dimension
    % windowSize
    windowSize = 9;
    TwoFramesLK(filename_prev,filename, windowSize);
    pause(0.5)
end