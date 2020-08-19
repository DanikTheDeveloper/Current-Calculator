function [loop] = addTwoLoops(loop1, loop2)
for ii = 1:size(loop1.resistance, 2)
    if(loop1.resistance(ii) == 0 && loop2.resistance(ii) == 0)
        loop.resistance(ii) = 0;
    elseif(loop1.resistance(ii) == 0)
        loop.resistance(ii) = loop2.resistance(ii);
    elseif(loop2.resistance(ii) == 0)
        loop.resistance(ii) = loop1.resistance(ii);
    else
        loop.resistance(ii) = 0;
    end
end
for ii = 1:size(loop1.voltage,2)
    if(loop1.voltage(ii) == 0 && loop2.voltage(ii) == 0)
        loop.voltage(ii) = 0;
    elseif(loop1.voltage(ii) == 0 && loop2.voltage(ii) ~= 0)
        loop.voltage(ii) = loop2.voltage(ii);
    elseif(loop2.voltage(ii) == 0 && loop1.voltage(ii) ~= 0)
        loop.voltage(ii) = loop1.voltage(ii);
    else
        loop.voltage(ii) = 0;
    end
end
end