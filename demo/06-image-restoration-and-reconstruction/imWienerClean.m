%Blind Wiener filtering
%HKa Feb. 2015
%Based on code from Eero Simoncelli

clear, close all

%Laod image
i = imread('boats.pgm');
%i= imread('cameraman.tif');
im=double(i)/255;

%set standard deviation in noise and add
stdev = .5;
noisy = im + stdev*randn(size(im));

%Do the Wiener clean, the final parameter in the func-call winerClean is the
%paramter in the psd estimate of teh original image
[clean, emse] = wienerClean(noisy,2.4);

figure, imshow(im);             title('Original');
figure, imshow(noisy);          title('Noise contaminated image');
figure, imshow(clean);          title('Cleaned image')
pause;

nsnrs = [-20:3:10];
csnrs = zeros(size(nsnrs));
esnrs = zeros(size(nsnrs));
for n=1:length(nsnrs)
    stdev = sqrt(  var2(im) * 10^(-nsnrs(n)/10) );
  noisy = im + stdev*randn(size(im));
  [clean,mse] = wienerClean(noisy,2.4);
  subplot(1,3,1); imshow(im);
  subplot(1,3,2); imshow(noisy); 
  subplot(1,3,3); imshow(clean);
  esnrs(n) = 10 * log10(var2(im) /  stdev^2);      %SNR before filtering 
  csnrs(n) = 10 * log10(var2(im) / var2(im-clean));%SNR after filtering
  
  figure(4)
  subplot(1,3,1); imshow(im);title('Original');
  
  str=strcat('SNR = ',num2str(esnrs(n)),'dB');
  subplot(1,3,2); imshow(noisy); title(str);

  str=strcat('SNR = ',num2str(csnrs(n)),'dB')
  subplot(1,3,3); imshow(clean);title(str);
   
   pause;
end;
figure, plot(csnrs-esnrs, 'ob');title('SNR gain using Wiener filtering')