%SNR, what is more, what is less
%GW pp.311-321
%HKa Jan. 2015

clear, close all;

I=imread('cameraman.tif');
I=double(I)/255;

n=.1*randn(size(I));
In=I+n;

SNR=10*log10((var(I(:),1)+mean(I(:))^2)/var(n(:),1))
str=strcat('Signal/støj-forhold: ', num2str(SNR), 'dB');
figure, subplot(121); imshow(I);
        subplot(122); imshow(In);title(str)