%Test of Laplacian operatoren
%HKa Feb. 2015

clear, close all;

%h = fspecial('prewitt'); % See GW p. 708
%ls = (imfilter(h, h) + imfilter(h', h'))/8

filter = fspecial('laplacian', 0)
image = imread('cameraman.tif');

filteredImage = imfilter(image, filter);

figure, imshow(image); title('original');
pause; 

figure, imshow( (double(image)/255) - (3*double(filteredImage)/255) ); title('original - filtered'); 
pause;

K = double(image)/255 - 3*double(filteredImage)/255;

imshow(histeq(K)); title('histeq');
pause; 

close all;
