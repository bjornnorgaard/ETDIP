%Lab 4 exercise 1
%Let's count rice -:)
%HKa sep. 2008

clear, close all; 
I=imread('rice.tif');
dI=double(I)/255;

figure, imshow(dI), title('Original') 

%Choose a single rice
Icrop=imcrop(I);
dIcrop=double(Icrop)/255;

[yvalsdIcrop,xvalsdIcrop]=hist(dIcrop(:),100);
[yvalsdI,xvalsdI]=        hist(dI(:),100);

figure, subplot(121);plot(xvalsdI,yvalsdI),        title('Histogram for original');
        subplot(122);plot(xvalsdIcrop,yvalsdIcrop),title('Histogram for the cropped image');

%Mean is treshold        
Th= mean(dIcrop(:));

K=zeros(size(I));
s=find(dIcrop>Th+.05);
K(s)=1;
dIcropAreal=sum(K(:));

J=zeros(size(I));
r=find(dI>Th+.05);
J(r)=1;
dJAreal=sum(J(:));

figure, imshow(J);title('BW-billede');

NrOfRice=dJAreal/dIcropAreal