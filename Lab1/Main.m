%%%%%%%%%%%%%%%%%%%
% Var 2           %
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
Var        = 2;
Work       = 1;

A  = [1 0 0 0 0 0 0 0 1 0];
C1 = [0 0 0 0 1 0 0 1 1 1];
C2 = [0 0 0 0 1 0 1 1 0 1];

fprintf('*********DSP Lab Work %g*********\n', Work)
fprintf('********Work variant = %g********\n', Var)

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
shift = 100 + Var * 10;
fprintf('Shift = %g\n', shift)

M1_shifted = [M1, zeros(1, shift)];
M2_shifted = [zeros(1, shift), -M2];

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

% MsumFiltered1 = Msum, M1
MsumFiltered1 = my_sf(Msum, M1);

% MsumFiltered2 = Msum, M2
MsumFiltered2 = my_sf(Msum, M2);

%               Debug             %
if debug_info == true
    disp('AKF = ')
    disp(AKF)
    disp('VKF = ')
    disp(VKF)
    disp('MsumFiltered1 = ')
    disp(MsumFiltered1)
    disp('MsumFiltered2 = ')
    disp(MsumFiltered2)
else
    fprintf('AKF - Done! Max position = %g\n', find(AKF == max(AKF)))
    disp('VKF - Done!')
    fprintf('MsumFiltered1 - Done! Max position = %g', find(MsumFiltered1 == max(MsumFiltered1)))
    fprintf('\nMsumFiltered2 - Done! Min position = %g\n', find(MsumFiltered2 == min(MsumFiltered2)))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ')
disp('- Filtering by built-in function:')
% AKF = M1, M1
AKFxcorr = xcorr(M1, M1);

% VKF = M2, M1
VKFxcorr = xcorr(M2, M1);

% MsumFiltered1 = Msum, M1
MsumFiltered1xcorr = xcorr(Msum, M1);

% MsumFiltered2 = Msum, M2
MsumFiltered2xcorr = xcorr(Msum, M2);

%               Debug             %
if debug_info == true
    disp('AKFxcorr = ')
    disp(AKFxcorr)
    disp('VKFxcorr = ')
    disp(VKFxcorr)
    disp('MsumFiltered1xcorr = ')
    disp(MsumFiltered1xcorr)
    disp('MsumFiltered2xcorr = ')
    disp(MsumFiltered2xcorr)
else
    fprintf('AKFxcorr - Done! Max position = %g\n', find(AKFxcorr == max(AKFxcorr)))
    disp('VKFxcorr - Done!')
    fprintf('MsumFiltered1xcorr - Done! Max position = %g', find(MsumFiltered1xcorr == max(MsumFiltered1xcorr)))
    fprintf('\nMsumFiltered2xcorr - Done! Min position = %g\n', find(MsumFiltered2xcorr == min(MsumFiltered2xcorr)))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plots creating %%
DisplayHeader('Creating plots...')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

CreateSimplePlot( true, 4, 2, 1, AKF, 'my_sf(M1, M1)' )
CreateSimplePlot( true, 4, 2, 2, AKFxcorr, 'xcorr(M1, M1)' )
CreateSimplePlot( true, 4, 2, 3, VKF, 'my_sf(M2, M1)' )
CreateSimplePlot( true, 4, 2, 4, VKFxcorr, 'xcorr(M2, M1)' )
CreateSimplePlot( true, 4, 2, 5, MsumFiltered1, 'my_sf(Msum, M1)' )
CreateSimplePlot( true, 4, 2, 6, MsumFiltered1xcorr, 'xcorr(Msum, M1)' )
CreateSimplePlot( true, 4, 2, 7, MsumFiltered2, 'my_sf(Msum, M2)' )
CreateSimplePlot( true, 4, 2, 8, MsumFiltered2xcorr, 'xcorr(Msum, M2)' )

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