function [H] = DLT(u2Trans, v2Trans, uBase, vBase)
% DLT(u2Trans, v2Trans, uBase, vBase) computes the homography H,
% applying the Direct Linear Transformation.
%
% The transformation is such that
% p2 = H * p1, i.e.:
% (uBase, vBase, 1)' = H * (u2Trans, v2Trans, 1)'
%
% INPUTS:
% u2Trans, v2Trans - vectors with coordinates u and v of the transformed
%                    image point p1
% uBase, vBase - vectors with coordinates u and v of the original base
%                    image point p2
%
% OUTPUT:
% H - a 3x3 homography matrix
%
% By Jeff Yuanbo Han (u6617017), 2018-04-26.
n = max(size(u2Trans)); % number of points
A = zeros(2*n, 9);
for i = 1:n
    A(2*i-1, 4:6) = -[u2Trans(i), v2Trans(i), 1];
    A(2*i-1, 7:9) = vBase(i) * [u2Trans(i), v2Trans(i), 1];
    A(2*i, 1:3) = [u2Trans(i), v2Trans(i), 1];
    A(2*i, 7:9) = -uBase(i) * [u2Trans(i), v2Trans(i), 1];
end

[~,~,V] = svd(A);
H = reshape(V(:,end), [3,3])';
end
