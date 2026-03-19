classdef Sorter < handle
    % SORTER Context dalam Strategy pattern

    properties (Access = private)
        Strategy
    end

    methods
        function setStrategy(obj, strategy)
            obj.Strategy = strategy;
        end

        function result = sort(obj, data)
            if isempty(obj.Strategy)
                error('Strategy belum di-set!')
            end
            fprintf('Sorting dengan %s...\n', class(obj.Strategy))
            result = obj.Strategy.sort(data);
        end
    end
end
