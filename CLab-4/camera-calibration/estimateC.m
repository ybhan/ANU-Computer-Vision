% CLAB-4: Estimate and decompose C.
% By Jeff Yuanbo Han (u6617017), 2018-05-13.
load a_points.mat
C = calibrate(img, XYZ, uv)
[K, R, t] = vgg_KR_from_P(C)

save a_points.mat C K R t -append
