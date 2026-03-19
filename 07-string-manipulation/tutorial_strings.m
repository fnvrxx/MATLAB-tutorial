%% ========================================================================
%  BAB 7: STRING MANIPULATION
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    7.1 Char arrays vs Strings
%    7.2 Operasi string dasar
%    7.3 Pencarian dan penggantian
%    7.4 Formatting (sprintf, fprintf)
%    7.5 Regular expressions
%    7.6 String arrays dan operasi
%  ========================================================================

%% 7.1 Char Arrays vs Strings

% --- Char array (petik tunggal) ---
ch = 'Hello MATLAB';
fprintf('Tipe: %s, Size: %dx%d\n', class(ch), size(ch))
% >>> Tipe: char, Size: 1x12

% Char array = array of characters
fprintf('Karakter ke-1: %s\n', ch(1))     % H
fprintf('Karakter ke-6: %s\n', ch(6))     % space

% --- String (petik ganda, sejak R2016b) ---
st = "Hello MATLAB";
fprintf('Tipe: %s, Size: %dx%d\n', class(st), size(st))
% >>> Tipe: string, Size: 1x1

% --- Kapan pakai apa? ---
% char array: kompatibilitas lama, indexing per karakter
% string:     operasi modern, string arrays, lebih fleksibel

%% 7.2 Operasi String Dasar

% --- Panjang ---
s = "Selamat Datang";
fprintf('strlength: %d\n', strlength(s))    % 14
fprintf('length char: %d\n', length(char(s))) % 14

% --- Concatenation ---
% Char array
nama = ['Budi', ' ', 'Santoso'];
disp(nama)

% String (menggunakan +)
nama_str = "Budi" + " " + "Santoso";
disp(nama_str)

% strcat (menghapus trailing spaces untuk char)
s1 = strcat('Hello', ' ', 'World');
disp(s1)

% join (untuk string array)
kata = ["Saya", "suka", "MATLAB"];
kalimat = join(kata, " ");
disp(kalimat)
% >>> Saya suka MATLAB

% --- Upper/Lower case ---
s = "Hello World";
fprintf('upper: %s\n', upper(s))     % HELLO WORLD
fprintf('lower: %s\n', lower(s))     % hello world

% --- Trim whitespace ---
s = "  Hello  ";
fprintf('strip: "%s"\n', strip(s))          % "Hello"
fprintf('strtrim: "%s"\n', strtrim(s))      % "Hello" (char compatible)

% --- Split ---
csv = "Jakarta,Bandung,Surabaya,Yogyakarta";
kota = split(csv, ",");
disp('Kota-kota:')
disp(kota)

% strsplit (char array version)
parts = strsplit(char(csv), ',');
disp(parts)

% --- Reverse ---
s = 'MATLAB';
disp(s(end:-1:1))    % BALTAM

% --- Repeat ---
s = repmat('Ha', 1, 3);
disp(s)  % HaHaHa

%% 7.3 Pencarian dan Penggantian

s = "MATLAB adalah bahasa pemrograman yang powerful";

% --- contains: cek apakah mengandung substring ---
fprintf('contains "bahasa": %d\n', contains(s, "bahasa"))     % 1
fprintf('contains "Python": %d\n', contains(s, "Python"))     % 0

% Case-insensitive
fprintf('contains "matlab" (ignore case): %d\n', ...
    contains(s, "matlab", 'IgnoreCase', true))  % 1

% --- startsWith, endsWith ---
fprintf('startsWith "MATLAB": %d\n', startsWith(s, "MATLAB"))  % 1
fprintf('endsWith "powerful": %d\n', endsWith(s, "powerful"))   % 1

% --- strfind: posisi substring ---
pos = strfind(char(s), 'a');
fprintf('Posisi huruf "a": ')
disp(pos)

% --- replace ---
s2 = replace(s, "powerful", "hebat");
disp(s2)
% >>> MATLAB adalah bahasa pemrograman yang hebat

% --- strrep (char version) ---
s3 = strrep(char(s), 'MATLAB', 'Octave');
disp(s3)

% --- erase: hapus substring ---
s4 = erase(s, " yang powerful");
disp(s4)

% --- extractBefore, extractAfter ---
fprintf('Before "bahasa": %s\n', extractBefore(s, "bahasa"))
fprintf('After "bahasa": %s\n', extractAfter(s, "bahasa"))

% --- strcmp: perbandingan string ---
fprintf('strcmp("abc","abc") = %d\n', strcmp('abc', 'abc'))     % 1
fprintf('strcmp("abc","ABC") = %d\n', strcmp('abc', 'ABC'))     % 0
fprintf('strcmpi("abc","ABC") = %d\n', strcmpi('abc', 'ABC')) % 1 (ignore case)

%% 7.4 Formatting

% --- sprintf: format string tanpa print ---
nama = 'Budi';
umur = 25;
tinggi = 175.5;

s = sprintf('Nama: %s, Umur: %d, Tinggi: %.1f cm', nama, umur, tinggi);
disp(s)

% --- Format specifiers ---
% %d   - integer
% %f   - floating point
% %e   - scientific notation
% %g   - compact float/scientific
% %s   - string
% %c   - single character
% %x   - hexadecimal
% %o   - octal
% %b   - binary (hanya untuk dec2bin)

fprintf('\n--- Format Specifiers ---\n')
fprintf('Integer:     %d\n', 42)
fprintf('Float:       %f\n', 3.14159)
fprintf('Scientific:  %e\n', 0.000123)
fprintf('Compact:     %g\n', 3.14159)
fprintf('Hex:         %x\n', 255)
fprintf('Octal:       %o\n', 8)
fprintf('Char:        %c\n', 65)    % A

% --- Width dan precision ---
fprintf('\n--- Width & Precision ---\n')
fprintf('|%10d|\n', 42)          % right-aligned, width 10
fprintf('|%-10d|\n', 42)         % left-aligned, width 10
fprintf('|%010d|\n', 42)         % zero-padded, width 10
fprintf('|%+d|\n', 42)           % always show sign
fprintf('|%.4f|\n', 3.14)        % 4 decimal places
fprintf('|%10.2f|\n', 3.14)      % width 10, 2 decimal

% --- Tabel formatting ---
fprintf('\n%-15s %10s %10s\n', 'Nama', 'Nilai', 'Grade')
fprintf('%-15s %10d %10s\n', 'Budi', 85, 'B')
fprintf('%-15s %10d %10s\n', 'Ani', 92, 'A')
fprintf('%-15s %10d %10s\n', 'Charlie', 78, 'C')

% --- Escape characters ---
fprintf('\n--- Escape Characters ---\n')
fprintf('Tab:\tHello\n')
fprintf('Newline:\nBaris baru\n')
fprintf('Backslash: \\\n')
fprintf('Persen: 100%%\n')
fprintf('Single quote: It''s MATLAB\n')

%% 7.5 Regular Expressions

% regexp - powerful pattern matching

teks = 'Email: budi@email.com dan ani123@gmail.com';

% --- Mencari pattern ---
% Mencari semua email
pattern = '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';
emails = regexp(teks, pattern, 'match');
fprintf('\nEmail ditemukan:\n')
for i = 1:length(emails)
    fprintf('  %s\n', emails{i})
end

% --- Token extraction ---
data = 'Nama: Budi, Umur: 25, Kota: Jakarta';
pattern = '(\w+):\s*(\w+)';
[tokens] = regexp(data, pattern, 'tokens');
fprintf('\nExtracted tokens:\n')
for i = 1:length(tokens)
    fprintf('  %s = %s\n', tokens{i}{1}, tokens{i}{2})
end

% --- Pattern matching common examples ---
teks2 = 'Nomor HP: 0812-3456-7890 dan 0856-1234-5678';

% Mencari nomor telepon
pattern_hp = '08\d{2}-\d{4}-\d{4}';
hp = regexp(teks2, pattern_hp, 'match');
fprintf('\nNomor HP: ')
disp(hp)

% --- regexprep: replace dengan regex ---
% Sensor kata tertentu
kalimat = 'Ini kata jelek dan buruk';
clean = regexprep(kalimat, '(jelek|buruk)', '***');
disp(clean)

% Ubah camelCase ke snake_case
camel = 'myVariableName';
snake = regexprep(camel, '([a-z])([A-Z])', '$1_$2');
snake = lower(snake);
fprintf('camelCase to snake_case: %s -> %s\n', camel, snake)

%% 7.6 String Arrays dan Operasi

% --- String array ---
buah = ["Apel", "Jeruk", "Mangga", "Pisang", "Durian"];

% Indexing
fprintf('Buah ke-3: %s\n', buah(3))

% Sorting
disp('Sorted:')
disp(sort(buah))

% Unique
data = ["A", "B", "A", "C", "B", "A"];
disp('Unique:')
disp(unique(data))

% Counting
fprintf('Jumlah "A": %d\n', sum(data == "A"))

% --- Konversi numerik <-> string ---
angka = [1.5, 2.7, 3.14];
str_angka = string(angka);     % numerik ke string array
disp(str_angka)

% str2double untuk konversi balik
nums = str2double(["3.14", "2.72", "1.41"]);
disp(nums)

% --- compose: vectorized sprintf ---
nama = ["Budi", "Ani", "Charlie"];
nilai = [85, 92, 78];
hasil = compose("%s mendapat nilai %d", nama', nilai');
disp(hasil)

%% Ringkasan Bab 7
% ==================
% - Char array ('...') vs String ("...")
% - Operasi: length, upper, lower, strip, split, join
% - Pencarian: contains, startsWith, strfind, strcmp
% - Penggantian: replace, strrep, erase
% - Formatting: sprintf, fprintf dengan format specifiers
% - Regex: regexp, regexprep untuk pattern matching
% - String arrays: operasi vectorized pada koleksi string

disp('=== Bab 7: String Manipulation - Selesai! ===')
