%Gaussian LP
%No ringing
%HKa Feb. 2015

clear, close all;

% Load image and show
image = imread('cameraman.tif');
% Create rektangel
%image = zeros(256,256); image(125:130,10:246)=255;
dI = double(image)/255;

figure(1), imshow(image); title('Original image')
pause;

% Lets calculate the Fourier Transform (goto Frequnecy Domain)
FI = fft2(dI);
FI = fftshift(FI);

% Gasussian filter
D0 = 10;
for r = 1:size(FI,1)
    for s = 1:size(FI,2)
        FI(r,s)=exp(-((r-128)^2+(s-128)^2)/(2*D0^2))*FI(r,s);
    end
end

logabsFI = log10(abs(FI));

figure(2), imshow(logabsFI/max(logabsFI(:))); title('Fourier of cutted frequence using Gaussian filter')
pause;

% Lets return to the spatial domain
FI = fftshift(FI);
idJ = real(ifft2(FI));

figure(3), imshow(idJ/max(idJ(:))); title('invers Fourier of original image filtered using Gaussian filter');
pause; 

close all;