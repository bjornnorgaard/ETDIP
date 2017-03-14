%Lab 6.1
%Remove periodic noise in images
%HKa oct. 2008

clear, close all;

B=imread('fig5_16(a).jpg');
dB=double(B)/255;

figure, imshow(B);title('Original');

FB=fftshift(fft2(dB));
laFB=log10(abs(FB)+1);
figure, imshow(laFB/max(laFB(:))),[x,y,p]=impixel;title('Fourier trans. of original')

%We use ideal bandrejectfilter
 Br=2;Bs=3;
 M=size(FB,1);
 N=size(FB,2);
 for m=1:M
     for n=1:N
       if (((m-M/2)^2+(n-N/2)^2)>((y(1)-M/2)^2+(x(1)-N/2)^2))&(((m-M/2)^2+(n-N/2)^2)<(y(2)-M/2)^2+(x(2)-N/2)^2) FB(m,n)=0; end;
   end;
end;

laFB=log10(abs(FB)+1);
figure, imshow(real(laFB/max(laFB(:))));;title('Fourier trans. after reject filter');

dBx=(ifft2(fftshift(FB)));
figure, imshow(real(dBx));;title('Fourier trans. after reject filter');

E=dB-dBx;
figure, imshow(histeq(abs(E/max(E(:)))));title('Removed signal')

%%Note Optional: Implementation of the Optium Notch Filter on pp. 338-342 in GW
S=1/9*[1 1 1;1 1 1;1 1 1]; %Mask for block operation
%Uses formulas on pp. 341-342 in GW
K=dB.*E;
M1=imfilter(K,S);
M2=imfilter(dB,S);
M3=imfilter(E,S);
M4=imfilter(E.^2,S);
M5=M3.^2;

W=(M1-M2.*M3)./(M4-M5);

F_hat=real(dB-W.*E);
figure, imshow(F_hat);title('Optimum notch GW pp. 338-342');