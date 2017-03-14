%% LAB 3, Exercise 1 %% 
clc; clear; close all;

%% 3.1 generate 128x128 image

% k = 5, l = 5
M = 128;N = 128;
k = 5; l = 5;
for r=0 : M-1
   for s=0 : N-1
       dI(r+1,s+1) = 0.5*sin(2*pi*( (r/M)*k + (s/N)*l ))+0.5;
   end
end
subplot(231); imshow(dI); title('k=5, l=5');

% k = 2, l = 5
k = 2; l = 5;
for r=0 : M-1
   for s=0 : N-1
       dI(r+1,s+1) = 0.5*sin(2*pi*( (r/M)*k + (s/N)*l ))+0.5;
   end
end

subplot(232); imshow(dI); title('k=2, l=5');

% k = 5, l = 2
k = 5; l = 2;
for r=0 : M-1
   for s=0 : N-1
       dI(r+1,s+1) = 0.5*sin(2*pi*( (r/M)*k + (s/N)*l ))+0.5;
   end
end

subplot(233); imshow(dI); title('k=5, l=2');
