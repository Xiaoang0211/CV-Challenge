function [Mask_Container, img_container, dates_container] = construct_containers(cell_mask, cell_img, dates, names)
%Conastructing mask and image containers
%
%   names: matrix of string, which contains the names of the layers
%   size of name: determined by the input of user:
%   when the user decided, how many clusters and compared images he wants
%   to have:
%   #rows: number of clusters
%   #columns: number of compared images
    [k, num_img] = size(names);
    Mask_Container = containers.Map;
    img_container = containers.Map;
    dates_container = containers.Map;
    for i = 1:num_img
        for j = 1:k
            Mask_Container(names{j,i}) = cell_mask{j,i};
            img_container(names{j,i}) = cell_img{j,i};
            dates_container(names{j, i}) = dates{i, 1};
        end
    end
end

