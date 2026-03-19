%% ========================================================================
%  BAB 21: GUI DEVELOPMENT
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    21.1 uifigure dan komponen dasar
%    21.2 Layout management
%    21.3 Callbacks
%    21.4 App Designer basics
%    21.5 Contoh: Kalkulator GUI
%    21.6 Contoh: Data Viewer
%  ========================================================================

%% 21.1 uifigure dan Komponen Dasar

fprintf('=== GUI Development ===\n')

% --- Membuat figure ---
fig = uifigure('Name', 'Tutorial GUI MATLAB', ...
               'Position', [100 100 500 400]);

% --- Label ---
lbl = uilabel(fig, ...
    'Text', 'Selamat Datang di GUI MATLAB!', ...
    'Position', [120 350 300 30], ...
    'FontSize', 16, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'center');

% --- Button ---
btn = uibutton(fig, 'push', ...
    'Text', 'Klik Saya!', ...
    'Position', [200 290 120 40], ...
    'ButtonPushedFcn', @(btn, event) onButtonClick(btn, lbl));

% --- Edit Field (Input) ---
lbl_input = uilabel(fig, 'Text', 'Nama Anda:', ...
    'Position', [50 230 100 22]);
ef = uieditfield(fig, 'text', ...
    'Position', [160 230 200 22], ...
    'Placeholder', 'Ketik nama Anda...');

% --- Numeric Edit Field ---
lbl_num = uilabel(fig, 'Text', 'Angka:', ...
    'Position', [50 190 100 22]);
nef = uieditfield(fig, 'numeric', ...
    'Position', [160 190 200 22], ...
    'Value', 42, ...
    'Limits', [0 100]);

% --- Dropdown ---
lbl_dd = uilabel(fig, 'Text', 'Pilih Kota:', ...
    'Position', [50 150 100 22]);
dd = uidropdown(fig, ...
    'Items', {'Jakarta', 'Bandung', 'Surabaya', 'Yogyakarta'}, ...
    'Position', [160 150 200 22], ...
    'ValueChangedFcn', @(dd, event) fprintf('Kota: %s\n', dd.Value));

% --- Checkbox ---
cb = uicheckbox(fig, ...
    'Text', 'Setuju dengan ketentuan', ...
    'Position', [160 110 200 22]);

% --- Slider ---
lbl_slider = uilabel(fig, 'Text', 'Volume:', ...
    'Position', [50 70 100 22]);
slider = uislider(fig, ...
    'Position', [160 80 200 3], ...
    'Limits', [0 100], ...
    'Value', 50);

% --- Text Area ---
ta = uitextarea(fig, ...
    'Position', [50 10 420 50], ...
    'Value', {'Output akan ditampilkan di sini...'}, ...
    'Editable', 'off');

% Callback function
function onButtonClick(~, lbl)
    lbl.Text = 'Tombol diklik!';
    pause(1)
    lbl.Text = 'Selamat Datang di GUI MATLAB!';
end

% Tutup setelah demo
pause(3)
close(fig)

%% 21.2 Layout Management

% --- Grid Layout ---
fig2 = uifigure('Name', 'Grid Layout Demo', 'Position', [100 100 400 300]);

gl = uigridlayout(fig2, [3 2]);
gl.RowHeight = {'1x', '1x', '1x'};
gl.ColumnWidth = {'1x', '1x'};

uilabel(gl, 'Text', 'Nama:', 'HorizontalAlignment', 'right');
uieditfield(gl, 'text');

uilabel(gl, 'Text', 'Email:', 'HorizontalAlignment', 'right');
uieditfield(gl, 'text');

uibutton(gl, 'Text', 'Submit');
uibutton(gl, 'Text', 'Cancel');

pause(2)
close(fig2)

% --- Tab Group ---
fig3 = uifigure('Name', 'Tab Demo', 'Position', [100 100 500 350]);

tg = uitabgroup(fig3);
tab1 = uitab(tg, 'Title', 'Data Input');
tab2 = uitab(tg, 'Title', 'Grafik');
tab3 = uitab(tg, 'Title', 'Hasil');

uilabel(tab1, 'Text', 'Ini adalah tab input data', 'Position', [20 270 200 22]);
uilabel(tab2, 'Text', 'Grafik akan ditampilkan di sini', 'Position', [20 270 200 22]);
uilabel(tab3, 'Text', 'Hasil analisis', 'Position', [20 270 200 22]);

pause(2)
close(fig3)

%% 21.3 Callbacks

fprintf('\n=== Callbacks ===\n')

% Callbacks adalah fungsi yang dipanggil saat event terjadi
% Tipe-tipe callback:
%   - ButtonPushedFcn     : tombol diklik
%   - ValueChangedFcn     : nilai berubah
%   - SelectionChangedFcn : pilihan berubah
%   - CellEditCallback    : cell tabel diedit
%   - WindowKeyPressFcn   : keyboard event

% --- Contoh callback patterns ---

% 1. Anonymous function
% btn.ButtonPushedFcn = @(src, event) disp('Clicked!');

% 2. Named function
% btn.ButtonPushedFcn = @myCallback;
% function myCallback(src, event)
%     disp('Clicked!')
% end

% 3. Function with extra arguments
% btn.ButtonPushedFcn = @(src, event) myFunc(src, event, extraArg);

fprintf('Callback patterns explained in comments\n')

%% 21.4 App Designer Basics

% App Designer adalah GUI visual tool untuk membuat apps
% Buka dengan: appdesigner
%
% Keuntungan App Designer:
% 1. Visual layout editor (drag & drop)
% 2. Code generation otomatis
% 3. Auto-completion untuk callbacks
% 4. Packaging sebagai standalone app
%
% Struktur App Designer:
% - classdef MyApp < matlab.apps.AppBase
% - properties: komponen GUI
% - methods: callbacks
% - startupFcn: inisialisasi

fprintf('\n=== App Designer ===\n')
fprintf('Buka App Designer dengan: >> appdesigner\n')
fprintf('File yang dihasilkan: .mlapp\n')

%% 21.5 Contoh: Kalkulator GUI
% Lihat file: KalkulatorApp.m

fprintf('\n=== Demo Kalkulator GUI ===\n')
fprintf('Jalankan: KalkulatorApp()\n')

% Demo singkat kalkulator
fig_calc = uifigure('Name', 'Kalkulator Sederhana', 'Position', [200 200 300 350]);

gl_calc = uigridlayout(fig_calc, [6, 4]);
gl_calc.RowHeight = {50, 50, 50, 50, 50, 50};
gl_calc.ColumnWidth = {'1x', '1x', '1x', '1x'};

% Display
display_field = uieditfield(gl_calc, 'text', 'Value', '0', ...
    'HorizontalAlignment', 'right', 'FontSize', 24, 'Editable', 'off');
display_field.Layout.Row = 1;
display_field.Layout.Column = [1 4];

% Tombol angka dan operasi
buttons = {'7','8','9','/'; '4','5','6','*'; '1','2','3','-'; 'C','0','=','+'};
for row = 1:4
    for col = 1:4
        b = uibutton(gl_calc, 'Text', buttons{row, col}, 'FontSize', 18);
        b.Layout.Row = row + 1;
        b.Layout.Column = col;
        b.ButtonPushedFcn = @(src, ~) calcButtonPress(src, display_field);
    end
end

function calcButtonPress(src, display)
    persistent expression
    if isempty(expression)
        expression = '';
    end

    btn_text = src.Text;

    switch btn_text
        case 'C'
            expression = '';
            display.Value = '0';
        case '='
            try
                result = eval(expression);
                display.Value = num2str(result);
                expression = num2str(result);
            catch
                display.Value = 'Error';
                expression = '';
            end
        otherwise
            if strcmp(display.Value, '0') && ~any(strcmp(btn_text, {'+','-','*','/'}))
                expression = btn_text;
            else
                expression = [expression btn_text];
            end
            display.Value = expression;
    end
end

pause(5)
close(fig_calc)

%% 21.6 Contoh: Data Viewer

fprintf('\n=== Demo Data Viewer ===\n')

fig_dv = uifigure('Name', 'Data Viewer', 'Position', [100 100 700 500]);

gl_dv = uigridlayout(fig_dv, [2 2]);
gl_dv.RowHeight = {'1x', '2x'};
gl_dv.ColumnWidth = {'1x', '2x'};

% Panel kontrol
panel_ctrl = uipanel(gl_dv, 'Title', 'Kontrol');
panel_ctrl.Layout.Row = 1;
panel_ctrl.Layout.Column = 1;

gl_ctrl = uigridlayout(panel_ctrl, [4 1]);
gl_ctrl.RowHeight = {30, 30, 30, 30};

dd_func = uidropdown(gl_ctrl, ...
    'Items', {'sin(x)', 'cos(x)', 'exp(-x)', 'x^2'}, ...
    'ValueChangedFcn', @(src, ~) updatePlot(src, ax));

slider_freq = uislider(gl_ctrl, 'Limits', [1 10], 'Value', 1);

uilabel(gl_ctrl, 'Text', 'Frekuensi ^');

btn_reset = uibutton(gl_ctrl, 'Text', 'Reset', ...
    'ButtonPushedFcn', @(~,~) resetView(ax));

% Tabel data
uit = uitable(gl_dv);
uit.Layout.Row = 2;
uit.Layout.Column = 1;

% Plot
ax = uiaxes(gl_dv);
ax.Layout.Row = [1 2];
ax.Layout.Column = 2;

% Initial plot
x = linspace(0, 2*pi, 100);
plot(ax, x, sin(x), 'LineWidth', 2)
grid(ax, 'on')
title(ax, 'sin(x)')

% Update table
uit.Data = table(x(1:10)', sin(x(1:10))', 'VariableNames', {'X', 'Y'});

function updatePlot(src, ax)
    x = linspace(0, 2*pi, 100);
    switch src.Value
        case 'sin(x)', y = sin(x);
        case 'cos(x)', y = cos(x);
        case 'exp(-x)', y = exp(-x);
        case 'x^2', y = x.^2;
    end
    plot(ax, x, y, 'LineWidth', 2)
    grid(ax, 'on')
    title(ax, src.Value)
end

function resetView(ax)
    xlim(ax, 'auto')
    ylim(ax, 'auto')
end

pause(5)
close(fig_dv)

%% Ringkasan Bab 21
% ==================
% - uifigure: container utama untuk modern GUI
% - Komponen: uilabel, uibutton, uieditfield, uidropdown, uislider, etc.
% - Layout: uigridlayout, uipanel, uitabgroup
% - Callbacks: fungsi yang dipanggil saat event terjadi
% - App Designer: visual tool untuk membuat apps
% - uiaxes: menampilkan plot di dalam GUI

disp('=== Bab 21: GUI Development - Selesai! ===')
