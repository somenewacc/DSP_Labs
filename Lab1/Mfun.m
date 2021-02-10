% Fun for M sequence %

function Ms = Mfun(A,C)

atmp = A;
ctmp = C;

% M = 2^m - 1
Alength = length( atmp );
Mlength = 2 .^ Alength - 1;

% tmp arrays declaration
Mtmp  = zeros( 1, Mlength );
Phtmp = zeros( 1, Alength );

xorresult = 0;

for j = 1:1:Mlength
    % An * Cn
    for i = 1:1:Alength
        Phtmp(i) = atmp(i) * ctmp(i);
    end
    % A1 * C1 xor A2 * C2 xor ...
    for i = 1:1:Alength
        xorresult = xor( xorresult, Phtmp(i) );
    end
    % 0 = 1, 1 = -1
    if ( xorresult == 0 ); Mtmp(j) = 1; else; Mtmp(j) = -1; end
    
    % concat xorresult + A >> 1
    atmp = circshift( atmp, [0 1] );
    atmp(1) = xorresult;
    xorresult = 0;
end

Ms = Mtmp;