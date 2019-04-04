function bow_feat = bow_feature_extraction(img)
% Output should be a fixed length vector [1*dimension] for a single image. 
% Please do NOT change the interface.

load('bag_of_visual_words.mat');
img = rgb2gray(img);
points = detectSURFFeatures(img);%key point detection
[keypnt_descriptor, ~] = extractFeatures(img, points, 'SURFSize', 128);

img_histogram = zeros(1,size(bag_of_visual_words,1));
bin_ind_for_each_keypnt = dsearchn(bag_of_visual_words, keypnt_descriptor);
for i=1:size(bin_ind_for_each_keypnt)
    img_histogram(1,bin_ind_for_each_keypnt(i)) = img_histogram(1,bin_ind_for_each_keypnt(i))+1;
end

bow_feat=img_histogram/sum(img_histogram);

end