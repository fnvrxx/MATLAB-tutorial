classdef LingkaranImpl < BentukAbstract
    % LINGKARANIMPL Implementasi BentukAbstract untuk lingkaran

    properties
        Radius (1,1) double {mustBePositive} = 1
    end

    methods
        function obj = LingkaranImpl(radius, warna)
            if nargin < 2, warna = "Hitam"; end
            obj = obj@BentukAbstract(warna);
            if nargin >= 1
                obj.Radius = radius;
            end
        end

        function luas = hitungLuas(obj)
            luas = pi * obj.Radius^2;
        end

        function keliling = hitungKeliling(obj)
            keliling = 2 * pi * obj.Radius;
        end

        function str = describe(obj)
            str = sprintf('Lingkaran (r=%.1f)', obj.Radius);
        end
    end
end
