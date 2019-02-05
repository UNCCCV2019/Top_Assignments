% Please edit this function only, and submit this Matlab file in a zip file
% along with your PDF report

function [left_x, right_x, left_y, right_y] = eye_detection(img)
% INPUT: RGB image
% OUTPUT: x and y coordinates of left and right eye.
% Please rewrite this function, and submit this file in Canvas (in a zip file with the report). 

% left_x = 100;
% right_x = 300;
% left_y = 50;
% right_y = 50;

im_adj = imadjust(img,[0.3 0.8],[]);
gray = rgb2gray(im_adj);

% [centers] = imfindcircles(gray,[20 80],'ObjectPolarity','dark','Sensitivity',0.96);
%   points = detectBRISKFeatures(gray,'ROI',[1 1 size(gray,2)*0.75 size(gray,1)*0.5]);
 points = detectBRISKFeatures(gray,'MinQuality',0.5,'MinContrast',0.3,'ROI',[size(gray,2)*0.10 size(gray,2)*0.05 size(gray,2)*0.75 size(gray,1)*0.5]);

%  points = detectBRISKFeatures(gray);

%  points = detectFASTFeatures(gray);

%  points = detectFASTFeatures(gray,'MinContrast',0.3,'ROI', [1 1 size(gray,2)*0.75 size(gray,1)*0.5]);

pt = points.selectStrongest(2);

left_x = pt.Location(1,1);
left_y = pt.Location(1,2);
right_x = pt.Location(2,1);
right_y = pt.Location(2,2);

% left_x = centers(1,1);
% left_y = centers(1,2);
% right_x = centers(2,1);
% right_y = centers(2,2);
% 

end