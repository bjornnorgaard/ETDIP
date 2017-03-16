%Transfom coding using scales
%HKa Feb. 2015
%See GW3e sec. 8.2.8 for further info.

clear, close all;

%Load image
I=imread('boats.pgm');
dI=double(I);

%Define scales, se GW fig. 8.30
scales=[16 11 10 16  24  40  51  61;
        12 12 14 19  26  58  60  55;
        14 13 16 24  40  57  69  56;
        14 17 22 29  51  87  80  62;
        18 22 37 56  68 109 103  77;
        24 35 55 64  81 104 113  92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103  99]
scales=scales*4;%used different scales => differnet comparion rat
    
%Forward transform by processing all blocks
[M,N]=size(dI);
M0=8;N0=8;%subimage size. Note M0 must divide M, and N0 must divide N
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
         Block=dct2(dI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))-128);%DCT-transform
         sBlock=Block./scales;
         dF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=sBlock;       
    end;
end;

%Rounding as in GW. pp. 578-579
qF=round(dF);


%Inverse transfom by processing all blocks
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
        qI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=...
            idct2(qF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0)).*scales)+128;
    end;
end;


figure(1), imshow(dI/255);title('Original')

figure(2), imshow(qI/255);title('Approximation')

dE=abs(qI-dI);
figure(3), imshow(dE/max(dE(:)));title('Errors (normalized)')

figure(4), hist(dF(:),100);title('Distribution in DCT image before rounding(after scaling)')
length(find(dF(:)==0))/(N*M)

figure(5), hist(qF(:),100);title('Distribution in DCT image after rounding and scaling')
length(find(qF(:)==0))/(N*M)

dctcoef=dF(1:M0:M,3:N0:N);%Use GW. fig. 829 to map coefficent number to (row, column)
figure(6), hist(dctcoef(:),100);title('Distribution of DCT coefficents')

BW=qF;
k=find(qF(:)~=0);
BW(k)=1;
figure(7), imshow(BW);title('White == DCT coefficent ~=0, Black == DCT coefficent  == 0')