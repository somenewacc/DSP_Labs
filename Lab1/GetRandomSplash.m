%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Function to get random string    %
%           from char matrix           %
%     This ver of MATLAB (7.11.0)      %
%    doesn't support string arrays.    %
%  I have to create N*M matrix of ch.  %
%    Every column - single splash.     %
%                                      %
%  Author: Bezborodov Grigoriy         %
%  Github: somenewacc                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ splash ] = GetRandomSplash()

    % Hack: align lines with spaces.
    splashes = ['Dont look at me     '
                'Macroscopic!        '
                'Ultimate edition!   '
                'Random splash!      '
                'Notch <3 ez!        '
                'Not linear!         '
                'Whoa, dude!         '
                'sqrt(-1) love you!  '
                'Lets dance!         '
                '20 GOTO 10!         '
                '790 lines of code!  '
                'I miss ADOM!        '
                'More Digital!       '
                'Absolutely no memes!'
                'Matlabicious edition'
                'GNU Terry Pratchett '
                'Made by Bezborodov! '
                'Pumpkinhead!        '
                'Also try Limbo!     '
                'i h8 my life        '
                '...!                '
                '90% bug free!       '
                'Awesome!            '
                '1% sugar!           '
                'Spiders everywhere! '
                'Check it out!       '
                'Singleplayer!       '
                'L33t!               '
                'Its a game!         '
                'Not on steam!       '
                'Thats no moon!      '
                'Closed source!      '
                'Pixels!             '
                '12 herbs and spices!'
                'Fat free!           '
                'More than 500 sold! '
                'Never dig down!     '
                'More polygons!      '
                'Now with difficulty!'
                'OpenGL 2.1!         '
                'Something funny!    '
                'Sublime!            '
                'Stay safe!          '
                'Tip your waiter!    '
                'Twittered about!    '
                'Very fun!           '
                'Water proof!        '
                'Rainbow turtle?     '
                'Punching wood!      '
                'Pretty scary!       '
                ];

    % Get the size of matrix to
    % set splash length and
    % number of splashes
    splashes_size = size( splashes );
    line_length   = splashes_size( 2 );
    splashes_size = splashes_size( 1 );
    
    splash_tmp = repmat( ' ', 1, line_length );
    
    choice = randi( splashes_size );
    for i = 1:1:line_length
        splash_tmp(i) = splashes( choice, i );
    end

    splash = splash_tmp;
end