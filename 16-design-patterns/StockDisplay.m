classdef StockDisplay < handle
    % STOCKDISPLAY Observer dalam Observer pattern

    properties
        Nama (1,1) string
    end

    methods
        function obj = StockDisplay(nama)
            obj.Nama = nama;
        end

        function onUpdate(obj, saham, harga)
            fprintf('  [%s] %s: Rp %d\n', obj.Nama, saham, harga)
        end
    end
end
