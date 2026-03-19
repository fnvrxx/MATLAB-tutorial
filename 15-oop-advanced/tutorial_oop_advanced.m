%% ========================================================================
%  BAB 15: OOP ADVANCED
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    15.1 Abstract classes
%    15.2 Interfaces (multiple inheritance)
%    15.3 Events & Listeners
%    15.4 Metaclass programming
%    15.5 Mixins
%    15.6 Custom containers (subsref, subsasgn)
%  ========================================================================

%% 15.1 Abstract Classes
% Lihat file: BentukAbstract.m, LingkaranImpl.m, PersegiImpl.m

% Abstract class TIDAK bisa di-instantiasi langsung
% Subclass HARUS mengimplementasi semua abstract methods

fprintf('=== Abstract Classes ===\n')

% BentukAbstract adalah abstract -> tidak bisa: b = BentukAbstract()
lingkaran = LingkaranImpl(5, "Biru");
persegi = PersegiImpl(4, "Merah");

% Polymorphism dengan abstract class
bentuk_list = {lingkaran, persegi};
for i = 1:length(bentuk_list)
    b = bentuk_list{i};
    fprintf('%s: luas=%.2f, keliling=%.2f\n', ...
        b.describe(), b.hitungLuas(), b.hitungKeliling())
end

%% 15.2 Interfaces (Multiple Inheritance)
% MATLAB mendukung multiple inheritance
% Lihat file: Serializable.m, Printable.m, DataObject.m

fprintf('\n=== Multiple Inheritance (Interfaces) ===\n')

obj = DataObject("Test Data", [1 2 3 4 5]);

% Method dari Printable
obj.printToConsole()

% Method dari Serializable
json = obj.serialize();
fprintf('Serialized: %s\n', json)

% Cek interface
fprintf('Is Serializable: %d\n', isa(obj, 'Serializable'))
fprintf('Is Printable: %d\n', isa(obj, 'Printable'))

%% 15.3 Events & Listeners
% Handle classes bisa mendefinisikan events yang bisa di-observe
% Lihat file: Thermostat.m

fprintf('\n=== Events & Listeners ===\n')

t = Thermostat(22);  % suhu awal 22°C

% Menambahkan listener
lh1 = addlistener(t, 'SuhuBerubah', ...
    @(src, evt) fprintf('  [Listener] Suhu berubah ke %.1f°C\n', src.Suhu));

lh2 = addlistener(t, 'PeringatanSuhu', ...
    @(src, evt) fprintf('  [PERINGATAN] %s\n', evt.Message));

% Mengubah suhu - akan trigger events
t.setSuhu(25);
t.setSuhu(38);      % trigger peringatan (> 35)
t.setSuhu(5);       % trigger peringatan (< 10)
t.setSuhu(22);

% Hapus listener
delete(lh1);
delete(lh2);

%% 15.4 Metaclass Programming

fprintf('\n=== Metaclass ===\n')

% Mendapatkan metaclass information
mc = meta.class.fromName('BankAccount');

fprintf('Class: %s\n', mc.Name)
fprintf('Superclasses: ')
for i = 1:length(mc.SuperclassList)
    fprintf('%s ', mc.SuperclassList(i).Name)
end
fprintf('\n')

% Daftar properties
fprintf('\nProperties:\n')
for i = 1:length(mc.PropertyList)
    p = mc.PropertyList(i);
    fprintf('  %-20s [Get: %-9s, Set: %-9s]\n', ...
        p.Name, p.GetAccess, p.SetAccess)
end

% Daftar methods
fprintf('\nMethods:\n')
for i = 1:length(mc.MethodList)
    m = mc.MethodList(i);
    if ~m.Hidden && strcmp(m.DefiningClass.Name, 'BankAccount')
        fprintf('  %-20s [Access: %s]\n', m.Name, m.Access)
    end
end

% --- Dynamic object creation ---
className = 'Lingkaran';
objDynamic = feval(className, 10);  % sama dengan Lingkaran(10)
fprintf('\nDynamic creation: %s, Radius=%.1f\n', class(objDynamic), objDynamic.Radius)

%% 15.5 Mixins
% Mixin = class yang menambahkan fungsionalitas tanpa menjadi parent utama
% Lihat file: LoggableMixin.m, TimestampMixin.m

% MATLAB mixin yang sudah ada:
% - matlab.mixin.Copyable: deep copy untuk handle class
% - matlab.mixin.SetGet: set/get syntax seperti graphics objects
% - matlab.mixin.CustomDisplay: custom display formatting
% - matlab.mixin.Heterogeneous: array dari tipe berbeda

fprintf('\n=== Mixins ===\n')

% Contoh Copyable mixin
% Lihat file: CopyableAccount.m
ca1 = CopyableAccount('Budi', 1000000);
ca2 = copy(ca1);        % deep copy berkat Copyable mixin

ca1.setor(500000);
fprintf('ca1.Saldo = %d\n', ca1.Saldo)
fprintf('ca2.Saldo = %d (tidak berubah, deep copy)\n', ca2.Saldo)

%% 15.6 Custom Containers (subsref, subsasgn)
% Override indexing behavior
% Lihat file: SafeArray.m

fprintf('\n=== Custom Container ===\n')

sa = SafeArray([10 20 30 40 50]);

% Indexing biasa
fprintf('sa(3) = %d\n', sa(3))

% Out-of-bounds handling (custom)
fprintf('sa(10) = %d (out of bounds, returns 0)\n', sa(10))

% Set value
sa(2) = 99;
fprintf('After sa(2)=99: ')
sa.display()

%% Ringkasan Bab 15
% ==================
% - Abstract class: template yang harus diimplementasi subclass
% - Multiple inheritance: MATLAB mendukung, dipakai untuk interfaces
% - Events & Listeners: observer pattern, notifikasi perubahan state
% - Metaclass: introspeksi class saat runtime
% - Mixins: reusable functionality (Copyable, SetGet, etc.)
% - subsref/subsasgn: custom indexing behavior

disp('=== Bab 15: OOP Advanced - Selesai! ===')
