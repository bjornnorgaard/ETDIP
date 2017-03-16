%ROC (receiver operation characteristic)
%We calculate the ROC for an edge detection filter
%P_Detection versus P_FalseAlarm
%HKa Feb. 2015

clear, close all;

%Create test image
N=512;
a=.75;b=.25
I1=a*ones(N,N/2);
I2=b*ones(N,N/2);
I=[I1 I2];

%Add noise to test image
s=1;%s=.17; is an OK value
In=I+s*randn(size(I));
figure, imshow(In);
%Test image -end-

%We try an edge filter
h=fspecial('sobel')';
J=imfilter(In,h);

%We calculate P_Detection and P_FalseAlarm for different values of the threshold th
minj=min(J(:));
maxj=max(J(:));
for k=1:50
    th=minj+(k/50)*(maxj-minj);
	P_D(k)=length(find(J(:,N/2)>th))/N;
	P_falsk_alarm(k)=length(find(J(:,N/2+3)>th))/N;
end

%We can also plot P_FalseAlarm versus P_Detection using formulas

%Correlationen between h and the mask at the edge
he=sum(sum((I(1:3,N/2-1:N/2+1).*h)));

%L2-normen of h is calculated
l2h=sqrt(sum(sum(h.^2)));

%Signal to noise ratio is calculated
SNR=he/(l2h*s)

%Theroretical ROC (see note)
Pfa=.01:.01:1;
PD=1-fi_01(fi_01_inv(1-Pfa)-SNR);

%Lets plot the it all
figure, plot(P_falsk_alarm, P_D,'gx',Pfa,PD,'r');
xlabel('Prob. of false alarm'), ylabel('Prob. of detection');
str=strcat('SNR: ',num2str(10*log10(SNR^2)),'dB');
title(str);