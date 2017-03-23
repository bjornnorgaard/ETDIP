%Lab 11
%HKa nov. 2008
%Simple OCR-system

clear, close all;

%Sound files used in enumerating the characters
[prik,fs]=wavread('classprik');
[en,fs]=wavread('class1');
[nul,fs]=wavread('class0');

%Read image
I=imread('Text01.jpg');

%Select part of image
J=imcrop(I);
dJ=double(rgb2gray(J))/255;

%Image converted to black and white, threshold from histogram
A=dJ<.9;
imshow(A)

%Segment bw iamge
labelA=bwlabel(A,8); %8 connectivity
labelmax=max(labelA(:));

%Feature extraction:  Area is feature
Areal=zeros(1,labelmax);
for k=1:labelmax
   r=find(labelA==k);
   Areal(k)=length(r);
end;
figure, plot(Areal,0,'xb');title('Feature space')
pause

%3 clases in feature space Area< 15, 15->30 and 30->45
my1=mean(Areal(find(Areal<15)))
my2=mean(Areal(find(15<=Areal&Areal<30)))
my3=mean(Areal(find(30<=Areal)))


%Minimum distance classifier. Show result
classA=zeros(size(A));
my=[];
for k=1:labelmax
    D=[abs(my1-Areal(k)), abs(my2-Areal(k)),abs(my3-Areal(k))];
    
    %Index i is min D value
    [m,i]=min(D);
    if i==1 Char(k).ascii='.'; end
    if i==2 Char(k).ascii='1'; end
    if i==3 Char(k).ascii='0'; end
   
   %Calculate center of gravity Char nr. k. Result in vector y
   [r,s]=find(labelA==k);
   Char(k).myr=mean(r);
   Char(k).mys=mean(s);
   my=[my;Char(k).myr,Char(k).mys];
end;

%Sort Char's read from kleft to right line by line
B=5;
my=B*round(my./B);
[x,i]=sortrows(my);

%Resultats
posA=zeros(size(A));
for k=1:labelmax
    if Char(i(k)).ascii=='.'
        sound(prik,fs);
    end;
    if Char(i(k)).ascii=='1'
        sound(en,fs);
        r=find(labelA==k);
    end
    if Char(i(k)).ascii=='0'
        sound(nul,fs);
    end
    Areal(i(k));
    r=find(labelA==i(k));
    posA(r)=1;
    figure(3),imshow(posA);
    pause(1)
end;