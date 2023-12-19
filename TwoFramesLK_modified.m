function [] = TwoFramesLK_modified(filename1, filename2, windowSize)

At = imread(filename1);
At1 = imread(filename2);

[rows, cols, dep]=size(At);
if (dep==3)
    At = rgb2gray(At);
    At1 = rgb2gray(At1);
end

[Uf,Vf] = LucasKanade(At, At1, windowSize);
% Calculate the magnitude of optical flow
magnitude = sqrt(Uf.^2 + Vf.^2);

% Since the magnitude is very noisy, it was added a threshold to eliminate
% the values that are lower

threshold = 1;
magnitude(magnitude <= threshold) = 0;

figure(1)
subplot(1,2,1);
imshow(magnitude);
title('Optical Flow Magnitude');

end
