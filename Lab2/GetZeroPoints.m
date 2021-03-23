%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Scuffed implementation of function    %
%    to get zeros nearest to maximum     %
%                                        %
%  Author: Bezborodov Grigoriy           %
%  Github: somenewacc                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ left, right ] = GetZeroPoints( dft, max_index )

    right = 0;
    left  = 0;
    is_right = false;
    current_index = max_index;
    delta = 1;
    done = false;
    min_value = abs( dft(max_index) );
    while( ~done )
        if abs( dft(current_index) ) <= min_value
            if ~is_right
                right = current_index;
                min_value = abs( dft(current_index) );
            else
                left = current_index;
                min_value = abs( dft(current_index) );
            end
        else
            if ~is_right
                is_right = true;
                current_index = max_index;
                min_value = abs( dft(max_index) );
                delta = -1;
            else
                done = true;
            end
        end
        current_index = current_index + delta;
        if current_index >= length(dft) || current_index <= 0
            right = 0;
            left  = 0;
            break
        end
    end
end