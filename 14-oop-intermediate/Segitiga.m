classdef Segitiga < Bentuk
    % SEGITIGA Subclass dari Bentuk untuk segitiga
    %   Segitiga sama kaki dengan alas dan tinggi

    properties
        Alas (1,1) double {mustBePositive} = 1
        Tinggi (1,1) double {mustBePositive} = 1
    end

    properties (Dependent)
        SisiMiring
    end

    methods
        function obj = Segitiga(alas, tinggi, warna)
            if nargin < 3
                warna = "Hitam";
            end
            obj = obj@Bentuk(warna);

            if nargin >= 1
                obj.Alas = alas;
            end
            if nargin >= 2
                obj.Tinggi = tinggi;
            end
        end

        function s = get.SisiMiring(obj)
            s = sqrt((obj.Alas/2)^2 + obj.Tinggi^2);
        end

        % Override
        function luas = hitungLuas(obj)
            luas = 0.5 * obj.Alas * obj.Tinggi;
        end

        function keliling = hitungKeliling(obj)
            keliling = obj.Alas + 2 * obj.SisiMiring;
        end

        function nama = getNamaBentuk(obj)
            nama = sprintf('Segitiga (a=%.1f, t=%.1f)', obj.Alas, obj.Tinggi);
        end
    end
end
