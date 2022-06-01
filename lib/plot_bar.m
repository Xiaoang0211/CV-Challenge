function b = plot_bar(masks,dates, names)
% This function will produce bar-diagram based on the output of the
% last function Color_Masks()
% The input is a cell array, which contains different color masks, where
% the entry of matrices are of type logical
% so that we can easily apply the MATLAB build-in function find()
% to determin how many pixels of a class(colors) are there 
% that we clustered from the last step.
% cell_img: the cell array of common part of compared images, whose first
% column are the corresponding dates.

    [k, num_img] = size(masks);
    %dates = datetime(dates, 'InputFormat', 'yyyy-MM');
    count = []; %count should have k rows, num_img columns
    % columns of variable count represent the compared images
    % rows of variable count represent the color masks of one image
    for i = 1:num_img
        for j = 1:k
            idx_entry = find(masks{j,i});
            [count_entry, ~] = size(idx_entry);
            count(i, j) = count_entry;
        end
    end
    count11 = count(1, 1:k);
    summe = sum(count11);
    
    % the datetime is set as the value of horizotal axis
    x = datetime(dates, 'InputFormat', 'yyyy-mm');
    
    % vertical axis values
    y = count./summe;
    y = roundn(y, -2);
    assignin('base','x',x);
    assignin('base','y',y);
    % plot the bar diagram
    fig11 = figure('Visible','off');
    b = bar(x, y);
    title(['Changes from the Year ', dates{1}, ' to Year ', dates{end}]);
    
    % showing the values of each bar on its top
    for i = 1:k
        xtips = b(i).XEndPoints;
        ytips = b(i).YEndPoints;
        labels = string(b(i).YData);
        text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
    end
        
    % legend of bar plot, to show the cluster name of each bar
    set(b, {'DisplayName'}, names');
    legend('Location',"bestoutside");
    oldfilename1 = [tempname(pwd), '.jpg'];
    saveas(fig11,oldfilename1,'jpg');
    assignin('base','oldfilename1',oldfilename1);
end

