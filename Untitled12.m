% classdef Circuit < Loop
%     properties
%         Loop;
%     end
%     methods
%         function obj = Circuit(R, V)%non-default constructor
%             for ii = 1:size(R, 1)
%                 obj = [obj;Loop(R(ii,:),V(ii,:))];
%             end
%         end
%         function[simplifiedRes] = addParrallelResistors(R)%R:3D -> 2D
%             sz = size(R);
%             if(lenght(sz) < 2)
%                 simplifiedRes = R;
%                 return;
%             end
%             for ii = 1:sz(2)
%                 flag = false;
%                 for jj = 1:sz(1)
%                     if(R(ii, jj) ~= 0.0 && flag == false)
%                         simplifiedRes(ii) = R(ii, jj);
%                         flag = true;
%                     elseif(R(ii, jj) ~= 0 && flag)
%                         simplifiedRes(ii) = (1/simplifiedRes(ii) + 1/obj.resistance(ii, jj))^-1;
%                     end
%                 end
%             end
%         end
%         function[current] = calculateCurrent(obj)%simplifiedRes,simplifiedVol -> current
%             current = sum(obj.voltage)./sum(obj.resistance);
%         end
%         function[obj1] = addCombinedLoops(obj)
%             for ii = 1:size(obj, 1)
%                 for jj = ii+1:size(obj, 1)
%                     obj1 = [obj1;addAllLoopsInBetween(obj, ii, jj)];
%                 end
%             end
%         end
%         function[loop] = addAllLoopsInBetween(obj, loopNum1, loopNum2)
%             loop = obj(loopNum1);
%             for ii = (loopNum1+1):(loopNum2-loopNum1)
%                 loop = twoLoopsAdded(loop, obj(ii));
%             end
%         end
%         function[loop] = twoLoopsAdded(loop1, loop2)
%             for ii = 1:size(loop1.resistance, 2)
%                 if(loop1.resistance(ii) == 0 && loop2.resistance(ii) == 0)
%                     R(ii) = 0;
%                 elseif(loop1.resistance(ii) == 0)
%                     R(ii) = loop2.resistance(ii);
%                 elseif(loop2.resistance(ii) == 0)
%                     R(ii) = loop1.resistance(ii);
%                 else
%                     R(ii) = 0;
%                 end
%             end
%             loop.resistance = R;
%             if(sum(loop1.voltage) == 0 && sum(loop2.voltage) == 0)
%                 loop.voltage(ii) = 0;
%             elseif(sum(loop1.voltage) == 0)
%                 loop.voltage(ii) = loop2.voltage;
%             elseif(sum(loop2.voltage) == 0)
%                 loop.voltage(ii) = loop1.voltage;
%             else
%                 loop.voltage(ii) = 0;
%             end
%         end
%     end
% end