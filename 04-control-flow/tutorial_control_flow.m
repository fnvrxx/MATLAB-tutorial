%% ========================================================================
%  BAB 4: CONTROL FLOW
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    4.1 if / elseif / else
%    4.2 switch / case
%    4.3 for loop
%    4.4 while loop
%    4.5 break & continue
%    4.6 Nested loops
%    4.7 Vectorization vs loops
%  ========================================================================

%% 4.1 if / elseif / else

% --- Struktur dasar ---
nilai = 75;

if nilai >= 90
    grade = 'A';
elseif nilai >= 80
    grade = 'B';
elseif nilai >= 70
    grade = 'C';
elseif nilai >= 60
    grade = 'D';
else
    grade = 'E';
end

fprintf('Nilai: %d, Grade: %s\n', nilai, grade)
% >>> Nilai: 75, Grade: C

% --- if sederhana (tanpa else) ---
umur = 20;
if umur >= 17
    disp('Anda boleh mengikuti pemilu')
end

% --- Kondisi gabungan ---
suhu = 37.5;
batuk = true;

if suhu > 37 && batuk
    disp('Kemungkinan sakit, segera periksa ke dokter')
elseif suhu > 37 || batuk
    disp('Perlu dipantau')
else
    disp('Kondisi normal')
end

% --- Nested if ---
x = 15;
if x > 0
    if mod(x, 2) == 0
        disp('Positif dan genap')
    else
        disp('Positif dan ganjil')
    end
else
    disp('Non-positif')
end
% >>> Positif dan ganjil

%% 4.2 switch / case

% --- Struktur dasar ---
hari = 'Senin';

switch hari
    case 'Senin'
        disp('Hari kerja - awal minggu')
    case {'Selasa', 'Rabu', 'Kamis'}    % multiple values
        disp('Hari kerja - tengah minggu')
    case 'Jumat'
        disp('Hari kerja - akhir minggu')
    case {'Sabtu', 'Minggu'}
        disp('Akhir pekan!')
    otherwise
        disp('Hari tidak valid')
end

% --- switch dengan numerik ---
bulan = 2;
tahun = 2024;

switch bulan
    case {1, 3, 5, 7, 8, 10, 12}
        hari_max = 31;
    case {4, 6, 9, 11}
        hari_max = 30;
    case 2
        if mod(tahun, 4) == 0 && (mod(tahun, 100) ~= 0 || mod(tahun, 400) == 0)
            hari_max = 29;  % tahun kabisat
        else
            hari_max = 28;
        end
    otherwise
        hari_max = 0;
        disp('Bulan tidak valid')
end

fprintf('Bulan %d tahun %d memiliki %d hari\n', bulan, tahun, hari_max)
% >>> Bulan 2 tahun 2024 memiliki 29 hari

%% 4.3 for Loop

% --- Iterasi sederhana ---
fprintf('\nCounting: ')
for i = 1:5
    fprintf('%d ', i)
end
fprintf('\n')
% >>> Counting: 1 2 3 4 5

% --- Step yang berbeda ---
fprintf('Genap: ')
for i = 2:2:10
    fprintf('%d ', i)
end
fprintf('\n')
% >>> Genap: 2 4 6 8 10

% --- Countdown ---
fprintf('Mundur: ')
for i = 5:-1:1
    fprintf('%d ', i)
end
fprintf('\n')
% >>> Mundur: 5 4 3 2 1

% --- Iterasi atas array ---
buah = {'Apel', 'Jeruk', 'Mangga', 'Pisang'};
for i = 1:length(buah)
    fprintf('%d. %s\n', i, buah{i})
end

% --- Iterasi langsung atas kolom matriks ---
M = [1 2 3; 4 5 6; 7 8 9];
fprintf('\nKolom-kolom matriks:\n')
for kolom = M
    disp(kolom')    % kolom adalah vector kolom
end

% --- Akumulasi dalam loop ---
% Menghitung faktorial
n = 5;
faktorial = 1;
for i = 1:n
    faktorial = faktorial * i;
end
fprintf('%d! = %d\n', n, faktorial)
% >>> 5! = 120

% Menghitung deret Fibonacci
n = 10;
fib = zeros(1, n);
fib(1) = 1;
fib(2) = 1;
for i = 3:n
    fib(i) = fib(i-1) + fib(i-2);
end
fprintf('Fibonacci(%d): ', n)
disp(fib)
% >>> Fibonacci(10): 1  1  2  3  5  8  13  21  34  55

%% 4.4 while Loop

% --- Struktur dasar ---
count = 1;
while count <= 5
    fprintf('Count = %d\n', count)
    count = count + 1;
end

% --- Contoh: mencari digit pertama ---
angka = 9876;
temp = angka;
while temp >= 10
    temp = floor(temp / 10);
end
fprintf('Digit pertama dari %d adalah %d\n', angka, temp)
% >>> Digit pertama dari 9876 adalah 9

% --- Contoh: tebak angka ---
% (simulasi, tanpa input user sebenarnya)
target = 42;
tebakan = 0;
percobaan = 0;

% Simulasi binary search
low = 1;
high = 100;

while tebakan ~= target
    tebakan = floor((low + high) / 2);
    percobaan = percobaan + 1;

    if tebakan < target
        low = tebakan + 1;
    elseif tebakan > target
        high = tebakan - 1;
    end
end
fprintf('Ditemukan %d setelah %d percobaan!\n', target, percobaan)

% --- Contoh: Newton-Raphson untuk sqrt ---
x = 25;        % mencari sqrt(25)
guess = x / 2; % tebakan awal
tol = 1e-10;   % toleransi

while abs(guess^2 - x) > tol
    guess = (guess + x/guess) / 2;
end
fprintf('sqrt(%d) = %.10f\n', x, guess)
% >>> sqrt(25) = 5.0000000000

%% 4.5 break & continue

% --- break: keluar dari loop ---
fprintf('\nMencari bilangan prima pertama > 20:\n')
for n = 21:100
    if isprime(n)
        fprintf('Ditemukan: %d\n', n)
        break   % keluar setelah menemukan yang pertama
    end
end
% >>> Ditemukan: 23

% --- continue: lewati iterasi saat ini ---
fprintf('\nBilangan 1-10 yang bukan kelipatan 3:\n')
for i = 1:10
    if mod(i, 3) == 0
        continue    % lewati kelipatan 3
    end
    fprintf('%d ', i)
end
fprintf('\n')
% >>> 1 2 4 5 7 8 10

% --- break dalam while ---
% Validasi input (simulasi)
inputs = [0 -1 5 3 -2 0 7];  % simulasi input
idx = 1;

total = 0;
while true    % infinite loop
    if idx > length(inputs)
        break
    end

    val = inputs(idx);
    idx = idx + 1;

    if val == 0
        disp('Input 0, berhenti.')
        break
    end

    if val < 0
        disp('Nilai negatif diabaikan')
        continue
    end

    total = total + val;
    fprintf('Menambahkan %d, total = %d\n', val, total)
end

%% 4.6 Nested Loops

% --- Tabel perkalian ---
fprintf('\nTabel Perkalian 5x5:\n')
fprintf('    ')
for j = 1:5
    fprintf('%4d', j)
end
fprintf('\n    --------------------\n')

for i = 1:5
    fprintf('%2d |', i)
    for j = 1:5
        fprintf('%4d', i * j)
    end
    fprintf('\n')
end

% --- Pattern: segitiga bintang ---
fprintf('\nSegitiga:\n')
n = 5;
for i = 1:n
    for j = 1:i
        fprintf('* ')
    end
    fprintf('\n')
end

% --- Mencari elemen dalam matriks ---
M = randi(100, 4, 4);  % matriks random 4x4
target = M(3, 2);       % ambil satu elemen sebagai target
fprintf('\nMencari %d dalam matriks:\n', target)
disp(M)

found = false;
for i = 1:size(M, 1)
    for j = 1:size(M, 2)
        if M(i, j) == target
            fprintf('Ditemukan di posisi (%d, %d)\n', i, j)
            found = true;
            break
        end
    end
    if found
        break       % break dari outer loop juga
    end
end

%% 4.7 Vectorization vs Loops (PENTING!)

% MATLAB dirancang untuk operasi vektor/matriks
% Vectorization JAUH lebih cepat daripada loop!

n = 1000000;

% --- Cara LAMBAT: menggunakan loop ---
tic     % mulai timer
result_loop = zeros(1, n);
for i = 1:n
    result_loop(i) = sin(i) * cos(i);
end
t_loop = toc;

% --- Cara CEPAT: vectorization ---
tic
x = 1:n;
result_vec = sin(x) .* cos(x);
t_vec = toc;

fprintf('\nPerforma (n = %d):\n', n)
fprintf('Loop:         %.4f detik\n', t_loop)
fprintf('Vectorized:   %.4f detik\n', t_vec)
fprintf('Speedup:      %.1fx lebih cepat!\n', t_loop / t_vec)

% --- Contoh lain vectorization ---

% LOOP:
A = rand(1000, 1);
B = rand(1000, 1);
C = zeros(1000, 1);
for i = 1:1000
    if A(i) > B(i)
        C(i) = A(i);
    else
        C(i) = B(i);
    end
end

% VECTORIZED (lebih cepat dan lebih ringkas):
C_vec = max(A, B);

% Verifikasi hasilnya sama
fprintf('Hasil sama: %d\n', isequal(C, C_vec))

% Tips vectorization:
% 1. Gunakan operasi element-wise (.*, ./, .^)
% 2. Gunakan fungsi bawaan (sum, mean, max, min, etc.)
% 3. Gunakan logical indexing
% 4. Gunakan arrayfun/cellfun untuk operasi kompleks

% Contoh: mengganti loop dengan logical indexing
data = randn(1, 100);  % 100 bilangan random normal

% Loop version
positif_loop = [];
for i = 1:length(data)
    if data(i) > 0
        positif_loop = [positif_loop, data(i)];
    end
end

% Vectorized version (JAUH lebih baik)
positif_vec = data(data > 0);

fprintf('Jumlah positif: %d\n', length(positif_vec))

%% Ringkasan Bab 4
% ==================
% - if/elseif/else: percabangan kondisional
% - switch/case: alternatif if untuk multiple values
% - for: iterasi dengan jumlah yang diketahui
% - while: iterasi sampai kondisi tidak terpenuhi
% - break: keluar dari loop
% - continue: lewati iterasi saat ini
% - Nested loops: loop di dalam loop
% - PENTING: Gunakan vectorization daripada loop jika memungkinkan!

disp('=== Bab 4: Control Flow - Selesai! ===')
