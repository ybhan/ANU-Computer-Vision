img = imread('images/my_photo.jpg');
img = rgb2gray(img);
img1 = imresize(imrotate(img, 5), 1.2);
img2 = imresize(imrotate(img, 15), 1.4);
img3 = imresize(imrotate(img, 45), 0.8);

imwrite(img1, 'images/photo1.png');
imwrite(img2, 'images/photo2.png');
imwrite(img3, 'images/photo3.png');
