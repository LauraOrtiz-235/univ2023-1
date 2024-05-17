% Load global variables
load('SONGID.mat', 'song_ids');
load('HASHTABLE.mat', 'hash_table');

% Prepare clip for identification
[y,fs] = audioread('ChristianNodalNaceUnBorracho.mp3');
clip_len = 10;   % Clip length in seconds
clip_samples = round(clip_len * fs);   % Clip length in samples

clip = y(1:clip_samples, 1);   % Extract the first channel of audio

% Match clip to song
[bestMatchID, confidence] = match_segment(clip, fs);

% Display results
if bestMatchID > 0
    fprintf('Best match: %s\n', song_ids{bestMatchID});
else
    fprintf('No match found\n');
end

fprintf('Confidence: %f\n', confidence);
