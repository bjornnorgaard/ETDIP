%TopHat transform
%See GW pp.672
%HKa Feb. 2015

clear, close all;

% Read image and show
image = imread('rice.tif');
%image = imread('cameraman.tif')
figure(1), imshow(image), title('Original');
pause;

%Maximize Contrast
structuralElement = strel('disk', 10);
Itop = imtophat(image, structuralElement); % h=f - (f open b)
Ibot = imbothat(image, structuralElement); % h=(f close b) -f
figure(2), imshow(Itop), title('top-hat image');
pause;

figure(3), imshow(Ibot), title('bottom-hat image');
pause;

% Subtract Images
Ienhance = imsubtract(imadd(Itop, image), Ibot);
figure(4), imshow(Ienhance), title('Original + top-hat - bottom-hat');
pause;

close all;
