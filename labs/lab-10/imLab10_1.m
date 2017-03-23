%Lab 10_1
%Transfom coding using scales
%HKa nov. 2008
%See GW pp.566-584

clear, close all;

I=imread('boats.pgm');
%I=imread('cameraman.tif');
dI=double(I);

scales=[16 11 10 16  24  40  51  61;
        12 12 14 19  26  58  60  55;
        14 13 16 24  40  57  69  56;
        14 17 22 29  51  87  80  62;
        18 22 37 56  68 109 103  77;
        24 35 55 64  81 104 113  92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103  99]


scales=1*scales; %See figure 8.30 p 578 
    
[M,N]=size(dI);
M0=8;N0=8;%subimage size notice, must divide M, and N

%Forward transform
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
         Block=dct2(dI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))-128);%DCT-transformation
         sBlock=Block./scales;
         dF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=sBlock;       
    end;
end;

%Rounding as in GW (8.2-26)
qF=round(dF);

%-----------------------------------------------
%Inverse transfom
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
        qI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=...
            idct2(qF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0)).*scales)+128;
    end;
end;


figure(1), imshow(dI/255);title('Original')

figure(2), imshow(qI/255);title('Approximation')

dE=abs(qI-dI);
figure(3), imshow(dE/max(dE(:)));title('Error (normalized)')

figure(4), hist(dF(:),100);title('Distribution of dct coefficents before rounding (after scaling)')
length(find(dF(:)==0))/(N*M)

figure(5), hist(qF(:),100);title('Distribution of dct coefficients after rounding (after scaling)')
length(find(qF(:)==0))/(N*M)

BW=qF;
k=find(qF(:)~=0);
BW(k)=1;
figure(7), imshow(BW);title('White:dct coefficient ~=0, Black: dct coefficient ==0')

%Global min/max of dct coefficients
figure(8), hist(qF(:), 100);title('Distribution of all dct coefficents')
max(qF(:))
min(qF(:))

%Min/max of dct coefficents as a function of frequency
for k=1:64
    [r,s]=dct2RS(k-1);
    dctcoef=dF(r:M0:M,s:N0:N);
    minValue(k)=min(dctcoef(:));
    maxValue(k)=max(dctcoef(:));
end;
figure(9), plot(0:63, minValue,0:63, maxValue);title('Min/Max of dct coefficients')