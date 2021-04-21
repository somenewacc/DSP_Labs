%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Variant 2          %
%       fs   = 802 Hz           %
%       f0   = 182 Hz           %
%       F    = 27 Hz            %
%       Nimp = 402              %
%       fdp  = 0                %
%       c    = 1                %
%       N    = 1024             %
%       T    = 1/802            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Bezborodov Grigoriy  %
%  Github: somenewacc           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TODO: Work has some issues.
% Not the best way.

%% Globals %%
close all
clear
clc

variant = 11;
work    = 3;

%% Variant variables %%
f0   = 180 + variant;
F    = 25  + variant;
fs   = 800 + variant;
Nimp = 400 + variant;
fdp  = 0;
c    = 2 / variant; % c = fi0/pi
N    = 1024;
T    = 1/fs;
ti   = Nimp * T;
step = (ti/(Nimp - 1));

fprintf('*********DSP Lab Work %g*********\n', work)
fprintf('********Work variant = %g********\n', variant)

%% Initial data %%
fprintf('\n- Initial data\n')
fprintf('fs = %g Hz\t- sampling frequency\n', fs)
fprintf('f0 = %g Hz\t- frequency\n', f0)
fprintf('F = %g Hz\n', F)
fprintf('Nimp = %g\n', Nimp)
fprintf('fdp = %g\n', fdp)
fprintf('c = %s\n', strtrim(rats(c)))
fprintf('N = %g\n', N)
fprintf('T = %s\t- period\n', strtrim(rats(T)))

%% Radio Center %%
DisplayHeader('Center radio signal')

t = (-ti/2):step:(ti/2);

center = ceil(Nimp/2);
Sg_pass = cos(pi .* (2 .* f0 .* t + F/ti .* (t.^2) + c));
Sg_pass_center = [Sg_pass(center:end), zeros(1, N - Nimp), Sg_pass(1:(center - 1))];
fprintf('Sg_pass_center - Done!\n')

h_pass        = fliplr( cos( pi .* ( 2 .* f0 .* t + F/ti .* ( t.^2 ) ) ) );
h_pass_center = [h_pass( center : end ), zeros( 1, N - Nimp ), h_pass( 1:( center - 1 ) )];
fprintf('h_pass_center - Done!\n')

S_pass_center = fft(Sg_pass_center, N);
phi_S         = atan(imag(S_pass_center)./real(S_pass_center));
fprintf('S_pass_center - Done!\n')

H_pass_center = fft(h_pass_center, N);
phi_H         = atan(imag(H_pass_center)./real(H_pass_center));
fprintf('H_pass_center - Done!\n')

k = fs / N;

center_position = floor(f0 / k);

fprintf('\nCenter Position = %g\n', center_position)

A_s = abs(S_pass_center);

H = A_s(center_position + 1);

h = H / 2;

fprintf('H = %g\n', H)

[~, index] = min(abs(A_s-h));

[~, index2] = min(abs(A_s(center_position:(length(A_s) / 2))-h));

index2 = index2 + center_position - 2;

fprintf('\nFirst task\n')
fprintf('x1 = %g\n', index)
fprintf('x2 = %g\n', index2)
fprintf('delta_x = %g\n', index2 - index)
fprintf('Practical   F = %d\n', round((fs / N) * (index2 - index)))
fprintf('Theoretical F = %d\n', F)

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

max_Sg = max(abs(sqrt(real(Sg_pass_center) .^ 2 + imag(Sg_pass_center) .^ 2)));
max_h = max(abs(sqrt(real(h_pass_center) .^ 2 + imag(h_pass_center) .^ 2)));

max_S = max(abs(S_pass_center));
max_H = max(abs(H_pass_center));

fprintf('\nThird task\n')
fprintf('A(s)/A(h) = %g\n', max_Sg / max_h)
fprintf('A(S)/A(H) = %g\n', max_S / max_H)

if abs(((max_Sg / max_h) / (max_S / max_H)) - 1) < 0.1
    fprintf('Check passed!\n')
else
    fprintf('Something wrong!\n')
end

CreateSimplePlot(real(Sg_pass_center), 'subplot', [4 2 1], 'title', 'Re(s)', 'grid')
CreateSimplePlot(imag(Sg_pass_center), 'subplot', [4 2 3], 'title', 'Im(s)', 'grid')
CreateSimplePlot(real(h_pass_center), 'subplot', [4 2 5], 'title', 'Re(h)', 'grid')
CreateSimplePlot(imag(h_pass_center), 'subplot', [4 2 7], 'title', 'Im(h)', 'grid')
CreateSimplePlot(abs(S_pass_center), 'subplot', [4 2 2], 'title', 'A(S)', 'grid')
CreateSimplePlot(phi_S, 'subplot', [4 2 4], 'title', 'phi(S)', 'grid')
CreateSimplePlot(abs(H_pass_center), 'subplot', [4 2 6], 'title', 'A(H)', 'grid')
CreateSimplePlot(phi_H, 'subplot', [4 2 8], 'title', 'phi(H)', 'grid')

fprintf('Plots created!\n')

fprintf('\n- SJTD, MULT\n')

SJTD      = ifft( S_pass_center .* H_pass_center ) / N;
A_db_SJTD = 20 * log( ( abs(SJTD) + 0.001 ) ./ max( abs(SJTD) ) );
fprintf('SJTD\t- Done!\n')
fprintf('A_db_SJTD\t- Done!\n')

MULT     = S_pass_center .* H_pass_center;
phi_MULT = atan(imag(MULT)./real(MULT));
fprintf('MULT\t- Done!\n')
fprintf('phi_MULT\t- Done!\n')

fprintf('\nFourth task\n')
phi0 = c * pi;
fprintf('phi0 = %g\n', phi0)

phi_at_center = phi_MULT(center_position + 1);
fprintf('phi_at_center = %g\n', phi_at_center)

if abs((phi_at_center / phi0) - 1) < 0.05
    fprintf('Check passed!\n')
else
    fprintf('Something wrong!\n')
end

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(SJTD), 'subplot', [4 2 1], 'title', 'Re(SJTD)', 'grid')
CreateSimplePlot(imag(SJTD), 'subplot', [4 2 3], 'title', 'Im(SJTD)', 'grid')
CreateSimplePlot(abs(SJTD), 'subplot', [4 2 5], 'title', 'A(SJTD)', 'grid')
CreateSimplePlot(A_db_SJTD, 'subplot', [4 2 7], 'title', 'A(SJTD) dB', 'grid')
CreateSimplePlot(real(MULT), 'subplot', [4 2 2], 'title', 'Re(MULT)', 'grid')
CreateSimplePlot(imag(MULT), 'subplot', [4 2 4], 'title', 'Im(MULT)', 'grid')
CreateSimplePlot(abs(MULT), 'subplot', [4 2 6], 'title', 'A(MULT)', 'grid')
CreateSimplePlot(phi_MULT, 'subplot', [4 2 8], 'title', 'phi(MULT)', 'grid')

fprintf('Plots created!\n')

%% Zero radio signal %%
DisplayHeader('Radio signal from zero')

t = 0:step:(ti);

Sg_pass      = cos( pi .* ( 2 .* f0 .* t + F/ti .* ( t.^2 ) + c ) );
Sg_pass_zero = [Sg_pass, zeros(1, N - Nimp)];
fprintf('Sg_pass_zero - Done!\n')

h_pass      = fliplr( cos( pi .* ( 2 .* f0 .* t + F/ti .* ( t.^2 ) ) ) );
h_pass_zero = [h_pass, zeros(1, N - Nimp)];
fprintf('h_pass_zero - Done!\n')

S_pass_zero = fft(Sg_pass_zero, N);
phi_S       = atan(imag(S_pass_zero)./real(S_pass_zero));
fprintf('S_pass_zero - Done!\n')

H_pass_zero = fft(h_pass_zero, N);
phi_H       = atan(imag(H_pass_zero)./real(H_pass_zero));
fprintf('H_pass_zero - Done!\n')

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(Sg_pass_zero), 'subplot', [4 2 1], 'title', 'Re(s)', 'grid')
CreateSimplePlot(imag(Sg_pass_zero), 'subplot', [4 2 3], 'title', 'Im(s)', 'grid')
CreateSimplePlot(real(h_pass_zero), 'subplot', [4 2 5], 'title', 'Re(h)', 'grid')
CreateSimplePlot(imag(h_pass_zero), 'subplot', [4 2 7], 'title', 'Im(h)', 'grid')
CreateSimplePlot(abs(S_pass_zero), 'subplot', [4 2 2], 'title', 'A(S)', 'grid')
CreateSimplePlot(phi_S, 'subplot', [4 2 4], 'title', 'phi(S)', 'grid')
CreateSimplePlot(abs(H_pass_zero), 'subplot', [4 2 6], 'title', 'A(H)', 'grid')
CreateSimplePlot(phi_H, 'subplot', [4 2 8], 'title', 'phi(H)', 'grid')

fprintf('Plots created!\n')

fprintf('\n- SJTD, MULT\n')

SJTD      = ifft( S_pass_zero .* H_pass_zero ) / N;
A_db_SJTD = 20 * log( ( abs(SJTD) + 0.001 ) ./ max( abs(SJTD) ) );
fprintf('SJTD - Done!\n')
fprintf('A_db_SJTD - Done!\n')

MULT     = S_pass_zero .* H_pass_zero;
phi_MULT = atan(imag(MULT)./real(MULT));
fprintf('MULT - Done!\n')
fprintf('phi_MULT - Done!\n')

A = 0.177;
x1 = 396;
%y1 = 0.09566;
x2 = 425;
%y2 = 0.0837;

delta_x1 = x2 - x1;
delta_x1_T = T * delta_x1;

x1 = 405;
%y1 = 0.0987;
x2 = 418;
%y2 = 0.08767;

delta_x2 = x2 - x1;
delta_x2_T = T * delta_x2;

fprintf('\nFifth task\n')
mean_of_deltas = mean([delta_x1_T delta_x2_T]);
fprintf('mean_of_deltas = %g\n', mean_of_deltas)

mean_theor = 1 / F;
fprintf('mean_theor = %g\n', mean_theor)

if abs((mean_of_deltas / mean_theor) - 1) < 0.2
    fprintf('Check passed!\n')
else
    fprintf('Something wrong!\n')
end

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(SJTD), 'subplot', [4 2 1], 'title', 'Re(SJTD)', 'grid')
CreateSimplePlot(imag(SJTD), 'subplot', [4 2 3], 'title', 'Im(SJTD)', 'grid')
CreateSimplePlot(abs(SJTD), 'subplot', [4 2 5], 'title', 'A(SJTD)', 'grid')
CreateSimplePlot(A_db_SJTD, 'subplot', [4 2 7], 'title', 'A(SJTD) dB', 'grid')
CreateSimplePlot(real(MULT), 'subplot', [4 2 2], 'title', 'Re(MULT)', 'grid')
CreateSimplePlot(imag(MULT), 'subplot', [4 2 4], 'title', 'Im(MULT)', 'grid')
CreateSimplePlot(abs(MULT), 'subplot', [4 2 6], 'title', 'A(MULT)', 'grid')
CreateSimplePlot(phi_MULT, 'subplot', [4 2 8], 'title', 'phi(MULT)', 'grid')

fprintf('Plots created!\n')

%% Video Center %%
DisplayHeader('Center video signal')

n      = 0:Nimp-1;
center = ceil(Nimp/2);

Sg_base        = cos(pi .* ( (F/Nimp .* (n.^2) .* T ) - (F .* n .* T) + c)) + 1i * sin(pi .* ( (F/Nimp .* (n.^2) .* T ) - (F .* n .* T) + c));
Sg_base_center = [Sg_base(center:end), zeros(1, N - Nimp), Sg_base(1:(center - 1))];
fprintf('Sg_pass_center - Done!\n')

h_base        = cos(pi .* ( (F/Nimp .* (n.^2) .* T ) - (F .* n .* T))) - 1i * sin(pi .* ( (F/Nimp .* (n.^2) .* T ) - (F .* n .* T)));
h_base_center = [h_base(center:end), zeros(1, N - Nimp), h_base(1:(center - 1))];
fprintf('h_pass_center - Done!\n')

S_base_center = fft(Sg_base_center, N);
phi_S         = atan(imag(S_base_center)./real(S_base_center));
fprintf('S_pass_center - Done!\n')

H_base_center = fft(h_base_center, N);
phi_H         = atan(imag(H_base_center)./real(H_base_center));
fprintf('H_pass_center - Done!\n')

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(Sg_base_center), 'subplot', [4 2 1], 'title', 'Re(s)', 'grid')
CreateSimplePlot(imag(Sg_base_center), 'subplot', [4 2 3], 'title', 'Im(s)', 'grid')
CreateSimplePlot(real(h_base_center), 'subplot', [4 2 5], 'title', 'Re(h)', 'grid')
CreateSimplePlot(imag(h_base_center), 'subplot', [4 2 7], 'title', 'Im(h)', 'grid')
CreateSimplePlot(abs(S_base_center), 'subplot', [4 2 2], 'title', 'A(S)', 'grid')
CreateSimplePlot(phi_S, 'subplot', [4 2 4], 'title', 'phi(S)', 'grid')
CreateSimplePlot(abs(H_base_center), 'subplot', [4 2 6], 'title', 'A(H)', 'grid')
CreateSimplePlot(phi_H, 'subplot', [4 2 8], 'title', 'phi(H)', 'grid')

fprintf('Plots created!\n')

fprintf('\n- SJTD, MULT\n')

SJTD     = ifft(S_base_center .* H_base_center) / N;
phi_SJTD = atan(imag(SJTD)./(real(SJTD) + 0.0001));
fprintf('SJTD - Done!\n')
fprintf('phi_SJTD - Done!\n')

MULT     = S_base_center .* H_base_center;
phi_MULT = atan(imag(MULT)./(real(MULT) + 0.0001));
fprintf('MULT - Done!\n')
fprintf('phi_MULT - Done!\n')

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(SJTD), 'subplot', [4 2 1], 'title', 'Re(SJTD)', 'grid')
CreateSimplePlot(imag(SJTD), 'subplot', [4 2 3], 'title', 'Im(SJTD)', 'grid')
CreateSimplePlot(abs(SJTD), 'subplot', [4 2 5], 'title', 'A(SJTD)', 'grid')
CreateSimplePlot(phi_SJTD, 'subplot', [4 2 7], 'title', 'phi(SJTD)', 'grid')
CreateSimplePlot(real(MULT), 'subplot', [4 2 2], 'title', 'Re(MULT)', 'grid')
CreateSimplePlot(imag(MULT), 'subplot', [4 2 4], 'title', 'Im(MULT)', 'grid')
CreateSimplePlot(abs(MULT), 'subplot', [4 2 6], 'title', 'A(MULT)', 'grid')
CreateSimplePlot(phi_MULT, 'subplot', [4 2 8], 'title', 'phi(MULT)', 'grid')

fprintf('Plots created!\n')

%% Video from zero %%
DisplayHeader('Video signal from zero')

n = 0:Nimp-1;

Sg_base_zero = [Sg_base, zeros(1, N - Nimp)];
fprintf('Sg_pass_center - Done!\n')

h_base_zero = [h_base, zeros(1, N - Nimp)];
fprintf('h_pass_center - Done!\n')

S_base_zero = fft(Sg_base_zero, N);
phi_S       = atan(imag(S_base_zero)./(real(S_base_zero) + 0.0001));
fprintf('S_pass_center - Done!\n')

H_base_zero = fft(h_base_zero, N);
phi_H       = atan(imag(H_base_zero)./(real(H_base_zero) + 0.0001));
fprintf('H_pass_center - Done!\n')

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(Sg_base_zero), 'subplot', [4 2 1], 'title', 'Re(s)', 'grid')
CreateSimplePlot(imag(Sg_base_zero), 'subplot', [4 2 3], 'title', 'Im(s)', 'grid')
CreateSimplePlot(real(h_base_zero), 'subplot', [4 2 5], 'title', 'Re(h)', 'grid')
CreateSimplePlot(imag(h_base_zero), 'subplot', [4 2 7], 'title', 'Im(h)', 'grid')
CreateSimplePlot(abs(S_base_zero), 'subplot', [4 2 2], 'title', 'A(S)', 'grid')
CreateSimplePlot(phi_S, 'subplot', [4 2 4], 'title', 'phi(S)', 'grid')
CreateSimplePlot(abs(H_base_zero), 'subplot', [4 2 6], 'title', 'A(H)', 'grid')
CreateSimplePlot(phi_H, 'subplot', [4 2 8], 'title', 'phi(H)', 'grid')

fprintf('Plots created!\n')

fprintf('\n- SJTD, MULT\n')

SJTD      = ifft(S_base_zero .* H_base_zero) / N;
A_db_SJTD = 20*log((abs(SJTD) + 0.001)./max(abs(SJTD)));
fprintf('SJTD - Done!\n')
fprintf('A_db_SJTD - Done!\n')

MULT     = S_base_zero .* H_base_zero;
phi_MULT = atan(imag(MULT)./real(MULT));
fprintf('MULT - Done!\n')
fprintf('phi_MULT - Done!\n')

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(real(SJTD), 'subplot', [4 2 1], 'title', 'Re(SJTD)', 'grid')
CreateSimplePlot(imag(SJTD), 'subplot', [4 2 3], 'title', 'Im(SJTD)', 'grid')
CreateSimplePlot(abs(SJTD), 'subplot', [4 2 5], 'title', 'A(SJTD)', 'grid')
CreateSimplePlot(A_db_SJTD, 'subplot', [4 2 7], 'title', 'A(SJTD) dB', 'grid')
CreateSimplePlot(real(MULT), 'subplot', [4 2 2], 'title', 'Re(MULT)', 'grid')
CreateSimplePlot(imag(MULT), 'subplot', [4 2 4], 'title', 'Im(MULT)', 'grid')
CreateSimplePlot(abs(MULT), 'subplot', [4 2 6], 'title', 'A(MULT)', 'grid')
CreateSimplePlot(phi_MULT, 'subplot', [4 2 8], 'title', 'phi(MULT)', 'grid')

fprintf('Plots created!\n')