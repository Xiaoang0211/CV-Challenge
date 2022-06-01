classdef DialogWindow_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure    matlab.ui.Figure
        InthisWindowyoushouldgivenametoeachclusterForexampleForLabel  matlab.ui.control.Label
        InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_2  matlab.ui.control.Label
        InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_3  matlab.ui.control.Label
        row         matlab.ui.control.NumericEditField
        col1        matlab.ui.control.NumericEditField
        col2        matlab.ui.control.NumericEditField
        InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_4  matlab.ui.control.Label
        InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_5  matlab.ui.control.Label
        okayButton  matlab.ui.control.Button
    end


    properties (Access = private)
        CallingApp % Description
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, mainapp, row, col1, col2)
            app.CallingApp = mainapp;
            app.row.Value=row;
            app.col1.Value=col1;
            app.col2.Value=col2;
            % Update UI with input values
        end

        % Button pushed function: okayButton
        function okayButtonPushed(app, event)
            %updateplot(app.CallingApp, app.EditField.Value, app.DropDown.Value);
            updateplot(app.CallingApp, app.row.Value, app.col1.Value,app.col2.Value);
            % Delete the dialog box
            delete(app)
        end

        % Close request function: UIFigure
        function UIFigureCloseRequest(app, event)

            app.CallingApp.ChangetheorderButtonPushed.Enable = 'on';

            % Delete the dialog box
            delete(app)
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 511 132];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @UIFigureCloseRequest, true);

            % Create InthisWindowyoushouldgivenametoeachclusterForexampleForLabel
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel = uilabel(app.UIFigure);
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel.Position = [2 103 519 22];
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel.Text = 'In this Window,you should give name to each cluster(For example, In picture Dubai,The names';

            % Create InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_2
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_2 = uilabel(app.UIFigure);
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_2.Position = [2 82 509 22];
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_2.Text = 'can be beach,sea and city.and the number of names are equal to the number of clusters and ';

            % Create InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_3
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_3 = uilabel(app.UIFigure);
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_3.Position = [2 61 420 22];
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_3.Text = 'the number of columns in this picture. Now let us accept the assumption,this ';

            % Create row
            app.row = uieditfield(app.UIFigure, 'numeric');
            app.row.Position = [57 18 37 22];
            app.row.Value = 1;

            % Create col1
            app.col1 = uieditfield(app.UIFigure, 'numeric');
            app.col1.Position = [215 18 37 22];
            app.col1.Value = 1;

            % Create col2
            app.col2 = uieditfield(app.UIFigure, 'numeric');
            app.col2.Position = [269 18 37 22];
            app.col2.Value = 2;

            % Create InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_4
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_4 = uilabel(app.UIFigure);
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_4.Position = [13 18 28 22];
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_4.Text = 'row ';

            % Create InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_5
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_5 = uilabel(app.UIFigure);
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_5.Position = [175 18 25 22];
            app.InthisWindowyoushouldgivenametoeachclusterForexampleForLabel_5.Text = 'col';

            % Create okayButton
            app.okayButton = uibutton(app.UIFigure, 'push');
            app.okayButton.ButtonPushedFcn = createCallbackFcn(app, @okayButtonPushed, true);
            app.okayButton.Position = [348 18 100 22];
            app.okayButton.Text = 'okay';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = DialogWindow_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

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