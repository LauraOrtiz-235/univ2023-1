
function peaks = fingerprint(y, fs)

    fs_new = 4000;                % New sampling rate
    win_len = 64;                 % Window length in seconds
    overlap_len = 32;             % Overlap length in seconds
    gs = 4;                       % grid size for spectrogram peak search
    
    y = mean(y, 2);
    y = y - mean(y);

    % Resample to new rate
    y = resample(y, fs_new, fs);


    % Compute spectrogram
    [S, F, T] = spectrogram(y, win_len, overlap_len, 64, fs_new);
    magS = abs(S);  % Magnitude of the spectrogram 
    

    peaks = ones(size(magS));
    for horShift = -gs:gs
        for vertShift = -gs:gs
            if vertShift ~= 0 || horShift ~= 0
                CS = circshift(magS, [vertShift, horShift]);
                CS2 = circshift(magS, [-vertShift, -horShift]);
                P = peaks.*((magS > CS) & (magS > CS2));
            end
        end
    end


    % Thresholding
    peaks_per_sec = 30;                       % scales the threshold
    peakMags = P.*magS;
    peaksThres = sort(peakMags(:),'descend'); % sort all peak values in order
    threshold = peaksThres(ceil(max(T)*peaks_per_sec));

    % Apply threshold
    if (threshold > 0)
        peaks = (peakMags >= threshold);
    end

    % Plot spectrogram, local peaks and thresholding
    figure;
    subplot(3,1,1)
    spectrogram(y, win_len, overlap_len, 64, fs_new);
    title('Spectrogram');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');

    subplot(3,1,2)
    imagesc(P);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title('Local peaks');

    subplot(3,1,3)
    imagesc(peaks);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title('Local peaks after thresholding');

    % Set a different colormap for each subplot
    colormap(subplot(3,1,1), 'default');
    colormap(subplot(3,1,2), 1-gray);
    colormap(subplot(3,1,3), 1-gray);


    % Shows the spectrogram with blinking dots where the peaks are
    optional_plot = 0; % turn plot on or off
    
    if optional_plot
        % plot spectrogram
        figure(1)
        Tplot = [5, 10]; % Time axis for plot
    
        logS = log(magS);
        imagesc(T,F,logS);
        title('Log Spectrogram');
        xlabel('time (s)');
        ylabel('frequency (Hz)');
        axis xy
        axis([Tplot, -inf, inf])
        frame1 = getframe;
    
        % plot local peaks over spectrogram
        peaksSpec = (logS - min(min(logS))).*(1-peaks);
        imagesc(T,F,peaksSpec);
        title('Log Spectrogram');
        xlabel('time (s)');
        ylabel('frequency (Hz)');
        axis xy
        axis([Tplot, -inf, inf])
        frame2 = getframe;
    
        movie([frame1,frame2],10,1)
    end

end
