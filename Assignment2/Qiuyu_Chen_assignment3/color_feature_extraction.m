function color_feat = color_feature_extraction(img)
num_h = 16;
num_s = 4;
num_v = 4;

[rows, cols, num_color_chans] = size(img);
hsv_img = rgb2hsv(img);

hsv_histogram = zeros(num_h, num_s, num_v);
for col = 1 : cols
    for row = 1 : rows
        hBin = ceil(hsv_img(row, col, 1) * num_h);
        if (hBin == 0)
           hBin = 1; 
        end
        sBin = ceil(hsv_img(row, col, 2) * num_s);
        if (sBin == 0)
           sBin = 1; 
        end
        vBin = ceil(hsv_img(row, col, 3) * num_v);
        if (vBin == 0)
           vBin = 1; 
        end
        hsv_histogram(hBin, sBin, vBin) = hsv_histogram(hBin, sBin, vBin) + 1;
    end
end
color_feat = reshape(hsv_histogram,[1, num_h*num_s*num_v]);
color_feat = color_feat/sum(color_feat);
end