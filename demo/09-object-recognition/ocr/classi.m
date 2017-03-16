% Perform the classification
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% List the features to be used for classification

feature_name{1} = 'Eccentricity';
feature_name{2} = 'Orientation';
feature_name{3} = 'HPSkewness';
feature_name{4} = 'VPSkewness';
feature_name{5} = 'HPKurtosis';
feature_name{3} = 'VPKurtosis';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the class means from the training data
load training_data stats
T = find_means(stats,feature_name);
clear stats

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each character, normalize the features so they can be compared to the means of
%   each class.

load test_data

for f_num = 1:length(feature_name)
	s = ['[stats.' feature_name{f_num} ']'''];
	this_feature = eval(s);
	f_norm(:,f_num) = this_feature - T.min_f_val(f_num);
	f_norm(:,f_num) = f_norm(:,f_num) / T.max_f_val(f_num);
end

%figure(4)
%plot(f_norm(:,2),f_norm(:,3),'x')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For each character, find the distance between it and each class
% Then assign the character to the class with the least distance

num_chars = length(stats);
for k = 1:num_chars
	num_classes = size(T.f_mean_norm,1);
	for class_num = 1:num_classes
		dist(class_num) = sum((f_norm(k,:) - T.f_mean_norm(class_num,:)).^2);
	end
	[min_dist,ind] = min(dist);
	stats(k).Class = T.classes(ind);
end

save classified_test_data I stats

