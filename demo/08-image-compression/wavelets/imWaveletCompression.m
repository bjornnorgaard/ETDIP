%Waveveletcompression
%Wavelet codec see GW section 8.2.10 pp.604-614
%HKa Feb. 2015

clear, close all;

%Load image and show
I=imread('cameraman.tif');
%I = checkerboard(50); 
I=double(I)/255;
figure, imshow(I); title('Original');


%Filters for incoding
%Daubecies 2 
h0=[-0.1294    0.2241    0.8365    0.4830]
%Daubecies 4 see GW table 71. p472
%h0=[-.01059740 .03288301 .03084138 -.18703481 -.02798376 .63088076 .71484657 .23037781];

%Show filter charteristics
n=1:length(h0);
signs=(-ones(1,length(h0))).^n; %signs contains alternating signs 
h1=signs.*h0(end:-1:1);
[H0,w]=freqz(h0);
[H1,w]=freqz(h1);
figure, subplot(221), stem(h0);         title('Low pass coefficients');
        subplot(223), plot(w, abs(H0)); title('Low pass Amp.Characteristics.');
        subplot(222), stem(h1);         title('High pass coefficients');
        subplot(224), plot(w, abs(H1)); title('High pass Amp. Characteristics.');

figure, subplot(221), freqz2(h0'*h0);   title('LP-LP Amp. Characteristics.');
        subplot(222), freqz2(h0'*h1);   title('LP-HP Amp. Characteristics.');
        subplot(223), freqz2(h1'*h0);   title('HP-LP Amp. Characteristics.');
        subplot(224), freqz2(h1'*h1);   title('HP-HP Amp. Characteristics.');

%Start incoding and show result. Insert 0's along right on lower border of image
I(size(I,1)+length(h0),size(I,2)+length(h0))=0;

dHh0=FilterAlongColumnsDown(h0,I);
dHh1=FilterAlongColumnsDown(h1,I);

dfi=DownFilterAlongColumns(h0,dHh0')';
dV =DownFilterAlongColumns(h1,dHh0')';
dH =DownFilterAlongColumns(h0,dHh1')';
dD =DownFilterAlongColumns(h1,dHh1')';
figure, imshow([dfi,dH;dV,dD]);         title('Wavelet transform, scale 1')
figure, subplot(221), hist(dfi(:), 100);
        subplot(223), hist(dV(:) , 100);
        subplot(222), hist(dH(:) , 100);
        subplot(224), hist(dD(:) , 100);title('Density functions');

%Cal. filters for decoding and show
g0= signs.*h1; %GW formula 7.1-10 7.1-11
g1=-signs.*h0;
[G0,w]=freqz(g0);
[G1,w]=freqz(g1);
figure, subplot(221), stem(g0);         title('Low pass coefficients, reconstr.(g0)');
        subplot(223), plot(w, abs(G0)); title('Low pass Amp. Characteristics, reconstr. (G0)');
        subplot(222), stem(g1);         title('High pass coefficients, reconstr.(g1)');
        subplot(224), plot(w, abs(G1)); title('High pass Amp.Characteristics, reconstr. (G1)');

        
%-----Start decoding-------
%Try to remove wavelet coefficents using thresholding with Th
Th=10;
%dfi=zeros(size(dfi));
dV=dV.*(abs(dV)>Th);
dH=dH.*(abs(dH)<Th);
dD=dD.*(abs(dD)>Th);

figure, imshow([(dfi~=0),(dH~=0);(dV~=0),(dD~=0)]);title('Wavelet coefficients =~ 0 used for reconstruction')

A=FilterAlongColumnsUp(g1,dD')'+FilterAlongColumnsUp(g0,dH')';
A1=FilterAlongColumnsUp(g1,A);

B=FilterAlongColumnsUp(g1,dV')'+FilterAlongColumnsUp(g0,dfi')';
B1=FilterAlongColumnsUp(g0,B);

II=A1+B1;

%Remove 0's along left and upper border of image
III= II(length(h0):end-1,length(h0):end-1);

figure,imshow(III); title('Reconstructed image after wavelet transform')


%Lets check the reconstrucion see GW. figure 7.6 p 469
filter(g0,1,h0)+filter(g1,1,h1)

%Try using the wavelet toolbox:
[LO_D,HI_D,LO_R,HI_R] = wfilters('db4')