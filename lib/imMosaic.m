function [imgout0,img1_same_area,img2_same_area,H] = imMosaic(img1,img2,varargin)
%[imgout0,img1_same_area,img2_same_area,H] = imMosaic( img1,img2,varargin )
%	img1 and img2 can (both) be rgb or gray, double or uint8.
%	If you have more than 2 images to do mosaic, call this function several
%	times.
%	If you set adjColor to 1, imMosaic will try to try to adjust the
%	color(for rgb) or grayscale(for gray image) of img1 linearly, so the 2 
%	images can join more naturally.
%   If H=ones(3,3) means matching failed 
% Speed     Select the ways(SURF/KAZE) to image registration.
% Speed     -"quick" Using SURF method, it is quick,but the accuracy is poor.
% Speed     -"slow" Using KAZE method, it is slow,but the accuracy is higher. 
% Tau       The threshold of finding feature points by SURF/KAZE method 
% thDist    The threshold of distance is used by ransac method to find Homography H
% thInlrRatio  The threshold of thInlrRatio is used by ransac method to find Homography H
% imgout0    The combination of img1 and img2
% img1_same_area   The same part of img1 between img1 and img2
% img2_same_area   The same part of img2 between img1 and img2
% H          The homography matrix H
%% input parameters
    P = inputParser;
    
    P.addOptional('Speed',"quick", @(x)isstring(x)); %quick or slow
    P.addOptional('Tau', 0.3, @(x)isnumeric(x)&&(x>0)&&(x<1)); 
    P.addOptional('thDist', 0.3, @(x)isnumeric(x)); 
    P.addOptional('thInlrRatio', 0.01, @(x)isnumeric(x)&&(x>0)&&(x<1)); 
    
    P.parse(varargin{:});
    
    Speed = P.Results.Speed;  %Mode quick or slow
    Tau = P.Results.Tau;
    thDist = P.Results.thDist;
    thInlrRatio=P.Results.thInlrRatio;
    

%% use SURF to find  quick
%
if Speed=="quick"
        IGray1 = rgb2gray(img1);
        IGray2 = rgb2gray(img2);
        %'MetricThreshold',100
        MetricThreshold_Standard=1000;
        MetricThreshold=MetricThreshold_Standard*Tau*2;
        points1 = detectSURFFeatures(IGray1,'MetricThreshold',MetricThreshold);
        points2 = detectSURFFeatures(IGray2,'MetricThreshold',MetricThreshold);

        [f1, vpts1] = extractFeatures(IGray1, points1,'FeatureSize',64); 
        [f2, vpts2] =extractFeatures(IGray2, points2,'FeatureSize',64);

        indexPairs = matchFeatures(f1, f2) ;
        matchedPoints1 = vpts1(indexPairs(:, 1));
        matchedPoints2 = vpts2(indexPairs(:, 2));

        matchLoc1=matchedPoints1.Location;
        matchLoc2=matchedPoints2.Location;

%% use KAZE to find  slow
elseif Speed=="slow"
        IGray1 = rgb2gray(img1);
        IGray2 = rgb2gray(img2);
        %'MetricThreshold',100 in surf
        Threshold_Standard=0.0001;
        Threshold=Threshold_Standard*Tau*2;
        
        points1 = detectKAZEFeatures(IGray1,'Threshold',Threshold);
        points2 = detectKAZEFeatures(IGray2,'Threshold',Threshold);
        %,'FeatureSize',64 in surf
        [f1, vpts1] = extractFeatures(IGray1, points1); 
        [f2, vpts2] =extractFeatures(IGray2, points2);

        indexPairs = matchFeatures(f1, f2) ;
        matchedPoints1 = vpts1(indexPairs(:, 1));
        matchedPoints2 = vpts2(indexPairs(:, 2));

        matchLoc1=matchedPoints1.Location;
        matchLoc2=matchedPoints2.Location;
end
%% use RANSAC to find homography matrix

[H,corrPtIdx] = findHomography(matchLoc2',matchLoc1',thDist,thInlrRatio);
%H  %#ok
    if H==ones(3,3)  %Means matching failed
       imgout0=img1; 
       img1_same_area(:,:,:)=0; 
       img2_same_area(:,:,:)=0; 
    else    %Means matching success
        try
        tform = maketform('projective',H');
        img21 = imtransform(img2,tform); % reproject img2

%% Finding the same matching area of images and adjust colors of images
        % adjust color or grayscale linearly, using corresponding infomation
        [M1,N1,dim] = size(img1);
        [M2,N2,~] = size(img2);
        adjColor=0;  %Never do the transform 
        if adjColor == 1
            radius = 2;
            x1ctrl = matchLoc1(corrPtIdx,1);
            y1ctrl = matchLoc1(corrPtIdx,2);
            x2ctrl = matchLoc2(corrPtIdx,1);
            y2ctrl = matchLoc2(corrPtIdx,2);
            ctrlLen = length(corrPtIdx);
            s1 = zeros(1,ctrlLen);
            s2 = zeros(1,ctrlLen);
            for color = 1:dim
                for p = 1:ctrlLen
                    left = round(max(1,x1ctrl(p)-radius));
                    right = round(min(N1,left+radius+1));
                    up = round(max(1,y1ctrl(p)-radius));
                    down = round(min(M1,up+radius+1));
                    % Take the chromaticity of the surrounding points
                    s1(p) = sum(sum(img1(up:down,left:right,color))); 
                end
                for p = 1:ctrlLen
                    left = round(max(1,x2ctrl(p)-radius));
                    right = round(min(N2,left+radius+1));
                    up = round(max(1,y2ctrl(p)-radius));
                    down = round(min(M2,up+radius+1));
                    s2(p) = sum(sum(img2(up:down,left:right,color)));
                end
                sc = (radius*2+1)^2*ctrlLen;
                adjcoef = polyfit(s1/sc,s2/sc,1);
                img1(:,:,color) = img1(:,:,color)*adjcoef(1)+adjcoef(2);
            end
        end

        % do the mosaic
        pt = zeros(3,4);
        pt(:,1) = H*[1;1;1];
        pt(:,2) = H*[N2;1;1];
        pt(:,3) = H*[N2;M2;1];
        pt(:,4) = H*[1;M2;1];
        x2 = pt(1,:)./pt(3,:);
        y2 = pt(2,:)./pt(3,:);

        up = round(min(y2));
        Yoffset = 0;
        if up <= 0
            Yoffset = -up+1;
            up = 1;
        end

        left = round(min(x2));
        Xoffset = 0;
        if left<=0
            Xoffset = -left+1;
            left = 1;
        end

        %Finding the same area of two images
        [M3,N3,~] = size(img21);
        imgout0(up:up+M3-1,left:left+N3-1,:) = img21;
        % img1 is above img21
        imgout0(Yoffset+1:Yoffset+M1,Xoffset+1:Xoffset+N1,:) = img1;

        imgout1(up:up+M3-1,left:left+N3-1,:) = img21;
        imgout1(Yoffset+1:Yoffset+M1,Xoffset+1:Xoffset+N1,:) = img1;
        % img21 is above img1
        imgout1(up:up+M3-1,left:left+N3-1,:) = img21;

        img_tem0=imgout0;
        img_tem0(:,:,:)=0;

        img_tem1=imgout1;
        img_tem1(:,:,:)=0;

        img_tem0(up:up+M3-1,left:left+N3-1,:) = img21;
        img21_pos=img_tem0;

        img_tem1(Yoffset+1:Yoffset+M1,Xoffset+1:Xoffset+N1,:) = img1;
        img1_pos=img_tem1;

        img2_rest_area=imgout0 -img1_pos;
        img2_same_area=img21_pos-img2_rest_area;

        [M4,N4,~] = size(img2_same_area);
        img1_same_area=img2_same_area;
        for i=1:M4
            for j=1:N4
                tem_sum=img2_same_area(i,j,1)+img2_same_area(i,j,2)+img2_same_area(i,j,3);
                if tem_sum>0
                img1_same_area(i,j,:)=imgout0(i,j,:);
                end
            end
        end
        %The new images is above the old images
        imgout0=imgout0-img1_same_area+img2_same_area;
               
%% Remove the black borders of the image
        row=size(img1_same_area,1);
        col=size(img1_same_area,2);  
        label=0;
        for i=1:row
            tem_sum=img1_same_area(i,:,1)+img1_same_area(i,:,2)+img1_same_area(i,:,3);        
            if tem_sum==zeros(1,size(img1_same_area,2))
               label(i)=i;
            end
        end
        img1_same_area(label>0,:,:)=[];
        label=0;
        for j=1:col
            tem_sum=img1_same_area(:,j,1)+img1_same_area(:,j,2)+img1_same_area(:,j,3);        
            if tem_sum==zeros(size(img1_same_area,1),1)
                 label(j)=j;
            end
        end
        img1_same_area(:,label>0,:)=[];
        label=0;
        row=size(img2_same_area,1);
        col=size(img2_same_area,2);        
        for i=1:row
            tem_sum=img2_same_area(i,:,1)+img2_same_area(i,:,2)+img2_same_area(i,:,3);        
            if tem_sum==zeros(1,size(img2_same_area,2))
                  label(i)=i;
            end
        end
        img2_same_area(label>0,:,:)=[];
        label=0;
        for j=1:col
            tem_sum=img2_same_area(:,j,1)+img2_same_area(:,j,2)+img2_same_area(:,j,3);        
            if tem_sum==zeros(size(img2_same_area,1),1)
                 label(j)=j;
            end
        end        
        img2_same_area(:,label>0,:)=[];
        
%% the catch means matching failed
        catch
        H=ones(3,3);  
        imgout0=img1; 
        img1_same_area(:,:,:)=0; 
        img2_same_area(:,:,:)=0; 
        end
    end
end

