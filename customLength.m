function n = customLength(R)
n = 1;
for ii = 1:length(R)
    if R(ii) ~= 0
        n = ii;
    end
end
end