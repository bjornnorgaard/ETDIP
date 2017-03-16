%Get Video add noise, winer-filter and show result
%HKa marts 2003

clear, close all;
%v=aviread('tungenud.avi');
v=aviread('hhh.avi');
s=aviinfo('hhh')


%Generate noise movie
for k=1:s.NumFrames-50
   gi =double(rgb2gray(frame2im(v(k))))/255;
   figure(1),imshow(gi);
   gv(k) = getframe;
   
   n=.6*randn(s.Height,s.Width);
   gin=gi+n;
   figure(2),imshow(gin);
   gnv(k) = getframe;
   
   [giclean, emse] = wienerClean(gin,2);
   figure(3),imshow(giclean);
   gis(k) = getframe;
   
   ges=abs(gin-giclean);
   figure(4),imshow(ges);
   ge(k) = getframe;
   
end

figure(1), movie(gv);
figure(2), movie(gnv);
figure(3), movie(gis);
figure(4), movie(ge);


%imwrite(gi,'xxx.bmp')
%d=imread('xxx.bmp')
%I=imread('xxx.bmp');

% % dI=double(gi)/255;
% % figure, imshow(dI);title('Original image')
% % 
% % DFT billedet
% % FI=fftshift(fft2(dI));
% % logabsFI=log10(abs(FI));
% % figure, imshow(logabsFI/max(logabsFI(:)));title('Fourier of original image')
% % 
% % Find d
% % w=1:size(dI,1);
% % s=20*log10((w-size(dI,1)/2+.01).^-1)+50;    d=-1 passer helt godt.
% % figure, plot(w,20*logabsFI(:,size(dI,1)/2),w,s );Power in a horizontal-direction
