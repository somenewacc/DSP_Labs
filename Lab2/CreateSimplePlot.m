%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to create a pretty simple plot  %
%     That used frequently in this work     %
%                                           %
%  Author: Bezborodov Grigoriy              %
%  Github: somenewacc                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = CreateSimplePlot( is_subplot, is_stem, a, b, c, y, plot_title )

    if is_subplot
        subplot(a, b, c)
    end
    if is_stem
        stem(y, '.b')
        hold on
        plot(y, '.r-')
    else
        plot(y)
    end

    % Get rid of interpreters since we don't have any TeX in this case
    title( plot_title, 'Interpreter', 'none' )
end