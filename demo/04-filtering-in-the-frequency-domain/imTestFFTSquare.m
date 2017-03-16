%Analysing the Fourier Transform
%Lets look at spectra for a rectangle, checkerboard and cameraman, 
%HKa Feb. 2015

clear, close all;

%Create Rectangle
I=zeros(256,256); I(125:130,110:140)=1;
%I=imrotate(I,35,'crop');

%Create checkerboard
%I = (checkerboard(30)>.5);
%I=imrotate(I,45);

%Load image cameraman
%I=imread('cameraman.tif');
%I = imread('boats.pgm');
figure(1), imshow(I);title('Original image')

%Let's calculate the Fourier Transform
FI=fft2(I);
logabsFI=log10(abs(FI));
figure(2), imshow(logabsFI/max(logabsFI(:)));title('Fourier of original image (without fftshift => DC in upper left corner)')

%Let's put the DC in the center
%This can be done using fftshift or spatial modulation with (-1)^(r+s) == fftshift();
dI=double(I);
for r=1:size(I,1)
    for s=1:size(I,2)
        dI(r,s)=(-1)^(r+s)*dI(r,s);
    end
end

%Note sinc() in horizontal and vertical derection (for the Rectangle)--
FI=fft2(dI);
logabsFI=log10(abs(FI));
figure(3), imshow(logabsFI/max(logabsFI(:)));title('Fourier of original image (DC in the center)')

%w=1:size(I,1);
%s=log10((w-size(I,1)/2+.5).^-1.6)+7;    %d=-1.6 for cameraman.
%figure, plot(w,logabsFI(:,size(I,1)/2),w,s );%Power in a horizontal-direction