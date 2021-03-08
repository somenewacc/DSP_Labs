%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function to decode fast transformed  %
%         Walsh-Hadamard code           %
%                                       %
%  Author: Bezborodov Grigoriy          %
%  Github: somenewacc                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ decoded_array, indexes ] = ProofOfConcept( Bp, r )

    Bp_tmp = Bp;
    
    Bp_length = length(Bp);

    % Value to find in code
    salt      = 2 ^ r;

    % I made this because we also have noisy codes
    % Normally you can set delta like +-( salt / 2)
    range_lower = salt - ( salt / 2 );
    range_upper = salt + ( salt / 2 );

    decoded_array = zeros( 1, Bp_length );
    indexes       = zeros( 1, Bp_length );
    for i = 1:1:Bp_length
        if abs( Bp_tmp(i) ) >= range_lower  && abs( Bp_tmp(i) ) <= range_upper
            % Length of binary must be same with 'r'
            % right-msb as default, so we don't
            % have to flip this number
            binary_number = de2bi(i - 1, r);
            decoded_number = bi2de(binary_number, 'left-msb');
            % If peak is negative - decoded number must be
            % also negative.
            if Bp_tmp(i) < 0
                decoded_number = decoded_number * -1;
            end
            decoded_array(i) = decoded_number;
            indexes(i)       = i - 1;
        end
    end

    % Get rid of zeros
    decoded_array = decoded_array( decoded_array~=0 );
    indexes       = indexes( indexes~=0 );
end