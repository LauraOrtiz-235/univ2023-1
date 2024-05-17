
% Make a recording or 

recordingOn = 0; % 1 for recording from microphone, 0 for random segment
duration = 5; 

global hashtable

% Check if we have a database in the workspace
if ~exist('songid')
    % Load database if one exists
    if exist('SONGID2.mat')
        load('SONGID2.mat');
        load('HASHTABLE2.mat');
    else  
        msgbox('No song database');
        return;
    end
end


global numSongs
numSongs = length(songid);

if recordingOn
    % Settings used for recording.
    fs = 44100;  % Sample frequency
    bits = 16;  % Bits used per sample

    % Record audio for <duration> seconds.
    rec = audiorecorder(fs, bits, 2);
    handle1 = msgbox('Recording');
    recordblocking(rec, duration);
    delete(handle1)

    % Store data in Double-precision array.
    sound = getaudiodata(rec);
    
else % Select a random segment
    
    folder_name = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/parte1/parte2/Canciones';    
    songs = getMp3List(folder_name);

    % Select random song
    SongId = ceil(length(songs)*rand);
    filename = strcat(folder_name, filesep, songs{SongId});
    disp(filename);
    [sound,fs] = audioread(filename);
    sound = mean(sound,2);
    sound = sound - mean(sound);
    
    % Select random segment
    if length(sound) > ceil(duration*fs)
        shiftRange = length(sound) - ceil(duration*fs)+1;
        shift = ceil(shiftRange*rand);
        sound = sound(shift:shift+ceil(duration*fs)-1);
    end

end


[bestMatchID, confidence] = match_segment(sound, fs);
answer = songid{bestMatchID};


if recordingOn
    msgbox({strcat(answer, '(Matched song)'), strcat(int2str(confidence), '(Confidence)')}, 'Recorded Segment');
else
    msgbox({strcat(songs{SongId}, '(Actual song)'), strcat(answer, '(Matched song)'), strcat(int2str(confidence), '(Confidence)')}, 'Random Segment');
end