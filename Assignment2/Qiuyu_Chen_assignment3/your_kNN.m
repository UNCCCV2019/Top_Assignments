function predict_label = your_kNN(feat)
% Output should be a fixed length vector [num of img, 1]. 
% Please do NOT change the interface.

%% load train feature vectors and labels
load('bow_feat_train.mat');
load('label_train.mat');
load('color_feat_train.mat');

%% build knn classifier
num_neighbors = 9;
weight=1;
classifier=fitcknn([color_feat_train, bow_feat_train*weight], label_train, 'NumNeighbors', num_neighbors, 'Distance', 'cityblock');

%% predition
[predict_label, predict_score, predict_cost]=predict(classifier, feat);

end