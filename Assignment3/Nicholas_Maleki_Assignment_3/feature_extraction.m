function feat = feature_extraction(img)
    all_des = [];
    global all_des_sample_test_uncc;
    class_label = [];

    if isempty(all_des_sample_test_uncc)
        all_des_sample_test_uncc = {};
    end
    addpath(genpath('OpenSURF_version1c'));

    Options.upright = false; % Rotation variant
    Options.tresh = 0.0001; % Hessian response threshold
    Options.extended = true; % If true - Descriptor length 128
    K = 128; % Must be same with descriptor length
    
    fprintf('Calculating SURF descriptors for image... ');
    k = 1;

    % Extract SURF features
    pts = OpenSurf(img, Options);

    % Landmark descriptors
    D = (reshape([pts.descriptor], K, []))';

    all_des = cat(1, all_des, D);
    all_des_sample_test_uncc = cat(2, all_des_sample_test_uncc, D); % this is the actual feature that is being returned as a global

    tmp = ones(size(D, 1), 1) * k;
    class_label = cat(1, class_label, tmp);

    disp('Done. ');
    
    feat = [1,128]; % this is done because open surf feature extraction returns many more data points than matlab's surf function and the test.m file is not built to handle that data type  
end