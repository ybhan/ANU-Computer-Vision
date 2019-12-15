% By Jeff Yuanbo Han (u6617017), 2018-04-24.
%% Read all the 145 face images
imgPath_train = 'yalefaces/trainingset/';
imgDir_train = dir(imgPath_train);
imgPath_test = 'yalefaces/testset/';
imgDir_test = dir(imgPath_test);

m = 135;  % Total number of training images
n = 10;   % Total number of test images
img = cell(m+n,1);
for i = 1:m
    img{i} = imread([imgPath_train imgDir_train(i+2).name]);
end
for i = m+1:m+n
    img{i} = imread([imgPath_test imgDir_test(i-m+2).name]);
end

%% Viola-Jones Face Detection
faceDetector = vision.CascadeObjectDetector;  % Default: finds faces

% Window size after cropping
width = 200;
height = 230;

% Phi matrix (columns are the training vectors)
Phi = repmat(255, [width*height, m]);

for i = 1:m+n
    bboxes = step(faceDetector, img{i});  % Detect the face
    
    bboxes(1) = bboxes(1) - 30;
    bboxes(2) = 10;
    bboxes(3:4) = [width-1, height-1];
    
    % Crop the image
    img{i} = imcrop(img{i}, bboxes);
    
    % Construct Phi matrix
    if i <= m
        [row, col] = size(img{i});
        Phi(1:row*col, i) = img{i}(:);
    end
end

X_bar = mean(Phi, 2);
Phi = Phi - repmat(X_bar, [1,m]);

%% Save images and data
newDir_train = 'yalefaces/trainingset_new';
mkdir(newDir_train);
newDir_test = 'yalefaces/testset_new';
mkdir(newDir_test);
for i = 1:m
    imwrite(img{i}, [newDir_train '/' imgDir_train(i+2).name], 'PNG');
end
for i = m+1:m+n
    imwrite(img{i}, [newDir_test '/' imgDir_test(i-m+2).name], 'PNG');
end

save train_data.mat img Phi X_bar width height
