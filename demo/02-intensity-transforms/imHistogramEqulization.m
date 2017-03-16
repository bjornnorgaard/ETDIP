%Demo, Histogram Equalization
%HKa Feb. 2015

clc, clear, close all;

x = round(99*rand(1000,1).^.3)+1;
[yvals, xvals] = hist(x,100);

figure(1)
plot(xvals, yvals, 'xb');
title('Histogram for original data');
pause;

figure(2)
s = sum(yvals);
F = cumsum(yvals)/s;
plot(xvals, F, '.r');
axis([xvals(1),xvals(end), 0,1]);
title('Cumulated Density Function for original data');

for k = 1:length(x)
    y(k)=F(x(k));
end;

[nyvals, nxvals]=hist(y,100);
pause;

figure(3)
plot(nxvals, nyvals, 'xb');
title('Histogram for transformed data');
pause;

figure(4)
ns = sum(nyvals);
nF = cumsum(nyvals)/ns;
plot(nxvals, nF, '.r');
axis([nxvals(1),nxvals(end), 0,1]);
title('Cumulative Density Function for transformerd data');
