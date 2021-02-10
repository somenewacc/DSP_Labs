% Var 2           %
% A  = 1000000010 %
% C1 = 0000100111 %
% C2 = 0000101101 %

%% Globals %%
debug_info = false;
Var        = 2;

A  = [1 0 0 0 0 0 0 0 1 0];
C1 = [0 0 0 0 1 0 0 1 1 1];
C2 = [0 0 0 0 1 0 1 1 0 1];


disp('*********DSP Lab Work 1*********')
disp(sprintf('********Work variant = %g********', Var))

%% 1st %%
M1 = Mfun(A, C1);
disp('M1 - Done!')
M2 = Mfun(A, C2);
disp('M2 - Done!')

if debug_info == true
    disp('M1 = ')
    disp(M1)
    disp('M2 = ')
    disp(M2)
end


%% Plot creating %%
disp('Creating plots...')
% M1
subplot(3, 1, 1)
x = 0:1:length(M1) - 1;
plot(x,M1)

% M2
subplot(3, 1, 2)
x = 0:1:length(M2) - 1;
plot(x,M2)