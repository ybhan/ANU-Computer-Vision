% CLAB-4: Select points for estimating.
% By Jeff Yuanbo Han (u6617017), 2018-05-13.
img = imread('stereo2012d.jpg');

imshow(img);
display('click mouse for 6 features...')
uv = ginput(6); % Graphical user interface to get 12 points
display(uv);

XYZ = [ 7, 7, 0;
        0, 7, 7;
        7, 0, 7;
       14, 7, 0;
        0,14, 7;
        7, 0,14 ];
   
save d_points.mat img uv XYZ
