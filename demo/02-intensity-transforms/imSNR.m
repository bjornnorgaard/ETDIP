%SNR in images. What is high, what is low?
%HKa Feb. 2015

clear, close all;

I=imread('cameraman.tif');
%I=imread('lenna.tif');
%I=imread('fingerprint.tif');
%I=imread('kobling.tif');

figure(1)
subplot(221); imshow(I)
subplot(222); hist(double(I(:)),50)
Pi=var(double(I(:)))
pause;

subplot(223)
n=50*randn(size(I));
J=double(I)+n;
imshow(uint8(J));
subplot(224); hist(double(J(:)),50)
Pn=var(double(n(:)))
SNR=10*log10(Pi/Pn)