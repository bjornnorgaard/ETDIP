%Butterworth transforms in frequence plane --
%Notice minimum ringing
%HKa Feb. 2015

clear, close all;

%Load image and show
I=imread('cameraman.tif');
%Create rektangel
%I=zeros(256,256); I(125:130,10:246)=255;
dI=double(I)/255;
figure(1), imshow(I);title('Original image')


%Lets calculate the Fourier Transform (goto Frequnecy Domain)
FI=fft2(dI);
FI=fftshift(FI);

%Butterworth filter
n=2;
D0=25;
for r=1:size(FI,1)
    for s=1:size(FI,2)
        FI(r,s)=1/(1+(((r-126)^2+(s-126)^2)/D0^2)^n)*FI(r,s);
    end
end
logabsFI=log10(abs(FI));
figure(2), imshow(logabsFI/max(logabsFI(:)));title('Fourier of cutted frequence using Butterworth')

%Lets return to the spatial domain
FI=fftshift(FI);
idJ=real(ifft2(FI));
figure(3), imshow(idJ/max(idJ(:)));title('Invers Fourier of original image filtered using Butterworth');