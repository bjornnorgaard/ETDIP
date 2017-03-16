%Demo, Histogram Equalization
%HKa Feb. 2015

clc, clear, close all;

randomNumbers = round(99*rand(1000,1).^.3)+1;
[yValues, xValues] = hist(randomNumbers, 100);

figure(1)
plot(xValues, yValues, 'xb');
title('Histogram for original data');
pause;

figure(2)
sumOfYValues = sum(yValues);
cummulativeSum = cumsum(yValues)/sumOfYValues;
plot(xValues, cummulativeSum, '.r');
axis([xValues(1), xValues(end), 0,1]);
title('Cumulated Density Function for original data');

for k = 1:length(randomNumbers)
    y(k) = sum(randomNumbers(k));
end;

[newYValues, newXValues] = hist(y,100);
pause;

figure(3)
plot(newXValues, newYValues, 'xb');
title('Histogram for transformed data');
pause;

figure(4)
newSumOfYValues = sum(newYValues);
newCummulativeSum = cumsum(newYValues)/newSumOfYValues;
plot(newXValues, newCummulativeSum, '.r');
axis([newXValues(1), newXValues(end), 0,1]);
title('Cumulative Density Function for transformerd data');

pause; close all;
