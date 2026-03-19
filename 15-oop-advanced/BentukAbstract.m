classdef (Abstract) BentukAbstract
    % BENTUKABSTRACT Abstract superclass untuk semua bentuk
    %   Subclass HARUS mengimplementasi semua abstract methods

    properties
        Warna (1,1) string = "Hitam"
    end

    methods (Abstract)
        % Semua subclass HARUS mendefinisikan methods ini
        luas = hitungLuas(obj)
        keliling = hitungKeliling(obj)
        str = describe(obj)
    end

    methods
        function obj = BentukAbstract(warna)
            if nargin > 0
                obj.Warna = warna;
            end
        end

        function tampilkanInfo(obj)
            fprintf('=== %s ===\n', obj.describe())
            fprintf('  Warna    : %s\n', obj.Warna)
            fprintf('  Luas     : %.2f\n', obj.hitungLuas())
            fprintf('  Keliling : %.2f\n', obj.hitungKeliling())
        end
    end
end
