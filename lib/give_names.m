function names_out = give_names(names, k, num_img)
%Constructing the name array
%   the variable names is an array of strings, whose size should be k*1, 
%   e.g. names = ['city', 'beach', 'sea']
%   where k is the given number of user, which indicates the number of 
%   clusters that the user wants to have.
%   names_out should be an array of size k * num_img
    names_out = cell(k, num_img);
    for i = 1:num_img
        for j = 1:k
            names_out{j, i} = [names{j}, num2str(i)];
        end
    end      
end

