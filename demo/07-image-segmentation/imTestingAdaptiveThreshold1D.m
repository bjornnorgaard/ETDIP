%Testing adaptive thresholding
%1D example
%GW3e sec. 10.3 pp. 738-739
%HKa Feb. 2015 

clear, close all;

N1=1000;N2=200;

p1=.1*randn(1,N1)+.1;
p2=.1*randn(1,N2)+.75

y=[p1,p2]
hist(y,100);title('Density')

T=.1;
Th=[T];
a=1;
while (a)
    s1=find(y<=T);
    my1=mean(y(s1));
    s2=find(y>T);
    my2=mean(y(s2));
    T1=(1/2)*(my1+my2);
    if (abs(T1-T)<.0001) a=0; end;
    T=T1
    Th=[Th,T];
end;

z=zeros(size(y));
r=find(y>T);
z(r)=1;

figure, plot(Th,'rx');title('Threshold values')

Facit=[zeros(1,N1),ones(1,N2)];
CorrectAns=(Facit+z-1).^2;
PCorrect=sum(CorrectAns)/length(CorrectAns)