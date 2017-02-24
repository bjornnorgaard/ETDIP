%Lab4.2
%Gaussian Pyramid
%HKa sep. 2008

clear, close all;

J0=imread('cameraman.tif');

figure, subplot(121), imshow(J0);title('Scale 0')
        subplot(122), imshow(log10(abs(fftshift(fft2(J0))))+1);title('FFT Scale 0')

%G=1;%Delta-funktion == no filtering
G=fspecial('gaussian',[10 10], 2);%G=1 no anti-alisering filter

G=fspecial('gaussian',[10 10], 2);
freqz2(G)
figure, freqz2(G)
5
K1=imfilter(J0,G);
J1=K1(2:2:end,1:2:end);
figure, subplot(121),imshow(J1);title('Scale 1')
        subplot(122), imshow(log10(abs(fftshift(fft2(J1)))+1));title('FFT Scale 1')

K2=imfilter(J1,G);
J2=K2(2:2:end,1:2:end);
figure, subplot(121),imshow(J2);title('Scale 2')
        subplot(122),imshow(log10(abs(fftshift(fft2(J2)))+1));title('FFT Scale 2')

K3=imfilter(J2,G);
J3=K3(2:2:end,1:2:end);
figure, subplot(121),imshow(J3);title('Scale 3')
        subplot(122),imshow(log10(abs(fftshift(fft2(J3)))+1));title('FFT Scale 3')

K4=imfilter(J3,G);
J4=K4(2:2:end,1:2:end);
figure, subplot(121),imshow(J4);title('Scale 4')
        subplot(122),imshow(log10(abs(fftshift(fft2(J4)))+1));title('FFT Scale 4')

K5=imfilter(J4,G);
J5=K5(2:2:end,1:2:end);
figure, subplot(121),imshow(J5);title('Scale 5')
        subplot(122),imshow(log10(abs(fftshift(fft2(J5)))+1));title('FFT Scale 5')
        
figure  , subplot(161),imshow(J0, 'truesize');title('Scale 0')
        , subplot(162),imshow(J1, 'truesize');title('Scale 1')
        , subplot(163),imshow(J2, 'truesize');title('Scale 2')
        , subplot(164),imshow(J3, 'truesize');title('Scale 3')
        , subplot(165),imshow(J4, 'truesize');title('Scale 4')
        , subplot(166),imshow(J5, 'truesize');title('Scale 5')