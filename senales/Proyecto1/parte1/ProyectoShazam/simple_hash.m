
function hash = simple_hash(f1, f2, deltaT, size)
    hash = mod(round( size*1000000*(log(abs(f1)+2) + 2*log(abs(f2)+2) + 3*log(abs(deltaT)+2)) ), size) + 1;
end