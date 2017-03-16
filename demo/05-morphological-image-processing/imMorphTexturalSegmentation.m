%Textural segmentation
%GW p. 675-676
%HKa Feb. 2015

clear, close all;

%Lets make some disks, random locations
N=256;
A=zeros(N,N);

p=.01; %Parameter for power in noise
x = rand(size(A));
A(find(x >= p/2 & x < p)) = 1; % Maximum (saturated) value

%Left disks with radius r
r=4;
Ar=[A(:,1:100) zeros(N,r)];
Br=strel('disk',r);
Ar=imdilate(Ar,Br);

%Right  lager disks (radius R)
R=8;
AR=[zeros(N,R) A(:,101:end)];
BR=strel('disk',R);
AR=imdilate(AR,BR);

A=[Ar AR];
%-----------------------


bA=logical(~A);
figure, imshow(bA);title('Original')
pause;

B1=strel('disk',5);
C=imclose(bA,B1);
figure, imshow(C);title('Closing using structuring element  lager than the disks on LHS')
pause;

B2=strel('disk',20);
D=imopen(C,B2);
figure, imshow(D);title('Closening with se lager than the disks on the LHS, followed by opening with se with radius lager than the distance between disks on the RHS')


