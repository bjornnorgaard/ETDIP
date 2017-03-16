%Test of Laplacian operatoren
%HKa Feb. 2015

clear, close all;

%h=fspecial('prewitt');%see GW p. 708
%ls=(imfilter(h,h)+imfilter(h',h'))/8

lp=fspecial('laplacian',0)
I=imread('cameraman.tif');

J=imfilter(I,lp);
figure, imshow(I);
figure, imshow(double(I)/255-3*double(J)/255)

K=double(I)/255-.5*double(J)/255;

imshow(histeq(K))

