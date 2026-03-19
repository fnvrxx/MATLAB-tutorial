%% ========================================================================
%  PROYEK 2: SIMULASI FISIKA - PENDULUM GANDA
%  Tutorial MATLAB - Real World Projects
%  ========================================================================
%  Tujuan:
%    - Memodelkan pendulum ganda (chaotic system)
%    - Menyelesaikan ODE non-linear
%    - Visualisasi animasi
%    - Analisis chaos (sensitivity to initial conditions)
%  ========================================================================

%% 1. Setup Parameter
fprintf('=== Proyek 2: Simulasi Pendulum Ganda ===\n\n')

% Parameter fisika
params = struct();
params.m1 = 1.0;    % massa pendulum 1 (kg)
params.m2 = 1.0;    % massa pendulum 2 (kg)
params.L1 = 1.0;    % panjang tali 1 (m)
params.L2 = 1.0;    % panjang tali 2 (m)
params.g  = 9.81;   % gravitasi (m/s^2)

fprintf('Parameter:\n')
fprintf('  m1=%.1f kg, m2=%.1f kg\n', params.m1, params.m2)
fprintf('  L1=%.1f m, L2=%.1f m\n', params.L1, params.L2)
fprintf('  g=%.2f m/s²\n', params.g)

%% 2. Persamaan Gerak (Lagrangian Mechanics)
% State vector: Y = [theta1, omega1, theta2, omega2]

function dYdt = doublePendulum(~, Y, p)
    th1 = Y(1); w1 = Y(2);
    th2 = Y(3); w2 = Y(4);

    m1 = p.m1; m2 = p.m2;
    L1 = p.L1; L2 = p.L2;
    g = p.g;

    delta = th2 - th1;

    den1 = (m1 + m2)*L1 - m2*L1*cos(delta)*cos(delta);
    den2 = (L2/L1)*den1;

    dYdt = zeros(4, 1);
    dYdt(1) = w1;
    dYdt(2) = (m2*L1*w1^2*sin(delta)*cos(delta) + ...
               m2*g*sin(th2)*cos(delta) + ...
               m2*L2*w2^2*sin(delta) - ...
               (m1+m2)*g*sin(th1)) / den1;
    dYdt(3) = w2;
    dYdt(4) = (-m2*L2*w2^2*sin(delta)*cos(delta) + ...
               (m1+m2)*(g*sin(th1)*cos(delta) - ...
               L1*w1^2*sin(delta) - g*sin(th2))) / den2;
end

%% 3. Simulasi
fprintf('\n--- Simulasi ---\n')

% Kondisi awal: theta1, omega1, theta2, omega2
Y0 = [pi/2; 0; pi/2; 0];  % kedua pendulum di 90 derajat

% Waktu simulasi
tspan = [0 30];
dt = 0.01;

% Solve ODE
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-12, 'MaxStep', dt);
[t, Y] = ode45(@(t, Y) doublePendulum(t, Y, params), tspan, Y0, opts);

% Konversi ke koordinat Cartesian
x1 = params.L1 * sin(Y(:,1));
y1 = -params.L1 * cos(Y(:,1));
x2 = x1 + params.L2 * sin(Y(:,3));
y2 = y1 - params.L2 * cos(Y(:,3));

fprintf('Simulasi selesai: %d titik waktu\n', length(t))

%% 4. Visualisasi Statis

figure('Position', [100 100 1200 600])

% --- Lintasan pendulum ---
subplot(2, 3, [1 4])
plot(x1, y1, 'b-', 'LineWidth', 0.5, 'Color', [0 0 1 0.3])
hold on
plot(x2, y2, 'r-', 'LineWidth', 0.5, 'Color', [1 0 0 0.3])
plot(0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k')
xlabel('x (m)'), ylabel('y (m)')
title('Lintasan Pendulum Ganda')
legend('Pendulum 1', 'Pendulum 2', 'Pivot')
axis equal, grid on
xlim([-2.5 2.5]), ylim([-2.5 1])

% --- Sudut vs waktu ---
subplot(2, 3, 2)
plot(t, rad2deg(Y(:,1)), 'b-', 'LineWidth', 1)
hold on
plot(t, rad2deg(Y(:,3)), 'r-', 'LineWidth', 1)
xlabel('Waktu (s)'), ylabel('Sudut (°)')
title('Sudut vs Waktu')
legend('\theta_1', '\theta_2')
grid on

% --- Kecepatan sudut ---
subplot(2, 3, 3)
plot(t, Y(:,2), 'b-', 'LineWidth', 1)
hold on
plot(t, Y(:,4), 'r-', 'LineWidth', 1)
xlabel('Waktu (s)'), ylabel('Kecepatan Sudut (rad/s)')
title('Kecepatan Sudut vs Waktu')
legend('\omega_1', '\omega_2')
grid on

% --- Phase space ---
subplot(2, 3, 5)
plot(Y(:,1), Y(:,2), 'b-', 'LineWidth', 0.5)
xlabel('\theta_1 (rad)'), ylabel('\omega_1 (rad/s)')
title('Phase Space - Pendulum 1')
grid on

subplot(2, 3, 6)
plot(Y(:,3), Y(:,4), 'r-', 'LineWidth', 0.5)
xlabel('\theta_2 (rad)'), ylabel('\omega_2 (rad/s)')
title('Phase Space - Pendulum 2')
grid on

sgtitle('Simulasi Pendulum Ganda', 'FontSize', 16)

%% 5. Energi
% Total energi harus konstan (konservasi energi)
KE = 0.5*params.m1*(params.L1*Y(:,2)).^2 + ...
     0.5*params.m2*((params.L1*Y(:,2).*cos(Y(:,1)) + params.L2*Y(:,4).*cos(Y(:,3))).^2 + ...
                     (params.L1*Y(:,2).*sin(Y(:,1)) + params.L2*Y(:,4).*sin(Y(:,3))).^2);
PE = -(params.m1+params.m2)*params.g*params.L1*cos(Y(:,1)) - ...
      params.m2*params.g*params.L2*cos(Y(:,3));
TE = KE + PE;

figure
plot(t, KE, 'r-', t, PE, 'b-', t, TE, 'k-', 'LineWidth', 1.5)
legend('Kinetik', 'Potensial', 'Total')
title('Energi Pendulum Ganda')
xlabel('Waktu (s)'), ylabel('Energi (J)')
grid on

fprintf('Energy conservation error: %.2e J\n', max(TE) - min(TE))

%% 6. Chaos: Sensitivity to Initial Conditions
fprintf('\n--- Analisis Chaos ---\n')

% Dua kondisi awal yang SANGAT mirip
Y0_a = [pi/2; 0; pi/2; 0];
Y0_b = [pi/2 + 0.001; 0; pi/2; 0];  % hanya 0.001 rad berbeda!

[t_a, Y_a] = ode45(@(t,Y) doublePendulum(t,Y,params), [0 30], Y0_a, opts);
[t_b, Y_b] = ode45(@(t,Y) doublePendulum(t,Y,params), [0 30], Y0_b, opts);

% Interpolasi untuk time alignment
t_common = linspace(0, 30, 3000);
Y_a_interp = interp1(t_a, Y_a, t_common);
Y_b_interp = interp1(t_b, Y_b, t_common);

% Perbedaan sudut theta2
diff_theta = abs(Y_a_interp(:,3) - Y_b_interp(:,3));

figure
subplot(2, 1, 1)
plot(t_common, rad2deg(Y_a_interp(:,3)), 'b-', ...
     t_common, rad2deg(Y_b_interp(:,3)), 'r--', 'LineWidth', 1)
legend('\Delta\theta_1 = 0', '\Delta\theta_1 = 0.001 rad')
title('Sensitivity to Initial Conditions (Chaos!)')
xlabel('Waktu (s)'), ylabel('\theta_2 (°)')
grid on

subplot(2, 1, 2)
semilogy(t_common, diff_theta, 'k-', 'LineWidth', 1.5)
title('Divergence |\Delta\theta_2|')
xlabel('Waktu (s)'), ylabel('|\Delta\theta_2| (rad)')
grid on

fprintf('Perbedaan awal: 0.001 rad (%.3f°)\n', rad2deg(0.001))
fprintf('Perbedaan akhir: %.2f rad (%.1f°)\n', diff_theta(end), rad2deg(diff_theta(end)))
fprintf('Ini menunjukkan CHAOS - perbedaan kecil menghasilkan hasil sangat berbeda!\n')

%% 7. Animasi Pendulum

figure('Position', [200 200 600 600])

% Pilih subset untuk animasi
step = 5;
idx = 1:step:length(t);

for k = idx
    clf

    % Posisi pendulum
    px = [0, x1(k), x2(k)];
    py = [0, y1(k), y2(k)];

    % Gambar tali
    plot(px, py, 'k-', 'LineWidth', 2)
    hold on

    % Gambar massa
    plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k')
    plot(x1(k), y1(k), 'bo', 'MarkerSize', 20, 'MarkerFaceColor', [0.3 0.5 0.9])
    plot(x2(k), y2(k), 'ro', 'MarkerSize', 20, 'MarkerFaceColor', [0.9 0.3 0.3])

    % Trail (jejak)
    trail_start = max(1, k-200);
    plot(x2(trail_start:k), y2(trail_start:k), 'r-', ...
        'LineWidth', 0.5, 'Color', [1 0 0 0.3])

    axis equal
    xlim([-2.5 2.5]), ylim([-2.5 1])
    grid on
    title(sprintf('Pendulum Ganda (t = %.2f s)', t(k)))
    xlabel('x (m)'), ylabel('y (m)')

    drawnow
    pause(0.01)
end

disp('=== Proyek 2: Selesai! ===')
