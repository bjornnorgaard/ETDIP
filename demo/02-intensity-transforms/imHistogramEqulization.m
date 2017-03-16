%Demo, Histogram Equalization
%HKa Feb. 2015

clc, clear, close all;

RandomNumbers = round(99*rand(1000,1).^.3)+1;
[YValues, XValues] = hist(RandomNumbers,100);

figure(1)
plot(XValues, YValues, 'xb');
title('Histogram for original data');
pause;

figure(2)
Sum = sum(YValues);
CummulativeSum = cumsum(YValues)/Sum;
plot(XValues, CummulativeSum, '.r');
axis([XValues(1),XValues(end), 0,1]);
title('Cumulated Density Function for original data');

for k = 1:length(RandomNumbers)
    y(k) = CummulativeSum(RandomNumbers(k));
end;

[NewYValues, NewXValues]=hist(y,100);
pause;

figure(3)
plot(NewXValues, NewYValues, 'xb');
title('Histogram for transformed data');
pause;

figure(4)
NewSum = sum(NewYValues);
NewCummulativeSum = cumsum(NewYValues)/NewSum;
plot(NewXValues, NewCummulativeSum, '.r');
axis([NewXValues(1),NewXValues(end), 0,1]);
title('Cumulative Density Function for transformerd data');

pause; close all;
