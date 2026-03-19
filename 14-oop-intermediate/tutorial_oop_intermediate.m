%% ========================================================================
%  BAB 14: OOP INTERMEDIATE
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    14.1 Inheritance (Pewarisan)
%    14.2 Method overriding
%    14.3 Encapsulation
%    14.4 Operator overloading
%    14.5 Enumeration classes
%    14.6 Copy behavior
%  ========================================================================

%% 14.1 Inheritance (Pewarisan)
% Lihat file: Bentuk.m, Persegi.m, Segitiga.m

% Bentuk adalah parent class (superclass)
% Persegi dan Segitiga adalah child class (subclass)

fprintf('=== Inheritance Demo ===\n\n')

% Membuat objek dari subclass
p = Persegi(5, 'Biru');
s = Segitiga(6, 4, 'Merah');

% Memanggil method yang diwarisi
p.tampilkanInfo()
fprintf('\n')
s.tampilkanInfo()

% Method dari parent class
fprintf('\nPersegi:  luas = %.2f, keliling = %.2f\n', p.hitungLuas(), p.hitungKeliling())
fprintf('Segitiga: luas = %.2f, keliling = %.2f\n', s.hitungLuas(), s.hitungKeliling())

% --- Cek inheritance ---
fprintf('\nisa(p, "Persegi") = %d\n', isa(p, 'Persegi'))     % true
fprintf('isa(p, "Bentuk") = %d\n', isa(p, 'Bentuk'))         % true
fprintf('isa(s, "Persegi") = %d\n', isa(s, 'Persegi'))       % false

%% 14.2 Method Overriding

% Subclass bisa mengganti implementasi method dari superclass
% Lihat implementasi hitungLuas() di Persegi vs Segitiga

% Polymorphism: method yang sama, perilaku berbeda
bentuk_list = {Persegi(4), Segitiga(3, 5), Persegi(7), Segitiga(6, 8)};

fprintf('\n=== Polymorphism ===\n')
for i = 1:length(bentuk_list)
    b = bentuk_list{i};
    fprintf('%s: luas = %.2f\n', class(b), b.hitungLuas())
end

%% 14.3 Encapsulation

% Mengontrol akses ke properties dan methods
% Access levels:
%   public    - bisa diakses dari mana saja (default)
%   private   - hanya bisa diakses dari dalam class
%   protected - bisa diakses dari class dan subclass

% Lihat file: Karyawan.m
k = Karyawan('Budi', 'IT-001', 8000000);
k.tampilkanInfo()

% Property public: bisa diakses
fprintf('Nama: %s\n', k.Nama)

% Property private: TIDAK bisa diakses dari luar
% k.GajiPokok     % ERROR: property is private

% Method untuk akses terkontrol (getter/setter)
fprintf('Gaji (via method): Rp %d\n', k.getGaji())
k.naikGaji(10)  % naik 10%

%% 14.4 Operator Overloading

% MATLAB memungkinkan overloading operator untuk class kustom
% Lihat file: Vektor2D.m

fprintf('\n=== Operator Overloading ===\n')

v1 = Vektor2D(3, 4);
v2 = Vektor2D(1, 2);

% + operator (overload plus)
v3 = v1 + v2;
fprintf('v1 + v2 = ')
disp(v3)

% - operator (overload minus)
v4 = v1 - v2;
fprintf('v1 - v2 = ')
disp(v4)

% * operator (dot product)
dp = v1 * v2;
fprintf('v1 * v2 (dot product) = %d\n', dp)

% == operator
fprintf('v1 == v2: %d\n', v1 == v2)    % false
fprintf('v1 == Vektor2D(3,4): %d\n', v1 == Vektor2D(3,4))  % true

% Scalar multiplication
v5 = v1 * 3;
fprintf('v1 * 3 = ')
disp(v5)

% Magnitude
fprintf('|v1| = %.2f\n', v1.magnitude())

% Normalisasi
vn = v1.normalize();
fprintf('normalize(v1) = ')
disp(vn)

%% 14.5 Enumeration Classes

% Enumeration = tipe data dengan nilai terbatas yang telah ditentukan
% Lihat file: Warna.m dan Hari.m

fprintf('\n=== Enumeration ===\n')

% Menggunakan enumeration
h = Hari.Senin;
fprintf('Hari: %s\n', string(h))

% Perbandingan
if h == Hari.Senin
    disp('Hari Senin!')
end

% Properties dari enumeration
fprintf('Apakah weekend? %d\n', h.isWeekend())

% Iterasi semua nilai enum
fprintf('\nSemua hari:\n')
semua = enumeration('Hari');
for i = 1:length(semua)
    fprintf('  %s (weekend: %d)\n', string(semua(i)), semua(i).isWeekend())
end

%% 14.6 Copy Behavior

% --- Value class: automatic deep copy ---
fprintf('\n=== Copy Behavior ===\n')

l1 = Lingkaran(5);
l2 = l1;            % deep copy otomatis
l2.Radius = 10;
fprintf('Value class: l1.Radius=%d, l2.Radius=%d\n', l1.Radius, l2.Radius)
% l1 tidak berubah

% --- Handle class: reference copy ---
a1 = BankAccount('Tes', 1000);
a2 = a1;            % reference saja!
a2.setor(500);
fprintf('Handle class: a1.Saldo=%d, a2.Saldo=%d\n', a1.Saldo, a2.Saldo)
% keduanya berubah!

% --- Membuat deep copy handle class ---
% Implementasikan method copy() di handle class
% Lihat implementasi di BankAccount.m (jika ada)
% atau gunakan matlab.mixin.Copyable

%% Ringkasan Bab 14
% ==================
% - Inheritance: classdef Child < Parent
% - Method overriding: subclass mendefinisikan ulang method parent
% - Encapsulation: public, private, protected access
% - Operator overloading: plus, minus, mtimes, eq, lt, gt, dll.
% - Enumeration: tipe data dengan nilai terbatas
% - Value class = deep copy, Handle class = reference copy

disp('=== Bab 14: OOP Intermediate - Selesai! ===')
