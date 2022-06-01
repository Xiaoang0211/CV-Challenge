classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        SelectPicturesDropDownLabel    matlab.ui.control.Label
        SelectPicturesDropDown         matlab.ui.control.DropDown
        Image                          matlab.ui.control.Image
        Image2                         matlab.ui.control.Image
        Button                         matlab.ui.control.Button
        Image3                         matlab.ui.control.Image
        Image4                         matlab.ui.control.Image
        Image8                         matlab.ui.control.Image
        Image7                         matlab.ui.control.Image
        Image6                         matlab.ui.control.Image
        Image5                         matlab.ui.control.Image
        ChoosetheimagesLabel           matlab.ui.control.Label
        Button_5                       matlab.ui.control.Button
        Button_6                       matlab.ui.control.Button
        Image15                        matlab.ui.control.Image
        Label                          matlab.ui.control.Label
        Label_2                        matlab.ui.control.Label
        Label_3                        matlab.ui.control.Label
        Label_4                        matlab.ui.control.Label
        Label_5                        matlab.ui.control.Label
        Label_6                        matlab.ui.control.Label
        Label_7                        matlab.ui.control.Label
        Label_8                        matlab.ui.control.Label
        Label_9                        matlab.ui.control.Label
        imagesoverviewLabel            matlab.ui.control.Label
        Label_10                       matlab.ui.control.Label
        Label_12                       matlab.ui.control.Label
        ZuchengHanXuYanJianTianLabel   matlab.ui.control.Label
        G24HuiyuWangXiaoangZhangLabel  matlab.ui.control.Label
        ReadmeButton                   matlab.ui.control.Button
        CenterPanel                    matlab.ui.container.Panel
        choosefourpictureswhichyouwanttocompareLabel  matlab.ui.control.Label
        Image9                         matlab.ui.control.Image
        thecommonpartsareasfollows_Label  matlab.ui.control.Label
        ImpactofhumanactivitiesLabel   matlab.ui.control.Label
        onthelandscapefromaboveLabel   matlab.ui.control.Label
        Image9_2                       matlab.ui.control.Image
        Image9_3                       matlab.ui.control.Image
        Image9_4                       matlab.ui.control.Image
        Image13                        matlab.ui.control.Image
        Image13_2                      matlab.ui.control.Image
        Image13_3                      matlab.ui.control.Image
        Image13_4                      matlab.ui.control.Image
        choosetwopicstoshowHighlights_Label  matlab.ui.control.Label
        pic1Label                      matlab.ui.control.Label
        pic2Label                      matlab.ui.control.Label
        pic3Label                      matlab.ui.control.Label
        pic4Label                      matlab.ui.control.Label
        SelectPicturesDropDown_2       matlab.ui.control.DropDown
        SelectPicturesDropDown_3       matlab.ui.control.DropDown
        readyandStartButton            matlab.ui.control.Button
        ParametersPanel                matlab.ui.container.Panel
        AdjusttheValueThreesholdtoshowthehighlightEditField_4  matlab.ui.control.NumericEditField
        AdjusttheValueThreesholdtoshowthehighlightEditField_5  matlab.ui.control.NumericEditField
        AdjusttheValueThreesholdtoshowthehighlightEditField_6  matlab.ui.control.NumericEditField
        SelectPicturesDropDown_5       matlab.ui.control.DropDown
        Tau_AreaLabel                  matlab.ui.control.Label
        threshLabel                    matlab.ui.control.Label
        min_distLabel                  matlab.ui.control.Label
        tempoLabel                     matlab.ui.control.Label
        startButton                    matlab.ui.control.Button
        Label_13                       matlab.ui.control.Label
        HighlightsVisualizationLabel   matlab.ui.control.Label
        UIAxes_4                       matlab.ui.control.UIAxes
        RightPanel                     matlab.ui.container.Panel
        largesmallModeHeatmapPanel     matlab.ui.container.Panel
        choose2picsinthesameclusterEditField_2  matlab.ui.control.EditField
        choose2picsinthesameclusterEditField_3  matlab.ui.control.EditField
        choosetwopicturestodrawtheHeatmapLabel  matlab.ui.control.Label
        Button_3                       matlab.ui.control.Button
        choosewindowsizeandtransparenceLabel  matlab.ui.control.Label
        AdjusttheValueThreesholdtoshowthehighlightEditField_2  matlab.ui.control.NumericEditField
        AdjusttheValueThreesholdtoshowthehighlightEditField_3  matlab.ui.control.NumericEditField
        KmeansClusteringLabel          matlab.ui.control.Label
        PleasechoosethenumberofClustersandIterationonlyIntegerPanel  matlab.ui.container.Panel
        ClusterEditFieldLabel          matlab.ui.control.Label
        ClusterEditField               matlab.ui.control.NumericEditField
        IterationEditFieldLabel        matlab.ui.control.Label
        IterationEditField             matlab.ui.control.NumericEditField
        readyandStartButton_2          matlab.ui.control.Button
        ChangetheorderButton           matlab.ui.control.Button
        VisualizationModeLabel         matlab.ui.control.Label
        Image14                        matlab.ui.control.Image
        slowModebarMapPanel            matlab.ui.container.Panel
        Button_4                       matlab.ui.control.Button
        ListBox                        matlab.ui.control.ListBox
        pleasegivenamestoeachcluster_Panel  matlab.ui.container.Panel
        fromlefttorightEditFieldLabel  matlab.ui.control.Label
        fromlefttorightEditField       matlab.ui.control.EditField
        Button_2                       matlab.ui.control.Button
        Label_11                       matlab.ui.control.Label
        TimeLapsePanel                 matlab.ui.container.Panel
        Button_7                       matlab.ui.control.Button
        SelectPicturesDropDown_4       matlab.ui.control.DropDown
        selectTempoLabel               matlab.ui.control.Label
        ResetButton                    matlab.ui.control.Button
        UIAxes_3                       matlab.ui.control.UIAxes
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end


    properties (Access = private)
        Dialogapp % Description
        row=1;
        col1=1;
        col2=2;
    end

    methods (Access = private)

        % Description
        function startupFcn(app)
            % Call updateplot to display an initial plot
            app.largesmallModeHeatmapPanel.Visible='off';
            app.slowModebarMapPanel.Visible='off';
            app.TimeLapsePanel.Visible='off';
            addpath(genpath('Datasets/'));
            addpath(genpath('lib/'));
        end

        % Close request function: UIFigure
        function MainAppCloseRequest(app, event)
            % Delete both apps
            delete(DialogAppExample1)
            delete(app)
        end
    end

    methods (Access = public)

        function updateplot(app,row,col1,col2)
            %from subapp to get the parameters
            masks=evalin('base','masks');
            clusters=evalin('base','clusters');
            [masks, clusters] = swap(masks, clusters, [row, col1, col2]);
            plot_rgb(clusters);
            assignin('base','masks',masks);
            assignin('base','clusters',clusters);
            % Re-enable the Plot Options button
            app.ChangetheorderButton.Enable = 'on';
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn2(app)
            addpath(genpath('Datasets/'));
            addpath(genpath('lib/'));
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {776, 776, 776};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {776, 776};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {238, '1x', 393};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            app.Label.Text='';
            app.Label_2.Text='';
            app.Label_3.Text='';
            app.Label_4.Text='';
            app.Label_5.Text='';
            app.Label_6.Text='';
            app.Label_7.Text='';
            app.Label_8.Text='';
%             delete('NewHeatMap.svg');
%             delete('*.svg');
            app.Image9.ImageSource='1.jpg';
            app.Image9_2.ImageSource='1.jpg';
            app.Image9_3.ImageSource='1.jpg';
            app.Image9_4.ImageSource='1.jpg';
            %app.detailedNode.Text=app.Image.ImageSource;
            q=app.ClusterEditField.Value;
            assignin('base','variable',q);
            var=app.SelectPicturesDropDown.Value;
            imgPath1 = 'Dataset/Columbia Glacier/'; % the path of the images
            imgDir1 = dir([imgPath1 '*.jpg']); % list of all jpg in this Path


            img=cell(length(imgDir1),2);
            folder=cell(length(imgDir1),1);
            for i = 1:length(imgDir1) % to change the structure of the images
                img{i,2} = imread([imgPath1 imgDir1(i).name]); %save the images
                img{i,1} = imgDir1(i).name; %save the names
                folder{i}=append(imgDir1(i).folder,"/",imgDir1(i).name);%save the paths
            end
            for i=1:size(img,1)
                tem=img{i,1};
                tem=extractBefore(tem,".jpg");
                tem = strrep(tem,'_','-');
                img{i,1}=tem;%get the date from img names
            end
            app.Image.Visible="on";
            app.Image2.Visible="on";
            app.Image3.Visible="on";
            app.Image4.Visible="on";
            app.Image5.Visible="on";
            app.Image6.Visible="on";
            app.Image7.Visible="on";
            app.Image8.Visible="on";
            %do the same thing like above
            switch var
                case 'Yangtse'
                    imgPath1 = 'Datasets/Yangtse/'; 
                    imgDir1 = dir([imgPath1 '*.jpg']); 

                    folder=cell(length(imgDir1),1);
                    img=cell(length(imgDir1),2);
                    for i = 1:length(imgDir1) 
                        img{i,2} = imread([imgPath1 imgDir1(i).name]); 
                        img{i,1} = imgDir1(i).name; 
                        folder{i}=append(imgDir1(i).folder,"/",imgDir1(i).name);
                    end
                    assignin('base',"folder",folder);
                    for i=1:size(img,1)
                        tem=img{i,1};
                        tem=extractBefore(tem,".jpg");
                        tem = strrep(tem,'_','-');
                        img{i,1}=tem;
                    end

                    app.Image.ImageSource = folder{1};
                    app.Image2.ImageSource = folder{2};
                    app.Image3.ImageSource = folder{3};
                    app.Image4.ImageSource = folder{4};
                    app.Image5.ImageSource = folder{5};
                    app.Image6.ImageSource = folder{6};
                    app.Image7.ImageSource = folder{7};
                    app.Image8.ImageSource = folder{8};
                    app.Label.Text=img{1,1};
                    app.Label_2.Text=img{2,1};
                    app.Label_3.Text=img{3,1};
                    app.Label_4.Text=img{4,1};
                    app.Label_5.Text=img{5,1};
                    app.Label_6.Text=img{6,1};
                    app.Label_7.Text=img{7,1};
                    app.Label_8.Text=img{8,1};
                    app.Image15.ImageSource=app.Image.ImageSource;
                    app.Label_9.Text=img{1,1};
                    m=8;
                case 'Glacier'%do the same thing like above
                    imgPath1 = 'Datasets/Columbia Glacier/'; 
                    imgDir1 = dir([imgPath1 '*.jpg']); 
                    folder=cell(length(imgDir1),1);

                    img=cell(length(imgDir1),2);
                    for i = 1:length(imgDir1) 
                        img{i,2} = imread([imgPath1 imgDir1(i).name]);
                        img{i,1} = imgDir1(i).name;
                        folder{i}=append(imgDir1(i).folder,"/",imgDir1(i).name);
                    end
                    for i=1:size(img,1)
                        tem=img{i,1};
                        tem=extractBefore(tem,".jpg");
                        tem = strrep(tem,'_','-');
                        img{i,1}=tem;
                    end

                    app.Image.ImageSource = folder{1};
                    app.Image2.ImageSource = folder{2};
                    app.Image3.ImageSource = folder{3};
                    app.Image4.ImageSource = folder{4};
                    app.Image5.ImageSource = folder{5};
                    app.Image6.ImageSource = folder{6};
                    app.Image7.ImageSource = folder{7};
                    app.Image8.ImageSource = folder{8};
                    app.Label.Text=img{1,1};
                    app.Label_2.Text=img{2,1};
                    app.Label_3.Text=img{3,1};
                    app.Label_4.Text=img{4,1};
                    app.Label_5.Text=img{5,1};
                    app.Label_6.Text=img{6,1};
                    app.Label_7.Text=img{7,1};
                    app.Label_8.Text=img{8,1};
                    app.Image15.ImageSource=app.Image.ImageSource;
                    app.Label_9.Text=img{1,1};
                    m=8;
                case 'Dubai'
                    imgPath1 = 'Datasets/Dubai/'; 
                    imgDir1 = dir([imgPath1 '*.jpg']); 


                    img=cell(length(imgDir1),2);
                    folder=cell(length(imgDir1),1);
                    for i = 1:length(imgDir1) 
                        img{i,2} = imread([imgPath1 imgDir1(i).name]); 
                        img{i,1} = imgDir1(i).name; 
                        folder{i}=append(imgDir1(i).folder,"/",imgDir1(i).name);
                    end
                    for i=1:size(img,1)
                        tem=img{i,1};
                        tem=extractBefore(tem,".jpg");
                        tem = strrep(tem,'_','-');
                        img{i,1}=tem;
                    end

                    app.Image.ImageSource = folder{1};
                    app.Image2.ImageSource = folder{2};
                    app.Image3.ImageSource = folder{3};
                    app.Image4.ImageSource = folder{4};
                    app.Image5.ImageSource = folder{5};
                    app.Image6.ImageSource = folder{6};
                    app.Image7.ImageSource = folder{7};
                    app.Image8.ImageSource = folder{8};
                    app.Label.Text=img{1,1};
                    app.Label_2.Text=img{2,1};
                    app.Label_3.Text=img{3,1};
                    app.Label_4.Text=img{4,1};
                    app.Label_5.Text=img{5,1};
                    app.Label_6.Text=img{6,1};
                    app.Label_7.Text=img{7,1};
                    app.Label_8.Text=img{8,1};
                    app.Image15.ImageSource=app.Image.ImageSource;
                    app.Label_9.Text=img{1,1};
                    m=8;
                case 'own pictures'
                    imgPath1 = 'Datasets/own pictures/'; 
                    imgDir1 = dir([imgPath1 '*.jpg']); 

                    folder=cell(length(imgDir1),1);
                    img=cell(length(imgDir1),2);
                    for i = 1:length(imgDir1) 
                        img{i,2} = imread([imgPath1 imgDir1(i).name]); 
                        img{i,1} = imgDir1(i).name;
                        folder{i}=append(imgDir1(i).folder,"/",imgDir1(i).name);
                    end
                    for i=1:size(img,1)
                        tem=img{i,1};
                        tem=extractBefore(tem,".jpg");
                        tem = strrep(tem,'_','-');
                        img{i,1}=tem;
                    end
                    [m,n]=size(img);
                    switch m %choose your own pics ,first of determine the number of pics
                        case 1
                            app.Image.ImageSource = folder{1};
                            app.Label.Text=img{1,1};
                            app.Label_9.Text=img{1,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Image2.Visible="off";
                            app.Image3.Visible="off";
                            app.Image4.Visible="off";
                            app.Image5.Visible="off";
                            app.Image6.Visible="off";
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 2
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_9.Text=img{1,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Image3.Visible="off";
                            app.Image4.Visible="off";
                            app.Image5.Visible="off";
                            app.Image6.Visible="off";
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 3
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_9.Text=img{1,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Image4.Visible="off";
                            app.Image5.Visible="off";
                            app.Image6.Visible="off";
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 4
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Image4.ImageSource = folder{4};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_4.Text=img{4,1};
                            app.Label_9.Text=img{1,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Image5.Visible="off";
                            app.Image6.Visible="off";
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 5
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Image4.ImageSource = folder{4};
                            app.Image5.ImageSource = folder{5};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_4.Text=img{4,1};
                            app.Label_5.Text=img{5,1};
                            app.Label_9.Text=img{1,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Image6.Visible="off";
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 6
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Image4.ImageSource = folder{4};
                            app.Image5.ImageSource = folder{5};
                            app.Image6.ImageSource = folder{6};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_4.Text=img{4,1};
                            app.Label_5.Text=img{5,1};
                            app.Label_6.Text=img{6,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=img{1,1};
                            app.Image7.Visible="off";
                            app.Image8.Visible="off";
                        case 7
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Image4.ImageSource = folder{4};
                            app.Image5.ImageSource = folder{5};
                            app.Image6.ImageSource = folder{6};
                            app.Image7.ImageSource = folder{7};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_4.Text=img{4,1};
                            app.Label_5.Text=img{5,1};
                            app.Label_6.Text=img{6,1};
                            app.Label_7.Text=img{7,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=img{1,1};
                            app.Image8.Visible="off";
                        otherwise
                            app.Image.ImageSource = folder{1};
                            app.Image2.ImageSource = folder{2};
                            app.Image3.ImageSource = folder{3};
                            app.Image4.ImageSource = folder{4};
                            app.Image5.ImageSource = folder{5};
                            app.Image6.ImageSource = folder{6};
                            app.Image7.ImageSource = folder{7};
                            app.Image8.ImageSource = folder{8};
                            app.Label.Text=img{1,1};
                            app.Label_2.Text=img{2,1};
                            app.Label_3.Text=img{3,1};
                            app.Label_4.Text=img{4,1};
                            app.Label_5.Text=img{5,1};
                            app.Label_6.Text=img{6,1};
                            app.Label_7.Text=img{7,1};
                            app.Label_8.Text=img{8,1};
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=img{1,1};
                            m=8;
                    end
%                     assignin('base','m',m);

            end
            assignin('base','m',m);
            %
            assignin('base','test',img);

        end

        % Image clicked function: Image
        function ImageClicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %choose images through Klick
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image2
        function Image2Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image2.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image2.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image2.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image2.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image3
        function Image3Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image3.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image3.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image3.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image3.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image4
        function Image4Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image4.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image4.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image4.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image4.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image5
        function Image5Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image5.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image5.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image5.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image5.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image6
        function Image6Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image6.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image6.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image6.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image6.ImageSource;
                                    end
                            end


                    end
            end
        end

        % Image clicked function: Image7
        function Image7Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image7.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image7.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image7.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image7.ImageSource;
                                    end
                            end


                    end
            end

        end

        % Image clicked function: Image8
        function Image8Clicked(app, event)
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            %assignin('base','var9',var9);
            switch var9
                case '1.jpg'
                    app.Image9.ImageSource=app.Image8.ImageSource;
                otherwise
                    switch var9_2
                        case '1.jpg'
                            app.Image9_2.ImageSource=app.Image8.ImageSource;
                        otherwise
                            switch var9_3
                                case '1.jpg'
                                    app.Image9_3.ImageSource=app.Image8.ImageSource;
                                otherwise
                                    switch var9_4
                                        case '1.jpg'
                                            app.Image9_4.ImageSource=app.Image8.ImageSource;
                                    end
                            end


                    end
            end

        end

        % Button pushed function: readyandStartButton
        function readyandStartButtonPushed(app, event)
%The Aim of this Section is to find the same area.
            app.Image13.ImageSource='1.jpg';
            app.Image13_2.ImageSource='1.jpg';
            app.Image13_3.ImageSource='1.jpg';
            app.Image13_4.ImageSource='1.jpg';
            test=evalin('base','test');
            I1 = imread(app.Image9.ImageSource);
            I2 = imread(app.Image9_2.ImageSource);
            I3 = imread(app.Image9_3.ImageSource);
            I4 = imread(app.Image9_4.ImageSource);
            I=cell(4,2);
            I(1,:)={app.Image9.ImageSource,I1};
            I(2,:)={app.Image9_2.ImageSource,I2};
            I(3,:)={app.Image9_3.ImageSource,I3};
            I(4,:)={app.Image9_4.ImageSource,I4};
            var9=app.Image9.ImageSource;
            var9_2=app.Image9_2.ImageSource;
            var9_3=app.Image9_3.ImageSource;
            var9_4=app.Image9_4.ImageSource;
            switch var9
                case app.Image.ImageSource
                    I(1,:)={test{1,1},I1};
                case app.Image2.ImageSource
                    I(1,:)={test{2,1},I1};
                case app.Image3.ImageSource
                    I(1,:)={test{3,1},I1};
                case app.Image4.ImageSource
                    I(1,:)={test{4,1},I1};
                case app.Image5.ImageSource
                    I(1,:)={test{5,1},I1};
                case app.Image6.ImageSource
                    I(1,:)={test{6,1},I1};
                case app.Image7.ImageSource
                    I(1,:)={test{7,1},I1};
                case app.Image8.ImageSource
                    I(1,:)={test{8,1},I1};
            end
            switch var9_2
                case app.Image.ImageSource
                    I(2,:)={test{1,1},I2};
                case app.Image2.ImageSource
                    I(2,:)={test{2,1},I2};
                case app.Image3.ImageSource
                    I(2,:)={test{3,1},I2};
                case app.Image4.ImageSource
                    I(2,:)={test{4,1},I2};
                case app.Image5.ImageSource
                    I(2,:)={test{5,1},I2};
                case app.Image6.ImageSource
                    I(2,:)={test{6,1},I2};
                case app.Image7.ImageSource
                    I(2,:)={test{7,1},I2};
                case app.Image8.ImageSource
                    I(2,:)={test{8,1},I2};
            end
            switch var9_3
                case app.Image.ImageSource
                    I(3,:)={test{1,1},I3};
                case app.Image2.ImageSource
                    I(3,:)={test{2,1},I3};
                case app.Image3.ImageSource
                    I(3,:)={test{3,1},I3};
                case app.Image4.ImageSource
                    I(3,:)={test{4,1},I3};
                case app.Image5.ImageSource
                    I(3,:)={test{5,1},I3};
                case app.Image6.ImageSource
                    I(3,:)={test{6,1},I3};
                case app.Image7.ImageSource
                    I(3,:)={test{7,1},I3};
                case app.Image8.ImageSource
                    I(3,:)={test{8,1},I3};
            end
            switch var9_4
                case app.Image.ImageSource
                    I(4,:)={test{1,1},I4};
                case app.Image2.ImageSource
                    I(4,:)={test{2,1},I4};
                case app.Image3.ImageSource
                    I(4,:)={test{3,1},I4};
                case app.Image4.ImageSource
                    I(4,:)={test{4,1},I4};
                case app.Image5.ImageSource
                    I(4,:)={test{5,1},I4};
                case app.Image6.ImageSource
                    I(4,:)={test{6,1},I4};
                case app.Image7.ImageSource
                    I(4,:)={test{7,1},I4};
                case app.Image8.ImageSource
                    I(4,:)={test{8,1},I4};
            end
            [I_out,n_matchings] = Images_Same_Area_New(I,'min_dist',230);
            switch n_matchings
                case 4
                    app.Image13.ImageSource=I_out{1,2};
                    app.Image13_2.ImageSource=I_out{2,2};
                    app.Image13_3.ImageSource=I_out{3,2};
                    app.Image13_4.ImageSource=I_out{4,2};
                case 3
                    app.Image13.ImageSource=I_out{1,2};
                    app.Image13_2.ImageSource=I_out{2,2};
                    app.Image13_3.ImageSource=I_out{3,2};
                case 2
                    app.Image13.ImageSource=I_out{1,2};
                    app.Image13_2.ImageSource=I_out{2,2};
                case 1
                    app.Image13.ImageSource=I_out{1,2};



            end

            assignin('base','I_out111',I_out);
            I_out(cellfun(@isempty,I_out))=[];
            
            [~,n]=size(I_out);
            assignin('base','I_out222',I_out);
            assignin('base','n',n);
            switch n
                case 4
                    I_out_new{1,1}=I_out{1,1};
                    I_out_new{2,1}=I_out{1,2};
                    I_out_new{1,2}=I_out{1,3};
                    I_out_new{2,2}=I_out{1,4};
                    assignin('base','I_out',I_out_new);
                case 6
                    I_out_new{1,1}=I_out{1,1};
                    I_out_new{2,1}=I_out{1,2};
                    I_out_new{3,1}=I_out{1,3};
                    I_out_new{1,2}=I_out{1,4};
                    I_out_new{2,2}=I_out{1,5};
                    I_out_new{3,2}=I_out{1,6};
                    assignin('base','I_out',I_out_new);
                otherwise
                    assignin('base','I_out',I_out);
            end
            assignin('base','n_matchings',n_matchings);
        end

        % Callback function
        function Button_2Pushed(app, event)
            
        end

        % Button pushed function: readyandStartButton_2
        function readyandStartButton_2Pushed(app, event)
%try to use k_means to clustering
            I_out=evalin('base','I_out');
            [dates, img_common] = construct_dates_common(I_out);
            Iteration=app.IterationEditField.Value;
            k=app.ClusterEditField.Value;
            assignin('base',"k",k);
            [masks, clusters] = color_masks_rgb(img_common, k,Iteration);
            assignin('base','masks',masks);
            assignin('base','clusters',clusters);
            assignin('base',"dates",dates);
            assignin('base',"img_common",img_common);
        end

        % Button pushed function: ChangetheorderButton
        function ChangetheorderButtonPushed(app, event)
%open the subapp to swap imgs to ensure all the pics in the same column is
%from one cluster
            app.ChangetheorderButton.Enable = 'off';

            app.Dialogapp = DialogWindow(app, app.row, app.col1, app.col2);
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)
            delete(app.Dialogapp)
            delete(app)
%when close the subapp,shut the Interface of Subapp down.
        end

        % Button pushed function: Button_2
        function Button_2Pushed2(app, event)
%give names to each cluster
            masks=evalin('base','masks');
            clusters=evalin('base','clusters');
            dates=evalin('base','dates');
            n_matchings=evalin('base','n_matchings');
            names = app.fromlefttorightEditField.Value;
            %assignin('base','names',names);
            k=app.ClusterEditField.Value;
            str = deblank(names);
            S = regexp(str, ';', 'split');
            num_img = n_matchings;
            %dates=
            names_arr = give_names(S, k, num_img);
            names=S;
            assignin('base',"names",names);
            [Mask_Container, img_container] = construct_containers(masks, clusters,dates, names_arr);
            figure('Visible',"off");
            app.choose2picsinthesameclusterEditField_2.Value=strcat(names{1,3},"1");
            app.choose2picsinthesameclusterEditField_3.Value=strcat(names{1,3},"2");
            source1=app.choose2picsinthesameclusterEditField_2.Value;
            assignin('base','source1',source1);
            source2=app.choose2picsinthesameclusterEditField_3.Value;
            img1_logical = Mask_Container(source1);
            img4_logical = Mask_Container(source2);

            img1 = img_container(source1);
            img4 = img_container(source2);

            %imshow(img1);
            %imshow(img4);
            assignin('base','img1',img1);
            assignin('base','img1',img4);
            assignin('base','img1_logical',img1_logical);
            assignin('base','img4_logical',img4_logical);
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
%draw Heatmap of the two pics ,which you select.
            n_matchings=evalin('base','n_matchings');
%             delete('NewHeatMap.svg');
%             delete('*.svg');
            masks=evalin('base','masks');
            clusters=evalin('base','clusters');
            dates=evalin('base','dates');
            names = app.fromlefttorightEditField.Value;
            %assignin('base','names',names);
            k=app.ClusterEditField.Value;
            str = deblank(names);
            S = regexp(str, ';', 'split');
            num_img = n_matchings;

            names_arr = give_names(S, k, num_img);
            names=S;
            assignin('base',"names",names);
            [Mask_Container, img_container,dates_container] = construct_containers(masks, clusters, dates,names_arr);
            figure('Visible',"off");
            source1=app.choose2picsinthesameclusterEditField_2.Value;
            assignin('base','source1',source1);
            source2=app.choose2picsinthesameclusterEditField_3.Value;
            img1_logical = Mask_Container(source1);
            img4_logical = Mask_Container(source2);

            img1 = img_container(source1);
            img4 = img_container(source2);

            app.UIAxes_3.Visible='on';
            app.Image14.Visible='on';
            window_size = app.AdjusttheValueThreesholdtoshowthehighlightEditField_2.Value;
            transparence = app.AdjusttheValueThreesholdtoshowthehighlightEditField_3.Value;
            window_size=[window_size,window_size];
            assignin('base',"window_size",window_size);
            assignin('base',"transparence",transparence);
            user_inputs = {source1, source2};
            HeatMap=plot_heatmap(img1, img1_logical, img4_logical, window_size, transparence,dates_container, user_inputs);
            assignin('base',"user_inputs",user_inputs);
            pause(1);
            oldfilename=evalin('base','oldfilename');
            app.Image14.ImageSource=oldfilename;
        end

        % Button pushed function: Button_4
        function Button_4Pushed(app, event)
%draw the Bar Map
            masks=evalin('base','masks');
            clusters=evalin('base','clusters');
            names=evalin('base','names');
            I_out=evalin('base','I_out');
            dates=evalin('base','dates');
            %dates=I_out{:,1};
            %assignin()
            app.Image14.Visible='on';
            app.UIAxes_3.Visible='off';
            b = plot_bar(masks,dates,names);
            pause(1);
            oldfilename1=evalin('base','oldfilename1');
            app.Image14.ImageSource=oldfilename1;
        end

        % Value changed function: ListBox
        function ListBoxValueChanged(app, event)
%choose the Visualization Mode
            value = app.ListBox.Value;
            app.largesmallModeHeatmapPanel.Visible='off';
            app.slowModebarMapPanel.Visible='off';
            app.TimeLapsePanel.Visible='off';
            switch value
                case 'Heatmap'
                    app.largesmallModeHeatmapPanel.Visible='on';
                    app.slowModebarMapPanel.Visible='off';
                    app.TimeLapsePanel.Visible='off';
                case 'Bar Map'
                    app.slowModebarMapPanel.Visible='on';
                    app.largesmallModeHeatmapPanel.Visible='off';
                    app.TimeLapsePanel.Visible='off';
                case 'Time Lapse'
                    app.TimeLapsePanel.Visible='on';
                    app.slowModebarMapPanel.Visible='off';
                    app.largesmallModeHeatmapPanel.Visible='off';

            end
        end

        % Button pushed function: Button_5
        function Button_5Pushed(app, event)
%overview the Images
            m=evalin('base',"m");
            var=app.Image15.ImageSource;
            switch m
                case 1
                    app.Button_6.Visible='off';
                    app.Button_5.Visible='off';
                case 2
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                            app.Button_5.Visible='on';
                    end
                case 3
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                            app.Button_5.Visible='on';
                    end
                case 4
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                            app.Button_5.Visible='on';
                    end
                case 5
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                            app.Button_5.Visible='on';
                    end
                case 6
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image6.ImageSource;
                            app.Label_9.Text=app.Label_6.Text;
                            app.Button_5.Visible='on';
                    end
                case 7
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image6.ImageSource;
                            app.Label_9.Text=app.Label_6.Text;
                        case app.Image6.ImageSource
                            app.Image15.ImageSource=app.Image7.ImageSource;
                            app.Label_9.Text=app.Label_7.Text;
                            app.Button_5.Visible='on';
                    end
                case 8
                    switch var
                        case app.Image.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_6.Visible='on';
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image6.ImageSource;
                            app.Label_9.Text=app.Label_6.Text;
                        case app.Image6.ImageSource
                            app.Image15.ImageSource=app.Image7.ImageSource;
                            app.Label_9.Text=app.Label_7.Text;
                        case app.Image7.ImageSource
                            app.Image15.ImageSource=app.Image8.ImageSource;
                            app.Label_9.Text=app.Label_8.Text;
                            app.Button_5.Visible='on';
                    end


            end
        end

        % Button pushed function: Button_6
        function Button_6Pushed(app, event)
 %Image overview
            m=evalin('base',"m");
            var=app.Image15.ImageSource;
            switch m
                case 1
                    app.Button_6.Visible='off';
                    app.Button_5.Visible='off';
                case 2
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                            app.Button_5.Visible='on';
                    end
                case 3
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                            app.Button_5.Visible='on';
                    end
                case 4
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                            app.Button_5.Visible='on';
                    end
                case 5
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                            app.Button_5.Visible='on';
                    end
                case 6
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image6.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                            app.Button_5.Visible='on';
                    end
                case 7
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image6.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                        case app.Image7.ImageSource
                            app.Image15.ImageSource=app.Image6.ImageSource;
                            app.Label_9.Text=app.Label_6.Text;
                            app.Button_5.Visible='on';
                    end
                case 8
                    switch var
                        case app.Image2.ImageSource
                            app.Image15.ImageSource=app.Image.ImageSource;
                            app.Label_9.Text=app.Label.Text;
                            app.Button_6.Visible='off';
                        case app.Image3.ImageSource
                            app.Image15.ImageSource=app.Image2.ImageSource;
                            app.Label_9.Text=app.Label_2.Text;
                        case app.Image4.ImageSource
                            app.Image15.ImageSource=app.Image3.ImageSource;
                            app.Label_9.Text=app.Label_3.Text;
                        case app.Image5.ImageSource
                            app.Image15.ImageSource=app.Image4.ImageSource;
                            app.Label_9.Text=app.Label_4.Text;
                        case app.Image6.ImageSource
                            app.Image15.ImageSource=app.Image5.ImageSource;
                            app.Label_9.Text=app.Label_5.Text;
                        case app.Image7.ImageSource
                            app.Image15.ImageSource=app.Image6.ImageSource;
                            app.Label_9.Text=app.Label_6.Text;
                        case app.Image8.ImageSource
                            app.Image15.ImageSource=app.Image7.ImageSource;
                            app.Label_9.Text=app.Label_7.Text;
                            app.Button_5.Visible='on';
                    end


            end
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)
            evalin('base','clearvars *' )
        end

        % Button pushed function: startButton
        function startButtonPushed(app, event)
%pics select to show highlights
            var=app.SelectPicturesDropDown_2.Value;
            var1=app.SelectPicturesDropDown_3.Value;
            Tau_Area=app.AdjusttheValueThreesholdtoshowthehighlightEditField_4.Value;
            thresh=app.AdjusttheValueThreesholdtoshowthehighlightEditField_5.Value;
            min_dist=app.AdjusttheValueThreesholdtoshowthehighlightEditField_6.Value;
            Speed_var=app.SelectPicturesDropDown_5.Value;
            switch Speed_var
                case 'quick'
                    Speed="quick";
                case 'slow'
                    Speed="slow";
            end
            switch var1
                case 'normal'
                    switch var
                        case 'pics 1 and 2'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_2.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 1 and 3'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_3.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 1 and 4'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 2 and 3'
                            img1=app.Image13_2.ImageSource;
                            img2=app.Image13_3.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 2 and 4'
                            img1=app.Image13_2.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 3 and 4'
                            img1=app.Image13_3.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=Highlights_Finden_Visualization(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                    end
                case 'PCA'
                    switch var
                        case 'pics 1 and 2'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_2.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 1 and 3'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_3.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 1 and 4'
                            img1=app.Image13.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 2 and 3'
                            img1=app.Image13_2.ImageSource;
                            img2=app.Image13_3.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 2 and 4'
                            img1=app.Image13_2.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                        case 'pics 3 and 4'
                            img1=app.Image13_3.ImageSource;
                            img2=app.Image13_4.ImageSource;
                            [imgout1_highlights,imgout2_highlights,A1]=PCA_Highlights(img1,img2,'Speed',Speed,'Tau_Area', Tau_Area,'thresh',thresh,'min_dist',min_dist);
                            figure();imshow(imgout1_highlights);

                            figure();imshow(imgout2_highlights);
                            imshow(A1,'parent',app.UIAxes_4);
                    end
            end
            assignin('base',"A1",A1);
        end

        % Button pushed function: Button_7
        function Button_7Pushed(app, event)
            tempo=app.SelectPicturesDropDown_4.Value;
            img_common=evalin('base','img_common');
            dates=evalin('base','dates');
            time_lapse(img_common, dates, tempo);
        end

        % Image clicked function: Image15
        function Image15Clicked(app, event)
            figure();
            imshow(app.Image15.ImageSource);
        end

        % Button down function: UIAxes_4
        function UIAxes_4ButtonDown(app, event)
            A1=evalin('base',"A1");
            figure();
            imshow(A1);
        end

        % Button pushed function: ReadmeButton
        function ReadmeButtonPushed(app, event)
            open("misc/Readme.txt");
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 1039 776];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {238, '1x', 393};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create SelectPicturesDropDownLabel
            app.SelectPicturesDropDownLabel = uilabel(app.LeftPanel);
            app.SelectPicturesDropDownLabel.HorizontalAlignment = 'right';
            app.SelectPicturesDropDownLabel.Position = [9 675 86 22];
            app.SelectPicturesDropDownLabel.Text = 'Select Pictures';

            % Create SelectPicturesDropDown
            app.SelectPicturesDropDown = uidropdown(app.LeftPanel);
            app.SelectPicturesDropDown.Items = {'Glacier', 'Dubai', 'Yangtse', 'own pictures'};
            app.SelectPicturesDropDown.DropDownOpeningFcn = createCallbackFcn(app, @updateAppLayout, true);
            app.SelectPicturesDropDown.ValueChangedFcn = createCallbackFcn(app, @updateAppLayout, true);
            app.SelectPicturesDropDown.Position = [94 675 111 22];
            app.SelectPicturesDropDown.Value = 'Glacier';

            % Create Image
            app.Image = uiimage(app.LeftPanel);
            app.Image.ImageClickedFcn = createCallbackFcn(app, @ImageClicked, true);
            app.Image.Position = [18 586 100 66];
            app.Image.ImageSource = '2.jpg';

            % Create Image2
            app.Image2 = uiimage(app.LeftPanel);
            app.Image2.ImageClickedFcn = createCallbackFcn(app, @Image2Clicked, true);
            app.Image2.Position = [20 458 100 100];
            app.Image2.ImageSource = '2.jpg';

            % Create Button
            app.Button = uibutton(app.LeftPanel, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [204 675 31 22];
            app.Button.Text = '√';

            % Create Image3
            app.Image3 = uiimage(app.LeftPanel);
            app.Image3.ImageClickedFcn = createCallbackFcn(app, @Image3Clicked, true);
            app.Image3.Position = [20 352 100 100];
            app.Image3.ImageSource = '2.jpg';

            % Create Image4
            app.Image4 = uiimage(app.LeftPanel);
            app.Image4.ImageClickedFcn = createCallbackFcn(app, @Image4Clicked, true);
            app.Image4.Position = [18 253 100 100];
            app.Image4.ImageSource = '2.jpg';

            % Create Image8
            app.Image8 = uiimage(app.LeftPanel);
            app.Image8.ImageClickedFcn = createCallbackFcn(app, @Image8Clicked, true);
            app.Image8.Position = [134 253 100 100];
            app.Image8.ImageSource = '2.jpg';

            % Create Image7
            app.Image7 = uiimage(app.LeftPanel);
            app.Image7.ImageClickedFcn = createCallbackFcn(app, @Image7Clicked, true);
            app.Image7.Position = [134 352 100 100];
            app.Image7.ImageSource = '2.jpg';

            % Create Image6
            app.Image6 = uiimage(app.LeftPanel);
            app.Image6.ImageClickedFcn = createCallbackFcn(app, @Image6Clicked, true);
            app.Image6.Position = [134 458 100 100];
            app.Image6.ImageSource = '2.jpg';

            % Create Image5
            app.Image5 = uiimage(app.LeftPanel);
            app.Image5.ImageClickedFcn = createCallbackFcn(app, @Image5Clicked, true);
            app.Image5.Position = [132 569 100 100];
            app.Image5.ImageSource = '2.jpg';

            % Create ChoosetheimagesLabel
            app.ChoosetheimagesLabel = uilabel(app.LeftPanel);
            app.ChoosetheimagesLabel.FontName = 'Arial Black';
            app.ChoosetheimagesLabel.FontSize = 20;
            app.ChoosetheimagesLabel.FontColor = [0 0 1];
            app.ChoosetheimagesLabel.Position = [18 217 216 32];
            app.ChoosetheimagesLabel.Text = 'Choose the images';

            % Create Button_5
            app.Button_5 = uibutton(app.LeftPanel, 'push');
            app.Button_5.ButtonPushedFcn = createCallbackFcn(app, @Button_5Pushed, true);
            app.Button_5.Position = [202 127 31 22];
            app.Button_5.Text = '>';

            % Create Button_6
            app.Button_6 = uibutton(app.LeftPanel, 'push');
            app.Button_6.ButtonPushedFcn = createCallbackFcn(app, @Button_6Pushed, true);
            app.Button_6.Position = [9 127 31 22];
            app.Button_6.Text = '<';

            % Create Image15
            app.Image15 = uiimage(app.LeftPanel);
            app.Image15.ImageClickedFcn = createCallbackFcn(app, @Image15Clicked, true);
            app.Image15.Position = [38 78 167 138];

            % Create Label
            app.Label = uilabel(app.LeftPanel);
            app.Label.HorizontalAlignment = 'center';
            app.Label.Position = [25 557 85 22];
            app.Label.Text = ' ';

            % Create Label_2
            app.Label_2 = uilabel(app.LeftPanel);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.Position = [27 451 85 22];
            app.Label_2.Text = ' ';

            % Create Label_3
            app.Label_3 = uilabel(app.LeftPanel);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.Position = [27 341 85 22];
            app.Label_3.Text = ' ';

            % Create Label_4
            app.Label_4 = uilabel(app.LeftPanel);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.Position = [27 244 85 22];
            app.Label_4.Text = ' ';

            % Create Label_5
            app.Label_5 = uilabel(app.LeftPanel);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.Position = [141 557 85 22];
            app.Label_5.Text = ' ';

            % Create Label_6
            app.Label_6 = uilabel(app.LeftPanel);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.Position = [141 451 85 22];
            app.Label_6.Text = ' ';

            % Create Label_7
            app.Label_7 = uilabel(app.LeftPanel);
            app.Label_7.HorizontalAlignment = 'center';
            app.Label_7.Position = [141 341 85 22];
            app.Label_7.Text = ' ';

            % Create Label_8
            app.Label_8 = uilabel(app.LeftPanel);
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.Position = [141 244 85 22];
            app.Label_8.Text = ' ';

            % Create Label_9
            app.Label_9 = uilabel(app.LeftPanel);
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.Position = [79 57 85 22];
            app.Label_9.Text = ' ';

            % Create imagesoverviewLabel
            app.imagesoverviewLabel = uilabel(app.LeftPanel);
            app.imagesoverviewLabel.FontName = 'Arial Black';
            app.imagesoverviewLabel.FontSize = 16;
            app.imagesoverviewLabel.FontColor = [0 0 1];
            app.imagesoverviewLabel.Position = [45 41 153 25];
            app.imagesoverviewLabel.Text = 'images overview';

            % Create Label_10
            app.Label_10 = uilabel(app.LeftPanel);
            app.Label_10.FontName = 'Arial Black';
            app.Label_10.FontSize = 20;
            app.Label_10.FontColor = [0.149 0.149 0.149];
            app.Label_10.Position = [9 208 241 32];
            app.Label_10.Text = '-----------------------------------';

            % Create Label_12
            app.Label_12 = uilabel(app.LeftPanel);
            app.Label_12.FontName = 'Arial Black';
            app.Label_12.FontSize = 20;
            app.Label_12.FontColor = [0.149 0.149 0.149];
            app.Label_12.Position = [10 701 227 25];
            app.Label_12.Text = '---------------------------------';

            % Create ZuchengHanXuYanJianTianLabel
            app.ZuchengHanXuYanJianTianLabel = uilabel(app.LeftPanel);
            app.ZuchengHanXuYanJianTianLabel.FontName = 'Arial Black';
            app.ZuchengHanXuYanJianTianLabel.FontColor = [0 0 1];
            app.ZuchengHanXuYanJianTianLabel.Position = [4 738 206 19];
            app.ZuchengHanXuYanJianTianLabel.Text = 'Zucheng Han|Xu Yan|Jian Tian';

            % Create G24HuiyuWangXiaoangZhangLabel
            app.G24HuiyuWangXiaoangZhangLabel = uilabel(app.LeftPanel);
            app.G24HuiyuWangXiaoangZhangLabel.FontName = 'Arial Black';
            app.G24HuiyuWangXiaoangZhangLabel.FontColor = [0 0 1];
            app.G24HuiyuWangXiaoangZhangLabel.Position = [2 756 222 19];
            app.G24HuiyuWangXiaoangZhangLabel.Text = 'G24:Huiyu Wang|Xiaoang Zhang';

            % Create ReadmeButton
            app.ReadmeButton = uibutton(app.LeftPanel, 'push');
            app.ReadmeButton.ButtonPushedFcn = createCallbackFcn(app, @ReadmeButtonPushed, true);
            app.ReadmeButton.BackgroundColor = [1 1 1];
            app.ReadmeButton.Position = [150 711 82 22];
            app.ReadmeButton.Text = 'Readme';

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create choosefourpictureswhichyouwanttocompareLabel
            app.choosefourpictureswhichyouwanttocompareLabel = uilabel(app.CenterPanel);
            app.choosefourpictureswhichyouwanttocompareLabel.Position = [11 680 269 22];
            app.choosefourpictureswhichyouwanttocompareLabel.Text = 'choose four pictures,which you want to compare.';

            % Create Image9
            app.Image9 = uiimage(app.CenterPanel);
            app.Image9.Position = [33 559 134 126];
            app.Image9.ImageSource = '1.jpg';

            % Create thecommonpartsareasfollows_Label
            app.thecommonpartsareasfollows_Label = uilabel(app.CenterPanel);
            app.thecommonpartsareasfollows_Label.Position = [96 451 200 22];
            app.thecommonpartsareasfollows_Label.Text = 'the common parts are as follows ^_^';

            % Create ImpactofhumanactivitiesLabel
            app.ImpactofhumanactivitiesLabel = uilabel(app.CenterPanel);
            app.ImpactofhumanactivitiesLabel.FontName = 'Arial Black';
            app.ImpactofhumanactivitiesLabel.FontSize = 20;
            app.ImpactofhumanactivitiesLabel.FontColor = [0 0 1];
            app.ImpactofhumanactivitiesLabel.Position = [39 742 308 33];
            app.ImpactofhumanactivitiesLabel.Text = 'Impact of human activities ';

            % Create onthelandscapefromaboveLabel
            app.onthelandscapefromaboveLabel = uilabel(app.CenterPanel);
            app.onthelandscapefromaboveLabel.FontName = 'Arial Black';
            app.onthelandscapefromaboveLabel.FontSize = 20;
            app.onthelandscapefromaboveLabel.FontColor = [0 0 1];
            app.onthelandscapefromaboveLabel.Position = [33 718 326 33];
            app.onthelandscapefromaboveLabel.Text = 'on the landscape from above';

            % Create Image9_2
            app.Image9_2 = uiimage(app.CenterPanel);
            app.Image9_2.Position = [218 560 134 126];
            app.Image9_2.ImageSource = '1.jpg';

            % Create Image9_3
            app.Image9_3 = uiimage(app.CenterPanel);
            app.Image9_3.Position = [33 457 134 126];
            app.Image9_3.ImageSource = '1.jpg';

            % Create Image9_4
            app.Image9_4 = uiimage(app.CenterPanel);
            app.Image9_4.Position = [218 457 134 126];
            app.Image9_4.ImageSource = '1.jpg';

            % Create Image13
            app.Image13 = uiimage(app.CenterPanel);
            app.Image13.BackgroundColor = [1 1 1];
            app.Image13.Position = [6 358 100 100];

            % Create Image13_2
            app.Image13_2 = uiimage(app.CenterPanel);
            app.Image13_2.BackgroundColor = [1 1 1];
            app.Image13_2.Position = [105 358 100 100];

            % Create Image13_3
            app.Image13_3 = uiimage(app.CenterPanel);
            app.Image13_3.BackgroundColor = [1 1 1];
            app.Image13_3.Position = [204 358 100 100];

            % Create Image13_4
            app.Image13_4 = uiimage(app.CenterPanel);
            app.Image13_4.BackgroundColor = [1 1 1];
            app.Image13_4.Position = [303 358 100 100];

            % Create choosetwopicstoshowHighlights_Label
            app.choosetwopicstoshowHighlights_Label = uilabel(app.CenterPanel);
            app.choosetwopicstoshowHighlights_Label.Position = [4 270 211 22];
            app.choosetwopicstoshowHighlights_Label.Text = 'choose two pics to show Highlights^_^';

            % Create pic1Label
            app.pic1Label = uilabel(app.CenterPanel);
            app.pic1Label.Position = [40 339 31 22];
            app.pic1Label.Text = 'pic 1';

            % Create pic2Label
            app.pic2Label = uilabel(app.CenterPanel);
            app.pic2Label.Position = [139 339 31 22];
            app.pic2Label.Text = 'pic 2';

            % Create pic3Label
            app.pic3Label = uilabel(app.CenterPanel);
            app.pic3Label.Position = [246 339 31 22];
            app.pic3Label.Text = 'pic 3';

            % Create pic4Label
            app.pic4Label = uilabel(app.CenterPanel);
            app.pic4Label.Position = [338 339 31 22];
            app.pic4Label.Text = 'pic 4';

            % Create SelectPicturesDropDown_2
            app.SelectPicturesDropDown_2 = uidropdown(app.CenterPanel);
            app.SelectPicturesDropDown_2.Items = {'pics 1 and 2', 'pics 1 and 3', 'pics 1 and 4', 'pics 2 and 3', 'pics 2 and 4', 'pics 3 and 4', ''};
            app.SelectPicturesDropDown_2.Position = [295 270 108 22];
            app.SelectPicturesDropDown_2.Value = 'pics 1 and 2';

            % Create SelectPicturesDropDown_3
            app.SelectPicturesDropDown_3 = uidropdown(app.CenterPanel);
            app.SelectPicturesDropDown_3.Items = {'normal', 'PCA'};
            app.SelectPicturesDropDown_3.Position = [218 270 76 22];
            app.SelectPicturesDropDown_3.Value = 'normal';

            % Create readyandStartButton
            app.readyandStartButton = uibutton(app.CenterPanel, 'push');
            app.readyandStartButton.ButtonPushedFcn = createCallbackFcn(app, @readyandStartButtonPushed, true);
            app.readyandStartButton.Position = [276 677 100 22];
            app.readyandStartButton.Text = 'ready and Start';

            % Create ParametersPanel
            app.ParametersPanel = uipanel(app.CenterPanel);
            app.ParametersPanel.TitlePosition = 'centertop';
            app.ParametersPanel.Title = 'Parameters';
            app.ParametersPanel.Position = [3 19 100 246];

            % Create AdjusttheValueThreesholdtoshowthehighlightEditField_4
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_4 = uieditfield(app.ParametersPanel, 'numeric');
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_4.HorizontalAlignment = 'center';
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_4.Position = [11 187 66 22];
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_4.Value = 1e-05;

            % Create AdjusttheValueThreesholdtoshowthehighlightEditField_5
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_5 = uieditfield(app.ParametersPanel, 'numeric');
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_5.HorizontalAlignment = 'center';
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_5.Position = [11 149 66 22];
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_5.Value = 0.001;

            % Create AdjusttheValueThreesholdtoshowthehighlightEditField_6
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_6 = uieditfield(app.ParametersPanel, 'numeric');
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_6.HorizontalAlignment = 'center';
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_6.Position = [11 112 66 22];
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_6.Value = 50;

            % Create SelectPicturesDropDown_5
            app.SelectPicturesDropDown_5 = uidropdown(app.ParametersPanel);
            app.SelectPicturesDropDown_5.Items = {'quick', 'slow'};
            app.SelectPicturesDropDown_5.Position = [12 70 66 22];
            app.SelectPicturesDropDown_5.Value = 'quick';

            % Create Tau_AreaLabel
            app.Tau_AreaLabel = uilabel(app.ParametersPanel);
            app.Tau_AreaLabel.Position = [16 170 57 22];
            app.Tau_AreaLabel.Text = 'Tau_Area';

            % Create threshLabel
            app.threshLabel = uilabel(app.ParametersPanel);
            app.threshLabel.Position = [28 136 34 17];
            app.threshLabel.Text = 'thresh';

            % Create min_distLabel
            app.min_distLabel = uilabel(app.ParametersPanel);
            app.min_distLabel.Position = [20 100 47 17];
            app.min_distLabel.Text = 'min_dist';

            % Create tempoLabel
            app.tempoLabel = uilabel(app.ParametersPanel);
            app.tempoLabel.Position = [26 56 41 15];
            app.tempoLabel.Text = 'tempo';

            % Create startButton
            app.startButton = uibutton(app.ParametersPanel, 'push');
            app.startButton.ButtonPushedFcn = createCallbackFcn(app, @startButtonPushed, true);
            app.startButton.Position = [11 10 65 22];
            app.startButton.Text = 'start';

            % Create Label_13
            app.Label_13 = uilabel(app.CenterPanel);
            app.Label_13.FontName = 'Arial Black';
            app.Label_13.FontSize = 20;
            app.Label_13.FontColor = [0.149 0.149 0.149];
            app.Label_13.Position = [3 327 418 32];
            app.Label_13.Text = '-------------------------------------------------------------';

            % Create HighlightsVisualizationLabel
            app.HighlightsVisualizationLabel = uilabel(app.CenterPanel);
            app.HighlightsVisualizationLabel.FontName = 'Arial Black';
            app.HighlightsVisualizationLabel.FontSize = 20;
            app.HighlightsVisualizationLabel.FontColor = [0 0 1];
            app.HighlightsVisualizationLabel.Position = [73 296 274 32];
            app.HighlightsVisualizationLabel.Text = 'Highlights Visualization ';

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.CenterPanel);
            app.UIAxes_4.XTick = [];
            app.UIAxes_4.YTick = [];
            app.UIAxes_4.ButtonDownFcn = createCallbackFcn(app, @UIAxes_4ButtonDown, true);
            app.UIAxes_4.Position = [82 1 321 270];

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create largesmallModeHeatmapPanel
            app.largesmallModeHeatmapPanel = uipanel(app.RightPanel);
            app.largesmallModeHeatmapPanel.TitlePosition = 'centertop';
            app.largesmallModeHeatmapPanel.Title = '    large/smallMode(Heat map)';
            app.largesmallModeHeatmapPanel.BackgroundColor = [1 1 1];
            app.largesmallModeHeatmapPanel.Position = [133 418 248 114];

            % Create choose2picsinthesameclusterEditField_2
            app.choose2picsinthesameclusterEditField_2 = uieditfield(app.largesmallModeHeatmapPanel, 'text');
            app.choose2picsinthesameclusterEditField_2.Position = [2 44 92 22];
            app.choose2picsinthesameclusterEditField_2.Value = 'city1';

            % Create choose2picsinthesameclusterEditField_3
            app.choose2picsinthesameclusterEditField_3 = uieditfield(app.largesmallModeHeatmapPanel, 'text');
            app.choose2picsinthesameclusterEditField_3.Position = [106 44 92 22];
            app.choose2picsinthesameclusterEditField_3.Value = 'city2';

            % Create choosetwopicturestodrawtheHeatmapLabel
            app.choosetwopicturestodrawtheHeatmapLabel = uilabel(app.largesmallModeHeatmapPanel);
            app.choosetwopicturestodrawtheHeatmapLabel.Position = [5 70 232 22];
            app.choosetwopicturestodrawtheHeatmapLabel.Text = 'choose two pictures to draw the Heatmap.';

            % Create Button_3
            app.Button_3 = uibutton(app.largesmallModeHeatmapPanel, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.Position = [206 4 31 22];
            app.Button_3.Text = '√';

            % Create choosewindowsizeandtransparenceLabel
            app.choosewindowsizeandtransparenceLabel = uilabel(app.largesmallModeHeatmapPanel);
            app.choosewindowsizeandtransparenceLabel.Position = [2 25 213 22];
            app.choosewindowsizeandtransparenceLabel.Text = 'choose window size and transparence.';

            % Create AdjusttheValueThreesholdtoshowthehighlightEditField_2
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_2 = uieditfield(app.largesmallModeHeatmapPanel, 'numeric');
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_2.HorizontalAlignment = 'center';
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_2.Position = [2 4 92 22];
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_2.Value = 8;

            % Create AdjusttheValueThreesholdtoshowthehighlightEditField_3
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_3 = uieditfield(app.largesmallModeHeatmapPanel, 'numeric');
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_3.HorizontalAlignment = 'center';
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_3.Position = [106 4 92 22];
            app.AdjusttheValueThreesholdtoshowthehighlightEditField_3.Value = 0.5;

            % Create KmeansClusteringLabel
            app.KmeansClusteringLabel = uilabel(app.RightPanel);
            app.KmeansClusteringLabel.FontName = 'Arial Black';
            app.KmeansClusteringLabel.FontSize = 20;
            app.KmeansClusteringLabel.FontColor = [0 0 1];
            app.KmeansClusteringLabel.Position = [86 743 221 32];
            app.KmeansClusteringLabel.Text = 'K-means Clustering';

            % Create PleasechoosethenumberofClustersandIterationonlyIntegerPanel
            app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel = uipanel(app.RightPanel);
            app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel.Title = 'Please,choose the number of Clusters and Iteration(only Integer)';
            app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel.Position = [21 652 355 93];

            % Create ClusterEditFieldLabel
            app.ClusterEditFieldLabel = uilabel(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel);
            app.ClusterEditFieldLabel.HorizontalAlignment = 'right';
            app.ClusterEditFieldLabel.Position = [18 45 46 22];
            app.ClusterEditFieldLabel.Text = 'Cluster';

            % Create ClusterEditField
            app.ClusterEditField = uieditfield(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel, 'numeric');
            app.ClusterEditField.Position = [73 45 42 22];
            app.ClusterEditField.Value = 3;

            % Create IterationEditFieldLabel
            app.IterationEditFieldLabel = uilabel(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel);
            app.IterationEditFieldLabel.HorizontalAlignment = 'right';
            app.IterationEditFieldLabel.Position = [15 12 49 22];
            app.IterationEditFieldLabel.Text = 'Iteration';

            % Create IterationEditField
            app.IterationEditField = uieditfield(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel, 'numeric');
            app.IterationEditField.Limits = [1 Inf];
            app.IterationEditField.Position = [73 12 42 22];
            app.IterationEditField.Value = 3;

            % Create readyandStartButton_2
            app.readyandStartButton_2 = uibutton(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel, 'push');
            app.readyandStartButton_2.ButtonPushedFcn = createCallbackFcn(app, @readyandStartButton_2Pushed, true);
            app.readyandStartButton_2.Position = [240 44 100 22];
            app.readyandStartButton_2.Text = 'ready and Start';

            % Create ChangetheorderButton
            app.ChangetheorderButton = uibutton(app.PleasechoosethenumberofClustersandIterationonlyIntegerPanel, 'push');
            app.ChangetheorderButton.ButtonPushedFcn = createCallbackFcn(app, @ChangetheorderButtonPushed, true);
            app.ChangetheorderButton.Position = [236 12 109 22];
            app.ChangetheorderButton.Text = 'Change the order';

            % Create VisualizationModeLabel
            app.VisualizationModeLabel = uilabel(app.RightPanel);
            app.VisualizationModeLabel.FontName = 'Arial Black';
            app.VisualizationModeLabel.FontSize = 20;
            app.VisualizationModeLabel.FontColor = [0 0 1];
            app.VisualizationModeLabel.Position = [92 528 213 32];
            app.VisualizationModeLabel.Text = 'Visualization Mode';

            % Create Image14
            app.Image14 = uiimage(app.RightPanel);
            app.Image14.BackgroundColor = [1 1 1];
            app.Image14.Position = [1 29 380 347];

            % Create slowModebarMapPanel
            app.slowModebarMapPanel = uipanel(app.RightPanel);
            app.slowModebarMapPanel.TitlePosition = 'centertop';
            app.slowModebarMapPanel.Title = 'slow Mode(bar Map)';
            app.slowModebarMapPanel.Visible = 'off';
            app.slowModebarMapPanel.BackgroundColor = [1 1 1];
            app.slowModebarMapPanel.Position = [6 381 119 43];

            % Create Button_4
            app.Button_4 = uibutton(app.slowModebarMapPanel, 'push');
            app.Button_4.ButtonPushedFcn = createCallbackFcn(app, @Button_4Pushed, true);
            app.Button_4.Position = [78 1 31 22];
            app.Button_4.Text = '√';

            % Create ListBox
            app.ListBox = uilistbox(app.RightPanel);
            app.ListBox.Items = {'Heatmap', 'Bar Map', 'Time Lapse', ''};
            app.ListBox.ValueChangedFcn = createCallbackFcn(app, @ListBoxValueChanged, true);
            app.ListBox.FontSize = 18;
            app.ListBox.FontColor = [0 0.4471 0.7412];
            app.ListBox.Position = [6 425 128 101];
            app.ListBox.Value = 'Heatmap';

            % Create pleasegivenamestoeachcluster_Panel
            app.pleasegivenamestoeachcluster_Panel = uipanel(app.RightPanel);
            app.pleasegivenamestoeachcluster_Panel.Title = 'please,give names to each cluster ^_^';
            app.pleasegivenamestoeachcluster_Panel.Position = [21 586 355 61];

            % Create fromlefttorightEditFieldLabel
            app.fromlefttorightEditFieldLabel = uilabel(app.pleasegivenamestoeachcluster_Panel);
            app.fromlefttorightEditFieldLabel.HorizontalAlignment = 'right';
            app.fromlefttorightEditFieldLabel.Position = [15 9 89 22];
            app.fromlefttorightEditFieldLabel.Text = 'from left to right';

            % Create fromlefttorightEditField
            app.fromlefttorightEditField = uieditfield(app.pleasegivenamestoeachcluster_Panel, 'text');
            app.fromlefttorightEditField.Position = [123 9 177 22];
            app.fromlefttorightEditField.Value = 'beach;sea;city';

            % Create Button_2
            app.Button_2 = uibutton(app.pleasegivenamestoeachcluster_Panel, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed2, true);
            app.Button_2.Position = [309 9 31 22];
            app.Button_2.Text = '√';

            % Create Label_11
            app.Label_11 = uilabel(app.RightPanel);
            app.Label_11.FontName = 'Arial Black';
            app.Label_11.FontSize = 20;
            app.Label_11.FontColor = [0.149 0.149 0.149];
            app.Label_11.Position = [6 551 405 32];
            app.Label_11.Text = '----------------------------------------------------------';

            % Create TimeLapsePanel
            app.TimeLapsePanel = uipanel(app.RightPanel);
            app.TimeLapsePanel.TitlePosition = 'centertop';
            app.TimeLapsePanel.Title = 'Time Lapse';
            app.TimeLapsePanel.Visible = 'off';
            app.TimeLapsePanel.BackgroundColor = [1 1 1];
            app.TimeLapsePanel.Position = [133 378 248 45];

            % Create Button_7
            app.Button_7 = uibutton(app.TimeLapsePanel, 'push');
            app.Button_7.ButtonPushedFcn = createCallbackFcn(app, @Button_7Pushed, true);
            app.Button_7.BackgroundColor = [1 1 1];
            app.Button_7.Position = [209 1 31 22];
            app.Button_7.Text = '√';

            % Create SelectPicturesDropDown_4
            app.SelectPicturesDropDown_4 = uidropdown(app.TimeLapsePanel);
            app.SelectPicturesDropDown_4.Items = {'quick', 'middle', 'slow'};
            app.SelectPicturesDropDown_4.Position = [96 1 105 22];
            app.SelectPicturesDropDown_4.Value = 'quick';

            % Create selectTempoLabel
            app.selectTempoLabel = uilabel(app.TimeLapsePanel);
            app.selectTempoLabel.Position = [8 2 76 22];
            app.selectTempoLabel.Text = 'select Tempo';

            % Create ResetButton
            app.ResetButton = uibutton(app.RightPanel, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.BackgroundColor = [1 1 1];
            app.ResetButton.Position = [304 1 82 22];
            app.ResetButton.Text = 'Reset';

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.RightPanel);
            app.UIAxes_3.XTick = [];
            app.UIAxes_3.YTick = [];
            app.UIAxes_3.Position = [6 87 375 279];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn2)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end