function img_circle_area = cake(min_dist,img,x,y)
% According to the position marked by the user on the map, determine the common part to be found.
% This function is used by Images_Same_Area_New.m
% It helps us identify the common parts on the image
% x,y              The center of the common part
% min_dist         The length of the common part
% img              Input data of image
% img_circle_area  The common part of image
    Cake=ones(2*min_dist+1);
    Centre_Point_x=min_dist+1;
    Centre_Point_y=min_dist+1;
    for i=1:2*min_dist+1
        for j=1:2*min_dist+1
            Distance=sqrt((i-Centre_Point_x)^2+(j-Centre_Point_y)^2);
            if Distance<min_dist
                Cake(i,j)=1;
            end
        end
    end
    Cake=uint8(Cake);
    img_circle_area=img(x-min_dist:x+min_dist,y-min_dist:y+min_dist,:).*Cake;
    
end