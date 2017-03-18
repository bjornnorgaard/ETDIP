%Textural segmentation
%GW p. 675-676
%HKa Feb. 2015

clear, close all;

% Lets make some disks, random locations
N = 256;
image = zeros(N,N);

powerInNoise = .01; % Parameter for power in noise
x = rand(size(image));
image(find(x >= powerInNoise/2 & x < powerInNoise)) = 1; % Maximum (saturated) value

% Left disks with radius r
r = 4;
Ar = [image(:, 1:100) zeros(N, r)];
Br = strel('disk', r);
Ar = imdilate(Ar, Br);

% Right lager disks (radius R)
R = 8;
AR = [zeros(N, R) image(:, 101:end)];
BR = strel('disk', R);
AR = imdilate(AR, BR);

image=[Ar AR];

%-----------------------

bA = logical(~image);
figure, imshow(bA); title('Original')
pause;

B1 = strel('disk', 5);
C = imclose(bA, B1);
figure, imshow(C); title('Closing using structuring element  lager than the disks on LHS')
pause;

B2 = strel('disk', 20);
D = imopen(C, B2);
figure, imshow(D); title('Closening with se lager than the disks on the LHS, followed by opening with se with radius lager than the distance between disks on the RHS')
pause;

close all;
