% Not very efficient way to implement this, but it works :)

function [ Mf ] = my_sf( A, B )

    atmp = A;
    btmp = B;

    Alength = length( atmp );
    Blength = length( btmp );

    % Flip A and B arrays horizontally
    atmp = fliplr( atmp );
    btmp = fliplr( btmp );

    % Nn = Na + Nb + 1 
    % Not sure about this, because I use algorithm 
    % that I used while paperwork.
    Mflength = Alength + Blength + 1;
    
    % Declaration temp vars
    aoper = zeros( 1, Blength );
    Mftmp = zeros( 1, Mflength );

    % First with full 0 in signal b4 1st shift
    Mftmp(1) = sum( btmp .* aoper );
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Shift signal into source %
    % Example (src = 011):     %
    %                          %
    %    |sig|src| * |xor|     %
    % 0: |101|000|000| 0 |     %
    % 1: | 10|100|000| 0 |     %
    % 2: |  1|010|010| 1 |     %
    % 3: |   |101|001| 1 |     %
    % 4: |   |010|010| 1 |     %
    % 5: |   |001|001| 1 |     %
    % 6: |   |000|000| 0 |     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j = 2:1:Mflength
        aoper = circshift( aoper, [0 1] );
        atmp  = circshift( atmp, [0 1] );
        aoper(1) = atmp(1);
        atmp(1) = 0;
        Mftmp(j) = sum( btmp .* aoper );
    end
    Mf = Mftmp;
end