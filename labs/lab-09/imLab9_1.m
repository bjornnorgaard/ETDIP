%Lab 9_1
%What is entropy
%HKa nov. 2008

clear, close all;

I=imread('cameraman.tif');
dI=double(I);
B=6;%Set B=0 to answer Q1
dI=2^B*floor(dI/2^B);
figure, imshow(dI/255);


[yvals, xvals]=hist(dI(:),0:255);
pvals=yvals/(sum(yvals));%The pdf is a sum of Dirac-deltas

figure, stem(pvals);title('pdf');

m0=sum(1.*pvals)             %0-moment should be zero
m=sum(xvals.*pvals)          %integrate to get mean
pvals(find(pvals==0))=10^-23;
H=sum(-log2(pvals).*pvals)   %entropy is calculated