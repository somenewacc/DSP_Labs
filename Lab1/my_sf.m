function [ Mf ] = my_sf( A, B )

    % if length(A) ~= length(B)
        % exception = MException('Mfun:lengthError', 'Lengths must be equal!');
        % throw(exception)

    atmp = A;
    btmp = B;

    Alength = length( atmp );

    atmp  = fliplr( atmp );
    aoper = zeros( 1, Alength );
    Mflength = 2 .* Alength - 1;
    Mftmp = zeros(1, Mflength);
    for j = 1:1:Mflength
        for i = Alength:-1:2
            aoper(i) = aoper(i - 1);
            if j > Alength
                aoper(1) = 0;
            else
                aoper(1) = btmp(j);
            end
        end
        Mftmp(j) = sum( atmp .* aoper );
    end
    Mf = Mftmp;

end

