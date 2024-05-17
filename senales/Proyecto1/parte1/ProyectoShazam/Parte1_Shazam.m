
folder_name = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/parte1/parte2/Canciones'; 
songs = getMp3List(folder_name);
%display(songs);

hashTableSize = 100000; % This can be adjusted. Setting it too small will cause more accidental collisions.

global hashtable

% Check if we have a database in the workspace
if ~exist('songid.mat') 
    % Load database if one exists
    if exist('SONGID2.mat')
        load('SONGID2.mat');
        load('HASHTABLE2.mat');
    else  
        % Create new database
        songid = cell(0);
        hashtable = cell(hashTableSize,2); 
    end 
end

% Song ID number
songIndex = length(songid); 

% Add songs to songid and fingerprints to hashtable
someNewSongs = 0;
for i = 1:length(songs)
    
    % Check if the song is already in the database
    songFound = 0;
    for m = 1:length(songid)
        if strcmp(songs{i}, songid{m})
            songFound = 1;
            break;
        end
    end
    
    if ~songFound
        someNewSongs = 1;
        songIndex = songIndex + 1;
        filename = strcat(folder_name, filesep, songs{i});
        [sound,fs] = audioread(filename);

        peaks = fingerprint(sound, fs);
        pairs = convert_to_pairs(peaks);
        maxCollisions = add_to_table(pairs, songIndex);
        
        songid{songIndex,1} = songs{i};
    end
end

global numSongs
numSongs = songIndex;
if someNewSongs
    save('SONGID2.mat', 'songid');
    save('HASHTABLE2.mat', 'hashtable');
end

load('SONGID2.mat');
whos;
disp(songid);