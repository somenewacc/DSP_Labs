%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Pretty neat function to get a noise.  %
%                  Why?                  %
%              Who knows...              %
%                                        %
%  Author: Bezborodov Grigoriy           %
%  Github: somenewacc                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ noise ] = GetRandomNoise( A, length )

    noise = A - 2 * A * rand( 1, length );
end