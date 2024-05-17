
function pairs = convert_to_pairs(peaks)

    del_t = 35; % bound on time difference (in pixels)
    del_f = 30; % bound on frequency difference (in pixels)
    fanout = 3; % Maximum number of pairs per peak.
    
    
    [f, t] = find(peaks);
    peakCount = length(f);
    
    pairs = zeros(fanout*peakCount, 4);
    index = 1;

    for x = 1:peakCount
        links = 0;
        for f2 = min(size(peaks,1),f(x)+1):min(size(peaks,1),f(x)+del_f)
            if peaks(f2,t(x))
                pairs(index, :) = [t(x) t(x) f(x) f2];
                links = links + 1;
                index = index + 1;
            end
            if (links >= fanout)
                break;
            end
        end
        for t2 = min(size(peaks,2),t(x)+1):min(size(peaks,2),t(x)+del_t)
            if (links >= fanout)
                break;
            end
            for f2 = max(1,f(x)-del_f):min(size(peaks,1),f(x)+del_f)
                if (links >= fanout)
                    break;
                end
                if peaks(f2,t2)
                    pairs(index, :) = [t(x) t2 f(x) f2];
                    links = links + 1;
                    index = index + 1;
                end
            end
        end
    end
    
    pairs = pairs(1:(index - 1), :);