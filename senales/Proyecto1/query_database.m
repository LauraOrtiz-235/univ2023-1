
% Parameters
folder_path = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/songa';
window_length = 0.064; % Window length in seconds
overlap_length = 0.032; % Overlap length in seconds
new_rate = 8000; % New sampling rate in Hz

% Load MP3 files
mp3_files = dir(fullfile(folder_path, '*.mp3'));
num_files = length(mp3_files);
song_names = cell(num_files, 1);
fingerprints = cell(num_files, 1);

for i = 1:num_files

    fprintf('Procesando canción %d de %d\n', i, length(mp3_files));

    % Read in MP3 file
    disp('reading mp3 file...');
    mp3_path = fullfile(mp3_files(i).folder, mp3_files(i).name);
    [y,fs] = audioread(mp3_path);
    
    % Preprocessing
    disp('preprocessing audio...');
    y = mean(y, 2); % Average the two channels
    y = y - mean(y); % Remove DC bias

    
    % Compute spectrogram
    disp('computing spectrogram...')
    window_samples = round(window_length * new_rate);
    overlap_samples = round(overlap_length * new_rate);
    [S, F, T] = spectrogram(y, window_samples, overlap_samples, [], new_rate);
    
    % Plot spectrogram
    figure;
    imagesc(T, F, abs(S));
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title('Spectrogram');
    
    % Compute fingerprint
    fingerprint = compute_fingerprint(S);
    
    % Add
    database;
    song_names{i} = mp3_files(i).name;
    fingerprints{i} = fingerprint;

end


% Create database
database = struct('song_names', song_names, 'fingerprints', fingerprints);
save('database.mat', 'database');