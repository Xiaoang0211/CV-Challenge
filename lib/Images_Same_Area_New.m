function [I_out,n_matchings]=Images_Same_Area_New(I,varargin)
%[I_out,n_matchings]=Images_Same_Area_New(I,varargin)
%  Find the same area of the set of images.
%  It can accept any number of pictures to find common parts  
%I            The first column is the date the picture was taken, and the second column is the picture
%min_dist     The Picture size. The length of the picture=2*min_dist+1
%n_matchings  It is the number of matched pictures
%I_out        The first column is the date the picture was taken, and the second column is the same area that we find in pictures     
%% Preparation
I_out=cell(size(I));
n_matchings=0;

P = inputParser;
P.addOptional('min_dist',280,@(x)isnumeric(x)); 

P.parse(varargin{:});

min_dist = P.Results.min_dist;

%Using kaze method to identify images.
Speed="slow";
n=0;
%Make sure to how many pictures enter
for i=1:size(I,1)
    if isempty(I{i,2})==true
        n=i-1;
        break;
    elseif isempty(I{4,2})==false
        n=4;
        break;
    end
end

I_index=zeros(size(I,1)-1,1); 

I_index(1,1)=1;

%% Find the same area between images that can be matched
%Step 1: Finding the matching relationship between image1 and image2
%In order to improve the running speed of the program, 
%firstly we just try to find matching relationship between first and second images.
%If the matching fails, it means that there is no matching image in this group of images, 
%So the function ends.
if I_index(1,1)>0
    [~,img1_same_area,img2_same_area,H] = imMosaic(I{I_index(1,1),2},I{I_index(1,1)+1,2},'Speed',Speed);
    
   if size(img1_same_area,1)<2*min_dist
           disp('No matching images!');
   elseif size(img1_same_area,2)<2*min_dist
            disp('No matching images!');
   elseif H==ones(3,3)
       disp('No matching images!');
   else
        %The center of same area of images is choosed by user
        figure(1),imshow(img1_same_area)
        try
        rectangle('position',[min_dist,min_dist,size(img1_same_area,2)-2*min_dist,size(img1_same_area,1)-2*min_dist],'EdgeColor','r')
        %The center point must be in red zone
        disp('The point must be in red zone');
        catch
        end        
        disp('choose you point as the center of analyze area');
        [xi,yi] = getpts(figure(1));
        xi=round(xi);
        yi=round(yi);

        img1_same_area=cake(min_dist,img1_same_area,yi,xi);
        img2_same_area=cake(min_dist,img2_same_area,yi,xi);
        I_out{I_index(1,1),2}=img1_same_area;
        I_out{I_index(1,1)+1,2}=img2_same_area;
        I_out{1,1}=I{1,1};
        I_out{I_index(1,1)+1,1}=I{I_index(1,1)+1,1};
        n_matchings=2;
   end
%Step 2: Finding the matching relationship of the remaining pictures
    for i=2:n-1
      
        [~,img1_same_area,img2_same_area,~] = imMosaic(I_out{i,2},I{i+1,2},'Speed',Speed);
        if size(img1_same_area,1)<2*min_dist
              break;
        elseif size(img1_same_area,2)<2*min_dist
              break;     
        else            
            I_out{i,2}=img1_same_area;
            I_out{i+1,2}=img2_same_area;
            %It gets the number of matched pictures
            n_matchings=i+1;  
            % Give date to the I_out
            I_out{i,1}=I{i,1};   
            I_out{i+1,1}=I{i+1,1};  
        end
    end
else
     n_matchings=0;
     disp('No matching images!');
end

%% Remove the black borders of the image
% This part will slow down the running speed of the program, so it will not be executed

% for i=1:n_matchings
%         img1_same_area=I_out{i,2};
%         row=size(img1_same_area,1);
%         col=size(img1_same_area,2);  
%         label=0;
%         for j=1:row
%             tem_sum=img1_same_area(j,:,1)+img1_same_area(j,:,2)+img1_same_area(j,:,3);        
%             if tem_sum==zeros(1,size(img1_same_area,2))
% %                img1_same_area(i,:,:)=[];
% %                row=row-1;
%                label(j)=j;
%             end
%         end
%         img1_same_area(label>0,:,:)=[];
%         label=0;
%         for k=1:col
%             tem_sum=img1_same_area(:,k,1)+img1_same_area(:,k,2)+img1_same_area(:,k,3);        
%             if tem_sum==zeros(size(img1_same_area,1),1)
% %                img1_same_area(:,j,:)=[];
% %                col=col-1;
%                  label(k)=j;
%             end
%         end
%         img1_same_area(:,label>0,:)=[];
%         label=0;
%         I_out{i,2}=img1_same_area;
% end 

%% Make sure that the area of the images in the Picture_size area is same
for i=1:n_matchings
    % Indicates that there are images in I_out
    if size(I_out{i,2},1)>0  
        Image_tem=I_out{i,2}; 
        for j=1:size(Image_tem,1)
            for k=1:size(Image_tem,2)
                tem_rgb=Image_tem(j,k,1)+Image_tem(j,k,2)+Image_tem(j,k,3);
                % Means that this is pure black
                if tem_rgb==0 
                    for L=1:n_matchings
                    Image_set=I_out{L,2};
                    Image_set(j,k,:)=zeros(3,1);
                    I_out{L,2}=Image_set;
                    end
                end
            end
        end     
    else
        break;
    end 
end



end