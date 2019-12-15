function [output_image] = my_median_filter(noisy_image, m)

[row, col] = size(noisy_image);
input = double(noisy_image);
output = input;

for i = 1 : row-m+1
    for j = 1 : col-m+1
        Neighbor = input(i:i+m-1, j:j+m-1);
        medvalue = median(Neighbor(:));
        output(i+(m-1)/2, j+(m-1)/2) = medvalue;
    end
end

output_image = uint8(output);
end
