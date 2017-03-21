%Image containg periodic noise. Lets remove it.
%We use an annulus in the frequnecy domain. See GW. f.g. 5.16
%HKa Jan. 2015

clear, close all;

f=imread('cameraman.tif');;
f=double(f)/255;

%Periodic noise
A=.075;
[M,N]=size(f);
l1=100; k1= 0;
l2=71; k2=71;
l3= 0; k3=100;
l4=71; k4=-71;
for r=0:M-1
    for s=0:N-1
        n1(r+1,s+1)=A*sin(2*pi/M*(l1*r)+2*pi/N*(k1*s));
        n2(r+1,s+1)=A*sin(2*pi/M*(l2*r)+2*pi/N*(k2*s));
        n3(r+1,s+1)=A*sin(2*pi/M*(l3*r)+2*pi/N*(k3*s));
        n4(r+1,s+1)=A*sin(2*pi/M*(l4*r)+2*pi/N*(k4*s));
    end
end
n=n1+n2+n3+n4;
fn=f+n;

figure(1), imshow(n/max(n(:))); title('Periodic noise');
pause;

figure(2), imshow(fn); title('Image and periodic');
pause;

FN=fftshift(fft2(fn));

mx=max(log10(abs(FN(:))+1));
LogFN=log10(abs(FN)+1)/mx;
figure(3), imshow(LogFN);
pause;

%Bandrejectfilter som i GW pp. 335-336
D0=100;W=5; %D0: radius of annulus, W: width of annulus
for r=1:M
    for s=1:N
        D=sqrt((r-(M/2+1))^2+(s-(N/2+1))^2);%Note DC in (M/2+1, N/2+1)
        
        %Butterworth filter
        n=10;%Filter order
        FN(r,s)=1/(1+((D*W)/(D^2-D0^2))^(2*n))*FN(r,s);
        
        %Gaussian filter
        %FN(r,s)=(1 - exp(-(1/2)*((D^2-D0^2)/(D*W))^2))*FN(r,s);
                
    end
end

mx=max(log10(abs(FN(:))+1));
figure(4), imshow(log10(abs(FN)+1)/mx),colormap(jet(64)),colorbar;
pause;

figure(5), imshow(real(ifft2(fftshift(FN))));
pause;

close all;
