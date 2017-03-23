%Lab 8_1
%Blokwis adaptiv thresholdning
%HKa oct. 2008

clear, close all;

I=imread('rice.tif');
dI=double(I)/255;
figure, imshow(dI), title('Original');

N=32;%Blok størrelse
BW=blkproc(dI,[N,N],@AdaptivelyThreshold); %Blockwise processing
figure, imshow(BW);title('BW image, adaptive threshold');

TH=blkproc(dI,[N,N],@AdaptivelyThresholdOutputThreshold);%Blockwise processing
figure, imshow(TH);title('Thresholded image');

for k=1:20
	BW1=zeros(size(dI));
	r=find(dI>k*.05);
	BW1(r)=1;
	
	ID=BW&BW1;%Detection image
	IFA=~BW&BW1; %False alarm image
	
	PD(k)=sum(ID(:))/sum(BW(:));
	PFA(k)=sum(IFA(:))/sum(1-BW(:));
    
%     figure, imshow(BW1); title('BW image global threshold');
%     figure, imshow(ID);title('White = Detection');
%     figure, imshow(IFA);title('White = False Alarm');
%     pause;

end

figure, plot(PFA, PD); xlabel('Prob. of false alarm'), ylabel('Prob. of detection');
title('ROC-curve');

%% PFA =5% => PD~=95%