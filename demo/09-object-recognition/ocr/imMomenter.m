%Momenter
%HKa Feb. 2015

clear, close all;

%Generate image
N=256;
I=zeros(N,N);
I(N/2:N/2+10,N/4:3*N/4)=1;
I=imrotate(I,5);
imshow(I);

M=0;
mm=zeros(2,1);
II=zeros(2,2);
for x=1:size(I,1);
    for y=1:size(I,2)
        M=M+I(x,y);
        mm(1)=mm(1)+I(x,y)*x;
        mm(2)=mm(2)+I(x,y)*y;
        II(1,1)=II(1,1)+I(x,y)*x*x;
        II(1,2)=II(1,2)+I(x,y)*x*y;
        II(2,1)=II(2,1)+I(x,y)*y*x;
        II(2,2)=II(2,2)+I(x,y)*y*y;
    end
end
m(1)=mm(1)/M
m(2)=mm(2)/M
A=II-M*m*m'
[V,D]=eig(A)


