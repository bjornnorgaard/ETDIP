%Test Sobel filter
%HKa Feb. 2015

clear, close all;

%dI = checkerboard(50); 
%dI = imrotate(dI,45,'bilinear');
image = imread('cameraman.tif');
dI = double(image)/255;

figure, imshow(dI); title('Original')
pause;

hv = fspecial('sobel');
dJv = imfilter(dI,hv);
figure, imshow(abs(dJv)); title('Horizontal edges')
pause;

dJh = imfilter(dI,hv'); %Turn Sobel Filter 90 degrees
figure, imshow(abs(dJh)); title('Veritical edges')
pause;

dJ = abs(1/sqrt(2))*sqrt((dJv).^2+(dJh).^2);%GW formel 3.7-13
dJ = dJ/max(dJ(:));
figure, imshow(dJ);title('Vertical and Horizontal edges')
pause;

%% Unsharp masking GW pp. 162 - 165
dII = imfilter(dI, fspecial('average', 3));

dKK = dI-.25*dII;
figure, imshow(dKK/max(dKK(:))); title('Unsharp masking')
pause;

%Make the image sharper using a Laplacian GW pp. 160-162
dK = imfilter(dI, fspecial('laplacian',0));

dKK = dI-1*dK;
figure, imshow(dKK/max(dKK(:))); title('Laplace sharpning')
pause;

close all;