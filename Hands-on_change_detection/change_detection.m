%% Task 1: work on the videosurveillance sequence using a simple background obtained as an 
% average between two empty frames

% Load two empty images
B1 = double(rgb2gray(imread('EmptyScene01.jpg')));
B2 = double(rgb2gray(imread('EmptyScene02.jpg')));

% Compute a simple background model
B = 0.5*(B1 + B2);

% Load each image in the sequence, perform the change detection
% show the frame, the background and the binary map
% Observe how the results change as you vary the threshold

tau = 20;

FIRST_IDX = 250; %index of first image
LAST_IDX = 320; % index of last image

for t = FIRST_IDX : LAST_IDX
    
    filename = sprintf('../../Data/videosurveillance/frame%4.4d.jpg', t);
    It = imread(filename);
    Ig = rgb2gray(It);
    
    Mt = (abs(double(Ig) - B) > tau);
    
    subplot(1, 3, 1), imshow(It),title("Original Image");
    subplot(1, 3, 2), imshow(uint8(B)), title("Background");
    subplot(1, 3, 3), imshow(uint8(Mt*255)), title("Binary Matrix");
    pause(0.5)

end

%% Task 2: working again on the videosurveillance sequence, use now a background model based 
% on running average to incorporate scene changes

FIRST_IDX = 250; % Index of first image
LAST_IDX = 320;  % Index of last image

% Let's use the first N  frames to initialize the background
N = 5;

filename = sprintf('../../Data/videosurveillance/frame%4.4d.jpg', FIRST_IDX);

B = double(rgb2gray(imread(filename))); % Load first frame as background

for t = FIRST_IDX+1 : FIRST_IDX + N-1

    filename = sprintf('../../Data/videosurveillance/frame%4.4d.jpg', t);
    B = B + double(rgb2gray(imread(filename)));

end

B = B / N; % Put as background the average of the first 5 frames

% Play with these parameters
TAU = 40; 
ALPHA = 0.7;
tau_prime = 2; 

% Now start the change detection while updating the background with the
% running average. For that you have to set the values for TAU and ALPHA

Bprev = B;
for t = FIRST_IDX+N : LAST_IDX
    
    filename = sprintf('../../Data/videosurveillance/frame%4.4d.jpg', t);
    filename_prev = sprintf('../../Data/videosurveillance/frame%4.4d.jpg', t-1);

    It = imread(filename);
    It_prev = imread(filename_prev);

    Ig = rgb2gray(It);
    Ig_prev = rgb2gray(It_prev);

    Mt = (abs(double(Ig) - Bprev) > TAU);
    
    % Implement the background update as a running average (SEE THE SLIDES)
    Dt = abs(double(Ig) - double(Ig_prev));
    
    for i=1:1:size(Dt,1)
        for j=1:1:size(Dt,2)
            if Dt(i,j) > tau_prime
                Bt(i,j) = Bprev(i,j);
            else 
                Bt(i,j) = (1-ALPHA)*Bprev(i,j) + ALPHA*double(Ig(i,j));
            end
        end
    end

    subplot(1, 3, 1), imshow(It), title("Original Image")
    subplot(1, 3, 2), imshow(uint8(Bt)), title("Background")
    subplot(1, 3, 3), imshow(uint8(Mt*255)), title("Binary Matrix")
    pause(0.1)
    Bprev = Bt;
    
end
