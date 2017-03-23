%Lab 8.2
%Polar Hough Transform
%
%HKa oct. 2008

clear, close all;

%%Lines
dI=zeros(256,256);
dI(126,100:200)=1;
dI(100:200,126)=1;
dI=imrotate(dI,35);


%Salt/peber noise
p=0.1 %"power" in noise
x = rand(size(dI));
dI(find(x < p/2)) = 0;           % Minimum value
dI(find(x >= p/2 & x < p)) = 1; % Maximum (saturated) value
figure, imshow(dI)

dJ=dI;


figure, imshow(dI);title('Original')

diagonal=sqrt(sum(size(dI).^2));

H=zeros(diagonal,180);%Hough-image 1.index in degrees, 2. index dist from origo 1==dist_equal_0

for r=1:size(dI,1)
    for s=1:size(dI,2)
        if (dI(r,s)==1)%draw line i Hough-space ??
            for fi=1:180
                d=round(abs(r*cos(pi*fi/180)+s*sin(pi*fi/180)))+1;
                H(d,fi)=H(d,fi)+1;
            end;
        end;
    end;
end;

%Normalize Hough-space
H=H/max(H(:));

ss=find(H>.5);
G=zeros(size(H));
G(ss)=1;


figure, imshow(G);title('Hough space')
xlabel('angle from horizontal (in degrees)');ylabel('distance from origo (in pixels)');
axis on;


%Draw lines from Hough-space i original
[fi,d,p]=impixel;

dK=zeros(size(dJ));
for k=1:length(fi)
    for s=1:size(dJ,2)
        r=round(-tan(pi*fi(k)/180)*s + d(k)/cos(pi*fi(k)/180)); %Notice sign of d is gone, may result in displaced line
        if((1<r) & (r<size(dJ,1))) dK(r,s)=255; end;
    end;
end;
dK=double(dK)/255;

figure, imshow(dK+dJ); title('Original with lines')