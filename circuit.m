function [C] = circuit(R1, V)%non-default constructor
sz1 = size(R1);
if length(sz1) > 2
    R1 = addParallelResistors(R1);
end
C = Loop(R1(1,:),V(1,:));
numBat = size(V);
if (numBat(1) ~= 1 && numBat(2) ~= 1)
    for count = 2:size(R1, 1)
        L = Loop(R1(count,:),V(count,:));
        C = [C;L];
    end
else
    for count = 2:size(R1, 1)
        L = Loop(R1(count,:),V(count));
        C = [C;L];
    end
end
% numLoops = length(C);
% sl = subLoop(C);
% for ii = 1:length(sl)-numLoops
%     C = [C; Loop(0,0)];
% end
% C = [C, sl];
end