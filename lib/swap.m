function [masks, clusters] = swap(masks, clusters, swap_hint)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   e.g. for swap_hint = [1, 1, 2]; 
%   first entry: row
%   second & third entry: the columns to swap
    swap_masks = masks(:, swap_hint(1));
    swap_clusters = clusters(:, swap_hint(1));
    
    swap_mask = swap_masks{swap_hint(2)};
    swap_masks{swap_hint(2)} = swap_masks{swap_hint(3)};
    swap_masks{swap_hint(3)} = swap_mask;
    masks(:, swap_hint(1)) = swap_masks;
    
    swap_cluster = swap_clusters{swap_hint(2)};
    swap_clusters{swap_hint(2)} = swap_clusters{swap_hint(3)};
    swap_clusters{swap_hint(3)} = swap_cluster;
    clusters(:, swap_hint(1)) = swap_clusters;
end

