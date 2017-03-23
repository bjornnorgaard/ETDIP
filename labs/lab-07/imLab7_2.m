% Lab 7.2, Blind Wiener filtering
% HKa oct. 2008

clear, close all

i = imread('boats.pgm');
%i= imread('cameraman.tif');
im=double(i)/255;

stdev = .5
n=stdev*randn(size(im));
noisy = im + n;

[clean, emse] = wienerClean(noisy,2.4);

figure, imshow(im);title('Original');
figure, imshow(noisy);title('Noise and original');
figure, imshow(clean);title('Cleaned image')
figure, imshow(abs(n));title('Noise');
figure, imshow(abs(clean-noisy));title('Signal removed by the Wiener filter');
figure, imshow(abs(clean+n-noisy));title('Difference between the 2 types of noise');