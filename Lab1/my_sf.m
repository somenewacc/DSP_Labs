% Absolute bs, doesn't work at all...

function [ Mf ] = my_sf( A, B )

    atmp = A;
    btmp = B;

    Alength = length( atmp );
    Blength = length( btmp );

    % Flip A array horizontally
    atmp  = fliplr( atmp );

    % Nn = 2 * N - 1
    Mflength = 2 .* Alength - 1;
    
    % Declaration temp vars
    aoper = zeros( 1, Alength );
    Mftmp = zeros( 1, Mflength );

    for j = 1:1:Mflength
        for i = Alength:-1:2
            aoper(i) = aoper(i - 1);
            if j > Blength
                aoper(1) = 0;
            else
                aoper(1) = btmp(j);
            end
        end
        Mftmp(j) = sum( atmp .* aoper );
    end
    Mf = Mftmp;

end