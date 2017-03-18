%Morphological pperations
%HKa Feb. 2015

clear, close all;

%Load
image = imread('henrik.bmp');

%Use negative in the following
bw1 = 1 - image;

%Do morphology
se = strel('line', 14, 0);
bw2 = imerode(bw1, se);
bw3 = imdilate(bw1, se);
bw4 = imclose(bw1, se);
bw5 = imopen(bw1, se);

%Show results
figure(1), imshow(bw1), title('Original negative')
pause;
figure(2), imshow(bw2), title('Erosion of negative')
pause;
figure(3), imshow(bw3), title('Dilation of negative')
pause;
figure(4), imshow(bw4), title('Closing of negative')
pause;
figure(5), imshow(bw5), title('Opening of negative')
pause;

close all;
