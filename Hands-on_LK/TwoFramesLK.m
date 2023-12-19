function [] = TwoFramesLK(filename1, filename2, windowSize)

At = imread(filename1);
At1 = imread(filename2);

[rows, cols, dep]=size(At);
if (dep==3)
    At = rgb2gray(At);
    At1 = rgb2gray(At1);
end

% Compute optical flow's components with Lucas Kanade
[Uf,Vf] = LucasKanade(At, At1, windowSize);

figure(1)
subplot(1,3,1)
imshow(At)
subplot(1,3,2)
imshow(At1)

subplot(1,3,3)
quiver(Uf(1:10:size(Uf,1), 1:10:size(Uf,2)), Vf(1:10:size(Vf,1), 1:10:size(Vf,2)))
title('Optical Flow Vectors');
xlabel('X-axis');
ylabel('Y-axis');
axis ij; % ADDED BECAUSE THE PLOT WAS UPSIDE DOWN 
axis tight; % Better resolution on the plot
axis equal;

