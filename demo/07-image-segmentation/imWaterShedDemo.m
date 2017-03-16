%Segemtation using WaterShed
%MatLab demo
%HKa Feb. 2015

clear, close all;

%Load and show
I = imread('afmsurf.tif');
%I=imread('rice.tif');
figure, imshow(I), title('surface image');

%Maximize Contrast
se = strel('disk', 15);
Itop = imtophat(I, se);
Ibot = imbothat(I, se);
figure, imshow(Itop), title('top-hat image');
figure, imshow(Ibot), title('bottom-hat image');

%Subtract Images
Ienhance = imsubtract(imadd(Itop, I), Ibot);
figure, imshow(Ienhance), title('original + top-hat - bottom-hat');

%Convert Objects of Interest
Iec = imcomplement(Ienhance);
figure, imshow(Iec), title('complement of enhanced image');

%Detect Intensity Valleys 
Iemin = imextendedmin(Iec, 22);%Get regions where pixel values are 22 less that neighbour pixel values
Iimpose = imimposemin(Iec, Iemin);%Set these regiosn to 0
figure, imshow(Iemin), title('extended minima image');
figure, imshow(Iimpose), title('imposed minima image');

%Watershed Segmentation
wat = watershed(Iimpose);
rgb = label2rgb(wat);
figure, imshow(rgb);
title('watershed segmented image');

%Extract Features from Label Matrix
stats = regionprops(wat, 'Area', 'Orientation');
area = [stats(:).Area];
orient = [stats(:).Orientation];
figure, plot(area, orient, 'b*');
title('Particle orientation versus particle area');
xlabel('Particle area (pixels)');
ylabel('Particle orientation (degrees)');