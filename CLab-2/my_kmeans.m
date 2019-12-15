function [data_clusters, cluster_stats] = my_kmeans(data, nc)
% Performs k-means clustering on data, given (nc) = the number of clusters.
% Euclidean distance is used in this function.

% Random Initialization
[ndata, ndims] = size(data);

random_labels = floor(rand(ndata,1) * nc) + 1;

data_clusters = random_labels;

cluster_stats = zeros(nc,ndims+1);

distances = zeros(ndata,1);  % Distance to the assigned cluster center.

while(1)
    pause(0.03);
    
    % Make a copy of cluster statistics for comparison purposes.
    % If the difference is very small, the while loop will exit.
    last_clusters = cluster_stats;
    
    % For each cluster,
    for c = 1:nc
        % Find all data points assigned to this cluster.
        [ind] = find(data_clusters == c);
        num_assigned = size(ind,1);
        
        % Some heuristic codes for exception handling.
        if( num_assigned < 1 )
            disp(['No points were assigned to this cluster,'...
                ' some special processing is given below.']);
            
            % Calculate the maximum distances from each cluster.
            max_distances = max(distances);
            
            [~, cluster_num] = max(max_distances);
            [~, data_point] = max(distances(:,cluster_num));
            
            data_clusters(data_point) = cluster_num;
            
            ind = data_point;
            num_assigned = 1;
        end   %% End of exception handling.
        
        % Save number of points per cluster, plus the mean vectors.
        cluster_stats(c,1) = num_assigned;
        if( num_assigned > 1 )
            summ = sum(data(ind,:));
            cluster_stats(c,2:ndims+1) = summ / num_assigned;
        else
            cluster_stats(c,2:ndims+1) = data(ind,:);
        end
        
    end
    
    % Exit criteria
    diff = sum(abs(cluster_stats(:) - last_clusters(:)));
    if( diff < 0.00001 )
        break;
    end
    
    % Assign each point to the nearest cluster center,
    % and thus update distances and data_clusters.
    [distances, data_clusters] = ...
        min(dist(data, cluster_stats(:, 2:ndims+1)'), [], 2);
    
    % Display clusters for the purpose of debugging.
    cluster_stats
    %pause;
end
