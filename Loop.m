classdef Loop
    properties
        resistance,%2D matrix (rows  resistors, columns - parallel resistors)
        voltage,%1D matrix (rows - batteries)
        current,%0D matrix
    end
    methods
        function obj = Loop(Res, Vol)%non-default constructor
            obj.resistance = Res;
            obj.voltage = Vol;
            obj.current = calculateCurrent(obj);
        end
        function[current] = calculateCurrent(obj)%simplifiedRes,simplifiedVol -> current
            if sum(obj.resistance) == 0
                current = 0;
                return;
            end
            current = sum(obj.voltage)./sum(obj.resistance);
        end
    end
end