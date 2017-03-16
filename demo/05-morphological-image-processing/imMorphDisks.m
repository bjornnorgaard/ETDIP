%Erosion and Dilation of small spots usedd for counting
%HKa Jan. 2015

clear, close all;

%Lets make som small squares, random size and location
N=256;
I=zeros(N,N);

p=.005; %Parameter to set "power" in noise
x = rand(size(I));
I(find(x >= p/2 & x < p)) = 1; % Maximum (saturated) value

[r,s]=find(I~=0);
R=round(4*rand(1,length(r)));%Get square size
for k=1:length(r)
    for m=0:R(k)-1
        for n=0:R(k)-1
            I(r(k)+m,s(k)+n)=1;
        end
    end
end

bI=logical(I);
figure, imshow(bI);title('Original')
pause;

%Ltes find the squares with side length larger than 4 
se = strel('square', 4);
bI1= imerode(bI,se);
figure, imshow(bI1);title('Erodered original')

bI2= imdilate(bI1,se);
figure, imshow(bI2), title('Erosion followed by dilation of original (opnening)')

sum(bI2(:))/(4*4)
length(find(R==4))