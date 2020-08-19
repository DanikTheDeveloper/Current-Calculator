function n = static_cast(c)
temp = double(c);
count = 1;
flag = true;
dot = false;
minus = false;
n = 0;
for ii = 1:length(temp)
    if temp(ii) == 45
        minus = true;
    elseif temp(ii) == 44
       if minus
           n(count) = (-1)*n(count);
       end
       count = count + 1; 
       flag = true;
       dot = false;
       minus = false;
    elseif temp(ii) == 46
        dot = true;
    elseif temp(ii) ~= 32
        if flag
            if ~dot
                n(count) = temp(ii) - 48;
            else
                n(count) = 0;
            end
            flag = false;
        else
            if ~dot
                n(count) = n(count)*10 + (temp(ii) - 48);
            else
                n(count) = n(count) + (1.0*temp(ii) - 48.0)/(10);
            end
        end
    end
    if minus
           n(count) = (-1)*n(count);
    end
end
end