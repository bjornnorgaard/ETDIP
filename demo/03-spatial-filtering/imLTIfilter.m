%How does the command imfilter work in MatLab
%HKa Feb. 2015

clear, close all;

n = 256;
% What is the P(oint) S(pread) F(unction)

filter = [ 1, 2, 3; 4, 5, 6; 7, 8, 9];

imageArray = zeros(n, n);
imageArray(n/2, n/2) = 1;

resultingArray = imfilter(imageArray, filter);
resultingArray(n/2-5:n/2+5, n/2-5:n/2+5)

%-------------------

% Lets study a MA filter
% MA filter blurs edges
filter = ones(3, 3)./9;

imageArray = zeros(n, n);
imageArray(n/2, :) = .5;
filteredImageArray = imfilter(imageArray, filter);

imageArray(n/2-5:n/2+5, n/2-5:n/2+5)
filteredImageArray(n/2-5:n/2+5, n/2-5:n/2+5)

figure(1)
subplot(211), imshow(imageArray); 		  title('Original')
subplot(212), imshow(filteredImageArray); title('Edges are blured using a MA filter')

imageArray = imread('cameraman.tif');

figure(2)
subplot(211), imshow(imageArray);								 title('Original')
subplot(212), imshow(imfilter(double(imageArray)./255, filter)); title('Edges are blured using a MA filter')
pause;

%-------------------

% MA filter closes holes
imageArray = zeros(n, n);
imageArray(n/2, :) = .5;
imageArray(n/2, n/2:n/2+1) = 0;

filter = ones(3,3)/4;
filteredImageArray = imfilter(imageArray,filter);

imageArray(n/2-5:n/2+5, n/2-5:n/2+5)
filteredImageArray(n/2-5:n/2+5, n/2-5:n/2+5)

figure(3)
subplot(211), imshow(imageArray);		  title('Orignal, note hole in the line')
subplot(212), imshow(filteredImageArray); title('Edges are blured using a MA filter')

filteredImageArray = filteredImageArray>.01;
figure(4)
imshow(filteredImageArray); title('Close holes using a MA filter')

pause; 
close all;
