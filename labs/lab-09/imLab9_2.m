%Lab9_2
%Transfom coding
%HKa nov. 2008

clear, close all;

I=imread('cameraman.tif');
dI=double(I)/255;

[M,N]=size(dI);
M0=8;N0=8;%subimage size. Notice: must divide M, and N
%Forward transform
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
         Block=dct2(dI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0)));%DCT-transform
         s=sort(abs(Block(:)));
         r=find(abs(Block)<s(50));% s(?) equals threshold.
         Block(r)=0;
         dF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=Block;       
    end;
end;

%-----------------------------------------------
%Inverse transfom
for r0=0:(M/M0)-1
    for s0=0:(N/N0)-1
        qI((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0))=...
            idct2(dF((r0*M0+1:(r0+1)*M0),(s0*N0+1:(s0+1)*N0)));
    end;
end;
dE=abs(qI-dI);
figure(1), imshow(dI);title('Original')
figure(2), imshow(qI);title('Approximation')
figure(3), imshow(dE/max(dE(:)));title('Error')
figure(4), hist(abs(dE(:)),100);title('Distribution of in error')