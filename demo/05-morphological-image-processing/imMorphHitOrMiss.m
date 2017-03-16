%Hit or Miss using morfological operations
%GW pp. 640- 642
%HKa Jan. 2015

clear, close all; 

%Create image to analyse
A=ones(12,7);
A(1,:)=0;A(12,:)=0;A(:,1)=0;A(:,7)=0; %%Create black border
A(2,3:6)=0;
A(3,2)=0; A(3,5:6)=0;
A(4,2)=0; A(4,5:6)=0;
A(5,2)=0; A(5,6)=0;
A(6,2)=0; A(6,6)=0;

%Lets Hit or Miss
B =strel('arbitrary',[1 0 0; 0 1 1;0 1 1]);
Bc=strel('arbitrary',[0 1 1; 1 0 0;1 0 0]);

Ac=~A;
A_star_B=imerode(A,B)&imerode(Ac,Bc)

figure(1), imshow(A);title('Original')
figure(2), imshow(A_star_B);title('Hit or Miss')