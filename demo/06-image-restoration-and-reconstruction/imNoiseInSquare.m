%Noise in a square and in a smaller square
%HKa Jan. 2015

clear, close all;

%Create signal
N=400;
x=.7*ones(N,N);
x(N/2:N,N/2:N,:)=0.6;

%Create noise in the region -3*s till 3*s
s=.2;
n=s*randn(N,N);
t=n>3*s;
n(t)=3*s;
b=n<-3*s;
n(b)=-3*s;

%Show image
x=x+n;
X(:,:,1)=x;
X(:,:,2)=x;
X(:,:,3)=x;
figure(1), imshow(X)

%Calculate histogram for the image
[yvals, xvals]=hist(x(:),100);
figure(2), plot(xvals,yvals);


