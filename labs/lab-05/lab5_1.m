%Lab 5 Exercise 1
%HKa sep. 2008

clear, close all; 

originalImport = imread('rice.tif');
image = double(originalImport)/255;
figure, imshow(image), title('Original') 

%Choose a single grain of rice
Icrop = imcrop(originalImport);
riceGrain = double(Icrop)/255;

[yvalsdIcrop,xvalsdIcrop]=hist(riceGrain(:),100);
[yvalsdI,xvalsdI]=        hist(image(:),100);

figure, subplot(121);plot(xvalsdI,yvalsdI),        title('Histogram for the original');
        subplot(122);plot(xvalsdIcrop,yvalsdIcrop),title('Histogram for a single grain of rice');

%Mean used as threshold        
Th = mean(riceGrain(:));

kZeros = zeros(size(originalImport));
sIndexAboveThreshold = find(riceGrain > Th + 0.05);
kZeros(sIndexAboveThreshold) = 1;
grainArea = sum( kZeros(:) );

jZeros = zeros(size(originalImport));
rIndexAboveThreshold = find(image > Th + 0.05);
jZeros(rIndexAboveThreshold) = 1;
imageArea = sum( jZeros(:) );

figure, imshow(jZeros); title('BW image');

NrOfRice = imageArea/grainArea

A = jZeros;

% Count regions
 B = strel('square',3);
%B = strel('arbitrary', [0 1 0; 1 1 1; 0 1 0])

label = 2;
p = min( find(A==1) );
while ~isempty(p)
    X0 = zeros( size(A) ); X0(p) = 1;
    X1 = zeros( size(A) );
    a = 1;
    while (a)
        X1 = imdilate(X0, B) & A;
        a = max( max(X0 ~= X1) );
        X0 = X1;
	end
	sIndexAboveThreshold = find(X0 == 1);
	A(sIndexAboveThreshold) = label;
	label = label + 1;
    p = min( find(A == 1) );
end

pseudocolor = rand(256,3);
figure, imshow(A, pseudocolor);