function hanoi(n, sumber, tujuan, bantu)
% HANOI Menyelesaikan Menara Hanoi secara rekursif
%   HANOI(n, sumber, tujuan, bantu)
%
%   Input:
%       n      - jumlah piringan
%       sumber - tiang sumber
%       tujuan - tiang tujuan
%       bantu  - tiang pembantu

    if n == 1
        fprintf('Pindahkan piringan 1 dari %s ke %s\n', sumber, tujuan)
        return
    end

    hanoi(n-1, sumber, bantu, tujuan);
    fprintf('Pindahkan piringan %d dari %s ke %s\n', n, sumber, tujuan);
    hanoi(n-1, bantu, tujuan, sumber);
end
