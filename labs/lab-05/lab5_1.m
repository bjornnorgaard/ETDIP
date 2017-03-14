%% LAB5_1
clc; clear; close all;

plot_h = 2;
plot_w = 2;

%% load image and show original
I = imread('rice.tif');
dI = double(I)/255;
subplot(plot_w, plot_h, 1); imshow(dI); title('original');

%% choose a single grain of rice
Icrop = imcrop(I);
dIcrop = double(Icrop)/255;

[yValuesIn_dIcrop, xValuesIn_dIcrop] = hist(dIcrop(:), 100);
[yValuesIn_dI    , xValuesIn_dI    ] = hist(dI    (:), 100);

figure,
subplot(plot_w, plot_h, 2); 
plot(xValuesIn_dI, yValuesIn_dI),
title('original');
