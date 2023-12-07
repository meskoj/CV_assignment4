function [] = TwoFramesLK(filename1, filename2, windowSize)

At = imread(filename1);
At1 = imread(filename2);

[rows, cols, dep]=size(At);
if (dep==3)
    At = rgb2gray(At);
    At1 = rgb2gray(At1);
end

[Uf,Vf] = LucasKanade(At, At1, windowSize);

% figure()
% subplot(1,2,1)
% imshow(At)
% subplot(1,2,2)
% imshow(At1)

% figure()
% SEE help quiver for more information
subplot(1,2,1);
quiver(Uf(1:10:size(Uf,1), 1:10:size(Uf,2)), Vf(1:10:size(Vf,1), 1:10:size(Vf,2)))
% 1:10:size fa il downsampling


%Uso quiver(u, -v, 0) per visualizzare il campo vettoriale (u,v)
%
