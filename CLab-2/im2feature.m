function [features] = im2feature(img)
% The feature vectors are in the form of [L, a*, b*, x, y]

[rows, cols, ~] = size(img);
npixels = rows * cols;

% Each feature vector consists of [L,a,b,x,y].
[x, y] = meshgrid(1:cols, 1:rows);
features = img;

factor = 1.0;  % May change the value of 'factor' to e.g. 10, or 0.1.
features(:,:,4) = factor * x;
features(:,:,5) = factor * y;

features = reshape(features, [npixels, 5]);

% Normalize the features
for i = 1:size(features,2)
    % Zero mean
    features(:,i) = features(:,i) - mean(features(:,i));
    % Normalize
    features(:,i) = features(:,i) / norm(features(:,i));
end
