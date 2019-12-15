% By Jeff Yuanbo Han (u6617017), 2018-04-26.
load train_data;

%% Compute eigenvalues and eigenvectors
m = size(Phi, 2);
% Consider Phi'*Phi/m instead, for computational feasibility.
[V, D] = eig(Phi'*Phi/m);
% Derive eigenvectors of Phi*Phi'/m
V = Phi * V;
% Sort them in an ascending order
[lambda, order] = sort(diag(D),'descend');
V = V(:, order);
% Normalization
for i = 1:m
    V(:,i) = V(:,i) ./ norm(V(:,i));
end

save train_data.mat lambda V -append

%% Choose k and plot eigenfaces
k = 10;
fprintf('k = %d, PCA preserves %.2f%% information.\n',...
    k, 100*sum(lambda(1:k))/sum(lambda));

% Combine eigenfaces together
nTileCol = 5;
nTileRow = ceil(k/nTileCol);
Y = zeros(height*nTileRow, width*nTileCol); % to store all images
for j = 1:k
    row = ceil(j/nTileCol);
    col = j - nTileCol*(row-1);
    Y((row-1)*height+1:row*height, (col-1)*width+1:col*width) =...
        reshape(V(:,j), [height,width]);
end

figure; imagesc(Y);
colormap(gray); axis off;
title(['Top ',num2str(k),' eigenfaces'], 'FontSize', 16);
