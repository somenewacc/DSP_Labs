%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to generate M-function  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Ms ] = Mfun( A, C )

    % Just for fun, don't think it's necessary here
    if length(A) ~= length(C)
        exception = MException('Mfun:lengthError', 'Lengths must be equal!');
        throw(exception)
    end

    a_tmp = A;
    c_tmp = C;

    % N = 2^m - 1
    A_length = length( a_tmp );
    M_length = 2 .^ A_length - 1;

    % tmp arrays declaration
    M_tmp  = zeros( 1, M_length );
    Ph_tmp = zeros( 1, A_length );

    xor_result = 0;

    for j = 1:1:M_length
        % An * Cn
        for i = 1:1:A_length
            Ph_tmp(i) = a_tmp(i) * c_tmp(i);
        end
        % A1 * C1 xor A2 * C2 xor ...
        for i = 1:1:A_length
            xor_result = xor( xor_result, Ph_tmp(i) );
        end
        % 0 = 1, 1 = -1
        if ( xor_result == 0 ); M_tmp(j) = 1; else M_tmp(j) = -1; end
        
        % concat xor_result + A >> 1
        a_tmp = circshift( a_tmp, [0 1] );
        a_tmp(1) = xor_result;
        xor_result = 0;
    end

    Ms = M_tmp;
end