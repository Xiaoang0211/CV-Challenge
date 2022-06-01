function [dates, img_common] = construct_dates_common(I_out)
%Splitting the cell array from the input: I_out
%   Because we will use the dates and image content separatly in different
%   functions, in this function, the cell array will be splitted into two
%   arrays
%   outputs:
%   dates: containing the date of the corresponding images
%   img_common: cell array of images, which show the common part of a
%               location from different years
    dates = I_out(:,1);
    img_common = I_out(:,2);
end

