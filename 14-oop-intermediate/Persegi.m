classdef Persegi < Bentuk
    % PERSEGI Subclass dari Bentuk untuk persegi

    properties
        Sisi (1,1) double {mustBePositive} = 1
    end

    methods
        function obj = Persegi(sisi, warna)
            % Panggil constructor parent
            if nargin < 2
                warna = "Hitam";
            end
            obj = obj@Bentuk(warna);

            if nargin >= 1
                obj.Sisi = sisi;
            end
        end

        % Override hitungLuas
        function luas = hitungLuas(obj)
            luas = obj.Sisi^2;
        end

        % Override hitungKeliling
        function keliling = hitungKeliling(obj)
            keliling = 4 * obj.Sisi;
        end

        function nama = getNamaBentuk(obj)
            nama = sprintf('Persegi (sisi=%.1f)', obj.Sisi);
        end
    end
end
