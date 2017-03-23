%Lab 12_1
%HKa dec. 2008
%Count cars

clear, close all;

N=9; %Load images
I1=imread('E45nord1.jpg');
I2=imread('E45nord2.jpg');
I3=imread('E45nord3.jpg');
I4=imread('E45nord4.jpg');
I5=imread('E45nord5.jpg');
I6=imread('E45nord6.jpg');
I7=imread('E45nord7.jpg');
I8=imread('E45nord8.jpg');
I9=imread('E45nord9.jpg');
figure, imshow([I1, I2, I3;I4, I5, I6;I7, I8, I9]); title('9 frames from camera in color');


%Convert to gray, remove upper part of images
K=20;%Hight of part to be removed
gI1=double(rgb2gray(I1))/255;gI1(1:K,1:end)=0;
gI2=double(rgb2gray(I2))/255;gI2(1:K,1:end)=0;
gI3=double(rgb2gray(I3))/255;gI3(1:K,1:end)=0;
gI4=double(rgb2gray(I4))/255;gI4(1:K,1:end)=0;
gI5=double(rgb2gray(I5))/255;gI5(1:K,1:end)=0;
gI6=double(rgb2gray(I6))/255;gI6(1:K,1:end)=0;
gI7=double(rgb2gray(I7))/255;gI7(1:K,1:end)=0;
gI8=double(rgb2gray(I8))/255;gI8(1:K,1:end)=0;
gI9=double(rgb2gray(I9))/255;gI9(1:K,1:end)=0;
figure, imshow([gI1, gI2, gI3;gI4, gI5, gI6;gI7, gI8, gI9]); title('9 frames from camera i grayscale');

%Lets find background bgI
for r=1:size(gI1,1)
    for s=1:size(gI1,2)
        p=[gI1(r,s), gI2(r,s),gI3(r,s), gI4(r,s), gI5(r,s), gI6(r,s), gI7(r,s), gI8(r,s), gI9(r,s)];
        bgI(r,s)=mean(p);%
    end;
end;
figure, imshow(bgI);title('Removed cars, only background left')

%Lets find foreground.
fgI=zeros(size(gI1,1),size(gI1,2),9);

afgI(:,:,1)=abs(gI1-bgI);
afgI(:,:,2)=abs(gI2-bgI);
afgI(:,:,3)=abs(gI3-bgI);
afgI(:,:,4)=abs(gI4-bgI);
afgI(:,:,5)=abs(gI5-bgI);
afgI(:,:,6)=abs(gI6-bgI);
afgI(:,:,7)=abs(gI7-bgI);
afgI(:,:,8)=abs(gI8-bgI);
afgI(:,:,9)=abs(gI9-bgI);


%Now we count cars
for m=1:N;
    fgI=afgI(:,:,m); 
	bwI=fgI>.1; %Wee choose a threshold on .1
    
    %Remove holes
	B=strel('square', 4);
	A=imdilate(bwI, B);
	
    %Find connected components
	labelA=bwlabel(bwI,8);
	labelmax=max(labelA(:));
	
	%Feature extraction: Cal. area for components
	Areal=zeros(1,labelmax);
	Cars=zeros(size(labelA));
	for k=1:labelmax
		r=find(labelA==k);
		Areal(k)=length(r);
		if (Areal(k)>25) Cars(r)=1; end;
                        %Remove components when area is < 50pix
                        %based on histogram for area
                        %figure, plot(Areal,0,'xb');title('Feature space')
	end;
	
    %Count cars
    cbw=bwlabel(Cars,8);
    countCars(m)=max(cbw(:))
    
	acI(:,:,m)=bgI+Cars;
end;

figure, imshow([acI(:,:,1), acI(:,:,2), acI(:,:,3);
                acI(:,:,4), acI(:,:,5), acI(:,:,6);
                acI(:,:,7), acI(:,:,8), acI(:,:,9)]); title('Here are the cars');
countCars