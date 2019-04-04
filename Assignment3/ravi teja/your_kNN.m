function predict_label = your_kNN(feat)
% Output should be a fixed length vector [num of img, 1]. 
% Please do NOT change the interface.
% Please do NOT change any thing in this script.
% I will use my own script for grading. 
% It will be exactly the same as this one but with different testing image.

img_path = 'D:/projects/sem2/Computer Vision/assignment 3/train/';
class_num = 30;
img_per_class = 55;
img_num = class_num .* img_per_class;
feat_dim = size(feature_extraction(imread('D:/projects/sem2/Computer Vision/assignment 3/train/Balloon/329000.JPG')),2);
folder_dir = dir(img_path);
train = zeros(img_num,feat_dim);
label = zeros(img_num,1);

for i = 1:length(folder_dir)-2
    
    img_dir = dir([img_path,folder_dir(i+2).name,'/*.JPG']);
    if isempty(img_dir)
        img_dir = dir([img_path,folder_dir(i+2).name,'/*.BMP']);
    end
    
    label((i-1)*img_per_class+1:i*img_per_class) = i;
    
    for j = 1:length(img_dir)        
        img = imread([img_path,folder_dir(i+2).name,'/',img_dir(j).name]);
        train((i-1)*img_per_class+j,:) = feature_extraction(img);
        
    end
    
end


mdl = fitcknn(train,label,'NumNeighbors',10);
[predict_label,~,~] = predict(mdl,feat);
end