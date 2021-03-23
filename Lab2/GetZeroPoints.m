%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Fast implementation of function to    %
%      get zeros nearest to maximum      %
%                                        %
%  Author: Bezborodov Grigoriy           %
%  Github: somenewacc                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ left, right ] = GetZeroPoints( dft, max_index )

    right = 0;
    left  = 0;
    is_zero_point_right = false;
    current_index = max_index;
    delta = 1;
    done = false;
    while( ~done )
        if floor( abs( dft(current_index) ) ) == 0
            if ~is_zero_point_right
                right = current_index;
                current_index = max_index;
                delta = -1;
                is_zero_point_right = true;
            else
                left = current_index;
                done = true;
            end
        end
        current_index = current_index + delta;
        if current_index >= length(dft) || current_index <= 0
            break
        end
    end
end