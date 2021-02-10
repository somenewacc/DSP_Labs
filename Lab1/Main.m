% Var 2           %
% A  = 1000000010 %
% C1 = 0000100111 %
% C2 = 0000101101 %

%% Globals %%
close
clear
clc

debug_info = false;
Var        = 2;
Work       = 1;

A  = [1 0 0 0 0 0 0 0 1 0];
C1 = [0 0 0 0 1 0 0 1 1 1];
C2 = [0 0 0 0 1 0 1 1 0 1];

disp(sprintf('*********DSP Lab Work %g*********', Work))
disp(sprintf('********Work variant = %g********', Var))

%% 1st %%
fprintf('\n1st and 2nd tasks:\n')
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
disp(sprintf('Shift = %g', shift))

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
% AKF = M1, M1
AKF = my_sf(M1, M1);

% VKF = M2, M1
VKF = my_sf(M2, M1);

% MsumFiltered1 = Msum, M1
MsumFiltered1 = my_sf(Msum, M1)

% MsumFiltered2 = Msum, M2
MsumFiltered2 = my_sf(Msum, M2)