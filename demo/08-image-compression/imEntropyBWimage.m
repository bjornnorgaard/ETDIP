%Entropy of BW-image
%Hka Feb. 2015

clear, close all;

%Cal. entropy and show
%Let p0 be prob of black and p1=1-p0 is prob. of white.
p0=0.01:.01:1;
H=-log2(p0).*p0-log2(1-p0).*(1-p0);
plot(p0,H);title('Entropy of binary binary image, p0 prob. of black');

%Cal. entropy for uniform discrete distribution
p=ones(1,8);
p=(1/sum(p))*p;
Hunif=sum(-log2(p).*p)
