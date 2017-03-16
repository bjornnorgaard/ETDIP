%Gamma-correction
%HKa Feb. 2015

clear, close all;

I=imread('cameraman.tif');
figure(1)
subplot(221); imshow(I)
subplot(222); hist(double(I(:)),50)
pause;

subplot(223)
I_gamma=255*((double(I)./255).^.45);%
imshow(uint8(I_gamma));
subplot(224); hist(I_gamma(:),50)