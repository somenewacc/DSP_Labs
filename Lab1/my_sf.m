%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Implementation of matched filter      %
%  Not very efficient way to implement this,  %
%               but it works :)               %
%                                             %
%  Author: Bezborodov Grigoriy                %
%  Github: somenewacc                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Mf ] = my_sf( A, B )

    a_tmp = A;
    b_tmp = B;

    A_length = length( a_tmp );
    B_length = length( b_tmp );

    % Max length to calculate the size
    % of Mf
    max_length = max([A_length B_length]);

    % To calculate zeros from the beginning
    % or from the end
    length_delta = A_length - B_length;

    if length_delta < 0
        length_delta = 0;
    end

    % Flip A and B arrays horizontally
    a_tmp = fliplr( a_tmp );
    b_tmp = fliplr( b_tmp );

    % Decided to make 2 * max - 1 cause it would
    % completely match with xcorr
    Mf_length = 2 * max_length - 1;
    
    % Declaration temp vars
    a_oper = zeros( 1, B_length );
    Mf_tmp = zeros( 1, Mf_length );

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Shift signal into source %
    % Example (src = 011):     %
    %                          %
    %    |sig|src| * |sum|     %
    % 0: |101|000|000| 0 |     %
    % 1: | 10|100|000| 0 |     %
    % 2: |  1|010|010| 1 |     %
    % 3: |   |101|001| 1 |     %
    % 4: |   |010|010| 1 |     %
    % 5: |   |001|001| 1 |     %
    % 6: |   |000|000| 0 |     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j = length_delta + 1:1:Mf_length
        a_oper = circshift( a_oper, [0 1] );
        a_tmp  = circshift( a_tmp, [0 1] );

        a_oper(1) = a_tmp(1);
        a_tmp(1)  = 0;

        Mf_tmp(j) = sum( b_tmp .* a_oper );
    end

    Mf = Mf_tmp;
end