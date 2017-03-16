%Find boundry using Morphological operations
%HKa Jan. 2015

clear, close all;

%Square as test image
% bw=zeros(256,256);
% bw(50:150,50:150)=1;

%Rice as test image
I=imread('rice.tif');

dI=double(I)/255;
bw=zeros(size(I));
r=find(dI>0.43);
bw(r)=1;

se = strel('disk',2);
bw1 = imerode(bw,se);
bw2=bw-bw1;
figure(1), imshow(bw), title('Original (thresholded version)');
figure(2), imshow(bw2), title('Boundary')