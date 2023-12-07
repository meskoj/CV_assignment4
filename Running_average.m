function Bprev = Running_average(Bprev,filename,filename_prev)
% Now start the change detection while updating the background with the
% running average. For that you have to set the values for TAU and ALPHA

% Play with these parameters
TAU = 25;
ALPHA = 0.9;

% for t = FIRST_IDX+N : LAST_IDX
% 
%     filename = sprintf('videosurveillance/frame%4.4d.jpg', t);
%     filename_prev = sprintf('videosurveillance/frame%4.4d.jpg', t-1);
% 
   It = imread(filename);
   It_prev = imread(filename_prev);
   Ig = rgb2gray(It);
   Ig_prev = rgb2gray(It_prev);
    Mt = (abs(double(Ig) - Bprev) > TAU);

    % Implement the background update as a running average (SEE THE SLIDES)
    Dt = abs(double(Ig) - double(Ig_prev));
    if Dt > TAU
        Bt = Bprev;
    else
        Bt = (1-ALPHA)*Bprev + ALPHA*double(Ig);
    end


    %keyboard
    %subplot(1, 3, 1), imshow(It);
    %subplot(1, 3, 2), imshow(uint8(Bt));
    subplot(1, 2, 2), imshow(uint8(Mt*255));
    Bprev = Bt;

% end
end