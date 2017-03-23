%Rotating advertesing pillar
%HKa oct. 2008

clear, close all;

%I=imread('cameraman.tif');
I=imread('henrikhenrik.jpg');
%I=imread('boats.pgm');
dI=double(I)/255;

[H,W]=size(I);
R=W/(2*pi); %Radius of pillar

Is=zeros(H,ceil(2*R)-1);

v=16; %speed of rotation
for t=1:size(dI,2)/v;%t is time
    
    for r=1:H %row index
        for s=1:ceil(2*R)-1%column index
            Is(r,s)=dI(r,1+mod(v*t+round(R*asin(s/R-1)+W/4),W));%mod(v*t+%,W)
            %W/2 is the offset. Where is the "gluing" when t=0.
            %mod(*,W) wraps the image around the cylinder                                                  
        end;
    end
    
    figure(1), imshow(Is);
    video(t) = getframe;
end;
    

movie(video,10,100);