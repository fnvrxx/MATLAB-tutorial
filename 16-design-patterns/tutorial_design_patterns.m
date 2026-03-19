%% ========================================================================
%  BAB 16: DESIGN PATTERNS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    16.1 Singleton Pattern
%    16.2 Observer Pattern
%    16.3 Strategy Pattern
%    16.4 Factory Pattern
%    16.5 Builder Pattern
%    16.6 Iterator Pattern
%  ========================================================================

%% 16.1 Singleton Pattern
% Hanya satu instance yang bisa dibuat
% Lihat file: DatabaseConnection.m

fprintf('=== Singleton Pattern ===\n')

db1 = DatabaseConnection.getInstance();
db2 = DatabaseConnection.getInstance();

fprintf('db1 == db2: %d (same instance!)\n', db1 == db2)

db1.query('SELECT * FROM users')
db2.query('INSERT INTO users VALUES (1, "Budi")')

%% 16.2 Observer Pattern
% Object (subject) memberi tahu observer saat state berubah
% Lihat file: StockMarket.m, StockDisplay.m

fprintf('\n=== Observer Pattern ===\n')

market = StockMarket();

% Registrasi observers
display1 = StockDisplay("Monitor 1");
display2 = StockDisplay("Monitor 2");

market.addObserver(display1);
market.addObserver(display2);

% Update harga
market.updateHarga("BBCA", 8500);
market.updateHarga("TLKM", 3200);

% Hapus satu observer
market.removeObserver(display2);
fprintf('\n(Monitor 2 dihapus)\n')
market.updateHarga("BBCA", 8600);

%% 16.3 Strategy Pattern
% Memilih algoritma saat runtime
% Lihat file: Sorter.m, BubbleSortStrategy.m, QuickSortStrategy.m

fprintf('\n=== Strategy Pattern ===\n')

data = [64 34 25 12 22 11 90];
fprintf('Data: ')
disp(data)

sorter = Sorter();

% Gunakan Bubble Sort
sorter.setStrategy(BubbleSortStrategy());
result1 = sorter.sort(data);
fprintf('Bubble Sort: ')
disp(result1)

% Ganti ke Quick Sort saat runtime
sorter.setStrategy(QuickSortStrategy());
result2 = sorter.sort(data);
fprintf('Quick Sort:  ')
disp(result2)

%% 16.4 Factory Pattern
% Membuat objek tanpa mengekspos logika pembuatan
% Lihat file: BentukFactory.m

fprintf('\n=== Factory Pattern ===\n')

b1 = BentukFactory.buat('lingkaran', 5);
b2 = BentukFactory.buat('persegi', 4);
b3 = BentukFactory.buat('segitiga', 6, 4);

bentuk_list = {b1, b2, b3};
for i = 1:length(bentuk_list)
    b = bentuk_list{i};
    fprintf('%s: luas = %.2f\n', class(b), b.hitungLuas())
end

%% 16.5 Builder Pattern
% Membangun objek kompleks secara bertahap
% Lihat file: QueryBuilder.m

fprintf('\n=== Builder Pattern ===\n')

qb = QueryBuilder();
query = qb.select('nama, umur, kota') ...
          .from('mahasiswa') ...
          .where('umur > 20') ...
          .where('kota = "Jakarta"') ...
          .orderBy('nama ASC') ...
          .limit(10) ...
          .build();

fprintf('Query: %s\n', query)

%% 16.6 Iterator Pattern
% Lihat file: NumberRange.m

fprintf('\n=== Iterator Pattern ===\n')

range = NumberRange(1, 10, 2);  % start=1, end=10, step=2
fprintf('Range [1, 10, step=2]: ')
while range.hasNext()
    fprintf('%d ', range.next())
end
fprintf('\n')

%% Ringkasan Bab 16
% ==================
% - Singleton: satu instance per class
% - Observer: subject notify observers saat berubah
% - Strategy: pilih algoritma saat runtime
% - Factory: pembuatan objek terencapsulasi
% - Builder: objek kompleks dibangun bertahap
% - Iterator: traversal sequential tanpa ekspos struktur

disp('=== Bab 16: Design Patterns - Selesai! ===')
