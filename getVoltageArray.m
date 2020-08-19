function voltageArray = getVoltageArray(C)
sz = size(C);
voltageArray = zeros(sz(1),1);
    for ii = 1:sz(1)
        if ii ~= 1
            for jj = 1:length(C(ii).voltage)
                if C(ii).voltage(jj) == C(ii - 1).voltage(jj)
                    C(ii).voltage(jj) = (-1)*C(ii).voltage(jj);
                end
            end
        end
        voltageArray(ii) = sum(C(ii).voltage);
    end
end