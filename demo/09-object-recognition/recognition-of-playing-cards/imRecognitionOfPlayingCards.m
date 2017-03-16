%Classification of Paying cards
%HKa Feb. 2015
%Basered on code by Jesse Hansen, http://www.ele.uri.edu/~hansenj/
clear, close all;

% Import training image
filename = 'suits.jpg';
[Im,map] = imread(filename);
if ~isempty(map)
    Im_intensity = ind2gray(Im,map);
else
    if size(Im,3)==3
        Im_intensity = rgb2gray(Im);
        Im_intensity = ind2gray(Im_intensity,gray(256));
    else
        Im_intensity = ind2gray(Im,gray(256));
    end
end

% Show the image
figure(1)
imshow(Im_intensity)

% Threshhold the image and smooth the edges
thresh = 128;
Im_thr = 255-Im_intensity>thresh;
BW1 = bwmorph(Im_thr,'majority',1);
BW1 = bwmorph(BW1,'open',1);
figure(2)
imshow(BW1)

% Label the regions
[L,num] = bwlabel(BW1);
figure(3)
map = [0 0 0;
    0    0.7  0.7;
    0.7   0   0.7;
    0.7  0.7   0;
    0.7  0.5  0.3];

imshow(L+1,map)

% Get features of the 4 training objects
stats = regionprops(L,'Extent','ConvexImage','Solidity');
class = {'spades','clubs','hearts','diamonds'};

% 'Extent' - Scalar; the proportion of the pixels in the bounding box that are
%  also in the region. Computed as the Area divided by area of the bounding box.
%  This property is supported only for 2-D input label matrices.

% 'Solidity' - Scalar; the proportion of the pixels in the convex hull that are
%  also in the region. Computed as Area/ConvexArea.

% 'Area' - Scalar; the actual number of pixels in the region (object).
% 'ConvexArea' - Scalar; the number of pixels in 'ConvexImage'.
% 'ConvexImage' - Binary image (uint8); the convex hull, with all pixels within
%  the hull filled in (i.e., set to on). The image is the size of the bounding
%  box of the region.
% 'ConvexHull' - p-by-2 matrix; the smallest convex polygon that can contain
%  the region. Each row of the matrix contains the x- and y-coordinates of one
%  vertex of the polygon.


figure(4)
subplot(223), imshow(stats(1).ConvexImage), title(class{1})
subplot(221), imshow(stats(2).ConvexImage), title(class{2})
subplot(224), imshow(stats(3).ConvexImage), title(class{3})
subplot(222), imshow(stats(4).ConvexImage), title(class{4})

s1 = [stats.Extent];
s2 = [stats.Solidity];

figure(5)
plot(s1,s2,'*')
xlabel('Extent'),ylabel('Solidity')

text(s1(1),s2(1),class{1}) 
text(s1(2),s2(2),class{2}) 
text(s1(3),s2(3),class{3}) 
text(s1(4),s2(4),class{4}) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Testing
% Import test image
filename = 'findsuits.jpg';
[Im,map] = imread(filename);
if ~isempty(map)
    Im_intensity = ind2gray(Im,map);
else
    if size(Im,3)==3
        Im_intensity = rgb2gray(Im);
        Im_intensity = ind2gray(Im_intensity,gray(256));
    else
        Im_intensity = ind2gray(Im,gray(256));
    end
end

% Threshhold the image and smooth the edges
Im_test_thr = (255-Im_intensity+1)>thresh;
BW2 = bwmorph(Im_test_thr,'majority',1);
BW2 = bwmorph(BW2,'open',1);
figure(6)
imshow(BW2)

% Label the regions
[L_test,num_test] = bwlabel(BW2);

% Get features of the test objects
stats_test = regionprops(L_test,'Image','Extent','ConvexImage','Solidity');
s1_test = [stats_test.Extent];
s2_test = [stats_test.Solidity];

figure(7)
plot(s1,s2,'x',s1_test,s2_test,'o')
xlabel('Extent'),ylabel('Solidity')

figure(8)
plot(ones(size(s2)),s2,'x',ones(size(s2_test)),s2_test,'+')
xlabel('Extent'),ylabel('Solidity')

figure(9)
for n = 1:num_test
	distance(n,:) = abs(s2-s2_test(n));
	[dummy,I] = min(distance(n,:));
	stats_test(n).Class = class(I);
	subplot(2,4,n), imshow(stats_test(n).Image), title(stats_test(n).Class)
end