function plot_rgb(clusters)
%Plot the clusters in subplots
%   the subplots will be created in this function, which shows the clusters
%   of the same area from different years
%   inputs:
%   clusters: containing the image (color) clusters from different years 
    [k, num_compared_img] = size(clusters);
    figure();
    for i = 1:num_compared_img
         for j = 1:k
                cluster = clusters{j, i};
                % generating subplot of suitable size as given through the
                % size of the cell array clusters
                subplot(num_compared_img,k,j + k*(i - 1));
                imshow(cluster);
                % adding title to subplot
                title(['Cluster ', num2str(j), ' of image ', num2str(i)]);
         end
    end
end

