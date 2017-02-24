%% LAB 4, Exercise 1 %%
clc, clear, close all; 

OrignalImage = imread('rice.tif');
OriginalImageAsDouble = double(OrignalImage) / 255;

figure, imshow(OriginalImageAsDouble), title('Original') 

% Choose a single rice
SingleGrainCrop = imcrop(OrignalImage);
SingleGrainCropAsDouble = double(SingleGrainCrop)/255;

[YSingleGrain, XSingleGrain] = hist(SingleGrainCropAsDouble(:), 100);
[YOrignalImage, XOrignalImage] = hist(OriginalImageAsDouble(:), 100);

figure,
subplot(121); plot(XOrignalImage, YOrignalImage),
title('Histogram for original');
subplot(122); plot(XSingleGrain, YSingleGrain),
title('Histogram for cropped image');

% Mean is threshold        
Threshold = mean(SingleGrainCropAsDouble(:));

ZeroOriginalImage = zeros(size(OrignalImage));
IndexGreaterThanSingleGrain = find(SingleGrainCropAsDouble > Threshold + .05);
ZeroOriginalImage(IndexGreaterThanSingleGrain) = 1;
SumOfOnesFromOriginalZero = sum(ZeroOriginalImage(:));

ZeroOriginalImage = zeros(size(OrignalImage));
IndexGreaterThanOrignalImage = find(OriginalImageAsDouble > Threshold + .05);
ZeroOriginalImage(IndexGreaterThanOrignalImage)=1;
SumOfOnesFromSingleZero = sum(ZeroOriginalImage(:));

figure, imshow(ZeroOriginalImage); title('BW-billede');

NumberOfRice = SumOfOnesFromSingleZero / SumOfOnesFromOriginalZero