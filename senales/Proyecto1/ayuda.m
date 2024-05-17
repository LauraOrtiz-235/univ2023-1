
% Read all MP3 files in 'dir' and add them to the database training if they
% are not already in 'songid'
% Parameters
dir = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/songa'; 
fs_new = 4000; % New sampling rate
win_len = 64; % Window length in seconds
overlap_len = 32; % Overlap length in seconds
NFFT = 2*nextpow2(win_len*fs_new); % Number of FFT points
songs = getMp3List(dir);

hashTableSize = 100000; % This can be adjusted.  Setting it too small will cause more accidental collisions.


% Check if we have a database in the workspace
if ~exist('song_ids')
    % Load database if one exists
    if exist('SONGID.mat')
        load('SONGID.mat');
        load('HASHTABLE.mat');
    else  
        % Create new database
        song_ids = cell(0);
        hashtable = cell(hashTableSize,2); % 
    end
end


songIndex = length(song_ids); % This becomes the song ID number.

% Add songs to songid and fingerprints to hashtable
someNewSongs = 0;
for i = 1:length(songs)
    
    % Check if the song is already in the database
    songFound = 0;
    for m = 1:length(song_ids)
        if strcmp(songs{i}, song_ids{m})
            songFound = 1;
            break;
        end
    end
    
    if ~songFound
        someNewSongs = 1;
        songIndex = songIndex + 1;
        filename = strcat(dir, filesep, songs{i});
        [y,fs] = audioread(filename);
        
        % INSERT CODE HERE
        % Use fingerprint.m, convert_to_pairs.m, and add_to_table.m
        y = mean(y, 2);
        y = y - mean(y);
    
        % Resample to new rate
        y = resample(y, fs_new, fs);
    
    
        % Compute spectrogram
        [S, F, T] = spectrogram(y, win_len, overlap_len, 64, fs_new);
        magS = abs(S); % Magnitude of the spectrogram 
        
        % Plot spectrogram and log of magnitude
        figure;
        spectrogram(y, win_len, overlap_len, 64, fs_new)
        title(sprintf('Spectrogram of %s', songs{i}));
    
    
        gs = 4; % Distance to search in each direction
    
        % Find local peaks in the spectrogram
        CS1 = circshift(S, [gs 0]);
        CS2 = circshift(S, [-gs 0]);
        CS3 = circshift(S, [0 gs]);
        CS4 = circshift(S, [0 -gs]);
        P = (S > CS1) & (S > CS2) & (S > CS3) & (S > CS4);
    
        % Plot peaks
        figure;
        imagesc(T, F, P);
        colormap(1-gray);
        xlabel('Time (s)');
        ylabel('Frequency (Hz)');
        title(sprintf('Local peaks of %s', songs{i}));
    
    
        % Thresholding
        %threshold = 0.4;
        %P = P & (S > threshold*max(S(:)));
    
        % Thresholding
        peaks_per_sec = 30; % scales the threshold
        peakMags = P.*magS;
        peaksThres = sort(peakMags(:),'descend'); % sort all peak values in order
        threshold = peaksThres(ceil(max(T)*peaks_per_sec));
        
        % Apply threshold
        if (threshold > 0)
            peaks = (peakMags >= threshold);
        end
    
        figure;
        imagesc(T, F, peaks);
        colormap (1-gray);
        xlabel('Time (s)');
        ylabel('Frequency (Hz)');
        title(sprintf('Local peaks of %s', songs{i}, 'after thresholding'));
       
    
        % Shows the spectrogram with blinking dots where the peaks are
        optional_plot = 0; % turn plot on or off
    
        if optional_plot
            % plot spectrogram
            figure;    
            [S, F, T] = spectrogram(y, win_len, overlap_len, 64, fs_new);
            spectrogram(y, win_len, overlap_len, 64, fs_new);
            title('Log Spectrogram');
            xlabel('time (s)');
            ylabel('frequency (Hz)');
        
            % plot local peaks over spectrogram
            imagesc(T, F, peaks);
            title('Log Spectrogram');
            xlabel('time (s)');
            ylabel('frequency (Hz)');
        end
    
    
        % Convert peaks to pairs
        pairs = convert_to_pairs(peaks);
    
        % Calculate hash for each pair
        for j = 1:size(pairs, 1)
            f1 = pairs(j, 1);
            f2 = pairs(j, 2);
            deltaT = pairs(j, 3);
            hash = simple_hash(f1, f2, deltaT, hash_table_size);
            if isempty(hash_table{hash})
                hash_table{hash} = struct('song', songs{i}, 'times', deltaT);
            else
                hash_table{hash}(end+1) = struct('song', songs{i}, 'times', deltaT);
            end
        end
        
        song_ids{songIndex,1} = songs{i};
    end
end

numSongs = songIndex;
if someNewSongs
    save('SONGID.mat', 'song_ids');
    save('HASHTABLE.mat', 'hash_table');
end

