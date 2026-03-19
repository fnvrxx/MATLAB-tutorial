%% ========================================================================
%  PROYEK 1: ANALISIS DATA PENJUALAN
%  Tutorial MATLAB - Real World Projects
%  ========================================================================
%  Tujuan:
%    - Membuat data penjualan sintetis
%    - Analisis tren, musiman, dan statistik
%    - Visualisasi komprehensif
%    - Prediksi sederhana
%  ========================================================================

%% 1. Generate Data Sintetis
fprintf('=== Proyek 1: Analisis Data Penjualan ===\n\n')

rng(42)  % reproducible results

% 365 hari data penjualan
n_hari = 365;
tanggal = datetime(2024, 1, 1) + days(0:n_hari-1);

% Komponen data:
% 1. Tren naik
tren = linspace(100, 150, n_hari);

% 2. Musiman (weekly pattern)
weekly = 30 * sin(2*pi*(1:n_hari)/7);

% 3. Musiman (monthly)
monthly = 20 * sin(2*pi*(1:n_hari)/30);

% 4. Random noise
noise = 15 * randn(1, n_hari);

% 5. Special events (lonjakan saat hari tertentu)
events = zeros(1, n_hari);
events(45:47) = 80;    % Valentine promo
events(180:185) = 100;  % Mid-year sale
events(330:340) = 120;  % Year-end sale

% Gabungkan
penjualan = max(0, tren + weekly + monthly + noise + events);

% Buat tabel
T = table(tanggal', penjualan', ...
    'VariableNames', {'Tanggal', 'Penjualan'});

% Tambahkan kolom
T.Bulan = month(T.Tanggal);
T.Hari = day(T.Tanggal, 'dayofweek');
T.NamaBulan = string(month(T.Tanggal, 'shortname'));
T.NamaHari = string(day(T.Tanggal, 'name'));

fprintf('Data shape: %d baris x %d kolom\n', height(T), width(T))
disp(head(T, 5))

%% 2. Statistik Deskriptif
fprintf('\n--- Statistik Deskriptif ---\n')
fprintf('Total penjualan  : Rp %.0f juta\n', sum(T.Penjualan))
fprintf('Rata-rata harian : Rp %.1f juta\n', mean(T.Penjualan))
fprintf('Median           : Rp %.1f juta\n', median(T.Penjualan))
fprintf('Std Dev          : Rp %.1f juta\n', std(T.Penjualan))
fprintf('Minimum          : Rp %.1f juta\n', min(T.Penjualan))
fprintf('Maximum          : Rp %.1f juta\n', max(T.Penjualan))
fprintf('Quartile Q1      : Rp %.1f juta\n', quantile(T.Penjualan, 0.25))
fprintf('Quartile Q3      : Rp %.1f juta\n', quantile(T.Penjualan, 0.75))

%% 3. Visualisasi

% --- Time series plot ---
figure('Position', [100 100 1200 800])

subplot(3, 2, [1 2])
plot(T.Tanggal, T.Penjualan, 'b-', 'LineWidth', 0.5)
hold on
% Moving average 7 hari
ma7 = movmean(T.Penjualan, 7);
ma30 = movmean(T.Penjualan, 30);
plot(T.Tanggal, ma7, 'r-', 'LineWidth', 1.5)
plot(T.Tanggal, ma30, 'k-', 'LineWidth', 2)
legend('Harian', 'MA-7', 'MA-30')
title('Penjualan Harian 2024')
ylabel('Penjualan (Juta Rp)')
grid on

% --- Per bulan (box plot simulasi) ---
subplot(3, 2, 3)
monthly_avg = zeros(12, 1);
monthly_std = zeros(12, 1);
for m = 1:12
    mask = T.Bulan == m;
    monthly_avg(m) = mean(T.Penjualan(mask));
    monthly_std(m) = std(T.Penjualan(mask));
end
bar(1:12, monthly_avg, 'FaceColor', [0.3 0.6 0.9])
hold on
errorbar(1:12, monthly_avg, monthly_std, 'k.', 'LineWidth', 1.5)
xticklabels({'Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'})
title('Rata-rata Penjualan per Bulan')
ylabel('Penjualan'), grid on

% --- Per hari dalam seminggu ---
subplot(3, 2, 4)
daily_avg = zeros(7, 1);
for d = 1:7
    daily_avg(d) = mean(T.Penjualan(T.Hari == d));
end
bar(daily_avg, 'FaceColor', [0.9 0.5 0.2])
xticklabels({'Min','Sen','Sel','Rab','Kam','Jum','Sab'})
title('Rata-rata Penjualan per Hari')
ylabel('Penjualan'), grid on

% --- Distribusi ---
subplot(3, 2, 5)
histogram(T.Penjualan, 30, 'FaceColor', [0.4 0.7 0.4])
title('Distribusi Penjualan')
xlabel('Penjualan'), ylabel('Frekuensi'), grid on

% Tambahkan garis mean dan median
xline(mean(T.Penjualan), 'r-', 'Mean', 'LineWidth', 2)
xline(median(T.Penjualan), 'b--', 'Median', 'LineWidth', 2)

% --- Cumulative penjualan ---
subplot(3, 2, 6)
cumulative = cumsum(T.Penjualan);
plot(T.Tanggal, cumulative, 'LineWidth', 2)
title('Kumulatif Penjualan')
ylabel('Total Kumulatif'), grid on

sgtitle('Dashboard Analisis Penjualan 2024', 'FontSize', 16)

%% 4. Prediksi Sederhana (Linear Regression)
fprintf('\n--- Prediksi ---\n')

% Konversi tanggal ke numerik
x = (1:n_hari)';
y = T.Penjualan;

% Linear regression
p = polyfit(x, y, 1);
y_pred = polyval(p, x);

fprintf('Slope (tren harian): %.3f juta/hari\n', p(1))
fprintf('Intercept: %.1f juta\n', p(2))

% R-squared
SS_res = sum((y - y_pred).^2);
SS_tot = sum((y - mean(y)).^2);
R2 = 1 - SS_res / SS_tot;
fprintf('R² = %.4f\n', R2)

% Prediksi 30 hari ke depan
x_future = (n_hari+1:n_hari+30)';
y_future = polyval(p, x_future);

figure
plot(T.Tanggal, y, 'b.', 'MarkerSize', 3)
hold on
plot(T.Tanggal, y_pred, 'r-', 'LineWidth', 2)
future_dates = T.Tanggal(end) + days(1:30);
plot(future_dates, y_future, 'g--', 'LineWidth', 2)
fill([future_dates(1) future_dates(end) future_dates(end) future_dates(1)], ...
    [min(y_future)-50 min(y_future)-50 max(y_future)+50 max(y_future)+50], ...
    'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none')
legend('Data', 'Tren Linear', 'Prediksi 30 Hari')
title('Prediksi Penjualan')
ylabel('Penjualan (Juta Rp)')
grid on

fprintf('Prediksi 30 hari ke depan: Rp %.1f - %.1f juta/hari\n', ...
    min(y_future), max(y_future))

%% 5. Export Laporan

% Simpan hasil ke file
writetable(T, 'penjualan_2024.csv');
fprintf('\nData disimpan ke penjualan_2024.csv\n')

% Simpan ringkasan
fid = fopen('ringkasan_penjualan.txt', 'w');
fprintf(fid, 'RINGKASAN ANALISIS PENJUALAN 2024\n');
fprintf(fid, '==================================\n\n');
fprintf(fid, 'Total Penjualan  : Rp %.0f juta\n', sum(T.Penjualan));
fprintf(fid, 'Rata-rata Harian : Rp %.1f juta\n', mean(T.Penjualan));
fprintf(fid, 'Bulan Terbaik    : %d\n', find(monthly_avg == max(monthly_avg)));
fprintf(fid, 'Hari Terbaik     : %d\n', find(daily_avg == max(daily_avg)));
fprintf(fid, 'Tren             : %.3f juta/hari\n', p(1));
fprintf(fid, 'R²               : %.4f\n', R2);
fclose(fid);

disp('=== Proyek 1: Selesai! ===')
