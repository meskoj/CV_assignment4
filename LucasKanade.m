function [u, v] = LucasKanade(im1, im2, windowSize)
% Optical Flow - Lucas Kanade algorithm
% INPUT: im1, im2 two adjacent image frames (instants t and t+1)
%        windowSize the size of a local neighbourhood
% OUTPUT: two maps (double) encoding the two components of OF
%---------------------------------------------------------------------


% images check
if (size(im1,1)~=size(im2,1)) | (size(im1,2)~=size(im2,2))
    error('the two frames have different sizes');
end

if (size(im1,3) ~= 1) | (size(im2, 3) ~= 1)
    error('images must be gray level');
end

% compute space and time derivatives
[fx, fy, ft] = ComputeDerivatives(im1, im2);

u = zeros(size(im1));
v = zeros(size(im1));

halfW = floor(windowSize/2);
dimWindow = sqrt(windowSize);

%  for each pixel of an image I build a least square system 
for i = halfW+1 : size(fx,1)-halfW
   for j = halfW+1:size(fx,2)-halfW
       counter = 1;
       for w1 = 1:dimWindow
           for w2 = 1:dimWindow
               A(counter,1) = fx(i - floor(dimWindow/2) + w1, j - floor(dimWindow/2) + w2);
               A(counter,2) = fy(i - floor(dimWindow/2) + w1, j - floor(dimWindow/2) + w2);
               b(counter,1) = -ft(i - floor(dimWindow/2) + w1, j - floor(dimWindow/2) + w2);
               counter = counter + 1;
           end
       end
   U = pinv(A)*b;     % (transpose(A)*A) * transpose(A)*b;   
      
   u(i,j)=U(1);
   v(i,j)=U(2);
      
   end
end

% adjust NaN
 u(isnan(u))=0;
 v(isnan(v))=0;
 