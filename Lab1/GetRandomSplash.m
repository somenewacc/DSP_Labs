function [ splash ] = GetRandomSplash()

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
                '[[]] lines of code! '
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

    splashessize = size(splashes);
    linelength   = splashessize(2);
    splashessize = splashessize(1);
    
    splashtmp = char( ' ' * linelength );
    
    choice = randi(splashessize);
    for i = 1:1:linelength
        splashtmp(i) = splashes( choice, i );
    end
    splash = splashtmp;
end