%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = CreateSimplePlot( is_subplot, a, b, c, y, plot_title )
    if is_subplot == true
        subplot(a, b, c)
    end
    x = 0:1:length(y) - 1;
    plot( x, y )
    title( plot_title, 'Interpreter', 'none' )
end

