function [masks, clusters] = color_masks_rgb(cell_img_common, k, iteration)
%% Input of this function
% This function takes the common part of two images as input
% In this function, k-means clustering will be applied in order to 
% extract the color information of the common part
% The possible input for the users on the interface are following:
% 1) the number of colors: user can change their decision if the
%    initial estimation was not sucessful enough
%    Also optional for the user: is there light and deep color that
%    are necessarily to be distinguished from each other?
%
%% Output of this function
%  Output of this function is the percentage of each color in the common
%  part of the two images
%  options for the visualization: 
%  plot of histogramm or the time lapse
%  user can choose through the interface, which visualization they want
%% function body
    % cell array which contains the all the color masks
    % first column the masks of the first image
    % second column the masks of the second image etc.
    num_compared_img = numel(cell_img_common);
    
    % cell array which contains the all the color masks
    % first column the masks of the first image
    % second column the masks of the second image etc.
    masks = cell(k,num_compared_img);
    clusters = cell(k,1);
    %fig1 = figure('Visible', 'off');
    %fig1 = figure();
    for i = 1:num_compared_img
        img_same_area = cell_img_common{i};
        same_masks = imsegkmeans(img_same_area, k, 'NumAttempts', iteration);
        %same_masks = imsegkmeans(img_same_area,k,'NormalizeInput',true);
        for j = 1:k
            masks{j, i} = same_masks == j;
            cluster = cell_img_common{i} .* uint8(masks{j, i});
            clusters{j, i} = cluster;
            %subplot(num_compared_img,k,j + k*(i - 1));
            %imshow(cluster);
            %title(['Cluster ', num2str(j), ' of image ', num2str(i)]);
        end
    end
    % the k clusters may not appear exactly in the same column, therefore
    % we apply the function auto_mask_sort() to do the alignment
    [masks, clusters] = auto_mask_sort(masks, clusters);
    fig1 = figure('Visible','off');
    plot_rgb(clusters);
    % display the k*num_compared_img color masks to let the user name all
    % the clusters.
    saveas(fig1,'color_masks.png','png');
end

