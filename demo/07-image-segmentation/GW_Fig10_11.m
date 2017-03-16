%Commnets on Fig 10.11 GW3e p. 705
%HKa Feb. 2015

clear, close all;

%Create test iamge
N=256;
I0=zeros(N,N/4);
for s=1:N/2
    I1(:,s)=(s-1)/(N/2)*ones(N,1);
end;
I2=ones(N,N/4);
I=[I0 I1 I2];

%Add Gaussian noise
s=.01;  %s=sigma
n=s*rand(size(I));
I=I+n;
%Test image - done

%Now filter
%h=[-1 1];
h=-fspecial('sobel')';

J=imfilter(I,h);
K=imfilter(J,h);

maxj=max(J(N/2, 10:end-10)); %Get scanline, don't use edges
minj=min(J(N/2, 10:end-10)); 
J=(J-minj)/(maxj-minj);
 

maxk=max(K(N/2, 10:end-10)); %Get scanline, don't use edges
mink=min(K(N/2, 10:end-10)); 
K=(K-mink)/(maxk-mink);

figure, subplot(231), imshow(I),      title('Original'),
        subplot(234), plot(I(N/2,:)), title('Scanline in Original');

        subplot(232), imshow(J), title('1. derivative (scaled)');
        subplot(235), plot(J(N/2, 10:end-10)), title('scanline in 1. derivative');
        
        subplot(233), imshow(K), title('2. derivative (scaled)');
        subplot(236), plot(K(N/2, 10:end-10)), title('scanline in 2. derivative ');


for k=1:100
    th=k/100;
	BW=zeros(size(J));
    BW(find(J>th))=1;	
	P_falsk_alarm(k)=(sum(sum(BW(:,1:N/4)))+sum(sum(BW(:,3*N/4:N))))/(N*N/2);
	P_D(k)=sum(sum(BW(:,N/4:3*N/4)))/(N*N/2);
end

k=0:.01:1;
figure, plot(P_falsk_alarm, P_D,'.r');
xlabel('Prob. of false alarm'), ylabel('Prob. of detection');
%str=strcat('SNR: ',num2str(10*log10(((a-b)/2)^2/s^2)),'dB');
%title(str);