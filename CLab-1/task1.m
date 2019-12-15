img1 = imread('Images-for-CLAB1/face_01_u6617017.jpg');
img1 = imresize(img1, [512, 768]);
figure;
imshow(img1);

r = img1(:,:,1);
g = img1(:,:,2);
b = img1(:,:,3);
Rcolor = cat(3,r,zeros(size(g)),zeros(size(b)));
Gcolor = cat(3,zeros(size(r)),g,zeros(size(b)));
Bcolor = cat(3,zeros(size(r)),zeros(size(g)),b);
Rcolor = rgb2gray(Rcolor);
Gcolor = rgb2gray(Gcolor);
Bcolor = rgb2gray(Bcolor);
figure;
subplot(3,1,1);
imshow(Rcolor);
subplot(3,1,2);
imshow(Gcolor);
subplot(3,1,3);
imshow(Bcolor);

figure;
subplot(3,1,1);
imhist(Rcolor);
subplot(3,1,2);
imhist(Gcolor);
subplot(3,1,3);
imhist(Bcolor);


img1_histeq = histeq(img1);

figure;
imshow(img1_histeq);

r = img1_histeq(:,:,1);
g = img1_histeq(:,:,2);
b = img1_histeq(:,:,3);
Rcolor = cat(3,r,zeros(size(g)),zeros(size(b)));
Gcolor = cat(3,zeros(size(r)),g,zeros(size(b)));
Bcolor = cat(3,zeros(size(r)),zeros(size(g)),b);
Rcolor = rgb2gray(Rcolor);
Gcolor = rgb2gray(Gcolor);
Bcolor = rgb2gray(Bcolor);
figure;
subplot(3,1,1);
imshow(Rcolor);
subplot(3,1,2);
imshow(Gcolor);
subplot(3,1,3);
imshow(Bcolor);

figure;
subplot(3,1,1);
imhist(Rcolor);
subplot(3,1,2);
imhist(Gcolor);
subplot(3,1,3);
imhist(Bcolor);
