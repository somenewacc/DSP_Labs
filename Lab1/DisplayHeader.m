%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Function to display headers         %
%  It's really hard to make anything in this  %
%   version of MATLAB, cause it doesn't has   %
%       any normal string functionality       %
%                                             %
%  Author: Bezborodov Grigoriy                %
%  Github: somenewacc                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = DisplayHeader( header )

    header_length   = length( header );

    % All this function was made only
    % to rid of manually calculating
    % how many dashes I need to make
    % an underline.
    dash_line = repmat( '-', 1, header_length );

    fprintf( strcat( '\n', header ) )
    fprintf( strcat( '\n', dash_line, '\n' ) )
end