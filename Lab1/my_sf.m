% Not very efficient way to implement this, but it works :)

function [ Mf ] = my_sf( A, B )

    atmp = A;
    btmp = B;

    Alength = length( atmp );
    Blength = length( btmp );

    % Flip A array horizontally
    atmp = fliplr( atmp );
    btmp = fliplr( btmp );

    % Nn = 2 * N - 1
    Mflength = Alength + Blength + 1;
    
    % Declaration temp vars
    aoper = zeros( 1, Blength );
    Mftmp = zeros( 1, Mflength );

    Mftmp(1) = sum( btmp .* aoper );
    for j = 2:1:Mflength
        aoper = circshift( aoper, [0 1] );
        atmp  = circshift( atmp, [0 1] );
        aoper(1) = atmp(1);
        atmp(1) = 0;
        Mftmp(j) = sum( btmp .* aoper );
    end
    Mf = Mftmp;
end