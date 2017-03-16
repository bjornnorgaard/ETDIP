%deBlurr using Wiener deconvolution
%HKa Feb. 2015

clear ,close all

%Load image and show
f=imread('NorbertWiener.jpg');
f=double(f)/255;
F=fft2(f);
figure(1), imshow(f), title('Original image');

%Generate filter
N=5;
hc=1/(N*N)*ones(N,N);
h=zeros(size(f));
h(1:size(hc,1),1:size(hc,2))=hc;
H=fft2(h);

%Filter f using hc
hf=imfilter(f,hc,'conv','circular');

%Generate noise
b=0.01;
n=b*randn(size(hf));

%Add noise
g=hf+n;
figure, imshow(g), title('Blurred image, noise added');
G=fft2(g);

%Deconvolution no Wiener
R = 1./H;
Fhat = R.*G;
fhat=ifft2(Fhat);
fhat  =real(fhat); %Use real, due to small imaginary component (round-off)


%Wiener restoration filter 
RW = conj(H)./(H.*conj(H)+2);%500*b^2./F.*conj(F)), also see GW section 5.8
FWhat = RW.*G;               %Restoration using Wiener
fWhat = ifft2(FWhat);               
fWhat = real(fWhat);         %Use real, due to small imaginary component (round-off)

figure, 
    subplot(121), imshow(fhat/max(fhat(:))), title('deBlurred image, No Wiener filter');
    subplot(122), imshow(fWhat/max(fWhat(:))), title('deBlurred image, Wiener filter');

figure, 
    subplot(121), hist(fhat(:),100),  title('Histogram deBlurred image, No Wiener filter');
    subplot(122), hist(fWhat(:),100), title('HistogramdeBlurred image, Wiener filter');
