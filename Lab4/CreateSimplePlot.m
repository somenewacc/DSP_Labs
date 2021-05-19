%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%                                           %
%  Arguments:                               %
%  <'subplot', [a b c]>                     %
%  <'custom_x', x>                          %
%  <'stem'>                                 %
%  <'title', charstr>                       %
%  <'xlabel', charstr>                      %
%  <'ylabel', charstr>                      %
%  <'hold'>                                 %
%  <'grid'>                                 %
%                                           %
%  Author: Bezborodov Grigoriy              %
%  Github: somenewacc                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Use inputParser

function [] = CreateSimplePlot( y, varargin )

    % Make sure that encoding is UTF-8
    % to display right unicode symbols
    if ~strcmp(slCharacterEncoding, 'UTF-8')
        slCharacterEncoding('UTF-8');
    end
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
        if ismember( 'complex', varargin_str )
            plot( x, real(y), x, imag(y), 'r' )
        else
            plot( x, y )
        end
    end

    %% Add title to plot %%
    if ismember( 'title', varargin_str )
        title_idx = find( strcmp( varargin_str, 'title' ) ) + 1;
        plot_title = varargin{title_idx};
        title( plot_title, 'Interpreter', 'none' )
    end

    %% Add xlabel to plot %%
    if ismember( 'xlabel', varargin_str )
        xlabel_idx = find( strcmp( varargin_str, 'xlabel' ) ) + 1;
        xlabel_data = varargin{xlabel_idx};
        xlabel( xlabel_data, 'Interpreter', 'none' )
    end

    %% Add ylabel to plot %%
    if ismember( 'ylabel', varargin_str )
        ylabel_idx = find( strcmp( varargin_str, 'ylabel' ) ) + 1;
        ylabel_data = varargin{ylabel_idx};
        ylabel( ylabel_data, 'Interpreter', 'none' )
    end

    if ismember( 'grid', varargin_str )
        grid on
    end

    if ismember( 'hold', varargin_str )
        hold on
    end
end