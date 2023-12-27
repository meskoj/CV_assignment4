function Bprev = Running_average(Bprev,filename,filename_prev)
% Now start the change detection while updating the background with the
% running average. For that you have to set the values for TAU and ALPHA

% Play with these parameters
TAU = 30;
TAU_prime = 0;
ALPHA = 0.5;

It = imread(filename);
It_prev = imread(filename_prev);
Ig = rgb2gray(It);
Ig_prev = rgb2gray(It_prev);
Mt = (abs(double(Ig) - Bprev) > TAU);

% Implement the background update as a running average (SEE THE SLIDES)
Dt = abs(double(Ig) - double(Ig_prev));

for i=1:1:size(Dt,1)
    for j=1:1:size(Dt,2)
        if Dt(i,j) > TAU_prime
            Bt(i,j) = Bprev(i,j);
        else
            Bt(i,j) = (1-ALPHA)*Bprev(i,j) + ALPHA*double(Ig(i,j));
        end
    end
end

subplot(1, 2, 2), imshow(uint8(Mt*255));
title("Change detection binary map")
Bprev = Bt;

end