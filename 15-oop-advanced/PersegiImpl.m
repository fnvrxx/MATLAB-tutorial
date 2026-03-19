classdef PersegiImpl < BentukAbstract
    % PERSEGIIMPL Implementasi BentukAbstract untuk persegi

    properties
        Sisi (1,1) double {mustBePositive} = 1
    end

    methods
        function obj = PersegiImpl(sisi, warna)
            if nargin < 2, warna = "Hitam"; end
            obj = obj@BentukAbstract(warna);
            if nargin >= 1
                obj.Sisi = sisi;
            end
        end

        function luas = hitungLuas(obj)
            luas = obj.Sisi^2;
        end

        function keliling = hitungKeliling(obj)
            keliling = 4 * obj.Sisi;
        end

        function str = describe(obj)
            str = sprintf('Persegi (s=%.1f)', obj.Sisi);
        end
    end
end
