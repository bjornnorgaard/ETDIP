%Pseudo colors
%HKa Feb. 2015

clear, close all;

%Load and show
I=imread('cameraman.tif');
figure(1), imshow(I);

%Genrate LUT and show
ps=rand(256,3);
figure(2), imshow(I,ps)