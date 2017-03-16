%Noise from CCD-kamera SiPiX resolution 640*480
%HKa Jan. 2015

clear, close all;

%A=imread('SeptemberHimmel.tif');
%A=imread('WhitePaper.tif');
A=imread('Tv.jpg');
figure(1), imshow(A),title('Original');


A=imcrop(A);

Br=double(A(:,:,1))/255;%Red
Bg=double(A(:,:,2))/255;%Green
Bb=double(A(:,:,3))/255;%Blue
Bgray=double(rgb2gray(A))/255; %Gray

SNRr=10*log10(mean(Br(:))^2/var(Br(:)))
SNRg=10*log10(mean(Bg(:))^2/var(Bg(:)))
SNRb=10*log10(mean(Bb(:))^2/var(Bb(:)))

figure,subplot(311), hist(Br(:),50),title('Red'),
      ,subplot(312), hist(Bg(:),50),title('Green'),
      ,subplot(313), hist(Bb(:),50),title('Blue');

     
FB=fftshift(fft2(Bgray));
m=max(max(log10(abs(FB)+1)))
figure, imshow(log10(abs(FB)+1)/m);title('Fourier trans. of original');colormap(jet(256));colorbar;
