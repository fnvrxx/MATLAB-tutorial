%% ========================================================================
%  BAB 22: SIMULINK BASICS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Memerlukan: Simulink
%  Topik:
%    22.1 Pengenalan Simulink
%    22.2 Membuat model programmatically
%    22.3 Model-Based Design workflow
%    22.4 Integrasi MATLAB-Simulink
%    22.5 Contoh: sistem kontrol sederhana
%  ========================================================================
%
%  CATATAN: Bab ini menjelaskan konsep Simulink. Beberapa contoh
%  memerlukan Simulink terinstal untuk dijalankan.
%  ========================================================================

%% 22.1 Pengenalan Simulink

fprintf('=== Simulink Basics ===\n')

% Simulink adalah lingkungan visual untuk:
% - Model-based design
% - Simulasi sistem dinamis
% - Multi-domain simulation (mekanik, elektrik, kontrol)
% - Code generation (embedded systems)
%
% Konsep utama:
% - Block: komponen dasar (source, sink, math, etc.)
% - Signal: koneksi antar block (garis)
% - Model: kumpulan block yang terhubung (.slx file)
% - Subsystem: model di dalam model

% Membuka Simulink
% simulink              % membuka Simulink Start Page
% open_system('model')  % membuka model yang sudah ada
% new_system('myModel') % membuat model baru

fprintf('\nKomponen Simulink:\n')
fprintf('  Sumber   : Constant, Sine Wave, Step, Ramp, Clock\n')
fprintf('  Sink     : Scope, Display, To Workspace\n')
fprintf('  Matematik: Sum, Gain, Product, Abs\n')
fprintf('  Kontrol  : Transfer Function, PID Controller, State-Space\n')
fprintf('  Logika   : Switch, Relay, Compare to Zero\n')
fprintf('  Routing  : Mux, Demux, Bus Creator\n')

%% 22.2 Membuat Model Secara Programmatik

fprintf('\n=== Membuat Model Programmatically ===\n')

% Cek apakah Simulink tersedia
hasSimulink = license('test', 'Simulink');

if hasSimulink
    % Membuat model baru
    modelName = 'demo_model';
    new_system(modelName);

    % Menambahkan block
    add_block('simulink/Sources/Sine Wave', ...
        [modelName '/Sine Wave'], ...
        'Frequency', '2*pi');

    add_block('simulink/Math Operations/Gain', ...
        [modelName '/Gain'], ...
        'Gain', '5');

    add_block('simulink/Sinks/Scope', ...
        [modelName '/Scope']);

    % Menghubungkan block
    add_line(modelName, 'Sine Wave/1', 'Gain/1');
    add_line(modelName, 'Gain/1', 'Scope/1');

    % Mengatur posisi block (opsional)
    set_param([modelName '/Sine Wave'], 'Position', [100 100 150 130]);
    set_param([modelName '/Gain'], 'Position', [250 100 300 130]);
    set_param([modelName '/Scope'], 'Position', [400 100 450 130]);

    % Mengatur parameter simulasi
    set_param(modelName, 'StopTime', '10');
    set_param(modelName, 'Solver', 'ode45');

    % Membuka model
    open_system(modelName);

    % Menjalankan simulasi
    sim(modelName);

    disp('Model Simulink berhasil dibuat dan dijalankan')

    % Hapus model (cleanup)
    close_system(modelName, 0);
else
    fprintf('Simulink tidak tersedia.\n')
    fprintf('Berikut adalah kode yang akan dijalankan:\n\n')

    fprintf('  new_system(''demo_model'');\n')
    fprintf('  add_block(''simulink/Sources/Sine Wave'', ''demo_model/Sine'');\n')
    fprintf('  add_block(''simulink/Math Operations/Gain'', ''demo_model/Gain'');\n')
    fprintf('  add_block(''simulink/Sinks/Scope'', ''demo_model/Scope'');\n')
    fprintf('  add_line(''demo_model'', ''Sine/1'', ''Gain/1'');\n')
    fprintf('  add_line(''demo_model'', ''Gain/1'', ''Scope/1'');\n')
    fprintf('  sim(''demo_model'');\n')
end

%% 22.3 Model-Based Design Workflow

fprintf('\n=== Model-Based Design ===\n')

% Workflow:
% 1. Modeling       : buat model matematis dari sistem
% 2. Simulation     : simulasikan untuk memverifikasi perilaku
% 3. Analysis       : analisis stabilitas, response, dll.
% 4. Design         : desain controller/filter
% 5. Verification   : verifikasi dengan requirements
% 6. Code Gen       : generate kode C/C++ (Embedded Coder)
% 7. Deployment     : deploy ke hardware

fprintf('Workflow Model-Based Design:\n')
fprintf('  1. Modeling -> 2. Simulation -> 3. Analysis\n')
fprintf('  4. Design  -> 5. Verification -> 6. Code Gen\n')
fprintf('  7. Deployment\n')

%% 22.4 Integrasi MATLAB-Simulink

fprintf('\n=== Integrasi MATLAB-Simulink ===\n')

% --- MATLAB ke Simulink ---
% 1. MATLAB Function block: menulis kode MATLAB di Simulink
% 2. From Workspace block: mengambil data dari MATLAB workspace
% 3. set_param(): mengatur parameter dari MATLAB
% 4. sim(): menjalankan simulasi dari MATLAB

% --- Simulink ke MATLAB ---
% 1. To Workspace block: menyimpan data ke workspace
% 2. simout = sim(model): mengambil output simulasi
% 3. Logging signals: merekam sinyal

% --- Contoh: mengatur dan menjalankan simulasi dari MATLAB ---
fprintf('\nContoh kode integrasi:\n')
fprintf('  %% Setup parameter di MATLAB\n')
fprintf('  Kp = 1.5; Ki = 0.5; Kd = 0.1;\n')
fprintf('  set_param(''model/PID'', ''P'', num2str(Kp));\n')
fprintf('  \n')
fprintf('  %% Jalankan simulasi\n')
fprintf('  simout = sim(''model'', ''StopTime'', ''10'');\n')
fprintf('  \n')
fprintf('  %% Ambil output\n')
fprintf('  t = simout.tout;\n')
fprintf('  y = simout.yout;\n')
fprintf('  plot(t, y)\n')

%% 22.5 Contoh: Sistem Kontrol Sederhana (di MATLAB)

% Karena Simulink mungkin tidak tersedia, kita buat
% ekuivalen-nya di MATLAB menggunakan Control System Toolbox

fprintf('\n=== Contoh: Sistem Kontrol ===\n')

% Transfer function: G(s) = 1 / (s^2 + 2s + 1)
% Ini adalah sistem orde-2 (mass-spring-damper)

num = [1];          % numerator
den = [1 2 1];      % denominator: s^2 + 2s + 1

% Cek apakah Control System Toolbox tersedia
hasControlTB = license('test', 'Control_Toolbox');

if hasControlTB
    G = tf(num, den);
    fprintf('Transfer Function:\n')
    disp(G)

    % --- Step response ---
    figure
    subplot(2, 2, 1)
    step(G)
    title('Step Response')
    grid on

    % --- Impulse response ---
    subplot(2, 2, 2)
    impulse(G)
    title('Impulse Response')
    grid on

    % --- Bode plot ---
    subplot(2, 2, 3)
    bode(G)
    title('Bode Plot')
    grid on

    % --- Nyquist plot ---
    subplot(2, 2, 4)
    nyquist(G)
    title('Nyquist Plot')
    grid on

    sgtitle('Analisis Sistem Kontrol', 'FontSize', 14)

    % --- PID Controller ---
    Kp = 10; Ki = 5; Kd = 1;
    C = pid(Kp, Ki, Kd);
    fprintf('PID Controller:\n')
    disp(C)

    % Closed-loop system
    T = feedback(C * G, 1);

    figure
    step(G, T)
    legend('Open Loop', 'Closed Loop (PID)')
    title('Step Response: Open vs Closed Loop')
    grid on

    % Step info
    info = stepinfo(T);
    fprintf('Rise Time:    %.4f s\n', info.RiseTime)
    fprintf('Settling Time: %.4f s\n', info.SettlingTime)
    fprintf('Overshoot:    %.2f%%\n', info.Overshoot)
    fprintf('Steady State: %.4f\n', info.SettlingMin)

else
    % Simulasi manual tanpa Control System Toolbox
    fprintf('Control System Toolbox tidak tersedia.\n')
    fprintf('Simulasi manual menggunakan ODE:\n\n')

    % Sistem: x'' + 2x' + x = u(t) (step input)
    % State space: [x1; x2]' = [0 1; -1 -2]*[x1; x2] + [0; 1]*u
    system_ode = @(t, x, Kp) [x(2); -(1+Kp)*x(1) - 2*x(2) + Kp*1];

    % Step response (tanpa controller)
    [t1, y1] = ode45(@(t,x) [x(2); -x(1) - 2*x(2) + 1], [0 15], [0; 0]);

    % Step response (dengan proportional control, Kp=10)
    Kp = 10;
    [t2, y2] = ode45(@(t,x) system_ode(t, x, Kp), [0 15], [0; 0]);

    figure
    plot(t1, y1(:,1), 'b-', t2, y2(:,1), 'r-', 'LineWidth', 2)
    legend('Open Loop', 'With P Control (Kp=10)')
    title('Step Response (Manual ODE)')
    xlabel('Time (s)'), ylabel('Output')
    grid on
end

%% Ringkasan Bab 22
% ==================
% - Simulink: visual environment untuk model-based design
% - Block + Signal = Model
% - Programmatic: new_system, add_block, add_line, sim
% - Integrasi: MATLAB <-> Simulink (set_param, sim, To/From Workspace)
% - Model-Based Design: dari model ke deployment
% - Control Systems: tf, pid, step, bode, feedback

disp('=== Bab 22: Simulink Basics - Selesai! ===')
