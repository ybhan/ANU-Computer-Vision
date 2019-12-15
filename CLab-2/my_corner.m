function [corners, count] = my_corner(bw, thresh)
% MY_CORNER computes Harris Corners of an image.
% Input:
%   bw: a grayscale image matrix
%   thresh: threshold
%
% Output:
%   corners: a matrix of the same size as bw, which records the Harris
%            Corners (corner's value == 1, otherwise == 0)
%   count: The number of corners obtained
% 
% By Jeff Yuanbo Han (u6617017), 2018-04-02.

sigma = 2;  % the sigma for Gaussian filter
count = 0;  % the number of detected corners

% Gaussian first partial derivatives
dy = [-1 0 1;-1 0 1;-1 0 1];
dx = dy';

% Gaussian first gradient of the intensity
Ix = conv2(bw,dx,'same');
Iy = conv2(bw,dy,'same');

% Generate a Gaussian kernel.
g = fspecial('gaussian',max(1,fix(6*sigma)),sigma);

% Gaussian second gradient of the intensity
Ix2 = conv2(Ix.^2,g,'same');
Iy2 = conv2(Iy.^2,g,'same');
Ixy = conv2(Ix.*Iy,g,'same');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Task: Compute the Harris Cornerness R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[height, width] = size(bw);  % Get the size of bw.
R = zeros(height, width);  % Harris Cornerness
Rmax = 0;  % The maximum value of R

for i = 1:height
    for j = 1:width
        M = [Ix2(i,j) Ixy(i,j); Ixy(i,j) Iy2(i,j)];  % M matrix
        R(i,j) = det(M) - 0.04*trace(M)^2;  % Compute R value.
        if R(i,j)> Rmax
            Rmax = R(i,j);  % Update Rmax.
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Task: Perform non-maximum suppression and threshold here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
corners = zeros(height, width);  % Record the corners (value will be 1).
for i = 2:height-1
    for j = 2:width-1
        % threshold and non-maximum
        if R(i,j) > thresh*Rmax ...
                && R(i,j) > R(i-1,j-1) && R(i,j) > R(i-1,j) ...
                && R(i,j) > R(i-1,j+1) && R(i,j) > R(i,j-1) ...
                && R(i,j) > R(i,j+1) && R(i,j) > R(i+1,j-1) ...
                && R(i,j) > R(i+1,j) && R(i,j) > R(i+1,j+1)
            corners(i,j) = 1;
            count = count + 1;
        end
    end
end

end
