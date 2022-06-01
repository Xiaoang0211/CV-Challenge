function percentage = img_percentage(img1)
%img_compare Summary of this function goes here
%   Function will operate the pixels in a block (e.g. of size 10*10).
%   The input images has nonzero entries,
%   where the pixel belong to the certain color mask
%   The number of the 'true' pixels will be counted for both images.
%   The percentage of 'true' pixels will be calculated for the block
%   output should be the difference between of the percentage from last
%   step.
    N = numel(img1);

    N1 = nnz(img1);
    
    percentage1 = N1/N;
end

