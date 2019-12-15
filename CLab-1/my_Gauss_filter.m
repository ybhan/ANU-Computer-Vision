function [output_image] = my_Gauss_filter(noisy_image, my_9x9_gausskernel)

[row, col] = size(noisy_image);
[kernel_row, kernel_col] = size(my_9x9_gausskernel);

N = (kernel_row + 1) / 2;

output_image = zeros(row, col);
img_expanded = zeros(row+2*N, col+2*N);

for i = 1:row
    for j = 1:col
        img_expanded(i+N, j+N) = noisy_image(i,j);
    end
end

% Convolution
for i = N+1 : row+N
    for j = N+1 : col+N
        output_row = i-N;
        output_col = j-N;
        value = 0;
        for ki = 1:kernel_row
            for kj = 1:kernel_col
                value = value + img_expanded(output_row+ki-1, ...
                    output_col+kj-1) * my_9x9_gausskernel(ki,kj);
            end
        end
        output_image(output_row,output_col) = value;
    end
end

output_image = uint8(output_image);

end
