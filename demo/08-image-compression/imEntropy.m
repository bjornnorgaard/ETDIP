%What is entropy
%HKa Feb. 2015

clear, close all;

%Load image
I=imread('cameraman.tif');
dI=double(I)/255;

%Cal. histogram and pdf and show
[yvals, xvals]=hist(dI(:),100);
pvals=yvals/(sum(yvals));%Normalize histogram to get prob. density function
figure(1), plot(xvals, pvals);title('pdf');

%Cal. moments
m0=sum(1.*pvals)             %0-moment should be zero
m=sum(xvals.*pvals)          %1-moment equals the mean
H=sum(-log2(pvals).*pvals)   %entropy is calculated