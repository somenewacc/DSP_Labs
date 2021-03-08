%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Implementation of fast Walsh transform  %
%         Butterflies, butterflies...      %
%                                          %
%  Author: Bezborodov Grigoriy             %
%  Github: somenewacc                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Bp ] = Bpfun( w, r )

    current_layer = w;
    
    w_length = length( w );

    next_layer = zeros( 1, w_length );

    % Length between origins of 'wing'
    delta = w_length / 2;
    
    % I think that it's more reliable
    % to make 'while delta >= 1' loop
    % but if I have 'r' as input
    % it should be ok with it
    position = 1;
    for i = 1:1:r
        % It's better to use while loop with current possition in layer
        while position <= w_length
            %%%%%%%%%%%%%%%%%%%%%
            % Walsh's butterfly %
            %       A   C       %
            %        \ /        %
            %         \         % 
            %        / \        %
            %       B   D       %
            %                   %
            % C = A + B         %
            % D = A - B         %
            %                   %
            % delta halves      %
            % every layer       %
            %%%%%%%%%%%%%%%%%%%%%
            next_layer(position)         = current_layer(position) + current_layer(position + delta);
            next_layer(position + delta) = current_layer(position) - current_layer(position + delta);

            % Butterflies sworm has length equals to delta
            % If sworm is over - jump to next sworm
            if mod( position, delta ) == 0
                position = position + delta + 1;
            else
                position = position + 1;
            end
        end
        % Latest layer is an answer
        Bp = next_layer;
        
        % Jump to next layer
        current_layer = next_layer;
        next_layer = next_layer * 0;
        delta = delta / 2;
        position = 1;
    end
end