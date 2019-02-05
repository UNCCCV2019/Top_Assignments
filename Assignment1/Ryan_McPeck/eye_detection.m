% Please edit this function only, and submit this Matlab file in a zip file
% along with your PDF report

function [left_x, right_x, left_y, right_y] = eye_detection(img)
% INPUT: RGB image
% OUTPUT: x and y coordinates of left and right eye.
% Please rewrite this function, and submit this file in Canvas (in a zip file with the report). 

% trying eye detect function
    %img = imread(img);
    
    [rows, columns, numberOfColorChannels] = size(img);
    %display(rows);
    %display(columns);
    %display(numberOfColorChannels);
    picCenter = [rows * .5, columns * .5];
    
    columnScalerOnePercent = columns * .05;
    rowScalerOnePercent = rows * .05;

    grayimage = rgb2gray(img);
    points = detectBRISKFeatures(grayimage);
    %imshow(grayimage); hold on;
    strongestPoints = points.selectStrongest(4);
    strongEyePoint = points.selectStrongest(1);
    %plot(points.selectStrongest(4));
    xyMatrix = strongestPoints.Location;
    %display(xyMatrix);
    
    %removes the strongEyePoint prediction from the other possible points
    xyMatrix(ismember(xyMatrix,strongEyePoint.Location,'rows'),:)=[];
    %display(xyMatrix);
    
    xy = strongEyePoint.Location;
    x = xy(1,1);
    y = xy(1,2);
    %display(xy)
    %display(x)
    %display(y)
    
    xMinThreshold = x - columnScalerOnePercent;
    xMaxThreshold = x + columnScalerOnePercent;
    %display(xMinThreshold)
    %display(xMaxThreshold)
    
    yMinThreshold = y - rowScalerOnePercent;
    yMaxThreshold = y + rowScalerOnePercent;
    %display(yMinThreshold)
    %display(yMaxThreshold)
    
    updatedPossibles = xyMatrix((xyMatrix(:,1) > xMaxThreshold | xyMatrix(:,1) < xMinThreshold), :);
    %display(updatedPossibles);

    nextEyePoint = picCenter;
    rowCount = size(updatedPossibles,1);
    closest_x = 50000;
    for i=1:rowCount
        %display(updatedPossibles(i,2));
        if updatedPossibles(i,2) > yMinThreshold && updatedPossibles(i,2) < yMaxThreshold
            dis = (abs(x - updatedPossibles(i,1)));
            if dis < closest_x
                closest_x = dis;
                nextEyePoint = updatedPossibles(i,:);
            end
        end
    end
    %display(nextEyePoint);
    
    
    %xy = strongestPoints(1).Location;
    %display(xy(1,1));
    %display(xy(1,2));
    
    
    %minDiffInd = find(abs(diff(xyMatrix(:,1)))==min(abs(diff(xyMatrix(:,1)))));
    %display(minDiffInd);
    
    %M = min(xyMatrix);
    %display(M);
    %eyeDistance = M(1,1) + columnScaler;
    %display(eyeDistance);
    %C = xyMatrix(xyMatrix(:,1) > eyeDistance, :)
    
    %display(C);
    
    %nextEyeCoordinates = C(1,:);
    %display(nextEyeCoordinates);
    
    %display(strongestPoints(1));
    %display(strongestPoints(2));
    %display(strongestPoints(3));
    %display(strongestPoints(4));

  left_x = x;
  right_x = nextEyePoint(1,1);
  left_y = y;
  right_y = nextEyePoint(1,2);
  
  %plot([left_x, right_x], [left_y, right_y],'r*');
  
  %left_x = 100;
  %right_x = 50;
  %left_y = 100;
  %right_y = 50;

  
end