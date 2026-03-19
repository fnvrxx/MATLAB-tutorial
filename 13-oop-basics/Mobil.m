classdef Mobil
    % MOBIL Class yang merepresentasikan sebuah mobil
    %   Demonstrasi berbagai jenis properties

    properties
        Warna (1,1) string = "Hitam"          % bisa diubah dari luar
    end

    properties (SetAccess = private)
        Merk (1,1) string                      % hanya bisa diubah internal
        Model (1,1) string
        TahunProduksi (1,1) double {mustBePositive}
    end

    properties (Dependent)
        Umur    % dihitung berdasarkan tahun saat ini
    end

    properties (Access = private)
        Kilometer (1,1) double = 0             % fully private
    end

    properties (Constant)
        KECEPATAN_MAX = 200;                   % konstanta
        JENIS = 'Kendaraan Bermotor';
    end

    methods
        % --- Constructor ---
        function obj = Mobil(merk, model, tahun, warna)
            if nargin >= 1
                obj.Merk = merk;
            end
            if nargin >= 2
                obj.Model = model;
            end
            if nargin >= 3
                obj.TahunProduksi = tahun;
            else
                obj.TahunProduksi = year(datetime('now'));
            end
            if nargin >= 4
                obj.Warna = warna;
            end
        end

        % --- Getter untuk Dependent property ---
        function u = get.Umur(obj)
            u = year(datetime('now')) - obj.TahunProduksi;
        end

        % --- Methods ---
        function klakson(obj)
            fprintf('%s %s: BEEEP BEEEP!\n', obj.Merk, obj.Model)
        end

        function info = getInfo(obj)
            info = sprintf('%s %s (%d) - %s, %d km', ...
                obj.Merk, obj.Model, obj.TahunProduksi, ...
                obj.Warna, obj.Kilometer);
        end

        function berkendara(obj, jarak)
            obj.Kilometer = obj.Kilometer + jarak;
            fprintf('Berkendara %d km. Total: %d km\n', jarak, obj.Kilometer)
        end

        % --- Custom display ---
        function disp(obj)
            fprintf('=== %s %s ===\n', obj.Merk, obj.Model)
            fprintf('  Tahun  : %d\n', obj.TahunProduksi)
            fprintf('  Warna  : %s\n', obj.Warna)
            fprintf('  Umur   : %d tahun\n', obj.Umur)
        end
    end
end
