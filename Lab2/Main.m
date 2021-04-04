%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Variant 2             %
%      fs = 64 Hz               %
%      Tp = 1 s                 %
%     f01 = 2 Hz                %
%     f02 = 4 Hz                %
%   phi01 = 3pi/4               %
%   phi02 = pi                  %
%      An = 2                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Bezborodov Grigoriy  %
%  Github: somenewacc           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Globals %%
close all
clear
clc

variant    = 2;
N_computer = 4;
work       = 2;

%% Variant variables %%
fs    = 64;
Tp    = 1;
f01   = 2;
f02   = 4;
phi01 = ( 3 * pi ) / 4;
phi02 = ( 2 * pi ) / variant;
A     = 1;
An    = 2 * A;
T     = 1 / fs;

fprintf('*********DSP Lab Work %g*********\n', work)
fprintf('********Work variant = %g********\n', variant)

DisplayHeader('Task 1: Create sinusoidal signals')

%% Initial data %%
fprintf('\n- Initial data\n')
fprintf('fs = %g Hz\t\t\t- sampling frequency\n', fs)
fprintf('Tp = %g s\t\t\t- signal duration\n', Tp)
fprintf('f01 = %g Hz\t\t\t- frequency of first signal\n', f01)
fprintf('f02 = %g Hz\t\t\t- frequency of second signal\n', f02)
fprintf('phi01 = %.5f\t\t- initial phase of first signal\n', phi01)
fprintf('phi02 = %.5f\t\t- initial phase of second signal\n', phi02)
fprintf('An = %g\t\t\t\t- noise amplitude\n', An)
fprintf('A = %g\t\t\t\t- signal amplitude\n', A)
fprintf('T = %s\t\t\t- period\n', strtrim(rats(T)))

% Number of samples
n = 0:1:fs - 1;

fprintf('\n- Creating signals fn = A * cos(2pi*f0n*t + phi)\n')
f1 = A * cos( 2 * pi * f01 * n * T + phi01 );
f2 = A * cos( 2 * pi * f02 * n * T + phi02 );
f = f1 + f2;

fprintf('f1 - Done!\n')
fprintf('f2 - Done!\n')
fprintf('f - Done!\n')

fprintf('\n- Creating dpf for f = f1 + f2\n')
dft = fft( f, fs );
fprintf('dft - Done!\n')

% Phase note:
% If |Im| > |Re|: Ph(f) = pi/2 - arct(Re/Im)
% but atan2 does all the job.
amplitude = abs(dft);
phase     = atan2( imag(dft) + 1e-6, real(dft) + 1e-3 );

fprintf('\n- Generating noise\n')
noise = GetRandomNoise(An, fs);
fprintf('noise - Done!\n')

fprintf('\n- Generating noisy f signal\n')
f_noisy = f + noise;
fprintf('f_noisy - Done!\n')

dft_noisy = fft( f_noisy, fs );

amplitude_noisy = abs(dft_noisy);
phase_noisy     = atan2( imag(dft_noisy) + 1e-6, real(dft_noisy) + 1e-3 );

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(amplitude, 'subplot', [2 2 1], 'title', 'Amplitude')
CreateSimplePlot(amplitude_noisy, 'subplot', [2 2 2], 'title', 'Amplitude noisy')
CreateSimplePlot(phase, 'subplot', [2 2 3], 'title', 'Phase')
CreateSimplePlot(phase_noisy, 'subplot', [2 2 4], 'title', 'Phase noisy')
fprintf('Plots created!\n')

DisplayHeader('Task 2: Investigating the DFT of a complex harmonic signal clipping')

%% Variant variables %%
binary_variant = de2bi( variant, 'left-msb', 5 );
Ni = N_computer + 10;
f0 = ( 1 + bi2de( binary_variant(4:5), 'left-msb' ) );
phi0 = ( 1 + bi2de( binary_variant(2:3), 'left-msb' ) ) * pi/( 1 + bi2de( binary_variant(4:5), 'left-msb' ) );
N = 128;
T = 1/( 3 * f0 * ( 1 + bi2de( binary_variant(2:4), 'left-msb' ) ) );
if binary_variant(2) == 0
    shift_sign = 1;
else
    shift_sign = -1;
end
shift = shift_sign * bi2de( binary_variant(3:5), 'left-msb' );
fs = 1/T;

if not(mod( Ni, 2 ))
    Ni = Ni + 1;
end

%% Initial data %%
fprintf('\n- Initial data\n')
fprintf('Ni = %g\t\t\t\t\t- signal length\n', Ni)
fprintf('f0 = %g Hz\t\t\t\t- signal frequency\n', f0)
fprintf('phi0 = %.5f\t\t\t- signal phase\n', phi0)
fprintf('N = %g\t\t\t\t\t- DFT calculation period length\n', N)
fprintf('T = %s\t\t\t\t- sampling period\n', strtrim(rats(T)))
fprintf('shift = %g\t\t\t\t- signal shift\n', shift)

fprintf('\n- Creating signal cos + jsin\n')
t = 0:T:T * ( Ni - 1 );
s_bare = cos( 2 * pi * f0 * t + phi0 ) + 1i * sin( 2 * pi * f0 * t + phi0 );

s1 = s_bare( 1:floor( Ni/2 ) );
s2 = s_bare( floor( Ni/2 ) + 1:Ni );

s = [s2 zeros( 1, N - Ni ) s1];

fprintf('s_bare - Done!\n')
fprintf('s - Done!\n')

fprintf('\n- Creating dft for s and shifted dft\n')
s_shifted = circshift( s, [0 shift] );

dft         = fft( s, N );
dft_shifted = fft( s_shifted, N );

fprintf('s_shifted - Done!\n')
fprintf('dft - Done!\n')
fprintf('dft_shifted - Done!\n')

fprintf('\n- Calculating theoretical and practical data\n')
max_value      = max( abs( dft ) );
max_value_calc = Ni;

max_index      = find( abs(dft) == max( abs( dft ) ) );
max_index_calc = f0 * T * N;

[zero_point_left, zero_point_right] = GetZeroPoints( dft, max_index );

zeros_practical = zero_point_right - zero_point_left;

A = max_index - 1;
B = max_index;

m_A = A - max_index;
m_B = B - max_index;

v = -shift;

delta_phi_A = m_A * v * ( 2 * pi / N );
delta_phi_B = m_B * v * ( 2 * pi / N );

phi_m_A = delta_phi_A + phi0;
phi_m_B = delta_phi_B + phi0;

angle_dft_s_calculated = atand( (phi_m_A - phi_m_B) ./ (m_B - m_A) );

amplitude_shifted = abs(dft_shifted);
phase_shifted     = atan2( imag(dft_shifted) + 1e-6, real(dft_shifted) + 1e-3 );

y1 = phase_shifted(A);
y2 = phase_shifted(B);

x1 = A;
x2 = B;

angle_dft_s = atand( (y1 - y2) ./ (x2 - x1) );

fprintf('Maximum dft = %g\n', max_value)
fprintf('Calculated maximum dft = %g\n', max_value_calc)
fprintf('Index of maximum dft = %g\n', max_index)
fprintf('Calculated index of maximum dft = %g\n', max_index_calc)
fprintf('Zeros of dft = %g\n', zeros_practical)
fprintf('Calculated zeros of dft = %g\n', 2 * N / Ni)
fprintf('Angle = %g%c\n', angle_dft_s, char(176))
fprintf('Calculated angle = %g%c\n', angle_dft_s_calculated, char(176))

amplitude = abs(dft);
phase     = atan2( imag(dft) + 1e-6, real(dft) + 1e-3 );

fprintf('Phase at maximum dft = %g\n', phase(max_index))
fprintf('Calculated phase = %g\n', phi0 * 2)

fprintf('\n- Creating plots\n')
splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(true, true, 3, 2, 1, real(s_bare), 'cos')
CreateSimplePlot(true, true, 3, 2, 2, imag(s_bare), 'sin')
CreateSimplePlot(true, true, 3, 2, 3, real(s), 'cos zeros')
CreateSimplePlot(true, true, 3, 2, 4, imag(s), 'sin zeros')
CreateSimplePlot(true, true, 3, 2, 5, real(s_shifted), 'cos shifted')
CreateSimplePlot(true, true, 3, 2, 6, imag(s_shifted), 'sin shifted')

splash = GetRandomSplash();
figure( 'Name', splash, 'NumberTitle', 'off' )

CreateSimplePlot(true, true, 2, 2, 1, amplitude, 'Amplitude')
CreateSimplePlot(true, true, 2, 2, 2, amplitude_shifted, 'Amplitude shifted')
CreateSimplePlot(true, true, 2, 2, 3, phase, 'Phase')
CreateSimplePlot(true, true, 2, 2, 4, phase_shifted, 'Phase shifted')

fprintf('Plots created!\n')