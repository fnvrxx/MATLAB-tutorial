%% ========================================================================
%  BAB 13: OOP BASICS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    13.1 Konsep OOP
%    13.2 Membuat class pertama
%    13.3 Properties
%    13.4 Methods
%    13.5 Constructor
%    13.6 Value class vs Handle class
%    13.7 Static methods
%  ========================================================================
%
%  PENTING: Di MATLAB, setiap class didefinisikan dalam file .m terpisah
%  dengan nama file = nama class.
%  File-file class untuk bab ini ada di folder yang sama.
%  ========================================================================

%% 13.1 Konsep OOP

% OOP (Object-Oriented Programming) adalah paradigma pemrograman yang
% mengorganisir kode dalam bentuk "objek" yang memiliki:
%   - Properties (data/atribut)
%   - Methods (fungsi/perilaku)
%
% 4 Pilar OOP:
%   1. Encapsulation - menyembunyikan detail implementasi
%   2. Abstraction   - menyederhanakan kompleksitas
%   3. Inheritance    - pewarisan sifat dari class parent
%   4. Polymorphism   - satu interface, banyak implementasi

%% 13.2 Class Pertama: Lingkaran
% Lihat file: Lingkaran.m

% --- Membuat objek ---
l1 = Lingkaran(5);      % lingkaran dengan radius 5
l2 = Lingkaran(10);     % lingkaran dengan radius 10

% --- Mengakses properties ---
fprintf('Lingkaran 1: radius = %.1f\n', l1.Radius)

% --- Memanggil methods ---
fprintf('Luas l1 = %.2f\n', l1.hitungLuas())
fprintf('Keliling l1 = %.2f\n', l1.hitungKeliling())
fprintf('Diameter l1 = %.2f\n', l1.Diameter)  % dependent property

% --- Display ---
disp(l1)

%% 13.3 Properties

% Lihat file: Mobil.m untuk contoh lengkap properties

m = Mobil('Toyota', 'Avanza', 2023, 'Putih');
disp(m)

% Mengubah property public
m.Warna = 'Merah';
fprintf('Warna baru: %s\n', m.Warna)

% Property read-only (SetAccess = private) tidak bisa diubah dari luar
% m.TahunProduksi = 2024;  % ERROR!

% Mengakses property
fprintf('Merk: %s\n', m.Merk)
fprintf('Umur: %d tahun\n', m.Umur)  % dependent property

%% 13.4 Methods

% Methods = fungsi yang terkait dengan class

% --- Memanggil method ---
m.klakson()             % method tanpa return
info = m.getInfo();     % method dengan return value
fprintf('%s\n', info)

% --- Method chaining (jika method mengembalikan object) ---
% Lihat Builder pattern di bab Design Patterns

%% 13.5 Constructor

% Constructor = method khusus yang dipanggil saat objek dibuat

% Dengan default values
l_default = Lingkaran();        % radius default = 1
fprintf('Default radius: %.1f\n', l_default.Radius)

% Dengan parameter
l_custom = Lingkaran(7.5);
fprintf('Custom radius: %.1f\n', l_custom.Radius)

% Constructor Mobil
m1 = Mobil('Honda', 'Jazz');                    % tahun & warna default
m2 = Mobil('Toyota', 'Avanza', 2022, 'Silver'); % semua parameter

%% 13.6 Value Class vs Handle Class

% MATLAB memiliki 2 jenis class:

% --- VALUE CLASS (default) ---
% - Copy semantics (seperti struct biasa)
% - Perubahan pada copy TIDAK mempengaruhi original
% - Didefinisikan tanpa "< handle"

v1 = Lingkaran(5);
v2 = v1;              % COPY, bukan reference
v2.Radius = 10;
fprintf('\nValue class:\n')
fprintf('v1.Radius = %.1f (tidak berubah)\n', v1.Radius)
fprintf('v2.Radius = %.1f\n', v2.Radius)

% --- HANDLE CLASS ---
% - Reference semantics (seperti pointer)
% - Perubahan pada reference MEMPENGARUHI original
% - Didefinisikan dengan "< handle"
% Lihat file: BankAccount.m

akun1 = BankAccount('Budi', 1000000);
akun2 = akun1;           % REFERENCE ke objek yang sama!
akun2.setor(500000);

fprintf('\nHandle class:\n')
fprintf('akun1.Saldo = Rp %d (ikut berubah!)\n', akun1.Saldo)
fprintf('akun2.Saldo = Rp %d\n', akun2.Saldo)
% Keduanya menunjuk objek yang SAMA

% Cek apakah dua handle menunjuk objek yang sama
fprintf('akun1 == akun2: %d\n', akun1 == akun2)  % true

%% 13.7 Static Methods

% Static method tidak memerlukan instance (objek)
% Dipanggil langsung dari nama class

% Lihat static methods di Lingkaran.m
fprintf('\nStatic methods:\n')
fprintf('Luas (r=5): %.2f\n', Lingkaran.hitungLuasStatic(5))

% Static method untuk konversi
fprintf('Keliling (d=10): %.2f\n', Lingkaran.dariDiameter(10).hitungKeliling())

%% Demonstrasi Lengkap: Bank Account

fprintf('\n=== Demo Bank Account ===\n')
akun = BankAccount('Ani Wijaya', 5000000);
akun.tampilkanInfo()

akun.setor(2000000);
akun.tampilkanInfo()

akun.tarik(1500000);
akun.tampilkanInfo()

% Transfer
akun_tujuan = BankAccount('Budi Santoso', 3000000);
akun.transfer(akun_tujuan, 1000000);

fprintf('\nSetelah transfer:\n')
akun.tampilkanInfo()
akun_tujuan.tampilkanInfo()

%% Ringkasan Bab 13
% ==================
% - Class didefinisikan dalam file .m terpisah
% - Properties: data/atribut objek, bisa public/private/dependent
% - Methods: fungsi terkait objek
% - Constructor: method yang dipanggil saat membuat objek
% - Value class: copy semantics (default)
% - Handle class: reference semantics (< handle)
% - Static methods: dipanggil tanpa membuat objek

disp('=== Bab 13: OOP Basics - Selesai! ===')
