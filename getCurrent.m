function I = getCurrent(C)
    resArr = getResistanceArray(C);
    M = zeros(length(resArr));
    M(1,1) = resArr(1);
    innerStart = length(C)*2 - 1;
    M(1,innerStart) = -1.0*resArr(innerStart);
    for ii = 2:length(C)-1
        M(ii,innerStart+ii-2) = resArr(innerStart+ii-2);
        M(ii,ii) = resArr(ii);
        M(ii,innerStart+ii-1) = -1.0*resArr(innerStart+ii-1);
        M(ii,innerStart-ii+1) = resArr(innerStart-ii+1);
    end
    M(length(C),length(C)) = resArr(length(C));
    M(length(C),length(resArr)) = resArr(length(resArr));
    volArr = [getVoltageArray(C);zeros(length(resArr)-length(C),1)];
    M = [M,volArr];
    for ii = 1:length(C)-1
        M(length(C)+ii,ii) = 1;
        M(length(C)+ii,innerStart+ii-1) = 1;
        M(length(C)+ii,ii+1) = -1;
    end
    for ii = 1:length(C)-3
        M(2*length(C)+ii-1,length(C)+ii) = 1;
        M(2*length(C)+ii-1,length(resArr)-ii) = -1;
        M(2*length(C)+ii-1,length(C)+ii+1) = -1;
    end
    M(length(resArr),innerStart-1) = 1;
    M(length(resArr),innerStart) = -1;
    M(length(resArr),1) = -1;
    disp(M);
    M = rref(M);
    I = M(:,length(resArr)+1);
end