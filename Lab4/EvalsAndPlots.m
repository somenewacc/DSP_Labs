function [hhg] = EvalsAndPlots(AFC, N, Nf, Title, varargin)

    if(ismember('ss',varargin))
        SS = AFC;
        ss = N;
        ssbp1 = Nf;
        
        SSbp1 = fft(ssbp1);
        figure( 'Name', Title, 'NumberTitle', 'off' )
        CreateSimplePlot(ss,         'subplot', [4 2 1], 'grid', 'title', 'ss',   'xlabel', 'Time, T', 'ylabel', 'v')
        xlim([0 length(ss)-1])
        CreateSimplePlot(real(ssbp1), 'subplot', [4 2 5], 'grid', 'title', 'ss(fnch)', 'xlabel', 'Time, T', 'ylabel', 'v')
        xlim([0 length(ss) - 1])

        CreateSimplePlot(abs(SS), 'subplot', [4 2 2], 'grid', 'title', 'abs(SS)', 'xlabel', 'Frequency, fs', 'ylabel', 'v*T')
        xlim([0 length(ss)-1])
        CreateSimplePlot(unwrap(angle(SS+1e-10)), 'subplot', [4 2 4], 'grid', 'title', 'fi(SS)', 'xlabel', 'Frequency, fs', 'ylabel', 'fi/pi')
        xlim([0 length(ss)-1])
        CreateSimplePlot(abs(SSbp1), 'subplot', [4 2 6], 'grid', 'title', 'abs(SSfnch)', 'xlabel', 'Frequency, fs', 'ylabel', 'v*T')
        xlim([0 length(ss)-1])
        CreateSimplePlot(unwrap(angle(SSbp1+1e-10)), 'subplot', [4 2 8], 'grid', 'title', 'fi(SSfnch)', 'xlabel', 'Frequency, fs', 'ylabel', 'fi/pi')
        xlim([0 length(ss)-1])
        return
    end

    h = ifft(AFC);
    if(ismember('diff',varargin))
        h = -h;
    end

    hh = [ h( N - floor( Nf/2 ) + 1 : N), h( 1: ceil( Nf / 2 ) )];

    if(ismember('diff',varargin))
        hh = [hh(1:floor(Nf/2)+1) fliplr(-hh(1:floor(Nf/2)))];
    end

    v = 0:1:Nf-1;
    g = 0.54 - 0.46*cos(2*pi*(v/(Nf-1)));
    
    hhg = hh.*g;

    zeros_from_end = zeros(1,N-Nf);
    x = fft([hh, zeros_from_end]);
    AFChh = abs(x);
    x = fft([hhg, zeros_from_end]);
    AFChhg = abs(x);
    phi = unwrap(angle(x+1e-10));
    
    figure( 'Name', Title, 'NumberTitle', 'off' )
    
    if(ismember('diff',varargin))
        h_y   = imag(h);
        hh_y  = imag(hh);
        hhg_y = imag(hhg);
    else
        h_y   = real(h);
        hh_y  = real(hh);
        hhg_y = real(hhg);
    end

    CreateSimplePlot(h_y,   'subplot', [4 2 1], 'grid', 'title', 'h',   'xlabel', 'Time, T', 'ylabel', '1')
    xlim([0 length(h)-1])
    CreateSimplePlot(hh_y,  'subplot', [4 2 3], 'grid', 'title', 'hh',  'xlabel', 'Time, T', 'ylabel', '1')
    xlim([0 length(hh)-1])
    CreateSimplePlot(hhg_y, 'subplot', [4 2 5], 'grid', 'title', 'hhg', 'xlabel', 'Time, T', 'ylabel', '1')
    xlim([0 length(hh)-1])

    CreateSimplePlot(AFC, 'subplot', [4 2 2], 'grid', 'title', 'chh, Re b, Im r', 'xlabel', 'Frequency, fs/N', 'ylabel', '1*T')
    xlim([0 length(AFC)-1])
    if(ismember('hw',varargin))
        CreateSimplePlot(AFChh, 'subplot', [4 2 4], 'grid', 'title', 'achh(hh)', 'xlabel', 'Frequency, fs/N', 'ylabel', '1*T')
        xlim([0 length(AFC)-1])
        CreateSimplePlot(AFChhg, 'subplot', [4 2 6], 'grid', 'title', 'achh(hhg)', 'xlabel', 'Frequency, fs/N', 'ylabel', '1*T')
        xlim([0 length(AFC)-1])
    else
        CreateSimplePlot(20 * log10( abs( AFChh ./ max( AFChh ) ) ), 'subplot', [4 2 4], 'grid', 'title', 'achh(hh), dB', 'xlabel', 'Frequency, fs/N', 'ylabel', 'dB')
        xlim([0 length(AFC)-1])
        CreateSimplePlot(20 * log10( abs( AFChhg ./ max( AFChhg ) ) ), 'subplot', [4 2 6], 'grid', 'title', 'achh(hhg), dB', 'xlabel', 'Frequency, fs/N', 'ylabel', 'dB')
        xlim([0 length(AFC)-1])
    end
    CreateSimplePlot(phi, 'subplot', [4 2 8], 'grid', 'title', 'phi', 'xlabel', 'Frequency, fs/N', 'ylabel', 'fi/pi')
    xlim([0 length(AFC)-1])
end