%Lab 5 Exercise 2
%HKa feb. 2013

clear, close all; 

A=imread('dots.bmp');
A=double(A)/255;
figure, imshow(A);

%Count regions
%Samme method as in 5.1
%B=strel('square',3);
B=strel('arbitrary',[0 1 0; 1 1 1; 0 1 0] )

label=2;
p=min(find(A==1));
while ~isempty(p)
    X0=zeros(size(A)); X0(p)=1;
    X1=zeros(size(A));
    a=1;
    while (a)
        X1=imdilate(X0,B)&A;
        a=max(max(X0~=X1));
        X0=X1;
	end
	s=find(X0==1);
	A(s)=label;
	label=label+1;
    p=min(find(A==1));
end

ps=rand(label,3)
figure, imshow(A,ps)

%Number of connected components, sorted according to size
A_Size=A;
b(4)=0;
Areal=zeros(1,label+1);
for k=2:label
   r=find(A==k);
   Areal(k+1)=length(r);
   if                  Areal(k+1)<1*69-1   A_Size(r)=2; b(1)=b(1)+1; end;
   if 1*69-1<=Areal(k+1)&Areal(k+1)<2*69  A_Size(r)=3; b(2)=b(2)+1; end;
   if 2*69-1<=Areal(k+1)&Areal(k+1)<3*69  A_Size(r)=4; b(3)=b(3)+1; end;
   if 3*69-1<=Areal(k+1)                  A_Size(r)=5; b(4)=b(4)+1; end;
end;

%Show Areal distribution, do not show black
figure, hist(Areal(2:end),20); title('Areal distribution')
figure, imshow(A_Size,ps)%,colormap(jet(100));
figure, stem(b);title('Distribution of component size')