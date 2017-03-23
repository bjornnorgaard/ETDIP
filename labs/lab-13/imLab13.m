%Tracking
%HKa oct. 2008

clear, close all;

load v;
m=[];
vg0=zeros(size(rgb2gray(v(:,:,:,1))));
dd=zeros(size(vg0));
for n=1:size(v,4)
    vgg=double(rgb2gray(v(:,:,:,n)))/255;
    vg1=double(rgb2gray(v(:,:,:,n)))/255>.5;
    diff=vg1<vg0;
    str=strel('square',5);
    diff=imerode(diff,str);
    [x,y]=find(diff>0);
    if not(isempty(x))
        s=ceil(mean([x y])')
        m=[m,s];
        vgg(s(1)-20:s(1)+20, s(2)-20)        =0;
        vgg(s(1)-20:s(1)+20, s(2)+20)        =0;
        vgg(s(1)-20,         s(2)-20:s(2)+20)=0;
        vgg(s(1)+20,         s(2)-20:s(2)+20)=0;
        
        ff=zeros(size(vgg)+[120 120]);
        ox=60-(s(1)-200);
        oy=60-(s(2)-180);
        ff(ox+1:240+ox,oy+1:320+oy)=vgg;
        figure(1), imshow(vgg);
        figure(2), imshow(ff);
    end 
    vg0=vg1;
    pause(1);
    
end; 
 
