
function [bestMatchID, confidence] = match_segment(clip, fs)

    global hashtable
    global numSongs
    
    hashTableSize = size(hashtable,1);
    
    
    % Find peak pairs from the clip
    peaks = fingerprint(clip, fs);
    pairs = convert_to_pairs(peaks);

    
    % Construct the cell of matches
    matches = cell(numSongs,1);
    for k = 1:size(pairs, 1)
        % Calculate hash for the clip
        f1 = pairs(k,3);
        f2 = pairs(k,4);
        deltaT = pairs(k,2) - pairs(k,1);
        clipHash = simple_hash(f1, f2, deltaT, hashTableSize);

        % If an entry exists with this hash, find the song(s) with matching peak pairs
        if (~isempty(hashtable{clipHash, 1}))
            matchID = hashtable{clipHash, 1}; % row vector of collisions
            matchTime = hashtable{clipHash, 2}; % row vector of collisions

            % Calculate the time difference between clip pair and song pair
            offsets =  pairs(k, 1) - matchTime;
                    
            % Add matches to the lists for each individual song
            for n = 1:numSongs
                songOffsets = offsets(matchID == n);
                matches{n} = [matches{n}, songOffsets];
            end
        end
    end
    
    % Find the counts of the mode of the time offset array for each song
    counts = zeros(numSongs, 1);
    for k = 1:numSongs
        if (~isempty(matches{k}))
            [~, mode_count] = mode(matches{k});
            counts(k) = mode_count;
        end
    end
    
  
    % Song decision and confidence
    [~, bestMatchID] = max(counts);
    confidence = 1;
    
    
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
