%Test Skeletonization
%HKa Feb. 2015

clear, close all;

I=imread('rice.tif');
dI=double(I)/255;
A=zeros(size(I));
r=find(dI>.5);
A(r)=1;

figure(1), imshow(A)
S= bwmorph(A,'skel',Inf);
figure(2), imshow(S)
 