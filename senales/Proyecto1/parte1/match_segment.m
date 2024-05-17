
function [bestMatchID, confidence] = match_segment(clip, fs)
% Load song IDs and hash table from files
load('SONGID.mat', 'song_ids');
load('HASHTABLE.mat', 'hash_table');

global numSongs
numSongs = length(song_ids);

hashTableSize = size(hash_table,1);
fs_new = 4000;                      
win_len = 64;                       
overlap_len = 32; 

% Find peak pairs from the clip
clip = mean(clip, 2);
clip = clip - mean(clip);

% Resample to new rate
clip = resample(clip, fs_new, fs);

% Compute spectrogram
[S, F, T] = spectrogram(clip, win_len, overlap_len, 64, fs_new);
magS = abs(S);  % Magnitude of the spectrogram 


gs = 4;         % Distance to search in each direction

% Find local peaks in the spectrogram
CS1 = circshift(S, [gs 0]);
CS2 = circshift(S, [-gs 0]);
CS3 = circshift(S, [0 gs]);
CS4 = circshift(S, [0 -gs]);
P = (S > CS1) & (S > CS2) & (S > CS3) & (S > CS4);


% Thresholding
peaks_per_sec = 30;                       % scales the threshold
peakMags = P.*magS;
peaksThres = sort(peakMags(:),'descend'); % sort all peak values in order
threshold = peaksThres(ceil(max(T)*peaks_per_sec));
    
% Apply threshold
if (threshold > 0)
    peaks = (peakMags >= threshold);
end

pairs = convert_to_pairs(peaks);


% Construct the cell of matches
matches = cell(numSongs,1);
for k = 1:size(pairs, 1)
    % Calculate hash for the clip
    f1 = pairs(k,1);
    f2 = pairs(k,2);
    t1 = pairs(k,3);
    %deltaT = t2-t1; % Duration of each time window
    clipHash = simple_hash(f1, f2, t1, hashTableSize);

    % If an entry exists with this hash, find the song(s) with matching peak pairs
    if (~isempty(hash_table{clipHash, 1}))
        matchID = hash_table{clipHash, 1}; % row vector of collisions
        matchTime = hash_table{clipHash, 2}; % row vector of collisions
        
        % Calculate the time difference between clip pair and song pair
        offsets = matchTime - t1;
        
        % Add matches to the lists for each individual song
        for n = 1:numSongs
            songOffsets = offsets(matchID == n);
            matches{n} = [matches{n}, songOffsets];
        end
    end
end


% Find the counts of the mode of the time offset array for each song
counts = zeros(numSongs,1);
for k = 1:numSongs
    if (~isempty(matches{k}))
        counts(k) = mode(matches{k});
    end
end

% Song decision and confidence
[maxCount, bestMatchID] = max(counts);
if (maxCount == 0)
    confidence = 0;
else
    % Calculate confidence based on the number of matching pairs
    numMatchingPairs = sum(counts == maxCount);
    confidence = numMatchingPairs / length(pairs);
end


optional_plot = 0; % turn plot on or off

if optional_plot
    figure(3)
    clf
    y = zeros(length(matches),1);
    
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        hist(matches{k},1000)
        y(k) = max(hist(matches{k},1000));
    end
    
    for k = 1:length(matches)
        subplot(length(matches),1,k)
        axis([-inf, inf, 0, max(y)])
    end

    subplot(length(matches),1,1)
    title('Histogram of offsets for each song')
end

end


%%

