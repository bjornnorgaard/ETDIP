%Fase is important
%HKa Feb. 2015

clear, close all;
I=imread('cameraman.tif');
dI=double(I)/255;
figure(1), imshow(dI);title('Original')

FI=fft2(dI);

%We destroy the amplitude, observe
%N=rand(size(I));
N=rand(size(I));
figure(2), imshow(real(ifft2(FI.*N)));title('Fase intact, amplitude is destroyed!')

%Vi ødelægger fasen, OBS! det kan vi IKKE leve med
%expN=exp(j*2*pi*rand(size(I)));
expN=exp(j*2*pi*.4*rand(size(I)));
figure(3), imshow(real(ifft2(FI.*expN)));title('Amp. intact, fasen is destroyed!')