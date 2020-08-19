function [loop] = subLoop(C)
L = addLoopsInBetween(C, 1, 2);
loop = Loop(L.resistance, L.voltage);
flag = false;
for ii = 1:size(C, 1)
    for jj = ii+1:size(C, 1)
        if flag
            L = addLoopsInBetween(C, ii, jj);
            loop = [loop; Loop(L.resistance, L.voltage)];
        end
        flag = true;
    end
end
end