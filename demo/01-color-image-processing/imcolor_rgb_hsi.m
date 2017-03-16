%Demo color rgb 2 hsi
%HKa aug. 2003

clear, close all

figure(1)
%rgb1=imread('Fig6.16(a).jpg');
rgb1=imread('flowers.tif');
imshow(rgb1);
title('Original color image')
pause;

figure(2)
r=rgb1(:,:,1);
hist(double(r(:)),255)
title('Histogram, red content')
pause;


figure(3)
colormap('default');
subplot(2,2,1);imshow(rgb1);title('full color');
subplot(2,2,2);;imshow(rgb1(:,:,1));title('red content');  
subplot(2,2,3); imshow(rgb1(:,:,2));title('green content');
subplot(2,2,4); imshow(rgb1(:,:,3));title('blue content');
pause;
 
hsi=rgb2hsv(rgb1);

figure(4);
subplot(2,2,1);imshow(rgb1);title('full color')
subplot(2,2,2); imshow(hsi(:,:,1));title('Hue content');
subplot(2,2,3); imshow(hsi(:,:,2));title('Saturation content');
subplot(2,2,4); imshow(hsi(:,:,3));title('Intensity content');
pause;

figure(5)
h=hsi(:,:,1);
hist(h(:),50);
title('Histogram, Hue content')
xlim([0 1])
pause;

figure(6)
rgb2=hsv2rgb(hsi);
imshow(rgb2);
title('rgb->hsi->rgb')
pause;

%Extra
% -----YCbCr color model-----  
% ycbcr=rgb2ycbcr(rgb1);
% figure;
% subplot(2,2,1);imshow(rgb1);title('full color')
% subplot(2,2,2); imshow(ycbcr(:,:,1));title('Y content');
% subplot(2,2,3); imshow(ycbcr(:,:,2));title('Cb content');
% subplot(2,2,4); imshow(ycbcr(:,:,3));title('Cr content');
% pause;
