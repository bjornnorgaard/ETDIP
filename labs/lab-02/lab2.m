%% lab 2
clc; clear; close all;

%% 2.1 explain psf

% et j�vnt ryk i kameraet

%% 2.2 measure blur

% looking at coat, its about 10px

%% 2.3 load image

original_image = imread('cameraman.tif');
image_double = double(original_image);
image_double = image_double / max(image_double(:));
subplot(221); imshow(image_double); title('original');

blur_factor = 9; %M odd
lines_of_ones = ones(1, blur_factor);
lines_of_ones = lines_of_ones ./ sum(lines_of_ones(:));

dB = imfilter(image_double, lines_of_ones);
subplot(222) ;imshow(dB); title('imfilter blurred');

%% 2.4 blur original image

blur_factor = 9; %M odd
lines_of_ones = ones(1, blur_factor);
lines_of_ones = lines_of_ones ./ sum(lines_of_ones(:));

for r = 1 : size(image_double, 1)
    dJ(r, :) = filter(lines_of_ones, 1, image_double(r,:));
end;

% dJ=dJ+.02*randn(size(dJ));

subplot(223); imshow(dJ); title('for-loop blurred');

%% 2.5 show h * h_inv = delta

%% 2.6 recover blurred image

L = blur_factor * 64;

for s = 1 : L
    if (mod(s - 1, blur_factor) == 0) 
        ih(s) =+ 1;
    end;
    if (mod(s - 2, blur_factor) == 0)
        ih(s) =- 1;
    end;
end;

ih(L) = 0;

% for r=1:size(dJ,1)
%     dK(r,:)=filter(ih,1,dJ(r,:));
% end;
for r = 1 : size(dJ, 1)
    dK(r,:) = filter(ih, 1, dJ(r, :));
end;

subplot(224); imshow(dK/max(dK(:))); title('deblurred');
