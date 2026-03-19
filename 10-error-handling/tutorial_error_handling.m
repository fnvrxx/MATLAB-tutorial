%% ========================================================================
%  BAB 10: ERROR HANDLING
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    10.1 Jenis-jenis error
%    10.2 try-catch
%    10.3 error() dan warning()
%    10.4 assert()
%    10.5 MException
%    10.6 Input validation
%    10.7 Debugging
%  ========================================================================

%% 10.1 Jenis-jenis Error

% --- Syntax Error ---
% Terdeteksi sebelum kode dijalankan
% Contoh: x = 1 +    (incomplete expression)

% --- Runtime Error ---
% Terjadi saat kode dijalankan
% Contoh: pembagian dengan nol untuk integer, index out of bounds

% --- Logical Error ---
% Kode berjalan tanpa error tapi hasil salah
% Paling sulit dideteksi!

%% 10.2 try-catch

% --- Struktur dasar ---
try
    % Kode yang mungkin error
    result = 10 / 0;   % Inf, bukan error untuk double
    disp(result)

    A = [1 2; 3 4];
    B = [1 2 3];
    C = A * B;          % Error! Dimensi tidak cocok
catch ME
    % Kode yang dijalankan jika error terjadi
    fprintf('Error terjadi!\n')
    fprintf('Identifier: %s\n', ME.identifier)
    fprintf('Message: %s\n', ME.message)
end

% --- try-catch dengan multiple error types ---
data = {'123', 'abc', '456', '', '78.9'};

for i = 1:length(data)
    try
        val = str2double(data{i});
        if isnan(val)
            error('MyApp:InvalidData', 'Tidak bisa konversi: "%s"', data{i})
        end
        fprintf('data{%d} = %.1f\n', i, val)
    catch ME
        switch ME.identifier
            case 'MyApp:InvalidData'
                fprintf('data{%d}: SKIP - %s\n', i, ME.message)
            otherwise
                fprintf('data{%d}: Error tidak terduga - %s\n', i, ME.message)
        end
    end
end

% --- Nested try-catch ---
try
    try
        error('Inner:Error', 'Error di dalam')
    catch ME_inner
        fprintf('Caught inner: %s\n', ME_inner.message)
        rethrow(ME_inner)   % lempar ulang ke outer
    end
catch ME_outer
    fprintf('Caught outer: %s\n', ME_outer.message)
end

% --- try-catch dengan cleanup ---
fid = -1;
try
    fid = fopen('test_error.txt', 'w');
    fprintf(fid, 'Hello\n');
    % ... operasi yang mungkin error ...
    error('Test:Error', 'Simulasi error')
catch ME
    fprintf('Error: %s\n', ME.message)
end
% Cleanup: pastikan file ditutup
if fid ~= -1
    fclose(fid);
    disp('File ditutup dengan aman')
end

%% 10.3 error() dan warning()

% --- error: menghentikan eksekusi ---
% error('Pesan error')
% error('ID:SubID', 'Pesan dengan %s', 'format')

% Contoh penggunaan dalam fungsi
function result = bagi(a, b)
    if b == 0
        error('MyApp:DivisionByZero', ...
            'Pembagian dengan nol! a=%g, b=%g', a, b)
    end
    result = a / b;
end

% Memanggil
try
    r = bagi(10, 0);
catch ME
    fprintf('Caught: %s\n', ME.message)
end

% --- warning: pesan peringatan (tidak menghentikan eksekusi) ---
warning('Ini adalah peringatan')

% Warning dengan ID
warning('MyApp:LowMemory', 'Memori hampir penuh: %.1f%% used', 85.5)

% Mematikan/menyalakan warning
warning('off', 'MyApp:LowMemory')   % matikan warning tertentu
warning('on', 'MyApp:LowMemory')    % nyalakan kembali
% warning('off', 'all')             % matikan semua (hati-hati!)

% Cek status warning
[state, ~] = warning('query', 'MyApp:LowMemory');
fprintf('Warning state: %s\n', state.state)

%% 10.4 assert()

% assert menghentikan eksekusi jika kondisi false
% Bagus untuk pre-conditions dan post-conditions

x = 5;
assert(x > 0, 'x harus positif, tapi x = %g', x)  % OK

try
    y = -3;
    assert(y > 0, 'y harus positif, tapi y = %g', y)  % FAIL
catch ME
    fprintf('Assert gagal: %s\n', ME.message)
end

% Assertion untuk cek dimensi
function result = dot_product(a, b)
    assert(isvector(a) && isvector(b), 'Input harus vektor')
    assert(length(a) == length(b), ...
        'Panjang vektor harus sama: %d vs %d', length(a), length(b))
    result = sum(a .* b);
end

fprintf('Dot product: %d\n', dot_product([1 2 3], [4 5 6]))

try
    dot_product([1 2], [3 4 5])
catch ME
    fprintf('Assert: %s\n', ME.message)
end

%% 10.5 MException (Exception Object)

% --- Membuat exception ---
ME = MException('MyApp:BadInput', 'Input tidak valid: %s', 'abc');

% --- Properties ---
fprintf('\nMException properties:\n')
fprintf('identifier: %s\n', ME.identifier)
fprintf('message: %s\n', ME.message)
fprintf('stack: %d entries\n', length(ME.stack))

% --- Chained exceptions (cause) ---
try
    try
        error('DB:Connection', 'Koneksi database gagal')
    catch ME_db
        ME_app = MException('App:DataLoad', 'Gagal memuat data');
        ME_app = addCause(ME_app, ME_db);
        throw(ME_app)
    end
catch ME_final
    fprintf('\nChained exception:\n')
    fprintf('Primary: %s\n', ME_final.message)
    if ~isempty(ME_final.cause)
        fprintf('Cause: %s\n', ME_final.cause{1}.message)
    end
end

% --- getReport: laporan lengkap ---
try
    A = rand(3);
    b = rand(4, 1);
    x = A \ b;
catch ME
    report = getReport(ME, 'extended');
    fprintf('\nFull report:\n%s\n', report)
end

%% 10.6 Input Validation (dengan arguments block, R2019b+)

% Cara modern untuk validasi input fungsi
% Lihat file: validated_func.m

% function result = validated_func(x, y, options)
%     arguments
%         x (1,:) double {mustBePositive}
%         y (1,1) double {mustBeFinite} = 1
%         options.Method string {mustBeMember(options.Method, ["linear","cubic"])} = "linear"
%         options.Verbose logical = false
%     end
%     ...
% end

% --- Fungsi validasi bawaan ---
% mustBePositive, mustBeNonnegative, mustBeNonzero
% mustBeFinite, mustBeNonNan, mustBeReal
% mustBeInteger, mustBeNumeric, mustBeNonempty
% mustBeA, mustBeMember, mustBeInRange
% mustBeFile, mustBeFolder
% mustBeGreaterThan, mustBeLessThan

% Contoh manual (kompatibel semua versi)
function validated_divide(a, b)
    validateattributes(a, {'numeric'}, {'scalar', 'finite'}, 'divide', 'a')
    validateattributes(b, {'numeric'}, {'scalar', 'finite', 'nonzero'}, 'divide', 'b')
    fprintf('%.4f / %.4f = %.4f\n', a, b, a/b)
end

validated_divide(10, 3)

try
    validated_divide('abc', 3)
catch ME
    fprintf('Validation error: %s\n', ME.message)
end

%% 10.7 Debugging Tips

% --- Perintah debugging ---
% dbstop in filename at linenum     - set breakpoint
% dbstop if error                   - stop saat error
% dbstop if warning                 - stop saat warning
% dbcont                            - continue execution
% dbstep                            - step to next line
% dbstep in                         - step into function
% dbstep out                        - step out of function
% dbquit                            - quit debug mode
% dbstack                           - show call stack
% dbclear all                       - clear all breakpoints

% --- Conditional breakpoint ---
% dbstop in myfunction at 15 if x > 100

% --- Teknik debugging ---
% 1. keyboard: pause eksekusi dan masuk ke interactive mode
%    Ketik 'dbcont' atau 'return' untuk melanjutkan
%    Ketik 'dbquit' untuk keluar

% 2. disp/fprintf untuk tracing
fprintf('\n--- Debugging trace ---\n')
for i = 1:5
    val = i^2;
    fprintf('DEBUG: i=%d, val=%d\n', i, val)  % trace output
end

% 3. Profiler
% profile on        % mulai profiling
% my_function()     % jalankan kode
% profile off
% profile viewer    % lihat hasil profiling

% 4. tic/toc untuk mengukur waktu
tic
pause(0.1)
elapsed = toc;
fprintf('\nElapsed time: %.3f seconds\n', elapsed)

%% Ringkasan Bab 10
% ==================
% - try-catch: menangkap dan menangani error
% - error(): membangkitkan error dengan ID dan pesan
% - warning(): peringatan tanpa menghentikan eksekusi
% - assert(): validasi kondisi
% - MException: objek error dengan identifier, message, stack, cause
% - Input validation: arguments block atau validateattributes
% - Debugging: breakpoints, keyboard, profiler

disp('=== Bab 10: Error Handling - Selesai! ===')
