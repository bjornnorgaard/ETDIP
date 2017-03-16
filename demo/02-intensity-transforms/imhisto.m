%Histogram equalization, what does it?
%HKa Feb. 2015

Image = imread('cameraman.tif');
%Image = imread('lenna.tif');
%Image = imread('fingerprint.tif');
%Image = imread('kobling.tif');

ImageWithEqualizedHistogram = histeq(Image);

figure(1)
subplot(221); imshow(Image)
subplot(222); hist(double(Image(:)),50)

pause;

subplot(223); imshow(uint8(ImageWithEqualizedHistogram));
subplot(224); hist(double(ImageWithEqualizedHistogram(:)),50)
