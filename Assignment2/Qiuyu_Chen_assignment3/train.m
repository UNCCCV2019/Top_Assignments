%% extract sift features from all images
img_path='train/';
folder_dir=dir(img_path);

imgs_keypoint_collector = [];
num_keypnts_collector = [];

for i = 1:length(folder_dir)-2
    img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
    end
    
    for j = 1:length(img_dir)        
        img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
        img = rgb2gray(img);%transform to gray scale
        points = detectSURFFeatures(img);%key point detection
        [new_keypoint_descriptor, new_num_keypnts] = extractFeatures(img, points, 'SURFSize', 128);%
        imgs_keypoint_collector = [imgs_keypoint_collector; new_keypoint_descriptor];
        %num_keypnts_collector = [num_keypnts_collector; new_num_keypnts];
    end  
end

%% sample sift features for cluster
rng(32);%for repeatable result
sample_size=1e4;
num_features = size(imgs_keypoint_collector);
num_features = num_features(1);
sample_index=randsample(num_features, sample_size);
sample_features=imgs_keypoint_collector(sample_index, :);

%% run k-means on sample features
vocabulary_size = 64;
[keypnt_ind, bag_of_visual_words] = kmeans(sample_features, vocabulary_size, 'MaxIter',300,'Display','iter','Replicates',1);
%[keypnt_ind, bag_of_visual_words] = kmeans(imgs_keypoint_collector, vocabulary_size, 'MaxIter',300,'Display','iter','Replicates',1);

%% save bag of words
save('bag_of_visual_words.mat','bag_of_visual_words');

%% compute training bow-features
img_path = './train/';
class_num = 30;
img_per_class = 55;
img_num = class_num .* img_per_class;
feat_dim = size(bow_feature_extraction(imread('./val/Balloon/329016.JPG')),2);

folder_dir = dir(img_path);
bow_feat_train = zeros(img_num, feat_dim);
label_train = zeros(img_num,1);

for i = 1:length(folder_dir)-3%skip .DS_Store file in mac os; please correct it if not running on Mac OS
    
    img_dir = dir([img_path,folder_dir(i+3).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+3).name,'/*.BMP']);
    end
    
    label_train((i-1)*img_per_class+1:i*img_per_class) = i;
    
    for j = 1:length(img_dir)        
        img = imread([img_path,folder_dir(i+3).name,'/',img_dir(j).name]);
        bow_feat_train((i-1)*img_per_class+j,:) = bow_feature_extraction(img);
    end
    
end

%% save the train features
save('bow_feat_train.mat','bow_feat_train');
save('label_train.mat', 'label_train');

%% compute training color features
img_path = './train/';
class_num = 30;
img_per_class = 55;
img_num = class_num .* img_per_class;
feat_dim = size(color_feature_extraction(imread('./val/Balloon/329016.JPG')),2);

folder_dir = dir(img_path);
color_feat_train = zeros(img_num, feat_dim);
label_train = zeros(img_num,1);

for i = 1:length(folder_dir)-3%skip .DS_Store file in mac os; please correct it if not running on Mac OS
    
    img_dir = dir([img_path,folder_dir(i+3).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+3).name,'/*.BMP']);
    end
    
    label_train((i-1)*img_per_class+1:i*img_per_class) = i;
    
    for j = 1:length(img_dir)        
        img = imread([img_path,folder_dir(i+3).name,'/',img_dir(j).name]);
        color_feat_train((i-1)*img_per_class+j,:) = color_feature_extraction(img);
    end
    
end
%% save color_feature
save('color_feat_train.mat', 'color_feat_train');

