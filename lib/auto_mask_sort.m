function [masks, clusters] = auto_mask_sort(masks, clusters)
%This function sort the k clusters after the clustering is finished
%   in the output cell arrays, the most similar clusters are all aligned
%   in the same row of the cell arrays, which will be shown later through 
%   the function plot_rgb() in the same column. 
    [k, num] = size(clusters);
    avg_first_img = [];
    clusters_gray = cell(size(clusters));
    masks_gray = masks;
    
    % convert all images into gray scale
    for i = 1:num
        for j = 1:k
            cluster = clusters{j,i};
            cluster_gray = rgb2gray(cluster);
            clusters_gray{j,i} = cluster_gray;
        end
    end
    
    %for y = 1:k
    %    cluster_gray1 = clusters_gray{y,1};
    %    cluster_gray1 = cluster_gray1(cluster_gray1~=0);
    %    avg = mean(cluster_gray1);
    %    avg_first_img(y) = avg;
    %end

    for i = 2:num
        % the color masks from the previous year is set as
        % the new 'standard' for the correlation computation in every 
        % iteration, so that the changes over time
        % will not have negative influence on the result. 
        for y = 1:k
            cluster_gray1 = clusters_gray{y,i-1};
            cluster_gray1 = cluster_gray1(cluster_gray1~=0);
            avg = mean(cluster_gray1);
            avg_first_img(y) = avg;
        end
        
        for j = 1:k
            correlation = [];
            current_img = clusters_gray{j,i};
            current_img = current_img(current_img~=0);
            avg_img = mean(current_img);
            
            % correlation of mask j of image i to mask x = 1:k of image 1
            for x = 1:k               
                correlation(x) = abs(corr2(masks{x,i-1}, masks{j,i}));
            end
            
            corr_buffer = correlation;
            [~, sorted_idx] = sort(corr_buffer, 'descend');
            % the index of the first 2 largest correlations
            idx_max1 = sorted_idx(1);
            idx_max2 = sorted_idx(2);
            %idx_max3 = sorted_idx(3);
            
            % the entries for the swap funtion
            first_entry = i;
            second_entry = j;
            third_entry = idx_max1;
            
            % average intensities of non-zero(no black) pixels of the
            % first/second strong related color mask to the current image in 
            % the loop: cluster{k, num}
            avg1_max = avg_first_img(idx_max1);
            avg2_max = avg_first_img(idx_max2);
            %avg3_max = avg_first_img(idx_max3);
            

            diff1_max = abs(avg_img - avg1_max);
            diff2_max = abs(avg_img - avg2_max);
            %diff3_max = abs(avg_img - avg3_max);
            
            % If the strongest related color mask of the previous year
            % to cluster{k, num} is in the sense of intensity actually more 
            % different to cluster{k, num} than the second
            % strongest, the actual related color mask would probably be
            % the second strongest related color mask
            if diff1_max > diff2_max
                third_entry = idx_max2;
            end
            
            %if diff2_max > diff3_max
            %    third_entry = idx_max3;
            %end
            
            % Now switch the color mask, so that e.g. the cluster of white
            % color is aligned in the same column, when we use function
            % plot_rgb() and the subplot function to show all the color masks
            swap_hint = [first_entry, second_entry, third_entry];
            [masks, clusters] = swap(masks, clusters, swap_hint);
            [masks_gray, clusters_gray] = swap(masks_gray, clusters_gray, swap_hint);
        end
    end
end

