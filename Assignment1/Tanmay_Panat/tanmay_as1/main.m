clear; clc; close all;

img_path = 'C:\Users\jogle\Desktop\evaluation\evaluation\test\';
%img_path = 'C:\Users\jogle\Desktop\validation\';
%img_num = 10;
img_num = 20;
img_dir = dir([img_path,'*.jpg']);
load('D:\sum\Its Study Time\Academic\M.S\Spring_2019\TA\Project1\P1\test\assignment1\evaluation\evaluation\test_gt.mat'); % ground truth
%load('D:\sum\Its Study Time\Academic\M.S\Spring_2019\TA\Project1\assignment1\assignment1\validation_gt.mat'); % ground truth

normlized_dist = zeros(img_num,1);

for i = 1:img_num
    disp(i);
    disp(img_path)
    img = imread([img_path,img_dir(i).name]);
    [left_x, right_x, left_y, right_y] = eye_detection(img);
    %close all;
    f = figure;
    imshow(img);
    hold on;
    plot([left_x, right_x], [left_y, right_y],'r*');
    saveas(f,['output_',img_dir(i).name]);
    [h,w,~] = size(img);
    %display(x(i,1));
    left_dist = sqrt( (x(i,1)-left_x).^2 + (y(i,1)-left_y).^2);
    %display(left_dist);
    right_dist = sqrt( (x(i,2)-right_x).^2 + (y(i,2)-right_y).^2);
    %display(right_dist);
    normlized_dist(i) = (left_dist + right_dist) / sqrt(h^2+w^2);
        
end

display('distance between groud truth:')
display(normlized_dist)