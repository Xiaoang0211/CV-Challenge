function im = plot_heatmap(img1, img1_log, img2_log, window_size, transparence, dates_container, user_input)
%Visualization with heat map
%   input 1: the first image choice (of an earlier datetime)
%   input 2: the logical matrix of the first image choice
%   input 3: the logical matrix of the second image choice
%   input 4: window size for computing percentage of change in this window
%   input 5: transparence of the heat map, which will overlay on img1

%   output: the resulted heat map overlaying on the first imge choice (of
%   an earlier datetime)

%   the larger the window size, the less misstake because of the wrong
%   correspondences or wrong clutsering will be less presented. However when
%   the user choose the window size smaller, the location of the changes
%   will be shown more precisely in the heat map.
    
    % function handle to compute the percentage of pixel of certain cluster
    % in an image (in function plot_heatmap() a given window)
    change = @(block_struct) img_percentage(block_struct.data);
    
    % computing the percentage of pixels of certain cluster in divided blocks
    % the block size is exactly the given window size
    splitted_img1 = blockproc(img1_log, window_size, change);
    splitted_img2 = blockproc(img2_log, window_size, change);
    % difference between two years
    diff = splitted_img1 - splitted_img2;

    %im1 = surf(diff);
    %shading interp
    %im1.AlphaData = .5;
    %hold on
    fig1 = figure('Visible','off');
    %img1 = rgb2gray(img1);
    imshow(img1);
    hold on
    
    %showing the heat map overlaying on img1
    im = imagesc(diff);
    cluster_name = user_input{1};
    cluster_name = cluster_name(1:end-1);
    title(['From Year ', dates_container(user_input{1}),  ' to Year ', dates_container(user_input{2}), ' : ', cluster_name]);
    
    %setting the transparence of the heat map for a better visualization
    im.AlphaData = transparence;
    colorbar('Ticks',[-30,0,20,60,100],...
             'TickLabels',{'increase',...
                           'neutral',...
                           'little decrease',...
                           'decrease',...
                           'large decrease'})
    %set(fig1, 'PaperPosition', [-0.75 0.2 26.5 26]);
    %set(fig1, 'PaperSize', [25 25]); 
    
    %  save the image to current folder, so that it can be imported and shown on
    %  the GUI.

    hold off
    oldfilename = [tempname(pwd), '.svg'];
    saveas(fig1,oldfilename,'svg');
    assignin('base','oldfilename',oldfilename);
end

