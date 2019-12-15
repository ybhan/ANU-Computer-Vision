% Step 1
img = imread('images/mandm.png');
%img = uint8(img ./ 256);
imshow(img), title('Input colour image');

% Step 2
cform = makecform('srgb2lab');
lab = applycform(img, cform);
lab = double(lab);

% Step 3
features = im2feature(lab);

% Step 4
nc = 5;
my_clusters = my_kmeans(features, nc);

% Step 5
displayclusters(img, my_clusters);

%displayclusters(img, kmeans(features, nc));
