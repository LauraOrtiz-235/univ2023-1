clc;

% Make a recording or 

recordingOn = 0; %1 for recording from microphone, 0 for random segment
duration = 5; % Seconds



global hash_table

% Check if we have a database in the workspace
% Load database if one exists
if exist('SONGID.mat', 'file') && exist('HASHTABLE.mat', 'file')
    load('SONGID.mat', 'song_ids');
    load('HASHTABLE.mat', 'hash_table');
else  
    msgbox('No song database');
    return;
end


global numSongs
numSongs = length(song_ids);


if recordingOn
    % Settings used for recording.
    fs = 44100; % Sample frequency
    bits = 16;  % Bits used per sample

    % Record audio for <duration> seconds.
    recObj = audiorecorder(fs, bits, 2);
    handle1 = msgbox('Recording');
    recordblocking(recObj, duration);
    delete(handle1)

    % Store data in Double-precision array.
    sound = getaudiodata(recObj);
    
else % Select a random segment
    
    add_noise = 0; % Optionally add noise by making this 1.
    SNRdB = 5; % Signal-to-noise Ratio in dB, if noise is added.  Can be negative.
    
    folder_name = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/parte1/Canciones'; % This is the folder that the MP3 files are in.
    songs = getMp3List(folder_name);
    
    % Select random song
    thisSongIndex = ceil(length(songs)*rand);
    filename = strcat(folder_name, filesep, songs{thisSongIndex});
    [sound,fs] = audioread(filename);
    sound = mean(sound,2);
    sound = sound - mean(sound);
    
    % Select random segment
    if length(sound) > ceil(duration*fs)
        shiftRange = length(sound) - ceil(duration*fs)+1;
        shift = ceil(shiftRange*rand);
        sound = sound(shift:shift+ceil(duration*fs)-1);
    end
    
    % Add noise
    if add_noise
        soundPower = mean(sound.^2);
        noise = randn(size(sound))*sqrt(soundPower/10^(SNRdB/10));
        sound = sound + noise;
    end
end


[bestMatchID, confidence] = match_segment(sound, fs);

answer = song_ids{bestMatchID};
confidence = confidence;             % Replace this line


if recordingOn
    msgbox({strcat(answer, '  (matched song)'), strcat(int2str(confidence), '  (confidence)')}, 'Recorded Segment');
else
    msgbox({strcat(songs{thisSongIndex}, '  (actual song)'), strcat(answer, '  (matched song)'), strcat(int2str(confidence), '  (confidence)')}, 'Random Segment');
end