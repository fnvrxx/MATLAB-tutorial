classdef Karyawan < handle
    % KARYAWAN Demonstrasi encapsulation

    properties
        Nama (1,1) string             % public
    end

    properties (SetAccess = private)
        ID (1,1) string               % read-only dari luar
    end

    properties (Access = private)
        GajiPokok (1,1) double         % fully private
    end

    methods
        function obj = Karyawan(nama, id, gaji)
            obj.Nama = nama;
            obj.ID = id;
            obj.GajiPokok = gaji;
        end

        % Getter terkontrol
        function gaji = getGaji(obj)
            gaji = obj.GajiPokok;
        end

        % Setter terkontrol dengan validasi
        function setGaji(obj, gajiDaru)
            if gajiDaru < 0
                error('Gaji tidak boleh negatif')
            end
            obj.GajiPokok = gajiDaru;
        end

        function naikGaji(obj, persen)
            kenaikan = obj.GajiPokok * persen / 100;
            obj.GajiPokok = obj.GajiPokok + kenaikan;
            fprintf('Gaji %s naik %.0f%% (Rp %d). Gaji baru: Rp %d\n', ...
                obj.Nama, persen, kenaikan, obj.GajiPokok)
        end

        function tampilkanInfo(obj)
            fprintf('Karyawan: %s (ID: %s)\n', obj.Nama, obj.ID)
            fprintf('Gaji: Rp %d\n', obj.GajiPokok)
        end
    end
end
