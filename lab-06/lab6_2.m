%Lab 6_2
%Lets look at the spectra for rose, crowd, cameraman,
%HKa okt. 2008

clear, close all;

%Load image
%I=imread('rose.jpg');
%I=imread('lena.jpg');
I=imread('cameraman.tif');


%dI=double(rgb2gray(I))/255; %Used for rose and lena
dI=double(I)/255;%Used for cameraman
figure, imshow(dI);title('Original image')

%DFT of image
FI=fftshift(fft2(dI));
logabsFI=log10(abs(FI)+1);
figure, imshow(logabsFI/max(logabsFI(:)));title('Fourier of original image')

%Find d
w=1:size(I,1);
s=20*log10((w-size(I,1)/2+.01).^-1.6)+50;       %d=-1.6 is OK.
figure, plot(w,20*logabsFI(:,size(I,1)/2),w,s );%Power in a horizontal-direction