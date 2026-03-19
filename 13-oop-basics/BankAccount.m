classdef BankAccount < handle
    % BANKACCOUNT Handle class untuk demonstrasi reference semantics
    %   Merepresentasikan akun bank dengan operasi dasar

    properties (SetAccess = private)
        NamaPemilik (1,1) string
        Saldo (1,1) double {mustBeNonnegative} = 0
        NomorRekening (1,1) string
    end

    properties (Access = private)
        Riwayat (:,1) cell = {}     % riwayat transaksi
    end

    methods
        % --- Constructor ---
        function obj = BankAccount(nama, saldoAwal)
            obj.NamaPemilik = nama;
            if nargin >= 2
                obj.Saldo = saldoAwal;
            end
            % Generate nomor rekening sederhana
            obj.NomorRekening = sprintf("REK-%06d", randi(999999));
            obj.addRiwayat('Buka akun', saldoAwal);
        end

        % --- Setor uang ---
        function setor(obj, jumlah)
            if jumlah <= 0
                error('BankAccount:InvalidAmount', ...
                    'Jumlah setor harus positif')
            end
            obj.Saldo = obj.Saldo + jumlah;
            obj.addRiwayat('Setor', jumlah);
            fprintf('Setor Rp %d berhasil. Saldo: Rp %d\n', jumlah, obj.Saldo)
        end

        % --- Tarik uang ---
        function tarik(obj, jumlah)
            if jumlah <= 0
                error('BankAccount:InvalidAmount', ...
                    'Jumlah tarik harus positif')
            end
            if jumlah > obj.Saldo
                error('BankAccount:InsufficientFunds', ...
                    'Saldo tidak cukup! Saldo: Rp %d, Diminta: Rp %d', ...
                    obj.Saldo, jumlah)
            end
            obj.Saldo = obj.Saldo - jumlah;
            obj.addRiwayat('Tarik', -jumlah);
            fprintf('Tarik Rp %d berhasil. Saldo: Rp %d\n', jumlah, obj.Saldo)
        end

        % --- Transfer ---
        function transfer(obj, tujuan, jumlah)
            if ~isa(tujuan, 'BankAccount')
                error('BankAccount:InvalidAccount', ...
                    'Tujuan harus BankAccount')
            end
            obj.tarik(jumlah);
            tujuan.setor(jumlah);
            obj.addRiwayat(sprintf('Transfer ke %s', tujuan.NamaPemilik), -jumlah);
        end

        % --- Tampilkan info ---
        function tampilkanInfo(obj)
            fprintf('--- Akun %s ---\n', obj.NomorRekening)
            fprintf('Pemilik : %s\n', obj.NamaPemilik)
            fprintf('Saldo   : Rp %d\n', obj.Saldo)
        end

        % --- Tampilkan riwayat ---
        function tampilkanRiwayat(obj)
            fprintf('=== Riwayat Transaksi %s ===\n', obj.NamaPemilik)
            for i = 1:length(obj.Riwayat)
                disp(obj.Riwayat{i})
            end
        end
    end

    methods (Access = private)
        function addRiwayat(obj, keterangan, jumlah)
            entry = struct('waktu', datetime('now'), ...
                          'keterangan', keterangan, ...
                          'jumlah', jumlah, ...
                          'saldo', obj.Saldo);
            obj.Riwayat{end+1} = entry;
        end
    end
end
