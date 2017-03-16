%Otsu algorithm for thresholdning
%GW3e sec. 10.3.3 pp 743-747
%HKa Feb. 2015

clear, close all;

%Load and show
I=imread('cameraman.tif');
figure(1), imshow(I);

%Threshold using Otsu and show
level = graythresh(I); %Otsu's algorithm
BW = im2bw(I,level);
figure(2), imshow(BW);title('Threshold-billede');