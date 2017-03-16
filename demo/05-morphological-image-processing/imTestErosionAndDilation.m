%Morphological pperations
%HKa Feb. 2015

clear, close all;

%Load
bw = imread('henrik.bmp');

%Use negative in the following
bw1=1-bw;

%Do morphology
se = strel('line',14,0);
bw2 = imerode(bw1, se);
bw3 = imdilate(bw1,se);
bw4 = imclose (bw1,se);

%Show results
figure(1), imshow(bw1), title('Original negative')
figure(2), imshow(bw2), title('Erosion of negative')
figure(3), imshow(bw3), title('Dilation of negative')
figure(4), imshow(bw4), title('Closing of negative')