% CLAB2 Task-1: Harris Corner Detector

close all;
clear all;

img = imread('images/peppers.png');

bw = rgb2gray(img);

mycorners = my_corner(bw, 0.01);

% Plot the corners on the image
[rows,cols] = find(mycorners == 1);
figure;
subplot(1,2,1);
imshow(bw);
hold on;
plot(cols,rows,'or');
title('Corners by my\_corner.m');

subplot(1,2,2);
corners = corner(bw, 100);
imshow(bw);
hold on;
plot(corners(:,1),corners(:,2),'or');
title('Corners by corner.m');
