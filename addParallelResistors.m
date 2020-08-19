function[simplifiedRes] = addParallelResistors(Res)%R:2D -> 1D
sz2 = size(Res);
simplifiedRes = zeros(sz2(1),sz2(2));
for ii = 1:sz2(1)
    for jj = 1:sz2(2)
        flag = false;
        for kk = 1:length(Res(ii, jj,:))
            if(Res(ii, jj, kk) ~= 0.0 && flag == false)
                simplifiedRes(ii, jj) = Res(ii, jj, kk);
                flag = true;
            elseif(Res(ii, jj, kk) ~= 0.0 && flag == true)
                simplifiedRes(ii, jj) = (1/simplifiedRes(ii, jj) + 1/Res(ii, jj, kk))^-1;
            end
        end
    end
end
end