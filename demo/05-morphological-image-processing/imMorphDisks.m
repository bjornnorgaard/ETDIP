%Erosion and Dilation of small spots usedd for counting
%HKa Jan. 2015

clear, close all;

% Lets make som small squares, random size and location
N = 256;
Image = zeros(N, N);

p=.005; % Parameter to set "power" in noise
x = rand(size(Image));
Image(find(x >= p/2 & x < p)) = 1; % Maximum (saturated) value

[r,s] = find(Image ~= 0);
R = round(4*rand(1,length(r))); %Get square size

for k = 1:length(r)
    for m = 0:R(k)-1
        for n = 0:R(k)-1
            Image(r(k)+m,s(k)+n)=1;
        end
    end
end

bI = logical(Image);
figure, imshow(bI); title('Original')
pause;

% Lets find the squares with side length larger than 4 
structuralElement = strel('square', 4);

bI1 = imerode(bI, structuralElement);
figure, imshow(bI1); title('Erodered original')
pause;

bI2 = imdilate(bI1, structuralElement);
figure, imshow(bI2), title('Erosion followed by dilation of original (opening)')

sum(bI2(:)) / (4*4)
length(find(R == 4))

pause;
close all;