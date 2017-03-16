% FIND_MEANS Find means of class features
%
% Given a set of training data features, we wish to find the mean of each feature
%   for a given class of character. These mean values are then normalized to permit
%   accurate distance measurements.

function T = find_means(stats,feature_name)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a sorted list of the character classes

num = length(stats);
classes(1) = stats(1).Class;
ind = 1;

for k = 2:num
	% if the class has not yet been encountered
	if ~sum(classes==stats(k).Class)
		ind = ind + 1;
		classes(ind,:) = stats(k).Class;
	end
end

classes = sort(classes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a matrix of mean feature values for each class of character

cc = [stats(:).Class]';

for feature_num = 1:length(feature_name)
	
	s = ['[stats.' feature_name{feature_num} ']'''];
	this_feature = eval(s);
	
	for class_num = 1:length(classes)
		% find which of the training characters belong to each class 
		char_ind = cc==classes(class_num);
		f_temp = this_feature(char_ind);
		f_mean(class_num,feature_num) = sum(f_temp)/length(f_temp);
	end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normalize the class/feature means

min_f_val = min(f_mean);
f_mean_norm = f_mean;

for feature_num = 1:length(feature_name)	
	f_mean_norm(:,feature_num) = f_mean_norm(:,feature_num) - min_f_val(feature_num);
	max_f_val(feature_num) = max(f_mean_norm(:,feature_num));
	f_mean_norm(:,feature_num) = f_mean_norm(:,feature_num) / max_f_val(feature_num);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store the important variables in a structure
T.classes = classes;
T.min_f_val = min_f_val;
T.max_f_val = max_f_val;
T.f_mean_norm = f_mean_norm;


