function [imgout1_highlights,imgout2_highlights,change_map] = PCA_Highlights(img1,img2,varargin)
%% [imgout1_highlights,imgout2_highlights,change_map] = PCA_Highlights(img1,img2,varargin)
%	Find the highlights between two imgase.
%	Using the function imMosaic() to find the same area of two images 
%   The images need to be subtracted from each other, and we use PCA method to find highlights of images
%	Analyze the highlights of the same area by binarization method
% Speed     Select the ways(SURF/KAZE) to image registration.
% Speed     -"quick" Using SURF method, it is quick,but the accuracy is poor.
% Speed     -"slow" Using KAZE method, it is slow,but the accuracy is higher.      
% Tau_Area  The smallest highlights area in the sum of area. 
% Thresh    The binarization threshold value
% min_dist  The radius of the centroid
% imgout1_highlights The highlights of img1
% imgout2_highlights The highlights of img2
% change_map         Binarized highlight map 
%% Parameter prepration
rate=0.9;
block_size=4;

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
    %Finding the same matching area of images
[~,im1,im2,H] = imMosaic(img1,img2,'Speed',Speed,'Tau',0.3,'thDist',0.3,'thInlrRatio',0.01); 
        %The images are not matching!
        if H==ones(3,3)
            disp('Matching error!');
            imgout1_highlights(:,:,:)=0;
            imgout2_highlights(:,:,:)=0;
            change_map(:,:)=0;
        else
%% set the proportion of the Pricipal Components;
if nargin <= 3
    rate=0.9;
end

%% calculate the image_size and padding_size;
image_size = size(im1);
padding_size = image_size + block_size;
padding_size(3) = padding_size(3) - block_size;

%% calculate the difference image;
delta = abs(double(im1)-double(im2));

%% padding
padding_img = zeros(padding_size);
lb = ceil(block_size/2);
ub_col = lb+image_size(1)-1;
ub_row = lb+image_size(2)-1;
padding_img(lb:ub_col,lb:ub_row,:)=delta;

%% generate feature vector for blocks;
vk = zeros(prod(image_size(1:2)),image_size(3)*block_size*block_size);
cnt=1;
for k1=1:image_size(1)
    for k2=1:image_size(2)
        vk_temp = padding_img(k1:k1+block_size-1,k2:k2+block_size-1,:);
        vk(cnt,:)=reshape(vk_temp,[],1);
        cnt=cnt+1;
    end
end
clear cnt;

%% normlization
mean_val = mean(vk);
std_val = std(vk)+1e-12;
num = size(vk,1);
vk = (vk-repmat(mean_val,num,1))./repmat(std_val,num,1);

%% PCA
cov = vk' * vk;
[V,D]=eig(cov);
val=diag(D);
for k1=length(val):-1:1
    if(sum(val(k1:length(val)))>=rate*sum(val))
        break;
    end
end
vec=V(:,k1:length(val));
feature=vk * vec;
% [M,index]=max(feature(1,:));
% feature(1,:);
%% kmeans
 [label,~]=kmeans(feature,2);
change_map=reshape(label,image_size([2,1]));
change_map=change_map'-1;

%Image binarization
%Thresh is binarization tau

BW = im2bw(change_map,thresh); 

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
change_map=A1;
%Find the highlights on the img1,img2
imgout1_highlights=im1.*tem;
imgout2_highlights=im2.*tem;
        end
end
