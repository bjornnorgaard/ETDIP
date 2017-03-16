%Polar Hough Transform
%HKa Feb. 2015 version 2

clear, close all;

%Load and show
%%Just points
% dI=zeros(256,256);
% dI(20,20)=1;
% dI(256-20,30)=1;
% %dI(20,256-20)=1;
% dI(256-20,256-20)=1;
% dJ=dI;

%%Lines
% dI=zeros(256,256);
% dI(50:200,126)=1;
% dI(126,100:200)=1;
% dI=imrotate(dI,35);
% dJ=dI;

%%Real image
J=imread('cameraman.tif');
dJ=double(J)/255;
h=fspecial('laplacian');
dI=imfilter(dJ,h);
z=find(dI>.15);
dI(:)=0;
dI(z)=1;
figure, imshow(dI);title('Original')

diagonal=int16(sqrt(sum(size(dI).^2)));
H=zeros(2*diagonal,180);%Hough-image 1.index in degrees, 2. index dist from origo 1==dist_equal_0

for r=1:size(dI,1)
    for s=1:size(dI,2)
        if (dI(r,s)==1)%draw line i Hough-space ??
            for fi=1:180
                d=round((r*cos(pi*fi/180)+s*sin(pi*fi/180))+diagonal);
                H(d,fi)=H(d,fi)+1;
            end;
        end;
    end;
end;

%Normalize Hough-space
H=H/max(H(:));


figure, imshow(1-H);title('Hough space')
xlabel('angle from horizontal add diagonal (in degrees)');ylabel('distance from origo added diagonal(in pixels)');
axis on%; colormap(jet(65)), colorbar

%Draw lines from Hough-space i original
%[fi,d,p]=impixel;

[d,fi]=find(H>.55);%Try to use 0.55 => gives the tripod...

dK=zeros(size(dJ));
for k=1:length(fi)
    for s=1:size(dJ,2)
        r=round(-tan(pi*fi(k)/180)*s + (d(k)-diagonal)/cos(pi*fi(k)/180)); %Notice sign of d is gone, may result in displaced line
        if((1<r) & (r<size(dJ,1))) dK(r,s)=255; end;
    end;    
end;
dK=double(dK)/255;

figure, imshow(dK+dJ); title('Original with lines')

