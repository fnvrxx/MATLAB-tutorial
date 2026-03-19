%% ========================================================================
%  BAB 11: CELL ARRAYS, STRUCTURES & TABLES
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    11.1 Cell Arrays
%    11.2 Structures (struct)
%    11.3 Tables
%    11.4 Containers.Map (Dictionary)
%    11.5 Nested data structures
%    11.6 cellfun, structfun, arrayfun
%  ========================================================================

%% 11.1 Cell Arrays

% Cell array bisa menyimpan tipe data BERBEDA dalam satu container!

% --- Membuat cell array ---
C = {42, 'hello', [1 2 3], true, {4, 5}};

% Menggunakan cell()
C2 = cell(2, 3);    % cell array 2x3 kosong

% --- Indexing ---
% () indexing -> mengembalikan cell
sub = C(1:3);       % sub-cell array {42, 'hello', [1 2 3]}
fprintf('Tipe C(1): %s\n', class(C(1)))  % cell

% {} indexing -> mengembalikan isi cell
val = C{1};         % 42
fprintf('Tipe C{1}: %s, Nilai: %d\n', class(val), val)

str = C{2};         % 'hello'
fprintf('String: %s\n', str)

arr = C{3};         % [1 2 3]
fprintf('Array elemen ke-2: %d\n', arr(2))

% Akses nested: isi cell lalu index array
fprintf('C{3}(2) = %d\n', C{3}(2))   % elemen ke-2 dari array di cell ke-3

% --- Modifikasi ---
C{6} = 'baru';     % tambah elemen baru
C{1} = 100;        % ubah elemen

% --- Cell array 2D ---
tabel = {'Nama', 'Umur', 'Kota';
         'Budi', 25, 'Jakarta';
         'Ani', 23, 'Bandung';
         'Charlie', 28, 'Surabaya'};

fprintf('\nTabel dari cell array:\n')
for i = 1:size(tabel, 1)
    for j = 1:size(tabel, 2)
        if isnumeric(tabel{i,j})
            fprintf('%-12d', tabel{i,j})
        else
            fprintf('%-12s', tabel{i,j})
        end
    end
    fprintf('\n')
end

% --- Konversi ---
% Cell ke array (jika semua elemen numerik)
numCell = {1, 2, 3, 4, 5};
numArr = cell2mat(numCell);
disp(numArr)

% Array ke cell
arr = [10 20 30];
cellArr = num2cell(arr);
disp(cellArr)

% String cell array
strCell = {'Hello', 'World', 'MATLAB'};
strArr = string(strCell);    % cell -> string array
disp(strArr)

%% 11.2 Structures (struct)

% Struct = collection of named fields (seperti record/dict)

% --- Membuat struct ---
% Cara 1: dot notation
mahasiswa.nama = 'Budi Santoso';
mahasiswa.nim = '12345';
mahasiswa.ipk = 3.75;
mahasiswa.aktif = true;

disp('Mahasiswa:')
disp(mahasiswa)

% Cara 2: struct()
dosen = struct('nama', 'Dr. Ani', ...
               'nip', '98765', ...
               'matkul', {{'Kalkulus', 'Aljabar Linear'}}, ...
               'gaji', 15000000);

fprintf('Dosen: %s\n', dosen.nama)
fprintf('Mata kuliah: %s\n', strjoin(dosen.matkul, ', '))

% --- Akses field ---
fprintf('Nama: %s\n', mahasiswa.nama)
fprintf('IPK: %.2f\n', mahasiswa.ipk)

% Dynamic field name
fieldName = 'nama';
fprintf('Dynamic access: %s\n', mahasiswa.(fieldName))

% --- Array of structs ---
siswa(1) = struct('nama', 'Budi', 'nilai', 85);
siswa(2) = struct('nama', 'Ani', 'nilai', 92);
siswa(3) = struct('nama', 'Charlie', 'nilai', 78);

fprintf('\nDaftar Siswa:\n')
for i = 1:length(siswa)
    fprintf('  %s: %d\n', siswa(i).nama, siswa(i).nilai)
end

% Mengakses field dari semua elemen
semua_nilai = [siswa.nilai];    % [85 92 78]
fprintf('Rata-rata: %.1f\n', mean(semua_nilai))

% --- Operasi struct ---
% Cek field ada
fprintf('Has "nama": %d\n', isfield(mahasiswa, 'nama'))
fprintf('Has "alamat": %d\n', isfield(mahasiswa, 'alamat'))

% Daftar semua field
fields = fieldnames(mahasiswa);
fprintf('\nField names:\n')
disp(fields)

% Hapus field
mahasiswa = rmfield(mahasiswa, 'aktif');

% Menambah field
mahasiswa.email = 'budi@email.com';

% orderfields
mahasiswa = orderfields(mahasiswa);
disp('Ordered fields:')
disp(mahasiswa)

%% 11.3 Tables (sejak R2013b)

% Table = tipe data tabular modern, campuran tipe per kolom

% --- Membuat table ---
Nama = {'Budi'; 'Ani'; 'Charlie'; 'Dina'; 'Eko'};
Umur = [25; 23; 28; 22; 30];
Kota = categorical({'Jakarta'; 'Bandung'; 'Jakarta'; 'Surabaya'; 'Bandung'});
IPK = [3.5; 3.8; 3.2; 3.9; 3.1];

T = table(Nama, Umur, Kota, IPK);
disp('Table:')
disp(T)

% --- Akses data ---
% Seluruh kolom
fprintf('Kolom Umur:\n')
disp(T.Umur)

% Baris tertentu
fprintf('Baris 2:\n')
disp(T(2, :))

% Cell dari kolom nama
fprintf('Nama ke-3: %s\n', T.Nama{3})

% Dot notation dengan row
fprintf('IPK Budi: %.1f\n', T.IPK(1))

% --- Filtering ---
% Mahasiswa dengan IPK > 3.5
T_tinggi = T(T.IPK > 3.5, :);
fprintf('\nIPK > 3.5:\n')
disp(T_tinggi)

% Mahasiswa dari Jakarta
T_jkt = T(T.Kota == 'Jakarta', :);
fprintf('Dari Jakarta:\n')
disp(T_jkt)

% --- Sorting ---
T_sorted = sortrows(T, 'IPK', 'descend');
fprintf('Sorted by IPK (descending):\n')
disp(T_sorted)

% --- Statistik ---
fprintf('Summary:\n')
summary(T)

fprintf('Mean IPK: %.2f\n', mean(T.IPK))
fprintf('Max Umur: %d\n', max(T.Umur))

% --- Grouping ---
% Group by Kota
[G, kota_unik] = findgroups(T.Kota);
ipk_per_kota = splitapply(@mean, T.IPK, G);
fprintf('\nRata-rata IPK per Kota:\n')
for i = 1:length(kota_unik)
    fprintf('  %s: %.2f\n', string(kota_unik(i)), ipk_per_kota(i))
end

% --- Menambah/menghapus kolom ---
T.Lulus = T.IPK >= 3.5;    % tambah kolom
T.Keterangan = repmat({'Mahasiswa'}, height(T), 1);
fprintf('\nTabel dengan kolom baru:\n')
disp(T)

T.Keterangan = [];         % hapus kolom
% atau: T = removevars(T, 'Keterangan');

% --- Join tables ---
Info = table({'Budi'; 'Ani'; 'Charlie'}, ...
             {'Teknik'; 'Sains'; 'Teknik'}, ...
             'VariableNames', {'Nama', 'Jurusan'});

T_joined = innerjoin(T(:, {'Nama', 'IPK'}), Info);
fprintf('Joined table:\n')
disp(T_joined)

%% 11.4 Containers.Map (Dictionary/HashMap)

% --- Membuat Map ---
harga = containers.Map();
harga('Nasi Goreng') = 25000;
harga('Mie Ayam') = 20000;
harga('Bakso') = 15000;
harga('Es Teh') = 5000;

% Atau langsung
ibukota = containers.Map(...
    {'Indonesia', 'Malaysia', 'Thailand', 'Jepang'}, ...
    {'Jakarta', 'Kuala Lumpur', 'Bangkok', 'Tokyo'});

% --- Akses ---
fprintf('\nHarga Nasi Goreng: Rp %d\n', harga('Nasi Goreng'))
fprintf('Ibukota Jepang: %s\n', ibukota('Jepang'))

% --- Cek key ada ---
if isKey(harga, 'Sate')
    disp('Sate tersedia')
else
    disp('Sate tidak tersedia')
end

% --- Semua keys dan values ---
semua_menu = keys(harga);
semua_harga = values(harga);

fprintf('\nMenu dan Harga:\n')
for i = 1:length(semua_menu)
    fprintf('  %-15s: Rp %d\n', semua_menu{i}, semua_harga{i})
end

% --- Hapus entry ---
remove(harga, 'Es Teh');

% --- Jumlah entries ---
fprintf('Jumlah menu: %d\n', length(harga))

%% 11.5 Nested Data Structures

% Struct berisi cell berisi struct...
universitas = struct();
universitas.nama = 'Universitas Indonesia';
universitas.fakultas = {
    struct('nama', 'Teknik', ...
           'jurusan', {{'Sipil', 'Mesin', 'Elektro'}}, ...
           'mahasiswa', 500), ...
    struct('nama', 'MIPA', ...
           'jurusan', {{'Matematika', 'Fisika', 'Kimia'}}, ...
           'mahasiswa', 400)
};

% Akses nested
fprintf('\n%s\n', universitas.nama)
for i = 1:length(universitas.fakultas)
    fak = universitas.fakultas{i};
    fprintf('  Fakultas %s (%d mahasiswa):\n', fak.nama, fak.mahasiswa)
    for j = 1:length(fak.jurusan)
        fprintf('    - %s\n', fak.jurusan{j})
    end
end

%% 11.6 cellfun, structfun, arrayfun

% --- cellfun: apply function ke setiap cell ---
words = {'hello', 'world', 'matlab', 'tutorial'};
lengths = cellfun(@length, words);
fprintf('\nPanjang kata: ')
disp(lengths)

upper_words = cellfun(@upper, words, 'UniformOutput', false);
disp(upper_words)

% --- arrayfun: apply function ke setiap elemen array ---
x = 1:10;
result = arrayfun(@(n) sum(1:n), x);  % sum 1 sampai n untuk setiap n
fprintf('Cumulative sums: ')
disp(result)

% --- structfun: apply function ke setiap field ---
data = struct('a', [1 2 3], 'b', [4 5], 'c', [6 7 8 9]);
sizes = structfun(@length, data);
fprintf('Ukuran setiap field: ')
disp(sizes')

%% Ringkasan Bab 11
% ==================
% - Cell Array: {mixed types}, indexing () vs {}
% - Struct: named fields, dot notation, dynamic fields
% - Table: tabular data modern, filtering, sorting, grouping
% - Containers.Map: key-value pairs (dictionary)
% - Nested structures: kombinasi cell, struct, array
% - Apply functions: cellfun, arrayfun, structfun

disp('=== Bab 11: Cell Arrays, Structures & Tables - Selesai! ===')
