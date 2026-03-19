%% ========================================================================
%  BAB 8: FILE I/O
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    8.1 Membaca dan menulis file teks
%    8.2 CSV files
%    8.3 MAT files
%    8.4 Excel files
%    8.5 Binary files
%    8.6 JSON dan XML
%    8.7 File management
%  ========================================================================

%% 8.1 Membaca dan Menulis File Teks

% --- Menulis file teks menggunakan fprintf ---
fid = fopen('output.txt', 'w');   % 'w' = write (overwrite)
if fid == -1
    error('Gagal membuka file!')
end

fprintf(fid, 'Ini adalah baris pertama\n');
fprintf(fid, 'Nama: %s, Umur: %d\n', 'Budi', 25);
fprintf(fid, 'Nilai: %.2f\n', 3.14159);

for i = 1:5
    fprintf(fid, 'Baris ke-%d\n', i);
end

fclose(fid);
disp('File output.txt berhasil ditulis')

% --- Membaca file teks ---
% Cara 1: fgets (baris per baris)
fid = fopen('output.txt', 'r');
fprintf('\n--- Membaca dengan fgets ---\n')
while ~feof(fid)          % feof = end of file
    line = fgets(fid);    % baca satu baris (termasuk \n)
    fprintf('%s', line)
end
fclose(fid);

% Cara 2: fgetl (tanpa newline)
fid = fopen('output.txt', 'r');
fprintf('\n--- Membaca dengan fgetl ---\n')
baris_ke = 0;
while ~feof(fid)
    line = fgetl(fid);
    baris_ke = baris_ke + 1;
    fprintf('[%d] %s\n', baris_ke, line)
end
fclose(fid);

% Cara 3: fileread (seluruh file sekaligus)
isi = fileread('output.txt');
fprintf('\n--- fileread ---\n')
disp(isi)

% Cara 4: readlines (R2020b+, mengembalikan string array)
% lines = readlines('output.txt');
% disp(lines)

% --- Mode file ---
% 'r'  - baca (read)
% 'w'  - tulis (write, overwrite)
% 'a'  - tambah (append)
% 'r+' - baca dan tulis
% 'w+' - baca dan tulis (overwrite)
% 'a+' - baca dan tambah

% --- Append ke file ---
fid = fopen('output.txt', 'a');  % append mode
fprintf(fid, '\n--- Ditambahkan ---\n');
fprintf(fid, 'Baris tambahan!\n');
fclose(fid);

%% 8.2 CSV Files

% --- Menulis CSV ---
% Cara 1: writematrix (R2019a+)
data = rand(5, 3);
writematrix(data, 'data_numerik.csv');
disp('data_numerik.csv ditulis')

% Cara 2: writetable (dengan header)
T = table({'Budi'; 'Ani'; 'Charlie'}, [85; 92; 78], [3.5; 3.8; 3.2], ...
    'VariableNames', {'Nama', 'Nilai', 'IPK'});
writetable(T, 'mahasiswa.csv');
disp('mahasiswa.csv ditulis')
disp(T)

% Cara 3: csvwrite (lama, hanya numerik)
csvwrite('simple.csv', magic(4));

% --- Membaca CSV ---
% Cara 1: readmatrix (R2019a+)
data_baca = readmatrix('data_numerik.csv');
fprintf('\nData dari CSV:\n')
disp(data_baca)

% Cara 2: readtable (dengan header)
T_baca = readtable('mahasiswa.csv');
fprintf('Tabel mahasiswa:\n')
disp(T_baca)

% Cara 3: csvread (lama, hanya numerik)
M = csvread('simple.csv');
disp(M)

% --- CSV dengan delimiter khusus ---
% Menulis
fid = fopen('custom.csv', 'w');
fprintf(fid, 'Nama;Kota;Umur\n');
fprintf(fid, 'Budi;Jakarta;25\n');
fprintf(fid, 'Ani;Bandung;23\n');
fclose(fid);

% Membaca dengan delimiter khusus
T_custom = readtable('custom.csv', 'Delimiter', ';');
disp(T_custom)

%% 8.3 MAT Files

% Format native MATLAB - paling efisien untuk data MATLAB

% --- Menyimpan ---
x = rand(100, 100);
nama = 'Tutorial MATLAB';
data = struct('nilai', [85 92 78], 'grade', {'B', 'A', 'C'});

% Simpan semua variabel
% save('workspace.mat')

% Simpan variabel tertentu
save('data_saya.mat', 'x', 'nama', 'data')
disp('data_saya.mat disimpan')

% Simpan dengan kompresi (default di MATLAB modern)
save('data_compressed.mat', 'x', '-v7.3')  % HDF5 format, bisa > 2GB

% --- Memuat ---
clear x nama data    % hapus dulu
load('data_saya.mat')
fprintf('Loaded: x (%dx%d), nama = "%s"\n', size(x), nama)

% Muat variabel tertentu
clear x nama data
load('data_saya.mat', 'nama')
fprintf('Hanya nama: %s\n', nama)

% Muat ke struct (tidak menimpa workspace)
S = load('data_saya.mat');
fprintf('Dari struct: nama = %s\n', S.nama)

% --- Inspeksi tanpa memuat ---
info = whos('-file', 'data_saya.mat');
fprintf('\nIsi data_saya.mat:\n')
for i = 1:length(info)
    fprintf('  %s: %s [%s]\n', info(i).name, ...
        mat2str(info(i).size), info(i).class)
end

%% 8.4 Excel Files

% --- Menulis ke Excel ---
% Cara 1: writetable
T = table({'Budi'; 'Ani'; 'Charlie'}, [85; 92; 78], ...
    'VariableNames', {'Nama', 'Nilai'});
writetable(T, 'nilai.xlsx', 'Sheet', 'Data Mahasiswa');
disp('nilai.xlsx ditulis')

% Cara 2: writematrix
writematrix(magic(5), 'magic.xlsx', 'Sheet', 1, 'Range', 'B2');

% Cara 3: xlswrite (lama)
% xlswrite('file.xlsx', data, sheet, range)

% --- Membaca dari Excel ---
% Cara 1: readtable
T_excel = readtable('nilai.xlsx');
disp(T_excel)

% Cara 2: readmatrix
M_excel = readmatrix('magic.xlsx');
disp(M_excel)

% Cara 3: xlsread (lama)
% [num, txt, raw] = xlsread('file.xlsx')

%% 8.5 Binary Files

% --- Menulis binary ---
data = rand(1, 100);

fid = fopen('data.bin', 'wb');  % 'wb' = write binary
fwrite(fid, length(data), 'int32');     % tulis panjang data
fwrite(fid, data, 'double');            % tulis data
fclose(fid);

% --- Membaca binary ---
fid = fopen('data.bin', 'rb');  % 'rb' = read binary
n = fread(fid, 1, 'int32');             % baca panjang data
data_baca = fread(fid, n, 'double');    % baca data
fclose(fid);

fprintf('\nBinary: %d elemen, pertama=%.4f, terakhir=%.4f\n', ...
    n, data_baca(1), data_baca(end))

% --- Tipe data binary ---
% 'int8', 'int16', 'int32', 'int64'
% 'uint8', 'uint16', 'uint32', 'uint64'
% 'single', 'double'
% 'char'

%% 8.6 JSON

% --- Membuat dan menulis JSON ---
data_json = struct();
data_json.nama = 'Budi Santoso';
data_json.umur = 25;
data_json.hobi = {{'Coding', 'Gaming', 'Membaca'}};
data_json.alamat = struct('kota', 'Jakarta', 'provinsi', 'DKI Jakarta');

json_str = jsonencode(data_json);
fprintf('\nJSON string:\n%s\n', json_str)

% Pretty print
json_pretty = jsonencode(data_json, 'PrettyPrint', true);
fprintf('\nJSON pretty:\n%s\n', json_pretty)

% Simpan ke file
fid = fopen('data.json', 'w');
fprintf(fid, '%s', json_pretty);
fclose(fid);

% --- Membaca JSON ---
json_content = fileread('data.json');
data_parsed = jsondecode(json_content);
fprintf('Nama: %s, Kota: %s\n', data_parsed.nama, data_parsed.alamat.kota)

%% 8.7 File Management

% --- Cek file/folder exists ---
fprintf('\nFile exists: %d\n', isfile('output.txt'))
fprintf('Dir exists: %d\n', isfolder('.'))

% --- Listing files ---
files = dir('*.csv');
fprintf('\nFile CSV:\n')
for i = 1:length(files)
    fprintf('  %s (%d bytes)\n', files(i).name, files(i).bytes)
end

% --- Membuat direktori ---
if ~isfolder('temp_folder')
    mkdir('temp_folder')
    disp('Direktori temp_folder dibuat')
end

% --- File info ---
info = dir('output.txt');
fprintf('\nInfo output.txt:\n')
fprintf('  Ukuran: %d bytes\n', info.bytes)
fprintf('  Tanggal: %s\n', info.date)

% --- Path operations ---
[pathstr, name, ext] = fileparts('/path/to/file.txt');
fprintf('\nPath: %s\n', pathstr)
fprintf('Name: %s\n', name)
fprintf('Ext: %s\n', ext)

full = fullfile('folder', 'subfolder', 'file.txt');
fprintf('Fullfile: %s\n', full)

% --- Cleanup files yang dibuat ---
% delete('output.txt')
% delete('*.csv')
% rmdir('temp_folder')

%% Ringkasan Bab 8
% ==================
% - File teks: fopen/fprintf/fclose, fileread, readlines
% - CSV: readtable/writetable, readmatrix/writematrix
% - MAT: save/load - format native paling efisien
% - Excel: writetable/readtable untuk xlsx
% - Binary: fread/fwrite untuk data besar
% - JSON: jsonencode/jsondecode
% - Management: dir, isfile, isfolder, mkdir, fileparts

disp('=== Bab 8: File I/O - Selesai! ===')
