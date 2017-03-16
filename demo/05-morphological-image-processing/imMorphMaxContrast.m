%TopHat transform
%See GW pp.672
%HKa Feb. 2015

clear, close all;

%Read image and show
I=imread('rice.tif');
%I=imread('cameraman.tif')
figure(1), imshow(I), title('Original');

%Maximize Contrast
se = strel('disk', 10);
Itop = imtophat(I, se); %h=f - (f open b)
Ibot = imbothat(I, se); %%h=(f close b) -f
figure(2), imshow(Itop), title('top-hat image');
figure(3), imshow(Ibot), title('bottom-hat image');

%Subtract Images
Ienhance = imsubtract(imadd(Itop, I), Ibot);
figure(4), imshow(Ienhance), title('Original + top-hat - bottom-hat');