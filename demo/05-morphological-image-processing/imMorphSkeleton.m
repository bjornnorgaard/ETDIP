%Calculate the Morphological skelton of an BW-image
% See GW fig. 9.24 p. 653
%HKa Jan. 2015


%Region as in GW p. 653.
A=ones(12,7);
A(1,:)=0;A(12,:)=0;A(:,1)=0;A(:,7)=0; %Create black border
A(2,3:6)=0;
A(3,2)=0; A(3,5:6)=0;
A(4,2)=0; A(4,5:6)=0;
A(5,2)=0; A(5,6)=0;
A(6,2)=0; A(6,6)=0;
figure(1), imshow(A);title('Original')


%Let's find the skelton
B=strel('square',3);

SA=zeros(size(A));
A_erode_kB=A;
a=1;
k=0;
while (a) 
    Sk= A_erode_kB & (1-imopen(A_erode_kB,B));
    
    imshow(A_erode_kB);str=strcat('A-kB for k=',num2str(k));title(str); 
    pause;
    
    imshow(Sk);str=strcat('Sk for k=',num2str(k));title(str);
    pause;
        
    SA=SA|Sk;
    
    k=k+1;
    A_erode_kB=imerode(A_erode_kB,B);
    a=max(max(A_erode_kB));

end

figure(2), imshow(SA), title('Skeleton');