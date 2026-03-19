function L = luas_lingkaran(r)
% LUAS_LINGKARAN Menghitung luas lingkaran
%   L = LUAS_LINGKARAN(r) menghitung luas lingkaran dengan jari-jari r
%
%   Input:
%       r - jari-jari lingkaran (skalar atau array)
%   Output:
%       L - luas lingkaran
%
%   Contoh:
%       L = luas_lingkaran(7)    % L = 153.9380

    if any(r < 0)
        error('Jari-jari harus positif!')
    end

    L = pi * r.^2;
end
