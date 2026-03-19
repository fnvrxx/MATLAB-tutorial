%% ========================================================================
%  BAB 5: FUNCTIONS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    5.1 Membuat fungsi dasar
%    5.2 Multiple input & output
%    5.3 Default arguments
%    5.4 Function handle
%    5.5 Anonymous functions
%    5.6 Local functions
%    5.7 Persistent & global variables
%    5.8 nargin, nargout
%    5.9 Recursive functions
%  ========================================================================

%% 5.1 Membuat Fungsi Dasar
% Fungsi di MATLAB biasanya disimpan dalam file .m terpisah
% Nama file HARUS sama dengan nama fungsi

% Fungsi sederhana (lihat file: luas_lingkaran.m)
% function L = luas_lingkaran(r)
%     L = pi * r^2;
% end

% Memanggil fungsi
r = 7;
L = luas_lingkaran(r);
fprintf('Luas lingkaran (r=%d) = %.2f\n', r, L)
% >>> Luas lingkaran (r=7) = 153.94

%% 5.2 Multiple Input & Output
% Lihat file: statistik_data.m

data = [85 92 78 96 88 73 91 82 79 95];
[rata, stdev, minVal, maxVal] = statistik_data(data);

fprintf('\nStatistik Data:\n')
fprintf('Rata-rata : %.2f\n', rata)
fprintf('Std Dev   : %.2f\n', stdev)
fprintf('Minimum   : %.2f\n', minVal)
fprintf('Maximum   : %.2f\n', maxVal)

% Mengabaikan beberapa output dengan ~
[rata, ~, minVal, ~] = statistik_data(data);
fprintf('Hanya rata-rata (%.2f) dan min (%.2f)\n', rata, minVal)

%% 5.3 Default Arguments (menggunakan nargin)
% Lihat file: salam.m

salam()                 % gunakan default
salam('Budi')           % gunakan nama tertentu
salam('Ani', 'Sore')    % gunakan nama dan waktu

%% 5.4 Function Handle
% Function handle (@) adalah referensi ke fungsi

% Handle ke fungsi bawaan
f = @sin;
fprintf('\nsin(pi/2) = %.4f\n', f(pi/2))
% >>> sin(pi/2) = 1.0000

% Handle ke fungsi kustom
hitung_luas = @luas_lingkaran;
fprintf('Luas (r=5) = %.2f\n', hitung_luas(5))

% Menyimpan function handles dalam cell array
operasi = {@sin, @cos, @tan};
x = pi/4;
for i = 1:length(operasi)
    fprintf('%s(pi/4) = %.4f\n', func2str(operasi{i}), operasi{i}(x))
end

% Passing function handle sebagai argument
% Lihat file: terapkan_fungsi.m
data = [1 2 3 4 5];
result = terapkan_fungsi(@(x) x.^2, data);
fprintf('Kuadrat: ')
disp(result)

%% 5.5 Anonymous Functions
% Fungsi tanpa nama, didefinisikan inline

% Satu variabel
kuadrat = @(x) x.^2;
fprintf('kuadrat(5) = %d\n', kuadrat(5))

% Dua variabel
hipot = @(a, b) sqrt(a.^2 + b.^2);
fprintf('hipot(3, 4) = %.2f\n', hipot(3, 4))

% Multiple expressions (gunakan deal atau array)
konversi_suhu = @(C) struct('F', C*9/5 + 32, 'K', C + 273.15);
hasil = konversi_suhu(100);
fprintf('100°C = %.1f°F = %.2f K\n', hasil.F, hasil.K)

% Composing anonymous functions
f = @(x) x.^2;
g = @(x) x + 1;
h = @(x) f(g(x));      % h(x) = (x+1)^2
fprintf('h(3) = (3+1)^2 = %d\n', h(3))

% Capture variables (closure)
offset = 10;
add_offset = @(x) x + offset;
fprintf('add_offset(5) = %d\n', add_offset(5))
% >>> add_offset(5) = 15

% PERHATIAN: offset captured saat definisi, bukan saat pemanggilan
offset = 100;   % mengubah offset
fprintf('add_offset(5) = %d (masih pakai offset=10!)\n', add_offset(5))
% >>> add_offset(5) = 15 (masih pakai offset=10!)

%% 5.6 Local Functions (sejak R2016b, bisa dalam script)
% Fungsi yang didefinisikan di akhir script/function file
% Hanya bisa diakses dari file yang sama

% Contoh: lihat local functions di akhir file ini
hasil = hitung_bmi(75, 1.75);
fprintf('\nBMI = %.1f\n', hasil)

kategori = kategori_bmi(hasil);
fprintf('Kategori: %s\n', kategori)

%% 5.7 Persistent & Global Variables

% --- Global variables ---
% TIDAK DIREKOMENDASIKAN, tapi kadang diperlukan
% Deklarasi: global namaVar (di semua fungsi yang menggunakan)

% global GRAVITY
% GRAVITY = 9.81;
% Fungsi lain juga harus mendeklarasikan: global GRAVITY

% --- Persistent variables ---
% Menyimpan nilai antar pemanggilan fungsi
% Hanya bisa digunakan dalam function (bukan script)
% Lihat file: counter.m

% counter()    % Count: 1
% counter()    % Count: 2
% counter()    % Count: 3

%% 5.8 nargin & nargout

% nargin: jumlah input yang diberikan saat pemanggilan
% nargout: jumlah output yang diminta saat pemanggilan
% Lihat file: flexible_func.m

fprintf('\nFlexible function demo:\n')
flexible_func(5)
flexible_func(5, 3)
[a, b] = flexible_func(5, 3);
fprintf('a = %d, b = %d\n', a, b)

%% 5.9 Recursive Functions (Rekursi)
% Fungsi yang memanggil dirinya sendiri
% Lihat file: factorial_recursive.m dan fibonacci_recursive.m

% Factorial
n = 6;
fprintf('\n%d! = %d (rekursif)\n', n, factorial_recursive(n))

% Fibonacci
fprintf('Fibonacci ke-10 = %d\n', fibonacci_recursive(10))

% Menara Hanoi
fprintf('\nMenara Hanoi (3 piringan):\n')
hanoi(3, 'A', 'C', 'B')

%% Local Functions (harus di bagian paling bawah script)

function bmi = hitung_bmi(berat, tinggi)
    % Menghitung Body Mass Index
    % berat dalam kg, tinggi dalam meter
    bmi = berat / (tinggi^2);
end

function kat = kategori_bmi(bmi)
    % Menentukan kategori BMI
    if bmi < 18.5
        kat = 'Underweight';
    elseif bmi < 25
        kat = 'Normal';
    elseif bmi < 30
        kat = 'Overweight';
    else
        kat = 'Obese';
    end
end
