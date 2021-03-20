%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Implementation of Shiro's machine  %
%   to generate Walsh-Hadamard code   %
%                                     %
%  Author: Bezborodov Grigoriy        %
%  Github: somenewacc                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ W ] = Wfun( data, r )

    data_tmp = data;

    W_length = 2 ^ r;
    T_length = 2 ^ ( r - 1 );

    W_tmp = zeros( 1, W_length );
    T_tmp = zeros( 1, T_length );

    data_binary = de2bi(data_tmp, 'left-msb');
    % Length of data_binary and r must be equal
    data_binary = [ zeros( 1, r - length( data_binary ) ) data_binary ];

    % First element of code is always 1 (inverted 0)
    W_tmp(1) = 1;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Shiro's algorithm                %
    % Example (r = 3, data = 5 - 101): %
    %                                  %
    %    |T1|T2|T3|T4|2^x|MX|sg|       %
    % 0: |0 |0 |0 |0 |zzz|0 | 1|       %
    % 1: |0+|0 |0 |0 |2-1|1 |-1|       %
    % 2: |1 |0+|0 |0 |1-0|0 | 1|       %
    % 3: |0 |1+|0 |0 |1-0|1 |-1|       %
    % 4: |1 |0 |1 |0+|0-1|1 |-1|       %
    % 5: |1 |1 |0 |1+|0-1|0 | 1|       %
    % 6: |0 |1 |1 |0+|0-1|1 |-1|       %
    % 7: |1 |0 |1 |1+|0-1|0 | 1|       %
    %                                  %
    % Note: previous MX shifts into T  %
    % from left every iteration        %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 2:1:2^r
        % Pretty neat hack to get the right index
        k = floor( log2( i - 1 ) );

        xor_result = xor( T_tmp( 2 ^ k ), data_binary( k + 1 ) );
        T_tmp = circshift( T_tmp, [0 1] );

        T_tmp(1) = xor_result;

        if ( xor_result == 0 ); W_tmp(i) = 1; else W_tmp(i) = -1; end
    end

    W = W_tmp;
end