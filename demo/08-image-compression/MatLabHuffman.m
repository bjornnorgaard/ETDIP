%Huffman coding usinge MatLab build-in functions
%HKa Feb. 2015

clear, close all;

symbols = [1:3];
p = [0.1 0.1 0.8];              % Probability of each data symbol
dict = huffmandict(symbols,p)   % Create the dictionary.

% Show one row of the dictionary.
dict{1,:}                   
dict{2,:}
dict{3,:}

%Try this on the on the cameraman iamge
clear, close all;

%Load image and quantize
I=imread('cameraman.tif');
dI=double(I);
B=0;%quantization level
dI=2^(B)*floor(dI/2^B);
figure, imshow(dI/255);

%Cal. histogram and show
[yvals, xvals]=hist(dI(:),1:255);
pvals=yvals/(sum(yvals));     %Normalize histogram to estimate pdf
figure, stem(pvals);title('pdf');

%Cal. moments
m0=sum(1.*pvals);             %0-moment should be zero
m=sum(xvals.*pvals);          %1-moment or mean
pvals(find(pvals==0))=10^-23; %Engineering trick: avoid log2(0)
H=sum(-log2(pvals).*pvals)    %Entropy is calculated

[dict, avl] = huffmandict(xvals, pvals); 
avl