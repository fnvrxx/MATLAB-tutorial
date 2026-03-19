classdef StockMarket < handle
    % STOCKMARKET Subject dalam Observer pattern

    properties (Access = private)
        Observers (:,1) cell = {}
        Harga containers.Map
    end

    methods
        function obj = StockMarket()
            obj.Harga = containers.Map();
        end

        function addObserver(obj, observer)
            obj.Observers{end+1} = observer;
        end

        function removeObserver(obj, observer)
            idx = [];
            for i = 1:length(obj.Observers)
                if obj.Observers{i} == observer
                    idx = i;
                    break
                end
            end
            if ~isempty(idx)
                obj.Observers(idx) = [];
            end
        end

        function updateHarga(obj, saham, harga)
            obj.Harga(saham) = harga;
            obj.notifyObservers(saham, harga)
        end
    end

    methods (Access = private)
        function notifyObservers(obj, saham, harga)
            for i = 1:length(obj.Observers)
                obj.Observers{i}.onUpdate(saham, harga)
            end
        end
    end
end
