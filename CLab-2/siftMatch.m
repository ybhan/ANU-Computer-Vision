% By Jeff Yuanbo Han (u6617017), 2018-04-03.

[img1, dcp1, loc1] = sift('images/photo1.png');
[img2, dcp2, loc2] = sift('images/photo3.png');

% Find matched feature points.
r = 0.6;
distance = dist(dcp1, dcp2');
[sorted_dist, idx] = sort(distance, 2);
i = find(sorted_dist(:,1) < r*sorted_dist(:,2));
j = idx(i,1);
match1 = [loc1(i,1), loc1(i,2)];
match2 = [loc2(j,1), loc2(j,2)+size(img1,2)];

% Concatenate img1 and img2 as common_img.
common_img = appendimages(img1, img2);

% Display common_img, and draw lines connecting the matched SIFT feature
% points.
figure;
imshow(common_img);
hold on;
for m = 1:min(size(i),15)
    line([match1(m,2),match2(m,2)], [match1(m,1),match2(m,1)]);
end
