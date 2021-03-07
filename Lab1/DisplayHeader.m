%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Function to display headers         %
%  It's really hard to make anything in this  %
%   version of MATLAB, cause it doesn't has   %
%       any normal string functionality       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ ] = DisplayHeader( header )
    header_length   = length( header );
    underscore_line = repmat( '-', 1, header_length );

    fprintf( strcat( '\n', header ) )
    fprintf( strcat( '\n', underscore_line, '\n' ) )
end

