%How does the imfilter command work in MatLab
%HKa Feb. 2015
clear, close all;

N=256;
%Impulse response or P(oint) S(pread) F(unction)
h=[1 2 3;4 5 6;7 8 9];

d=zeros(N,N);
d(1,1)=1;

f=imfilter (d,h,'circular');

h
f(1:5, 1:5)
f(end-5:end, 1:5)
f(1:5,end-5:end)
f(end-5:end,end-5:end)
