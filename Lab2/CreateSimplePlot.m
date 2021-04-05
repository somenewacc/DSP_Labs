%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%                                           %
%  Arguments:                               %
%  <'subplot', [a b c]>                     %
%  <'custom_x', x>                          %
%  <'stem'>                                 %
%  <'title', charstr>                       %
%  Author: Bezborodov Grigoriy              %
%  Github: somenewacc                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Use inputParser

function [] = CreateSimplePlot( y, varargin )

    varargin_str = cellfun( @(x) num2str(x), varargin, 'UniformOutput', 0 );

    %% Draw plot in subplot %%
    if ismember( 'subplot', varargin_str )
        subplot_values_idx = find( strcmp( varargin_str, 'subplot' ) ) + 1;
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

    %% Define custom x instead of '0:1:length(y) - 1' %%
    if ismember( 'custom_x', varargin_str )
        x_idx = find( strcmp( varargin_str, 'custom_x' ) ) + 1;
        x_tmp = varargin{x_idx};
        if isnumeric( x_tmp ) && length( x_tmp ) == length(y)
            x = x_tmp;
        else
            fprintf('Problem with x value, using default!\n')
            x = 0:1:length(y) - 1;
        end
    else
        x = 0:1:length(y) - 1;
    end

    %% Stemmed plot %%
    if ismember( 'stem', varargin_str )
        stem( x, y, '.b' )
        hold on
        plot( x, y, '.r-' )
    else
        plot( x, y )
    end

    %% Add title to plot %%
    if ismember( 'title', varargin_str )
        title_idx = find( strcmp( varargin_str, 'title' ) ) + 1;
        plot_title = varargin{title_idx};
        title( plot_title, 'Interpreter', 'none' )
    end
end