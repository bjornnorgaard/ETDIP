%Iterative Global Threshold
%Anders Krogh Mortensen
%Feb. 2016

clear, close all



I=imread('cameraman.tif');
T0 = max(I(:))-1;
% T0 = mean(I(:));
dT = 0.1;


T_curr = double(T0);
T_prev = Inf;
itr = 0;
disp('Itr.  Tnew   Tprev   dT')
disp(num2str(itr,'%4.4u'))
[counts, binLocations] = imhist(I);

BW = im2bw(I,T_curr/255);
fig = figure;
figure(fig);
clf;
subplot(1,3,1);
imshow(I);
title('Original image');
subplot(1,3,2);
imhist(I);
hold on;
plot([T_curr T_curr], [0 max(counts)],'r-','LineWidth',2);
legend('Image histogram',['Threshold (' num2str(T_curr) ')'],'Location','NorthOutside');
subplot(1,3,3);
imshow(BW);title('Thresholded image');
pause();

while (abs(T_prev-T_curr) > dT)
    Ibw = im2bw(I,T_curr/255);
    meanFG = mean(I(Ibw));
    meanBG = mean(I(~Ibw));
    T_prev = T_curr;
    T_curr = (meanFG+meanBG)/2;
    itr = itr + 1;
    disp([itr T_curr T_prev abs(T_prev-T_curr)])
    
    BW = im2bw(I,T_curr/255);
    
    figure(fig);
    clf;
    subplot(1,3,1);
    imshow(I);
    title('Original image');
    subplot(1,3,2);
    imhist(I);
    hold on;
    plot([T_curr T_curr], [0 max(counts)],'r-','LineWidth',2);
    plot([T_prev T_prev], [0 max(counts)],'b--','LineWidth',2);
    plot([meanFG meanFG], [0 max(counts)],'g-','LineWidth',2);
    plot([meanBG meanBG], [0 max(counts)],'g-','LineWidth',2);
    legend('Image histogram',['New threshold (' num2str(T_curr) ')'],['Previous threshold (' num2str(T_prev) ')'],'\mu1','\mu2','Location','NorthOutside');
    subplot(1,3,3);
    imshow(BW);title('Thresholded image');
    pause();
end;
