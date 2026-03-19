classdef Lingkaran
    % LINGKARAN Class yang merepresentasikan lingkaran
    %   Contoh class dasar dengan properties, methods, constructor
    %
    %   Contoh:
    %       l = Lingkaran(5);
    %       luas = l.hitungLuas();

    properties
        Radius (1,1) double {mustBeNonnegative} = 1   % jari-jari
    end

    properties (Dependent)
        Diameter    % dihitung dari Radius
        Luas        % dihitung dari Radius
        Keliling    % dihitung dari Radius
    end

    methods
        % --- Constructor ---
        function obj = Lingkaran(radius)
            % Membuat objek Lingkaran
            %   l = Lingkaran()     % radius = 1 (default)
            %   l = Lingkaran(5)    % radius = 5
            if nargin > 0
                obj.Radius = radius;
            end
        end

        % --- Methods ---
        function luas = hitungLuas(obj)
            % Menghitung luas lingkaran
            luas = pi * obj.Radius^2;
        end

        function keliling = hitungKeliling(obj)
            % Menghitung keliling lingkaran
            keliling = 2 * pi * obj.Radius;
        end

        function skala(obj, faktor)
            % Mengubah radius dengan faktor skala
            % Catatan: ini VALUE class, jadi perlu return
            % Gunakan: l = l.skala(2) atau buat handle class
            obj.Radius = obj.Radius * faktor;
        end

        % --- Dependent property getters ---
        function d = get.Diameter(obj)
            d = 2 * obj.Radius;
        end

        function l = get.Luas(obj)
            l = pi * obj.Radius^2;
        end

        function k = get.Keliling(obj)
            k = 2 * pi * obj.Radius;
        end

        % --- Display method ---
        function disp(obj)
            fprintf('Lingkaran:\n')
            fprintf('  Radius   = %.2f\n', obj.Radius)
            fprintf('  Diameter = %.2f\n', obj.Diameter)
            fprintf('  Luas     = %.2f\n', obj.Luas)
            fprintf('  Keliling = %.2f\n', obj.Keliling)
        end
    end

    methods (Static)
        function luas = hitungLuasStatic(radius)
            % Static method: bisa dipanggil tanpa objek
            %   Lingkaran.hitungLuasStatic(5)
            luas = pi * radius^2;
        end

        function obj = dariDiameter(diameter)
            % Factory method: membuat Lingkaran dari diameter
            %   l = Lingkaran.dariDiameter(10)
            obj = Lingkaran(diameter / 2);
        end
    end
end
