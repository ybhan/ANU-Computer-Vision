img5 = imread('Images-for-CLAB1/text.png');
img5 = imresize(img5, [1024, 1024]);
I = rgb2gray(img5);

M = I>=150;
imshow(M);

white = sum(sum(M == 0))
black = sum(sum(M == 1))
white + black
