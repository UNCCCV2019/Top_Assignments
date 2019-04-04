function feat = feature_extraction(img)
% Output should be a fixed length vector [1*dimension] for a single image. 
% Please do NOT change the interface.
weight=1;
feat=[color_feature_extraction(img), bow_feature_extraction(img)*weight];

end