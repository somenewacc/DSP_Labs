%%%%%%%%%%%%%%%%%%%
% variant 2           %
% A  = 1000000010 %
% C1 = 0000100111 %
% C2 = 0000101101 %
%%%%%%%%%%%%%%%%%%%

% Maybe pretty much overloaded implementation of this laboratory work.
% But why not?

%% Globals %%
close all
clear
clc

debug_info = false;
variant    = 2;
work       = 1;

A  = [1 0 0 0 0 0 0 0 1 0];
C1 = [0 0 0 0 1 0 0 1 1 1];
C2 = [0 0 0 0 1 0 1 1 0 1];

fprintf('*********DSP Lab Work %g*********\n', work)
fprintf('********work variant = %g********\n', variant)

DisplayHeader('Phase 1: Synthesis and filtering of M-sequences')

%% Generate M1 and M2 %%
DisplayHeader('Generate M1 and M2:')
M1 = Mfun( A, C1 );
M2 = Mfun( A, C2 );

%            Debug         %
if debug_info == true
    disp('M1 = ')
    disp(M1)
    disp('M2 = ')
    disp(M2)
else
    disp('M1 - Done!')
    disp('M2 - Done!')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Msum %%
DisplayHeader('Generate Msum:')
shift = 100 + variant * 10;
fprintf('Shift = %g\n', shift)

M1_shifted = [ M1, zeros( 1, shift ) ];
M2_shifted = [ zeros( 1, shift ), -M2 ];

Msum = M1_shifted + M2_shifted;

%            Debug         %
if debug_info == true
    disp('M1_shifted = ')
    disp(M1_shifted)
    disp('M2_shifted = ')
    disp(M2_shifted)
    disp('Msum = ')
    disp(Msum)
else
    disp('Msum - Done!')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plot creating %%
DisplayHeader('Creating plots...')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

CreateSimplePlot( true, 3, 1, 1, M1, 'M1' )
CreateSimplePlot( true, 3, 1, 2, M2, 'M2' )
CreateSimplePlot( true, 3, 1, 3, Msum, 'Msum' )

disp('Plots created!')

%% my_sf %%
DisplayHeader('Filtering signals...')
disp('- Filtering by own function:')
% AKF = M1, M1
AKF = my_sf(M1, M1);

% VKF = M2, M1
VKF = my_sf(M2, M1);

% Msum_filtered1 = Msum, M1
Msum_filtered1 = my_sf(Msum, M1);

% Msum_filtered2 = Msum, M2
Msum_filtered2 = my_sf(Msum, M2);

%               Debug             %
if debug_info == true
    disp('AKF = ')
    disp(AKF)
    disp('VKF = ')
    disp(VKF)
    disp('Msum_filtered1 = ')
    disp(Msum_filtered1)
    disp('Msum_filtered2 = ')
    disp(Msum_filtered2)
else
    fprintf('AKF - Done! Max position = %g\n', find( AKF == max( AKF ) ))
    disp('VKF - Done!')
    fprintf('Msum_filtered1 - Done! Max position = %g', find( Msum_filtered1 == max( Msum_filtered1 ) ))
    fprintf('\nMsumFiltered2 - Done! Min position = %g\n', find( Msum_filtered2 == min( Msum_filtered2 ) ))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ')
disp('- Filtering by built-in function:')
% AKF = M1, M1
AKF_xcorr = xcorr(M1, M1);

% VKF = M2, M1
VKF_xcorr = xcorr(M2, M1);

% Msum_filtered1 = Msum, M1
Msum_filtered1_xcorr = xcorr(Msum, M1);

% Msum_filtered2 = Msum, M2
Msum_filtered2_xcorr = xcorr(Msum, M2);

%               Debug             %
if debug_info == true
    disp('AKF_xcorr = ')
    disp(AKF_xcorr)
    disp('VKF_xcorr = ')
    disp(VKF_xcorr)
    disp('Msum_filtered1_xcorr = ')
    disp(Msum_filtered1_xcorr)
    disp('Msum_filtered2_xcorr = ')
    disp(Msum_filtered2_xcorr)
else
    fprintf('AKF_xcorr - Done! Max position = %g\n', find( AKF_xcorr == max( AKF_xcorr ) ))
    disp('VKF_xcorr - Done!')
    fprintf('Msum_filtered1_xcorr - Done! Max position = %g', find( Msum_filtered1_xcorr == max( Msum_filtered1_xcorr ) ))
    fprintf('\nMsumFiltered2xcorr - Done! Min position = %g\n', find( Msum_filtered2_xcorr == min( Msum_filtered2_xcorr ) ))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plots creating %%
DisplayHeader('Creating plots...')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

CreateSimplePlot( true, 4, 2, 1, AKF, 'my_sf(M1, M1)' )
CreateSimplePlot( true, 4, 2, 2, AKF_xcorr, 'xcorr(M1, M1)' )
CreateSimplePlot( true, 4, 2, 3, VKF, 'my_sf(M2, M1)' )
CreateSimplePlot( true, 4, 2, 4, VKF_xcorr, 'xcorr(M2, M1)' )
CreateSimplePlot( true, 4, 2, 5, Msum_filtered1, 'my_sf(Msum, M1)' )
CreateSimplePlot( true, 4, 2, 6, Msum_filtered1_xcorr, 'xcorr(Msum, M1)' )
CreateSimplePlot( true, 4, 2, 7, Msum_filtered2, 'my_sf(Msum, M2)' )
CreateSimplePlot( true, 4, 2, 8, Msum_filtered2_xcorr, 'xcorr(Msum, M2)' )

disp('Plots created!')

%% Noise reduction %%
DisplayHeader('Noise reduction:')
disp('- Create noise:')
noise = GetRandomNoise( 2, length(M1) );

%          Debug         %
if debug_info == true
    disp('noise =')
    disp(noise)
else
    disp('Noise - Done!')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('- Create M3 = M1 + noise:')
M3 = M1 + noise;

%          Debug         %
if debug_info == true
    disp('M3 =')
    disp(M3)
else
    disp('M3 - Done!')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('- Filter M3:')
M3_filtered = my_sf( M3, M1 );

%            Debug            %
if debug_info == true
    disp('M3_filtered =')
    disp(M3_filtered)
else
    disp('M3_filtered - Done!')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('- Generating dB:')
dB = 20 * log10( abs( M3_filtered ./ max( M3_filtered ) ) );

%% Plots creating %%
DisplayHeader('Creating plots...')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

CreateSimplePlot( true, 3, 1, 1, M3, 'M3' )
CreateSimplePlot( true, 3, 1, 2, M3_filtered, 'my_sf(M3, M1)' )
CreateSimplePlot( true, 3, 1, 3, dB, 'my_sf(M3, M1), dB' )

disp('Plots created!')

DisplayHeader('End of phase 1...')