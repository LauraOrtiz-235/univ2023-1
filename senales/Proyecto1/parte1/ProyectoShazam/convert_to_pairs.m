
function pairs = convert_to_pairs(peaks)

    del_t = 35; % bound on time difference (in pixels)
    del_f = 30; % bound on frequency difference (in pixels)
    fanout = 3; % Maximum number of pairs per peak.
    
    % We get the number of peaks of the audio signal and store them in the variables "f" and "t".
    [f, t] = find(peaks);
    % number of peak
    peakCount = length(f);
    
    % An array "pairs" is initialized
    pairs = zeros(fanout*peakCount, 4);
    index = 1;

    % Iterates over the peaks of the audio signal
    for x = 1:peakCount

        % keep track of the number of pairs that have been added to the current peak.
        links = 0;

        % iterate over the frequencies that are within the allowed frequency difference range
        for f2 = min(size(peaks,1),f(x)+1):min(size(peaks,1),f(x)+del_f)

            if peaks(f2,t(x))
                % a pair is added to the "pairs" array with the coordinates 
                % of the current peak and the frequency of the peak found
                pairs(index, :) = [t(x) t(x) f(x) f2];
                links = links + 1;
                index = index + 1;
            end

            if (links >= fanout)
                break;
            end
        end

        % iterate over times that are within the allowed time difference range
        for t2 = min(size(peaks,2),t(x)+1):min(size(peaks,2),t(x)+del_t)

            if (links >= fanout)
                break;
            end

            % search for a frequency within the allowed frequency difference 
            % range to form a pair with the current peak
            for f2 = max(1,f(x)-del_f):min(size(peaks,1),f(x)+del_f)

                if (links >= fanout)
                    break;
                end

                if peaks(f2,t2)
                    % a pair is added to the "pairs" array with the coordinates 
                    % of the current peak and the frequency of the peak found
                    pairs(index, :) = [t(x) t2 f(x) f2];
                    links = links + 1;
                    index = index + 1;
                end
            end
        end
    end
    
    pairs = pairs(1:(index - 1), :);

end