
function maxCollisions = add_to_table(tuple, songIdNum)

    global hashtable;
    
    hashTableSize = size(hashtable,1);
    
    % Count the max number of collisions for a given hash (FYI)
    maxCollisions = 0;   
            
    for m = 1:size(tuple, 1);
        hash = simple_hash(tuple(m,3), tuple(m,4), tuple(m,2)-tuple(m,1), hashTableSize);

        %  first instance of this hash
        if isempty(hashtable{hash,1})
            hashtable{hash, 1} = songIdNum; % # id of the song
            hashtable{hash, 2} = tuple(m,1); 

        % duplicate instance of this hash
        else
            hashtable{hash, 1} = [hashtable{hash, 1}, songIdNum];
            hashtable{hash, 2} = [hashtable{hash, 2}, tuple(m,1)];
    
            collisions = length(hashtable{hash, 1});
            
            if collisions > maxCollisions
                maxCollisions = collisions;
            end
        end
    end

end