classdef NumberRange < handle
    % NUMBERRANGE Iterator Pattern

    properties (Access = private)
        StartVal (1,1) double
        EndVal (1,1) double
        Step (1,1) double
        Current (1,1) double
    end

    methods
        function obj = NumberRange(startVal, endVal, step)
            obj.StartVal = startVal;
            obj.EndVal = endVal;
            if nargin >= 3
                obj.Step = step;
            else
                obj.Step = 1;
            end
            obj.Current = startVal;
        end

        function tf = hasNext(obj)
            tf = obj.Current <= obj.EndVal;
        end

        function val = next(obj)
            if ~obj.hasNext()
                error('No more elements')
            end
            val = obj.Current;
            obj.Current = obj.Current + obj.Step;
        end

        function reset(obj)
            obj.Current = obj.StartVal;
        end
    end
end
