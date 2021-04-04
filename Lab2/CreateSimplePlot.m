%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%                                           %
%  Author: Bezborodov Grigoriy              %
%  Github: somenewacc                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: User inputParser

function [] = CreateSimplePlot( y, varargin )

    varargin_str = cellfun(@(x) num2str(x), varargin, 'UniformOutput',0);
    if ismember('subplot', varargin_str)
        subplot_values_idx = find(strcmp(varargin_str, 'subplot')) + 1;
        subplot_values = varargin{subplot_values_idx};
        if length(subplot_values) == 3
            a = subplot_values(1);
            b = subplot_values(2);
            c = subplot_values(3);
            subplot(a, b, c)
        else
            fprintf('Wrong subplot values!\n')
        end
    end

    if ismember('custom_x', varargin_str)
        x_idx = find(strcmp(varargin_str, 'custom_x')) + 1;
        if isnumeric(varargin{x_idx}) && length(varargin{x_idx}) == length(y)
            x = varargin{x_idx};
        else
            fprintf('Problem with x value, using default!\n')
            x = 0:1:length(y) - 1;
        end
    else
        x = 0:1:length(y) - 1;
    end

    if ismember('stem', varargin_str)
        stem(x, y, '.b')
        hold on
        plot(x, y, '.r-')
    else
        plot(x, y)
    end

    if ismember('title', varargin_str)
        title_idx = find(strcmp(varargin_str, 'title')) + 1;
        plot_title = varargin{title_idx};
        title( plot_title, 'Interpreter', 'none' )
    end
end