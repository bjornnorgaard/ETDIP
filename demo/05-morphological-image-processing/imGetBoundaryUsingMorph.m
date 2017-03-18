%Find boundry using Morphological operations
%HKa Jan. 2015

clc; clear; close all;

% Square as test image
% blackAndWhiteImage = zeros(256, 256);
% blackAndWhiteImage(50:150, 50:150) = 1;

% Rice as test image
riceImage = imread('rice.tif');

riceImageDouble = double(riceImage) / 255;
blackAndWhiteImage = zeros(size(riceImage));
indexForThresholding = find(riceImageDouble > 0.43);
blackAndWhiteImage(indexForThresholding) = 1;

structuralElement = strel('disk', 2);
bw1 = imerode(blackAndWhiteImage, structuralElement);
bw2 = blackAndWhiteImage - bw1;

figure(1), imshow(blackAndWhiteImage), title('Original (thresholded version)');
figure(2), imshow(bw2), 			   title('Boundary')
