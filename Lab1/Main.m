% Var 2           %
% A  = 1000000010 %
% C1 = 0000100111 %
% C2 = 0000101101 %
% TODO:           %
% my_sf is bad    %
% doesn't work    %
% need to rewrite %

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

%% 1st %%
fprintf('1st and 2nd tasks:\n')
disp('------------------')
M1 = Mfun(A, C1);
M2 = Mfun(A, C2);

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
fprintf('\n3rd task:\n')
disp('---------')
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
fprintf('\nCreating plots...\n')
disp('-----------------')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

% M1
subplot(3, 1, 1)
x = 0:1:length(M1) - 1;
plot(x, M1)
title('M1')

% M2
clear x
subplot(3, 1, 2)
x = 0:1:length(M2) - 1;
plot(x, M2)
title('M2')

% Msum
clear x
subplot(3, 1, 3)
x = 0:1:length(Msum) - 1;
plot(x, Msum)
title('Msum')

clear x
disp('Plots created!')

%% my_sf %%
fprintf('\nFiltering signals...\n')
disp('-----------------')
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
fprintf('\nCreating plots...\n')
disp('-----------------')

% Generating random window title
splash = GetRandomSplash();
figure('Name', splash, 'NumberTitle', 'off')

% TODO:
% There must be an easier and prettier
% way to implement multiple plot creating

% AKF
subplot(4, 2, 1)
x = 0:1:length(AKF) - 1;
plot(x, AKF)
title('my_sf(M1, M1)', 'Interpreter', 'none')

% AKFxcorr
subplot(4, 2, 2)
x = 0:1:length(AKFxcorr) - 1;
plot(x, AKFxcorr)
title('xcorr(M1, M1)')

% VKF
clear x
subplot(4, 2, 3)
x = 0:1:length(VKF) - 1;
plot(x, VKF)
title('my_sf(M2, M1)', 'Interpreter', 'none')

% VKFxcorr
clear x
subplot(4, 2, 4)
x = 0:1:length(VKFxcorr) - 1;
plot(x, VKFxcorr)
title('xcorr(M2, M1)')

% MsumFiltered1
clear x
subplot(4, 2, 5)
x = 0:1:length(MsumFiltered1) - 1;
plot(x, MsumFiltered1)
title('my_sf(Msum, M1)', 'Interpreter', 'none')

% MsumFiltered1xcorr
clear x
subplot(4, 2, 6)
x = 0:1:length(MsumFiltered1xcorr) - 1;
plot(x, MsumFiltered1xcorr)
title('xcorr(Msum, M1)')

% MsumFiltered2
clear x
subplot(4, 2, 7)
x = 0:1:length(MsumFiltered2) - 1;
plot(x, MsumFiltered2)
title('my_sf(Msum, M2)', 'Interpreter' ,'none')

% MsumFiltered2xcorr
clear x
subplot(4, 2, 8)
x = 0:1:length(MsumFiltered2xcorr) - 1;
plot(x, MsumFiltered2xcorr)
title('xcorr(Msum, M2)')

clear x
disp('Plots created!')