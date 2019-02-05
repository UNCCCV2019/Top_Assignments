% Please edit this function only, and submit this Matlab file in a zip file
% along with your PDF report

function [left_x, right_x, left_y, right_y] = eye_detection(img)
% INPUT: RGB image
% OUTPUT: x and y coordinates of left and right eye.
% Please rewrite this function, and submit this file in Canvas (in a zip file with the report). 

        img2=rgb2gray(img)
        img2=imsharpen(img2)
        points = detectBRISKFeatures(img2);
        %figure;
        strong=selectStrongest(points, 3);
     



left_x = strong.Location(1,1);

left_y = strong.Location(1,2);


if strong.Location(2,1)<(strong.Location(1,1)+50) && strong.Location(2,1)>(strong.Location(1,1)-50)
    right_x = strong.Location(3,1);
    right_y = strong.Location(3,2);
else
    right_x = strong.Location(2,1);
    right_y = strong.Location(2,2);
end
    

end