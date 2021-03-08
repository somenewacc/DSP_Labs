%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%                                           %
%  Author: Bezborodov Grigoriy              %
%  Github: somenewacc                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = CreateSimplePlot( is_subplot, a, b, c, y, plot_title )

    if is_subplot == true
        subplot(a, b, c)
    end
    x = 0:1:length(y) - 1;
    plot( x, y )

    % Get rid of interpretes since we don't have any TeX in this case
    title( plot_title, 'Interpreter', 'none' )
end