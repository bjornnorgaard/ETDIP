%Lets find letters --
%HKa Feb. 2015

clear, close all;

%Load image and show
I=imread('abctext.jpg');
I=rgb2gray(I);
dI=1-double(I)/255;
figure(1), imshow(I);title('Original image')
pause;

%Crop letter
dX=imcrop(dI);

%Add noise
dI=dI+.01*randn(size(dI));
figure(2), imshow(dI);title('Noise added');

profile on -detail builtin -history

%Filter using dX
dJ=imfilter(dI,dX);

%Find positions where the letter is located.
dK=dX.^2;
Th=sum(dK(:));
r=find(dJ>=Th);
L=zeros(size(dJ));
L(r)=255;
figure(3), imshow(L);title('Here it is (Mach-method)!')


%Now lets try correlation done in the frequence domain
dX(size(dI,1),size(dI,2))=0;
FdX=fftshift(fft2(dX));
FdI=fftshift(fft2(dI));
FdIX=FdI.*conj(FdX);
dK=real(ifft2(fftshift(FdIX)));
v=find(dK(:)/max(dK(:))>.95);
S=zeros(size(dK));
S(v)=255;

figure(4), imshow(abs(FdX)/max(abs(FdX(:))));title('Fourier of Template');
figure(5), imshow(abs(FdI)/max(abs(FdI(:))));title('Fourier of Original');
figure(6), imshow(dK/max(dK(:)));title('Fourier of Cross correlation')
figure(7), imshow(S);title('Here it is (Fourier-method)!')

profile report
