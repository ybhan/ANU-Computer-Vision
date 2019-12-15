% By Jeff Yuanbo Han (u6617017), 2018-04-26.

load train_data.mat;
[pixels, m] = size(Phi); % numbers of pixels and training images
n = size(img,1) - m; % number of test images

% Vectorize test images
Phi_test = zeros(pixels, n);
for i = 1:n
    Phi_test(:,i) = double(img{m+i}(:)) - X_bar;
end

%% Recognition using eigenfaces
k = 5; % First choose k

% Project onto the k-dimension subspace
Omega = V(:,1:k)' * Phi;
Omega_test = V(:,1:k)' * Phi_test;

% Find the nearest neighbor
distances = dist(Omega', Omega_test);

[difs, neighbor] = min(distances); % distances in face space
classify = ceil(neighbor/9); % number of person (each has 9 expressions)

fprintf('k = %d, PCA preserves %.2f%% information.\n',...
    k, 100*sum(lambda(1:k))/sum(lambda));
fprintf('The nearest neighbor:\n'); disp(neighbor);
fprintf('Classify as:\n'); disp(classify);
fprintf('Distance in face space:\n'); disp(difs);

% Display the most three similar faces in pair
[~, index] = sort(difs);

Y = zeros(3*height, 2*width);
for j = 1:3
    Y((j-1)*height+1:j*height, 1:width) = img{m+index(j)};
    Y((j-1)*height+1:j*height, width+1:width*2) = img{neighbor(index(j))};
end

figure; imagesc(Y);
colormap(gray); axis off;
title('Test Image------------Nearest Neighbor', 'FontSize', 16);
