%How does the command imfilter work in MatLab
%HKa Feb. 2015

clear, close all;

N=256;
%What is the P(oint) S(pread) F(unction)
h=[1 2 3;4 5 6;7 8 9];

d=zeros(N,N);
d(N/2,N/2)=1;

f=imfilter(d,h);

h
f(N/2-5:N/2+5,N/2-5:N/2+5)
pause;
%-------------------

%Let's study a MA filter
% MA filter blurs edges
h1=ones(3,3)./9;

I=zeros(N,N);
I(N/2,:)=.5;
II=imfilter(I,h1);

I(N/2-5:N/2+5,N/2-5:N/2+5)
II(N/2-5:N/2+5,N/2-5:N/2+5)

figure(1)
subplot(211), imshow(I);title('Original')
subplot(212), imshow(II);title('Edges are blured using a MA filter')


I=imread('cameraman.tif');
figure(2)
subplot(211), imshow(I);title('Original')
subplot(212), imshow(imfilter(double(I)./255,h1));title('Edges are blured using a MA filter')
pause;
%-------------------

%MA filter closes holes
I=zeros(N,N);
I(N/2,:)=.5;
I(N/2, N/2:N/2+1)=0;

h1=ones(3,3)/4;
II=imfilter(I,h1);

I(N/2-5:N/2+5,N/2-5:N/2+5)
II(N/2-5:N/2+5,N/2-5:N/2+5)

figure(3)
subplot(211), imshow(I);title('Orignal, note hole in the line')
subplot(212), imshow(II);title('Edges are blured using a MA filter')

II=II>.01;
figure(4)
imshow(II);title('Close holes using a MA filter')