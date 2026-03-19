function salam(nama, waktu)
% SALAM Menampilkan salam dengan default arguments
%   SALAM()           - Salam default
%   SALAM(nama)       - Salam dengan nama
%   SALAM(nama, waktu) - Salam dengan nama dan waktu

    if nargin < 1
        nama = 'Dunia';
    end
    if nargin < 2
        waktu = 'Pagi';
    end

    fprintf('Selamat %s, %s!\n', waktu, nama)
end
