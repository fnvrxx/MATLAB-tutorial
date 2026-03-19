classdef Bentuk
    % BENTUK Abstract-like superclass untuk semua bentuk geometri
    %   Ini adalah parent class yang diwarisi oleh Persegi, Segitiga, dll.

    properties
        Warna (1,1) string = "Hitam"
    end

    methods
        function obj = Bentuk(warna)
            if nargin > 0
                obj.Warna = warna;
            end
        end

        function tampilkanInfo(obj)
            fprintf('[%s] %s - Warna: %s\n', class(obj), ...
                obj.getNamaBentuk(), obj.Warna)
            fprintf('  Luas     : %.2f\n', obj.hitungLuas())
            fprintf('  Keliling : %.2f\n', obj.hitungKeliling())
        end

        % Methods yang harus di-override oleh subclass
        function luas = hitungLuas(obj)
            luas = 0;  % default, harus di-override
        end

        function keliling = hitungKeliling(obj)
            keliling = 0;  % default, harus di-override
        end

        function nama = getNamaBentuk(obj)
            nama = class(obj);  % default: nama class
        end
    end
end
