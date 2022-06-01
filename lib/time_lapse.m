function tl = time_lapse(img_common, dates, tempo)
%This function will output the time lapse for visualization
%   The user should input whether 'quick', 'middle' or 'slow' to determin
%   the tempo of image switching
%   by typing any letter on the keyboard, the loop will come to break
    length_cmp = length(img_common);
    count = 1;
    
    % tempo of the timelapse, determined by user
    switch tempo
        case 'quick'
            speed = 0.5;
        case 'middle'
            speed = 1;
        case 'slow'
            speed = 1.5;
    end
    
    % now showing the time lapse in a figure
    figure();
    while true
        tl = imshow(img_common{count,1});
        title(dates{count});
        hold on
        
        if count == length_cmp
            % the timelapse pause a little more after showing the last year
            pause(speed*2);
        else
            pause(speed);
        end
        
        count = count + 1;
        
        % if the count exceeds the number of images, it be be again set to 1
        % exactly like the beginning
        if count == length_cmp+1
            count = 1;
        end
        
        % the loop will come to end, when the user click on any
        % letter on his/her keyboard
        if isletter(get(gcf,'CurrentCharacter'))
            break;
        end
    end
    hold off
end

