%% ========================================================================
%  BAB 2: DATA TYPES & VARIABLES
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    2.1 Tipe data numerik
%    2.2 Character & String
%    2.3 Logical (Boolean)
%    2.4 Complex numbers
%    2.5 Konversi tipe data
%    2.6 Special values
%    2.7 Pengecekan tipe data
%  ========================================================================

%% 2.1 Tipe Data Numerik

% --- double (default) ---
% Semua angka di MATLAB secara default bertipe double (64-bit)
x = 42;
fprintf('x = %d, tipe: %s\n', x, class(x))
% >>> x = 42, tipe: double

y = 3.14;
fprintf('y = %.2f, tipe: %s\n', y, class(y))
% >>> y = 3.14, tipe: double

% --- single (32-bit floating point) ---
a = single(3.14);
fprintf('a = %.2f, tipe: %s, bytes: %d\n', a, class(a), whos('a').bytes)

% --- Integer types ---
% Signed integers
i8  = int8(127);       % -128 to 127
i16 = int16(32767);    % -32768 to 32767
i32 = int32(100);      % -2^31 to 2^31-1
i64 = int64(100);      % -2^63 to 2^63-1

% Unsigned integers
u8  = uint8(255);      % 0 to 255
u16 = uint16(65535);   % 0 to 65535
u32 = uint32(100);     % 0 to 2^32-1
u64 = uint64(100);     % 0 to 2^64-1

fprintf('int8 range: %d to %d\n', intmin('int8'), intmax('int8'))
% >>> int8 range: -128 to 127

fprintf('uint8 range: %d to %d\n', intmin('uint8'), intmax('uint8'))
% >>> uint8 range: 0 to 255

% Overflow behavior (saturasi, bukan wrap-around)
val = uint8(300);  % melebihi batas 255
fprintf('uint8(300) = %d (saturasi ke max)\n', val)
% >>> uint8(300) = 255 (saturasi ke max)

%% 2.2 Character & String

% --- Character Array (char) ---
% Menggunakan petik tunggal
nama_char = 'Budi Santoso';
fprintf('Tipe: %s, Isi: %s\n', class(nama_char), nama_char)
% >>> Tipe: char, Isi: Budi Santoso

% Char array adalah array of characters
fprintf('Huruf pertama: %s\n', nama_char(1))      % B
fprintf('Panjang: %d\n', length(nama_char))        % 12

% Concatenation char
salam = ['Halo, ', nama_char, '!'];
disp(salam)
% >>> Halo, Budi Santoso!

% --- String (sejak R2016b) ---
% Menggunakan petik ganda
nama_str = "Budi Santoso";
fprintf('Tipe: %s\n', class(nama_str))
% >>> Tipe: string

% Perbedaan char vs string
ch = 'Hello';     % char array, 1x5
st = "Hello";     % string scalar, 1x1

fprintf('char size: %dx%d\n', size(ch))    % 1x5
fprintf('string size: %dx%d\n', size(st))  % 1x1

% String array
kota = ["Jakarta", "Bandung", "Surabaya"];
fprintf('Kota kedua: %s\n', kota(2))
% >>> Kota kedua: Bandung

% Konversi antara char dan string
char_to_str = string('Hello');        % char -> string
str_to_char = char("Hello");          % string -> char

%% 2.3 Logical (Boolean)

% Nilai logical: true (1) atau false (0)
benar = true;
salah = false;
fprintf('benar = %d, salah = %d\n', benar, salah)
% >>> benar = 1, salah = 0

% Hasil operasi perbandingan menghasilkan logical
hasil = 5 > 3;
fprintf('5 > 3 = %d, tipe: %s\n', hasil, class(hasil))
% >>> 5 > 3 = 1, tipe: logical

% Logical array
arr = [1 2 3 4 5];
mask = arr > 3;
disp('Elemen > 3:')
disp(mask)
% >>> 0  0  0  1  1

% Logical indexing (sangat powerful!)
disp('Nilai yang > 3:')
disp(arr(mask))
% >>> 4  5

% Fungsi logical
disp(any([0 0 1 0]))    % true jika ada elemen true
% >>> 1
disp(all([1 1 1 0]))    % true jika semua elemen true
% >>> 0

%% 2.4 Complex Numbers (Bilangan Kompleks)

% Membuat bilangan kompleks
z1 = 3 + 4i;           % menggunakan i
z2 = 2 - 3j;           % j juga bisa digunakan
z3 = complex(5, 6);    % menggunakan fungsi complex()

fprintf('z1 = %.1f + %.1fi\n', real(z1), imag(z1))
% >>> z1 = 3.0 + 4.0i

% Operasi bilangan kompleks
z_sum = z1 + z2;
z_prod = z1 * z2;
z_conj = conj(z1);     % konjugat
z_abs = abs(z1);        % magnitude/modulus
z_angle = angle(z1);    % sudut dalam radian

fprintf('|z1| = %.2f\n', z_abs)
% >>> |z1| = 5.00

fprintf('angle(z1) = %.4f rad = %.2f deg\n', z_angle, rad2deg(z_angle))

% Cek apakah bilangan kompleks
fprintf('isreal(z1) = %d\n', isreal(z1))    % false
fprintf('isreal(5) = %d\n', isreal(5))      % true

%% 2.5 Konversi Tipe Data

% --- Numerik ke numerik ---
d = 3.7;
i = int32(d);           % double -> int32 (dibulatkan ke 4)
s = single(d);          % double -> single
fprintf('double %.1f -> int32 %d\n', d, i)
% >>> double 3.7 -> int32 4

% --- Numerik ke string/char ---
num = 42;
str_num = num2str(num);          % angka ke string
fprintf('num2str: "%s", tipe: %s\n', str_num, class(str_num))

% Dengan format
str_fmt = num2str(3.14159, '%.2f');
fprintf('Formatted: %s\n', str_fmt)
% >>> Formatted: 3.14

% --- String/char ke numerik ---
val1 = str2double('3.14');       % string ke double
val2 = str2num('42');            % string ke numerik (kurang aman)
fprintf('str2double: %.2f\n', val1)

% --- Logical conversions ---
log_val = logical(1);            % numerik ke logical
num_val = double(true);          % logical ke double
fprintf('logical(1) = %d, double(true) = %d\n', log_val, num_val)

% --- ASCII conversions ---
ascii_val = double('A');         % karakter ke ASCII
char_val = char(65);             % ASCII ke karakter
fprintf('A = %d, 65 = %s\n', ascii_val, char_val)
% >>> A = 65, 65 = A

%% 2.6 Special Values (Nilai Khusus)

% pi - konstanta pi
fprintf('pi = %.10f\n', pi)

% Inf - infinity (tak hingga)
fprintf('1/0 = %f\n', 1/0)              % Inf
fprintf('-1/0 = %f\n', -1/0)            % -Inf

% NaN - Not a Number
fprintf('0/0 = %f\n', 0/0)              % NaN
fprintf('Inf - Inf = %f\n', Inf - Inf)  % NaN

% Cek NaN dan Inf
fprintf('isnan(NaN) = %d\n', isnan(NaN))     % 1
fprintf('isinf(Inf) = %d\n', isinf(Inf))     % 1
fprintf('isfinite(5) = %d\n', isfinite(5))   % 1

% eps - epsilon mesin (presisi floating-point)
fprintf('eps = %.2e\n', eps)
% >>> eps = 2.22e-16

% realmin, realmax
fprintf('realmin = %.2e\n', realmin)    % bilangan positif terkecil
fprintf('realmax = %.2e\n', realmax)    % bilangan positif terbesar

% i dan j - unit imajiner
fprintf('i = %.1f + %.1fi\n', real(1i), imag(1i))

%% 2.7 Pengecekan Tipe Data

x = 42;
s = "hello";
arr = [1 2 3];
c = 3 + 4i;

% class() - mendapatkan nama tipe data
fprintf('class(x) = %s\n', class(x))
fprintf('class(s) = %s\n', class(s))

% isa() - cek apakah suatu tipe
fprintf('isa(x, "double") = %d\n', isa(x, 'double'))
fprintf('isa(x, "numeric") = %d\n', isa(x, 'numeric'))

% Fungsi is* untuk pengecekan
fprintf('isnumeric(x) = %d\n', isnumeric(x))
fprintf('ischar("hi") = %d\n', ischar('hi'))
fprintf('isstring("hi") = %d\n', isstring("hi"))
fprintf('islogical(true) = %d\n', islogical(true))
fprintf('isinteger(int8(1)) = %d\n', isinteger(int8(1)))
fprintf('isfloat(3.14) = %d\n', isfloat(3.14))
fprintf('isreal(c) = %d\n', isreal(c))
fprintf('isempty([]) = %d\n', isempty([]))
fprintf('isscalar(5) = %d\n', isscalar(5))
fprintf('isvector([1 2 3]) = %d\n', isvector([1 2 3]))

%% Ringkasan Bab 2
% ==================
% - Default numerik: double (64-bit floating point)
% - Integer: int8/16/32/64, uint8/16/32/64
% - Char array ('...') vs String ("...")
% - Logical: true/false, hasil operasi perbandingan
% - Complex: a + bi, fungsi real(), imag(), abs(), angle()
% - Konversi: num2str, str2double, char, double, logical
% - Special: pi, Inf, NaN, eps, i/j
% - Pengecekan: class(), isa(), is*() functions

disp('=== Bab 2: Data Types & Variables - Selesai! ===')
