classdef CopyableAccount < handle & matlab.mixin.Copyable
    % COPYABLEACCOUNT Handle class yang bisa di-deep-copy
    %   Menggunakan matlab.mixin.Copyable mixin

    properties (SetAccess = private)
        Nama (1,1) string
        Saldo (1,1) double = 0
    end

    methods
        function obj = CopyableAccount(nama, saldo)
            obj.Nama = nama;
            if nargin >= 2
                obj.Saldo = saldo;
            end
        end

        function setor(obj, jumlah)
            obj.Saldo = obj.Saldo + jumlah;
        end

        function tarik(obj, jumlah)
            obj.Saldo = obj.Saldo - jumlah;
        end
    end
end
