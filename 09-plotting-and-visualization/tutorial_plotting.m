%% ========================================================================
%  BAB 9: PLOTTING & VISUALIZATION
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    9.1 Plot 2D dasar
%    9.2 Customization (warna, style, label)
%    9.3 Multiple plots
%    9.4 Plot types khusus
%    9.5 Plot 3D
%    9.6 Animasi
%    9.7 Export dan saving
%  ========================================================================

%% 9.1 Plot 2D Dasar

% --- Line plot ---
x = 0:0.1:2*pi;
y = sin(x);

figure
plot(x, y)
title('Grafik Sinus')
xlabel('x (radian)')
ylabel('sin(x)')
grid on

% --- Menambahkan beberapa kurva ---
figure
y1 = sin(x);
y2 = cos(x);
y3 = sin(x) + cos(x);

plot(x, y1, x, y2, x, y3)
title('Fungsi Trigonometri')
xlabel('x')
ylabel('y')
legend('sin(x)', 'cos(x)', 'sin(x)+cos(x)')
grid on

%% 9.2 Customization

% --- Line style, marker, color ---
figure
x = 0:0.5:4*pi;

% Format: 'color marker linestyle'
plot(x, sin(x), 'r-o', ...        % merah, circle, solid line
     x, cos(x), 'b--s', ...       % biru, square, dashed
     x, sin(x).*cos(x), 'g:d')    % hijau, diamond, dotted

title('Custom Plot Styles')
legend('sin', 'cos', 'sin*cos')
grid on

% --- Warna yang tersedia ---
% 'r' red, 'g' green, 'b' blue, 'c' cyan
% 'm' magenta, 'y' yellow, 'k' black, 'w' white

% --- Marker yang tersedia ---
% 'o' circle, 's' square, 'd' diamond, '^' triangle up
% 'v' triangle down, '>' triangle right, '<' triangle left
% 'p' pentagram, 'h' hexagram, '+' plus, 'x' cross, '*' star

% --- Line style ---
% '-' solid, '--' dashed, ':' dotted, '-.' dash-dot

% --- Properties lebih detail ---
figure
x = linspace(0, 10, 100);
plot(x, sin(x), ...
    'Color', [0.8 0.2 0.1], ...    % RGB color
    'LineWidth', 2.5, ...           % ketebalan garis
    'LineStyle', '-', ...
    'Marker', 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', [1 0.5 0], ...  % warna isi marker
    'MarkerEdgeColor', 'k', ...        % warna tepi marker
    'MarkerIndices', 1:10:100)         % marker tiap 10 titik

title('Plot dengan Detail Properties', 'FontSize', 16, 'FontWeight', 'bold')
xlabel('Waktu (s)', 'FontSize', 12)
ylabel('Amplitudo', 'FontSize', 12)
grid on
set(gca, 'FontSize', 11)    % ukuran font axis

% --- Axis customization ---
xlim([0 10])           % batas x
ylim([-1.5 1.5])       % batas y
% axis equal            % skala x dan y sama
% axis tight            % otomatis ketat

% --- Text dan annotation ---
text(pi, 0, '\leftarrow \pi', 'FontSize', 14)

%% 9.3 Multiple Plots

% --- subplot: multiple plot dalam satu figure ---
figure
x = linspace(0, 2*pi, 100);

subplot(2, 2, 1)    % 2 baris, 2 kolom, posisi 1
plot(x, sin(x), 'r', 'LineWidth', 1.5)
title('sin(x)')
grid on

subplot(2, 2, 2)    % posisi 2
plot(x, cos(x), 'b', 'LineWidth', 1.5)
title('cos(x)')
grid on

subplot(2, 2, 3)    % posisi 3
plot(x, tan(x), 'm', 'LineWidth', 1.5)
title('tan(x)')
ylim([-5 5])
grid on

subplot(2, 2, 4)    % posisi 4
plot(x, sin(x).*cos(x), 'g', 'LineWidth', 1.5)
title('sin(x)*cos(x)')
grid on

sgtitle('Fungsi Trigonometri', 'FontSize', 14)

% --- hold on/off: overlay plots ---
figure
x = linspace(-5, 5, 100);

hold on
plot(x, x.^2, 'r-', 'LineWidth', 2)
plot(x, x.^3, 'b--', 'LineWidth', 2)
plot(x, exp(x), 'g:', 'LineWidth', 2)
hold off

title('Multiple Curves dengan Hold')
legend('x^2', 'x^3', 'e^x', 'Location', 'northwest')
grid on
ylim([-50 50])

% --- tiledlayout (R2019b+, pengganti subplot) ---
figure
t = tiledlayout(2, 1, 'TileSpacing', 'compact');
title(t, 'Tiledlayout Demo')

nexttile
plot(x, sin(x), 'LineWidth', 1.5)
ylabel('sin(x)')
grid on

nexttile
plot(x, cos(x), 'LineWidth', 1.5)
ylabel('cos(x)')
xlabel('x')
grid on

%% 9.4 Plot Types Khusus

x = linspace(0, 2*pi, 50);

% --- Bar plot ---
figure
subplot(2, 3, 1)
data = [85 92 78 96 88];
bar(data)
title('Bar Plot')
xticklabels({'Budi', 'Ani', 'Cika', 'Doni', 'Eva'})
ylabel('Nilai')

% --- Horizontal bar ---
subplot(2, 3, 2)
barh(data)
title('Bar Horizontal')
yticklabels({'Budi', 'Ani', 'Cika', 'Doni', 'Eva'})

% --- Pie chart ---
subplot(2, 3, 3)
labels = {'Java', 'Python', 'MATLAB', 'C++', 'Other'};
values = [30 25 20 15 10];
pie(values, labels)
title('Pie Chart')

% --- Histogram ---
subplot(2, 3, 4)
data = randn(1000, 1);
histogram(data, 30)
title('Histogram')
xlabel('Value')
ylabel('Frequency')

% --- Scatter plot ---
subplot(2, 3, 5)
x = randn(100, 1);
y = x + 0.5*randn(100, 1);
scatter(x, y, 30, 'filled', 'MarkerFaceAlpha', 0.5)
title('Scatter Plot')
xlabel('x')
ylabel('y')

% --- Stem plot ---
subplot(2, 3, 6)
n = 0:20;
y = sin(2*pi*n/20);
stem(n, y, 'filled')
title('Stem Plot')
xlabel('n')
ylabel('Amplitude')

sgtitle('Tipe-tipe Plot', 'FontSize', 14)

% --- Area plot ---
figure
subplot(1, 2, 1)
x = 1:5;
Y = [1 2 3 4 5; 5 4 3 2 1; 2 3 4 3 2]';
area(x, Y)
title('Area Plot')
legend('A', 'B', 'C')

% --- Error bar ---
subplot(1, 2, 2)
x = 1:5;
y = [2.1 3.5 4.2 3.8 5.1];
err = [0.3 0.5 0.2 0.4 0.3];
errorbar(x, y, err, 'o-', 'LineWidth', 1.5, 'MarkerFaceColor', 'b')
title('Error Bar Plot')

% --- Polar plot ---
figure
theta = linspace(0, 2*pi, 100);
rho = abs(sin(3*theta));
polarplot(theta, rho, 'LineWidth', 2)
title('Polar Plot: |sin(3\theta)|')

% --- Heatmap ---
figure
data = rand(5, 5);
heatmap({'A','B','C','D','E'}, {'P','Q','R','S','T'}, data)
title('Heatmap')

%% 9.5 Plot 3D

% --- Line 3D ---
figure
t = linspace(0, 10*pi, 1000);
x = sin(t);
y = cos(t);
z = t;
plot3(x, y, z, 'LineWidth', 1.5)
title('3D Helix')
xlabel('x'), ylabel('y'), zlabel('z')
grid on

% --- Surface plot ---
figure
[X, Y] = meshgrid(-3:0.1:3, -3:0.1:3);
Z = sin(X) .* cos(Y);

subplot(2, 2, 1)
surf(X, Y, Z)
title('Surface (surf)')
colorbar

subplot(2, 2, 2)
mesh(X, Y, Z)
title('Wireframe (mesh)')

subplot(2, 2, 3)
contour(X, Y, Z, 20)
title('Contour')
colorbar

subplot(2, 2, 4)
contourf(X, Y, Z, 20)
title('Filled Contour')
colorbar

sgtitle('Plot 3D', 'FontSize', 14)

% --- Surface dengan colormap ---
figure
[X, Y] = meshgrid(linspace(-3, 3, 100));
Z = peaks(100);

surf(X, Y, Z, 'EdgeColor', 'none')
colormap(jet)
colorbar
title('Peaks Function')
xlabel('x'), ylabel('y'), zlabel('z')
view(45, 30)    % sudut pandang (azimuth, elevation)

% --- Scatter 3D ---
figure
n = 500;
x = randn(n, 1);
y = randn(n, 1);
z = randn(n, 1);
c = sqrt(x.^2 + y.^2 + z.^2);  % warna berdasarkan jarak

scatter3(x, y, z, 20, c, 'filled')
colormap(hot)
colorbar
title('3D Scatter with Color')
xlabel('x'), ylabel('y'), zlabel('z')

%% 9.6 Animasi Sederhana

figure
x = linspace(0, 2*pi, 100);
h = plot(x, sin(x), 'LineWidth', 2);
title('Animasi Gelombang')
xlabel('x')
ylabel('y')
ylim([-2 2])
grid on

for phi = linspace(0, 4*pi, 100)
    set(h, 'YData', sin(x + phi) .* (1 + 0.3*sin(phi)))
    title(sprintf('Phase = %.2f rad', phi))
    drawnow
    pause(0.05)
end

%% 9.7 Export dan Saving

% --- Simpan sebagai gambar ---
figure
plot(0:0.1:2*pi, sin(0:0.1:2*pi), 'LineWidth', 2)
title('Plot untuk Disimpan')
grid on

% PNG (raster)
saveas(gcf, 'plot_demo.png')

% PDF (vector - bagus untuk paper)
% saveas(gcf, 'plot_demo.pdf')

% SVG (vector - bagus untuk web)
% saveas(gcf, 'plot_demo.svg')

% FIG (format MATLAB - bisa diedit lagi)
% savefig('plot_demo.fig')

% High-resolution export
% exportgraphics(gcf, 'plot_hires.png', 'Resolution', 300)
% exportgraphics(gcf, 'plot_hires.pdf', 'ContentType', 'vector')

% print command (lebih banyak opsi)
% print('-dpng', '-r300', 'plot_print.png')
% print('-depsc', 'plot_print.eps')

disp('Plot disimpan sebagai plot_demo.png')

%% Ringkasan Bab 9
% ==================
% - plot: grafik 2D dasar
% - Customization: color, linewidth, marker, label, legend
% - subplot/tiledlayout: multiple plots
% - Tipe: bar, pie, histogram, scatter, stem, area, polar, heatmap
% - 3D: plot3, surf, mesh, contour, scatter3
% - Animasi: update data + drawnow + pause
% - Export: saveas, exportgraphics, print

disp('=== Bab 9: Plotting & Visualization - Selesai! ===')
