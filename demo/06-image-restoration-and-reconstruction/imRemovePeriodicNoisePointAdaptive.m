%Image containing periodic noise. Lets remove this
%Pick out noise in the frequency domian and remove in the frequency plane.
%Optional: Also Adaptivte filter i GW. p338-342
%HKa Jan. 2015

clear, close all;

%Load and and add artificial noise
f=imread('cameraman.tif');
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
figure(1), imshow(fn); title('Original with noise')
imwrite(fn,'pcameraman','tif');

%Now lets remove the nosie
FN=fftshift(fft2(fn));

%Notch rejectfilter as in GW pp. 337-338
%Pick noise
mx=max(log10(abs(FN(:))+1));
LogFN=log10(abs(FN)+1)/mx;
figure, [v0, u0, p]=impixel(LogFN);title('Pick noise (points in the frequency domain')

D0=5; %D0: radius of "hole", see GW pp.337-338
for k=1:length(u0)
    for r=1:M
        for s=1:N
            D1=sqrt((r-u0(k))^2+(s-v0(k))^2);
            D2=sqrt((r+u0(k)-2*(M/2+1))^2+(s+v0(k)-2*(N/2+1))^2);
            
            %Butterworth filter
            n=3;%Filter order
            FN(r,s)=(1/(1+((D0*D0)/(D1*D2))^n))*FN(r,s);
            
            %Gaussian filter
            %FN(r,s)=(1 - exp(-(1/2)*((D^2-D0^2)/(D*W))^2))*FN(r,s);
        end  
    end
end

mx=max(log10(abs(FN(:))+1));
LogFN=log10(abs(FN)+1)/mx;
figure, imshow(LogFN);title('Spectrum after Notch filtering');colormap(jet(64)),colorbar;


e=fn-real(ifft2(fftshift(FN)));
g=fn;
figure, imshow(g-e);title('Remove with band reject');

%%Optional --- Optional --- Optional --- Optional --- Optional --- Optional 
%Adaptive as in GW pp. 338- 342
S=1/9*[1 1 1;1 1 1;1 1 1]; %Mask used for block operations
%Uses formula p. 252 i GW
ge_mean=imfilter(g.*e,S);
g_mean=imfilter(g,S);
e_mean=imfilter(e,S);
ee_mean=imfilter(e.^2,S);
e_mean_s=e_mean.^2;
 
w=(ge_mean-g_mean.*e_mean)./(ee_mean-e_mean_s);
 
f_hat=g-w.*e;


figure, imshow(g-w.*e);title('Optimum notch GW p. 251');
figure, hist(w(:),100);title('Fordeling af w-vaerdier (bør vaere 1)')
figure, imshow(w-.5);title('Korrektionsfaktorer w'); colormap(jet(256));colorbar;