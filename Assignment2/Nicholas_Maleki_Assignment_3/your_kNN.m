function predict_label = your_kNN(feat)
    load('variables.mat');
    global all_des_sample_test_uncc;
    hists_test= buildHist_test(centers, all_des_sample_test_uncc, knnTHRESH, N);

    [IDX, D] = kNearestNeighbors(hists, hists_test, 1);
    clearvars -global all_des_sample_test_uncc;
    predict_label = IDX(2:end);
end

function hists = buildHist_test(centers, all_des_sample, THRESH, N)
    disp('Begin hists creation..');

    hists = [];

    for i = 1:size(all_des_sample, 2)
        % Descriptor of each test image
        sample_des = (all_des_sample{i});

        % kNN Search
        [IDX, D] = kNearestNeighbors(centers, double(sample_des), 1);

        % Statistics
        hist = double(zeros(1, N));

        for j = 1:size(IDX)
            if D(j) > THRESH
                continue;
            end

            hist(IDX(j)) = hist(IDX(j)) + 1;
        end

        % Normalization and summary
        hist = hist / sum(hist);
        hists = [hists; hist];
    end

    disp('Done\n\n');
end

function [neighborIds neighborDistances] = kNearestNeighbors(dataMatrix, queryMatrix, k)
    if(nargin ~= 3)
        k = 1;
    end

    neighborIds = zeros(size(queryMatrix, 1), k);
    neighborDistances = neighborIds;

    numDataVectors = size(dataMatrix, 1);
    numQueryVectors = size(queryMatrix, 1);

    for i = 1:numQueryVectors
        dist = sum((repmat(queryMatrix(i, :), numDataVectors, 1) - dataMatrix).^2, 2);
        [sortval sortpos] = sort(dist, 'ascend');
        neighborIds(i, :) = sortpos(1:k);
        neighborDistances(i, :) = sqrt(sortval(1:k));
    end
end