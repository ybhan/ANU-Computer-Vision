function C = calibrate(im, XYZ, uv)
% Function to perform camera calibration.
%
% Usage:   K = calibrate(image, XYZ, uv)
%
%   Where:   image - is the image of the calibration target.
%            XYZ - is a N x 3 array of  XYZ coordinates
%                  of the calibration target points. 
%            uv  - is a N x 2 array of the image coordinates
%                  of the calibration target points.
%            K   - is the 3 x 4 camera calibration matrix.
%  The variable N should be an integer greater than or equal to 6.
%
%  This function plots the uv coordinates onto the image of the calibration
%  target. 
%
%  It also projects the XYZ coordinates back into image coordinates using
%  the calibration matrix and plots these points too as 
%  a visual check on the accuracy of the calibration process.
%
%  Lines from the origin to the vanishing points in the X, Y and Z
%  directions are overlaid on the image. 
%
%  The mean squared error between the positions of the uv coordinates 
%  and the projected XYZ coordinates is also reported.
%
%  The function should also report the error in satisfying the 
%  camera calibration matrix constraints.
%
% By Jeff Yuanbo Han (u6617017), 2018-05-13.

n = size(uv, 1); % number of points
A = zeros(2*n, 12);
for i = 1:n
    A(2*i-1, 5:8) = -[XYZ(i,:), 1];
    A(2*i-1, 9:12) = uv(i,2) * [XYZ(i,:), 1];
    A(2*i, 1:4) = [XYZ(i,:), 1];
    A(2*i, 9:12) = -uv(i,1) * [XYZ(i,:), 1];
end

[~,~,V] = svd(A);
C = reshape(V(:,end), [4,3])';

err = 0; % Squared error

% Display the selected and estimated points
figure; imshow(im); hold on;
for i = 1:n
    plot(uv(i,1), uv(i,2), 'rx');
    estm = C * [XYZ(i,:),1]';
    estm = estm ./ estm(3);
    plot(estm(1), estm(2), 'bo');
    
    err = err + dist(uv(i,:), estm(1:2))^2;
end

fprintf('MSE = %f\n', err/n);

orig = C * [0,0,0,1]';
orig = orig ./ orig(3);
x_axis = C * [50,0,0,1]';
x_axis = x_axis ./ x_axis(3);
y_axis = C * [0,50,0,1]';
y_axis = y_axis ./ y_axis(3);
z_axis = C * [0,0,50,1]';
z_axis = z_axis ./ z_axis(3);
plot([orig(1),x_axis(1)], [orig(2),x_axis(2)], 'g');
plot([orig(1),y_axis(1)], [orig(2),y_axis(2)], 'g');
plot([orig(1),z_axis(1)], [orig(2),z_axis(2)], 'g');
end
