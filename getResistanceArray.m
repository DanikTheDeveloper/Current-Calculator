function [resistanceArray] = getResistanceArray(C)
numLoops = size(C);
numLoops = numLoops(1);
resSize = length(C(1).resistance);
resistanceArray = zeros(1,3*length(C)-3);
for ii = 1:resSize
    if C(1,1).resistance(ii) ~= C(2,1).resistance(ii)
        resistanceArray(1) = resistanceArray(1) + C(1,1).resistance(ii);
    end
end
for jj = 2:numLoops-1
    flag = false;
    flag2 = false;
    for kk = 1:resSize
        if C(jj,1).resistance(kk) ~= C(jj-1,1).resistance(kk) && ~flag && ~flag2
            flag = true;
            flag2 = true;
        end
        if C(jj,1).resistance(kk) == C(jj+1,1).resistance(kk) && flag
            flag = false;
        end
        if flag
            resistanceArray(jj) = resistanceArray(jj) + C(jj,1).resistance(kk);
        end
    end
end
for ii = 1:resSize
    if C(numLoops,1).resistance(ii) ~= C(numLoops-1,1).resistance(ii)
        resistanceArray(numLoops) = resistanceArray(numLoops) + C(numLoops,1).resistance(ii);
    end
end
for jj = 2:numLoops-2
    flag = false;
    flag2 = false;
    for kk = 1:resSize
        if C(jj,1).resistance(kk) == C(jj+1,1).resistance(kk) && ~flag2
            flag2 = true;
        end
        if C(jj,1).resistance(kk) ~= C(jj+1,1).resistance(kk) && flag2
            flag = true;
        end
        if flag
            resistanceArray(jj+numLoops-2) = resistanceArray(jj+numLoops-2) + C(jj,1).resistance(kk);
        end
    end
end
for jj = 2:numLoops
    for kk = 1:resSize
        if C(jj,1).resistance(kk) == C(jj-1,1).resistance(kk)
            resistanceArray(jj+2*numLoops-3) = resistanceArray(jj+2*numLoops-3) + C(jj,1).resistance(kk);
        end
    end
end
end