%% lab 1
clear; clc;

% global variables
pauseDuration = 1;

%% 1. load image
img = imread('pcameraman.tiff');

% 1.1 determine image dimentions
whos img
% eller
size(img)

% 1.1 find max and min pixel value
min(img(:))
max(img(:))

%% 2. show image

imshow(img);
pause(pauseDuration);
close all;

%% 3. show specific part of image

subImg = img(100:150,100:150);
imshow(subImg);
pause(pauseDuration);
close all;

% pretty subplot
figure;
subplot(2,1,1);
imshow(img);
subplot(2,1,2);
imshow(subImg);
pause(pauseDuration);
close all;

%% 4. use histogram function

hist(double(img(:)));
pause(pauseDuration);
close all;

%% 5. generate new image

% find the mean value
mean = mean(img(:));
newImage = zeros(size(img));
lr = find(img > mean);
newImage(lr) = 255;

imshow(newImage);
pause(pauseDuration);
close all;

%% 6. enlarge image 3 times with nearest neighbor interpolation

factor = 3;
new_image = zeros(size(img)*factor);

for r=1 : size(new_image,1)
    for c=1 : size(new_image,2)
        new_image(r,c) = img(ceil(r/factor),ceil(c/factor));
    end;
end;

imshow(uint8(new_image));
pause(pauseDuration);
close all;

%% 7. 

E = 3;
Id=double(img);
Id(end+1,:)=Id(end,:);Id(:,end+1)=Id(:,end); 
I7=zeros(size(img)*E);
for r=1:size(I7,1)
    for s=1:size(I7,2)
        dx=mod(r-1,E)/E;
        dy=mod(s-1,E)/E;
        x0=ceil(r/E);x1=x0+1;
        y0=ceil(s/E);y1=y0+1;
        p=Id(x0,y0)+(Id(x1,y0)-Id(x0,y0))*dx;
        q=Id(x0,y1)+(Id(x1,y1)-Id(x0,y1))*dx;
                
        I7(r,s)=p+(q-p)*dy;
    end;
end;

imshow(uint8(I7));
pause(pauseDuration);
close all;
