% By Jeff Yuanbo Han (u6617017), 2018-04-26.

img_L = imread('Left.jpg');
img_R = imread('Right.jpg');

n = 6;

figure; imshow(img_L);
for i = 1:n
    [X_L(i), Y_L(i)] = ginput(1);
    hold on;
    plot(X_L(i), Y_L(i), 'rx');
end

figure; imshow(img_R);
for i = 1:n
    [X_R(i), Y_R(i)] = ginput(1);
    hold on;
    plot(X_R(i), Y_R(i), 'rx');
end

H = DLT(X_L, Y_L, X_R, Y_R);
disp(H);

save H_estimate.mat X_L Y_L X_R Y_R H
