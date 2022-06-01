function [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,varargin)
%[imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,varargin)
%	Find the highlights between two imgase.
%	Using the function imMosaic() to find the same area of two images 
%   The images just need to be subtracted from each other, and we add the two difference value.
%	Analyze the highlights of the same area by binarization method
% Speed     Select the ways(SURF/KAZE) to image registration.
% Speed     -"quick" Using SURF method, it is quick,but the accuracy is poor.
% Speed     -"slow" Using KAZE method, it is slow,but the accuracy is higher.      
% Tau_Area  The smallest highlights area in the sum of area. 
% Thresh    The binarization threshold value
% min_dist  The radius of the centroid
%imgout1_highlights The highlights of img1
%imgout2_highlights The highlights of img2
%A1         Binarized highlight map 
%% Preparation
    P = inputParser;
    
    P.addOptional('Speed',"quick", @(x)isstring(x));
    P.addOptional('Tau_Area', 0.01, @(x)isnumeric(x)&&(x>0)&&(x<1)); 
    P.addOptional('thresh',0.3,@(x)isnumeric(x)&&(x>0)&&(x<1));
    P.addOptional('min_dist',150,@(x)isnumeric(x));

    P.parse(varargin{:});
    
    Speed = P.Results.Speed;  %Mode quick or slow
    Tau_Area = P.Results.Tau_Area;
    thresh = P.Results.thresh;
    min_dist=P.Results.min_dist;
%% Finding the same matching area of images
[~,img1_same_area,img2_same_area,H] = imMosaic(img2,img1,'Speed',Speed,'Tau',0.3,'thDist',0.3,'thInlrRatio',0.01);

        %The images are not matching!
        if H==ones(3,3) 
            disp('Matching error!');
            imgout1_highlights(:,:,:)=0;
            imgout2_highlights(:,:,:)=0;
            A1=0;
        else
%% Finding the highlights of the same area images
            %In order to avoid loss of information,
            %The images need to be subtracted from each other.
            %And we add the two difference value.
            I_sub=imsubtract(img1_same_area,img2_same_area);
            I_sub2=imsubtract(img2_same_area,img1_same_area);
            I_sub_result=imadd(I_sub,I_sub2);
            
            %Adjust image contrast to improve recognition accuracy
            g=imadjust(I_sub_result,[0.2 0.6], [0 1],0.5);
            I1=g(:,:,1);
            I2=g(:,:,2);
            I3=g(:,:,3);
            %Filtering to eliminate error points
            Y1=ordfilt2(I1,5,ones(3,3));
            Y2=ordfilt2(I2,5,ones(3,3));
            Y3=ordfilt2(I3,5,ones(3,3));
            Z(:,:,1)=Y1;
            Z(:,:,2)=Y2;
            Z(:,:,3)=Y3;
            %Image binarization
            %Thresh is binarization tau
            BW = im2bw(Z,thresh); 

            figure('Visible','off'),imshow(BW) 
            %Tau_Area means the smallest highlights area in the sum of area. 
            set_area=round(Tau_Area*size(BW,1)*size(BW,2));%set_area=total area*threshold area
            % Delete objects in the binary image whose pixels are smaller than the area of the set_area area
            BWA= bwareaopen(BW,set_area);
            %Binary area expansion
            A1= imdilate(BWA,strel('disk',6));
            %Find the centroid of the binary region
            s = regionprops(A1,'centroid'); 
            centroids = cat(1,s.Centroid);
            centroids=centroids';
            %Take centroid of the center of the circle.
            %The radius of the circle is min_dist.
            %So the inside is Highlights
            for  i=1:size(centroids,2)
                for j=1:size(A1,1)
                    for k=1:size(A1,2)               
                        Distance=sqrt((k-centroids(1,i))^2+(j-centroids(2,i))^2);
                        if Distance<min_dist
                           A1(j,k)=true;
                        end
                    end
                end
            end

            tem=uint8(A1);
            %Find the highlights on the img1,img2
            imgout1_highlights=img1_same_area.*tem;
            imgout2_highlights=img2_same_area.*tem;
        end

end