%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               %
%  Author: Bezborodov Grigoriy  %
%  Github: somenewacc           %
%                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Globals %%
close all
clear
clc

variant = 11;
work    = 4;

fprintf('*********DSP Lab Work %g*********\n', work)
fprintf('********Work variant = %g********\n', variant)

DisplayHeader('Task 1. Digital filters')

fs = 720;
fn = fs/2;

N = 1024;
Nn = N/2;

% LOWPASS
fc = 148;
fz = 220;

Nf = round( abs( 3 * fs / ( fz - fc ) ) );
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

Nc = round( N * fc / fs );
Nz = round( N * fz / fs );

AFC = [ ones( 1, Nc ), zeros( 1, Nz - Nc ), zeros( 1, Nn - Nz ) ];
AFC = [ AFC, fliplr(AFC) ];

EvalsAndPlots( AFC, N, Nf, '1 - LOWPASS');

% HIGHPASS
fc = 220;
fz = 148;

Nf = round( abs( 3 * fs / ( fz - fc ) ) );
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

Nc = round( N * fc / fs);
Nz = round( N * fz / fs);

AFC = [ zeros(1, Nz), zeros(1, Nc - Nz), ones( 1, Nn - Nc) ];
AFC = [ AFC, fliplr(AFC) ];

EvalsAndPlots( AFC, N, Nf, '1 - HIGHPASS');

% BANDPASS
f0 = 150;
fc = 100;
fz = 170;

Nf = round( abs( 3 * fs / ( fz - fc ) ) );
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

N0 = round( N * f0 / fs );
% Nc = round( N * fc / fs );
Nz = round( N * fz / fs );

AFC = [ zeros( 1, N0), ones( 1, Nz-N0), zeros(1, (N/2)-Nz) ];
AFC = [ AFC, fliplr(AFC) ];

EvalsAndPlots( AFC, N, Nf, '1 - BANDPASS');

% BANDSTOP
% f0 = 150;
fc = 170;
fz = 100;

Nf = round( abs( 3 * fs / ( fz - fc ) ) );
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

% N0 = round( N * f0 / fs );
Nc = round( N * fc / fs );
Nz = round( N * fz / fs );

AFC = [ ones( 1, Nz ), zeros( 1, Nc-Nz), ones(1, (N/2)-Nz-(Nc-Nz)) ];
AFC = [ AFC, fliplr(AFC) ];

EvalsAndPlots( AFC, N, Nf, '1 - BANDSTOP');

% Differentiator
fc = 288;

Nf = round(abs(3*fs/(fn-fc)));
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

% Nc = round(N*fc/fs);

a = linspace(0,1,N/2);
a(end) = [];
not_a = fliplr(-a);
not_a(end) = [];

AFC = [a, 0, 0, 0, not_a];

% AFC = [ linspace(0,1,Nc), linspace(1,-1,N-2*Nc), linspace(-1,0,Nc) ];

EvalsAndPlots( AFC, N, Nf, '1 - Differentiator', 'diff');

% Hilbert
fc=72;

Nf = round(abs(3*fs/(fc)));
if rem(Nf, 2) == 0
    Nf = Nf + 1;
end

Nc = round(N*fc/fs);

AFC = [0, ones(1, Nn-2), 0, 0, 0, -ones(1, Nn-2)];

EvalsAndPlots( AFC, N, Nf, '1 - Hilbert', 'diff');

DisplayHeader('Task 2. Check the homework')
fs = 720;
fn=fs/2;
N = 8;
Nn = N/2;
Nf=7;

% LOWPASS
fc = 148;
fz = 220;

Nc = round(N*fc/fs);
Nz = round(N*fz/fs);

AFC = [ ones(1, Nc+1), zeros(1, Nc+1), ones(1, Nz) ];

EvalsAndPlots( AFC, N, Nf, '2 - LOWPASS', 'hw');

% HIGHPASS
fc = 220;
fz = 148;

Nc = round(N*fc/fs);
Nz = round(N*fz/fs);

AFC = [ zeros(1, Nc+1), ones(1, Nc+1), zeros(1, Nz) ];

EvalsAndPlots( AFC, N, Nf, '2 - HIGHPASS', 'hw');

% BANDPASS
f0 = 150;
fc = 100;
fz = 170;

N0 = round(N*f0/fs);
Nc = round(N*fc/fs);
% Nz = round(N*fz/fs);

AFC = [ zeros(1, N0), ones(1, Nc), zeros(1, N0+1), ones(1, Nc), zeros(1, Nc) ];

EvalsAndPlots( AFC, N, Nf, '2 - BANDPASS', 'hw');

% BANDSTOP
f0 = 150;
fc = 170;
fz = 100;

N0 = round(N*f0/fs);
Nc = round(N*fc/fs);
Nz = round(N*fz/fs);

AFC = [ ones(1, Nz), zeros(1, N0), ones(1, N0+1), zeros(1, Nc) ];

EvalsAndPlots( AFC, N, Nf, '2 - BANDSTOP', 'hw');

% Differentiator
fc = 288;

Nc = round(N*fc/fs);

a = linspace(0,1,Nc+2);
a(end) = [];
minus_a = fliplr(-a);
minus_a(end) = [];
AFC = [a, 0, minus_a];

EvalsAndPlots( AFC, N, Nf, '2 - Differentiator', 'diff', 'hw');

% Hilbert
fc = 72;

Nc = ceil(N*fc/fs);

AFC = [zeros(1, Nc), ones(1, Nc*3), 0, -ones(1, Nc*3)];

EvalsAndPlots( AFC, N, Nf, '2 - Hilbert', 'diff', 'hw');

DisplayHeader('Task 3. Signal dividing via bandpass')
N = 1024;
Nn = N/2;
fs = 720;
Nimp = round(0.07*N);

f01 = 100;
As1 = 50;
fi01 = 0;

f02 = 250;
As2 = 25;
fi02 = 0;

k = -Nimp/2:1:Nimp/2;
s1 = As1 * cos( pi*k*f01/(fs/2) + fi01 );
s2 = As2 * cos( pi*k*f02/(fs/2) + fi02 );

ss = s1 + s2;
ss = [ss zeros(1, N-Nimp-1)];
SS = fft(ss);


% Bandpass1
f0 = 100;
fc = 100;
fz = 170; 

Nf = round(abs(3*fs/(fz-fc)));

N0 = round(N*f0/fs);
Nc = round(N*fc/fs);
Nz = round(N*fz/fs);

AFC = [zeros(1,Nz-N0),ones(1,Nc/2),zeros(1,Nz-N0+Nz-1)];
AFC = [AFC, fliplr(AFC)];
bp1 = EvalsAndPlots( AFC, N, Nf, '3 - Bandpass1');

s = zeros(1,length(bp1));
ssbp1 = zeros(1,length(bp1));
for i=1:1:N
    s = [0 s(1:length(s)-1)];
    s(1) = ss(i);
    premx = bp1.*s;
    ssbp1(i) = sum(premx);
end

EvalsAndPlots( SS, ss, ssbp1, '3 - ss from s1', 'ss');

% Bandpass2
f0 = 250;
fc = 100;
fz = 170; 

Nf = round(abs(3*fs/(fz-fc)));

N0 = round(N*f0/fs);
Nc = round(N*fc/fs);
Nz = round(N*fz/fs);
AFC = [zeros(1,Nz+Nc/2),ones(1,Nc/2),zeros(1,Nn - (Nz+Nc/2+Nc/2))];
AFC = [AFC, fliplr(AFC)];
bp1 = EvalsAndPlots( AFC, N, Nf, '3 - Bandpass2');

s = zeros(1, length(bp1));
ssbp1 = zeros(1, length(bp1));
for i=1:1:N
    s = [0 s(1:length(s)-1)];
    s(1) = ss(i);
    premx = bp1.*s;
    ssbp1(i) = sum(premx);
end
EvalsAndPlots( SS, ss, ssbp1, '3 - ss from s2', 'ss');