%% ========================================================================
%  BAB 1: BASIC SYNTAX MATLAB
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    1.1 Mengenal MATLAB
%    1.2 Command Window & Script
%    1.3 Variabel pertama
%    1.4 Komentar
%    1.5 Perintah dasar
%    1.6 Help & dokumentasi
%    1.7 Workspace
%  ========================================================================

%% 1.1 Mengenal MATLAB
% MATLAB = MATrix LABoratory
% MATLAB adalah bahasa pemrograman tingkat tinggi yang dirancang untuk
% komputasi numerik, visualisasi, dan pemrograman.
%
% Area kerja MATLAB:
%   - Command Window   : tempat mengetik perintah langsung
%   - Editor           : tempat menulis script (.m files)
%   - Workspace        : menampilkan variabel yang aktif
%   - Current Folder   : menampilkan file di direktori kerja
%   - Command History  : riwayat perintah

%% 1.2 Menjalankan Perintah
% Ada 2 cara menjalankan kode MATLAB:
%   1. Langsung di Command Window (interaktif)
%   2. Melalui Script file (.m)

% Perintah paling sederhana - menampilkan teks
disp('Hello, World!')
% >>> Hello, World!

% Menampilkan dengan fprintf (lebih fleksibel)
fprintf('Selamat datang di Tutorial MATLAB!\n')
% >>> Selamat datang di Tutorial MATLAB!

% Perbedaan disp vs fprintf
disp('disp menambahkan newline otomatis')
fprintf('fprintf tidak menambahkan newline')
fprintf(' kecuali kita tambahkan \\n\n')

%% 1.3 Variabel Pertama
% Membuat variabel - tidak perlu deklarasi tipe
x = 10;           % integer (disimpan sebagai double)
nama = 'Budi';    % string (char array)
pi_val = 3.14159; % floating point

% Titik koma (;) di akhir = menekan output
a = 5;    % tidak menampilkan output
b = 10    % menampilkan output karena tanpa ;
% >>> b = 10

% Menampilkan nilai variabel
disp(x)
% >>> 10

disp(nama)
% >>> Budi

fprintf('Nilai pi = %.5f\n', pi_val)
% >>> Nilai pi = 3.14159

%% 1.4 Komentar
% Ini adalah komentar satu baris (menggunakan %)

% {
% Ini adalah komentar
% multi-baris (block comment)
% Gunakan %{ dan %} di baris terpisah
% }

%% Ini adalah Section Break
% Dua tanda persen (%%) membuat section baru
% Section berguna untuk menjalankan bagian kode tertentu
% Tekan Ctrl+Enter untuk menjalankan section aktif

%% 1.5 Perintah Dasar yang Sering Digunakan

% --- clc: membersihkan Command Window ---
% clc

% --- clear: menghapus variabel dari workspace ---
% clear           % hapus semua variabel
% clear x y       % hapus variabel x dan y saja

% --- close: menutup figure/plot ---
% close           % tutup figure aktif
% close all       % tutup semua figure

% --- who & whos: melihat variabel di workspace ---
who     % daftar nama variabel
% >>> Your variables are:
% >>> a  b  nama  pi_val  x

whos    % detail lengkap variabel (nama, ukuran, tipe, bytes)

% --- format: mengatur tampilan angka ---
format short    % default, 4 digit desimal
disp(pi)
% >>> 3.1416

format long     % 15 digit desimal
disp(pi)
% >>> 3.141592653589793

format short    % kembalikan ke default

% --- pwd, cd, ls: navigasi direktori ---
disp(pwd)       % tampilkan direktori kerja saat ini
% ls            % daftar file di direktori kerja
% cd('path')    % pindah direktori

%% 1.6 Sistem Help MATLAB

% --- help: bantuan cepat di Command Window ---
% help disp       % bantuan untuk fungsi disp
% help plot       % bantuan untuk fungsi plot

% --- doc: membuka dokumentasi lengkap ---
% doc disp        % buka dokumentasi disp di browser

% --- lookfor: mencari fungsi berdasarkan keyword ---
% lookfor 'inverse'  % cari fungsi terkait 'inverse'

%% 1.7 Workspace dan Penyimpanan

% Membuat beberapa variabel
data1 = [1 2 3 4 5];
data2 = 'Hello MATLAB';
data3 = magic(3);      % matriks ajaib 3x3

% Menyimpan workspace ke file .mat
% save('my_workspace.mat')          % simpan semua variabel
% save('my_data.mat', 'data1', 'data2')  % simpan variabel tertentu

% Memuat workspace dari file .mat
% load('my_workspace.mat')          % muat semua variabel
% load('my_data.mat', 'data1')      % muat variabel tertentu

%% 1.8 Tips dan Trik

% 1. Gunakan Tab untuk auto-complete
% 2. Panah atas/bawah untuk navigasi history
% 3. Ctrl+C untuk menghentikan eksekusi
% 4. F5 untuk menjalankan script
% 5. Ctrl+Enter untuk menjalankan section

% Concatenation output
x = 42;
disp(['Jawaban dari segalanya adalah: ', num2str(x)])
% >>> Jawaban dari segalanya adalah: 42

% sprintf untuk formatting string
msg = sprintf('Nilai x = %d, pi = %.2f', x, pi);
disp(msg)
% >>> Nilai x = 42, pi = 3.14

%% 1.9 Aturan Penamaan Variabel

% VALID:
myVar = 1;          % camelCase
my_var = 2;         % snake_case
var123 = 3;         % mengandung angka
_hidden = 4;        % diawali underscore (tapi tidak direkomendasikan)

% TIDAK VALID (akan error):
% 123var = 5;       % tidak boleh diawali angka
% my-var = 6;       % tidak boleh mengandung tanda hubung
% my var = 7;       % tidak boleh mengandung spasi

% Case-sensitive
Nilai = 100;
nilai = 200;
% Nilai dan nilai adalah DUA variabel berbeda!
fprintf('Nilai = %d, nilai = %d\n', Nilai, nilai)
% >>> Nilai = 100, nilai = 200

% Hindari nama variabel yang sama dengan fungsi bawaan
% Contoh BURUK: sum = 5;  (menimpa fungsi sum())
% Contoh BURUK: i = 10;   (menimpa unit imajiner i)

%% Ringkasan Bab 1
% ==================
% - MATLAB menggunakan Command Window dan Script (.m files)
% - Variabel dibuat langsung tanpa deklarasi tipe
% - Titik koma (;) menekan output
% - Komentar menggunakan %
% - Section break menggunakan %%
% - Perintah penting: clc, clear, close, who, whos, help, doc
% - Variabel bersifat case-sensitive
% - Hindari nama variabel yang sama dengan fungsi bawaan

disp('=== Bab 1: Basic Syntax - Selesai! ===')
