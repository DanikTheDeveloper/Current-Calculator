function boo = isZero(arr)
boo = true;
    for ii = 1:length(arr)
       if arr(ii) ~= 0
           boo = false;
       end
    end
end