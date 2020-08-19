function [loop] = addLoopsInBetween(C, index1, index2)
% if index2-index1 < 3
%     loop = addTwoLoops(C(index1), C(index2));
%     return;
% end
loop = C(index1);
for ii = index1+1:index2
    loop = addTwoLoops(loop, C(ii));
end
end