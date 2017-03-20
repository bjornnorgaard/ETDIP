%Butterworth transforms in frequence plane --
%High pass filter
%Notice minimum ringing
%HKa Feb. 2015

clc; clear; close all;

%Load image
originalImage = imread('cameraman.tif');
%originalImage = zeros(256,256); originalImage(125:130,10:246)=255;

% Create rektangel
image = double(originalImage)/255;

figure(1), imshow(originalImage); title('Original image')
pause;

% Lets calculate the Fourier Transform (goto Frequnecy Domain)
FI = fft2(image);
FI = fftshift(FI);

% Butterworth HP filter
n = 2;
D0 = 25;
for r = 1:size(FI,1)
    for s = 1:size(FI,2)
        FI(r,s) = 1/(1+(((r-128)^2+(s-128)^2)/D0^2)^(-n))*FI(r,s);
    end
end

logabsFI = log10(abs(FI));
%logabsFI = abs(FI);

figure(2), imshow(logabsFI/max(logabsFI(:))); title('Fourier of cutted frequence using Butterworth')
pause;

% Lets return to the spatial domain
FI = fftshift(FI);
idJ = real(ifft2(FI));

figure(3), imshow(idJ/max(idJ(:))); title('invers Fourier of original image filtered using Butterworth');
pause;

close all;
