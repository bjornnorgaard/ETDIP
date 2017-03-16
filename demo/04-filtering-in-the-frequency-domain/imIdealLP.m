%Transforms in frequency plane -- Ideal Low-pass
%Notice ringing
%HKa Feb. 2015

clear, close all;

%Load image and show
I=imread('cameraman.tif');
%I=zeros(256,256); I(128, 128)=255; %Delta function
dI=double(I)/255;
figure(1), imshow(I);title('Original image')

%Lets calculate the Fourier Transform (goto Frequnecy Domain)
FI=fft2(dI);
FI=fftshift(FI);

%Do the Low pass filtering
D0=25;
for r=1:size(FI,1)
    for s=1:size(FI,2)
        if (r-128)^2+(s-128)^2 > D0^2 FI(r,s)=0; end;
    end
end
logabsFI=log10(abs(FI)+1);
figure(2), imshow(logabsFI/max(logabsFI(:)));title('Fourier of cutted frequences')

%Lets return to the spatial domain
FI=fftshift(FI);
idJ=ifft2(FI);
figure(3), imshow(idJ/max(idJ(:)));title('Ideal Lowpass filtered image')