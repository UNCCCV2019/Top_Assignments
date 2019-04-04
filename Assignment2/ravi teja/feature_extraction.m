function feat = feature_extraction(img)
% Output should be a fixed length vector [1*dimension] for a single image. 
% Please do NOT change the interface.
img = rgb2gray(img);
%points = detectSURFFeatures(img);
%[features, validPoints] = extractFeatures(img,points);
%features = extractFeatures(img,validPoints.selectStrongest(1));

%feat = features;
lbpFeatures = extractLBPFeatures(img,'CellSize',[64 64],'Interpolation','Nearest');
numNeighbors = 4;
numBins = numNeighbors*(numNeighbors-1);
lbpCellHists = reshape(lbpFeatures,numBins,[]);
lbpCellHists = bsxfun(@rdivide,lbpCellHists,sum(lbpCellHists));
lbpFeatures = reshape(lbpCellHists,1,[]);
feat = lbpFeatures;
end