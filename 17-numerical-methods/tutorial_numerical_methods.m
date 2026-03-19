%% ========================================================================
%  BAB 17: NUMERICAL METHODS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    17.1 Root finding (pencarian akar)
%    17.2 Interpolasi
%    17.3 Integrasi numerik
%    17.4 Diferensiasi numerik
%    17.5 ODE (Ordinary Differential Equations)
%    17.6 Optimisasi
%    17.7 Curve fitting
%  ========================================================================

%% 17.1 Root Finding (Pencarian Akar)

fprintf('=== Root Finding ===\n')

% --- fzero: pencarian akar untuk persamaan nonlinear ---
% f(x) = x^3 - 6x^2 + 11x - 6 = 0
f = @(x) x.^3 - 6*x.^2 + 11*x - 6;

% Mencari akar di sekitar x0
x1 = fzero(f, 0);
x2 = fzero(f, 2.5);
x3 = fzero(f, 4);

fprintf('Akar f(x) = x^3 - 6x^2 + 11x - 6:\n')
fprintf('  x1 = %.4f\n', x1)  % 1
fprintf('  x2 = %.4f\n', x2)  % 2
fprintf('  x3 = %.4f\n', x3)  % 3

% Visualisasi
figure
x = linspace(0, 4, 200);
plot(x, f(x), 'b-', 'LineWidth', 2)
hold on
plot([x1 x2 x3], [0 0 0], 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r')
grid on
title('Root Finding: f(x) = x^3 - 6x^2 + 11x - 6')
xlabel('x'), ylabel('f(x)')
legend('f(x)', 'Akar')
yline(0, 'k--')

% --- fzero dengan opsi ---
options = optimset('Display', 'iter', 'TolX', 1e-12);
% x = fzero(f, 1.5, options);

% --- roots: akar polinomial ---
% Koefisien: x^3 - 6x^2 + 11x - 6
p = [1 -6 11 -6];
r = roots(p);
fprintf('\nroots() result: ')
disp(r')

% --- Metode Biseksi (implementasi manual) ---
function root = biseksi(f, a, b, tol)
    if f(a) * f(b) > 0
        error('f(a) dan f(b) harus berbeda tanda')
    end
    iter = 0;
    while (b - a) / 2 > tol
        c = (a + b) / 2;
        if f(c) == 0
            break
        elseif f(a) * f(c) < 0
            b = c;
        else
            a = c;
        end
        iter = iter + 1;
    end
    root = (a + b) / 2;
    fprintf('Biseksi: %d iterasi\n', iter)
end

akar = biseksi(f, 0, 1.5, 1e-10);
fprintf('Akar (biseksi) = %.10f\n', akar)

% --- Newton-Raphson ---
function root = newton_raphson(f, df, x0, tol, maxIter)
    x = x0;
    for i = 1:maxIter
        fx = f(x);
        dfx = df(x);
        if abs(dfx) < eps
            error('Derivatif mendekati nol')
        end
        x_new = x - fx / dfx;
        if abs(x_new - x) < tol
            root = x_new;
            fprintf('Newton-Raphson: %d iterasi\n', i)
            return
        end
        x = x_new;
    end
    root = x;
    warning('Maximum iterasi tercapai')
end

df = @(x) 3*x.^2 - 12*x + 11;
akar_nr = newton_raphson(f, df, 0.5, 1e-10, 100);
fprintf('Akar (Newton-Raphson) = %.10f\n', akar_nr)

%% 17.2 Interpolasi

fprintf('\n=== Interpolasi ===\n')

% Data titik
x_data = [0 1 2 3 4 5];
y_data = [0 0.8 0.9 0.1 -0.8 -1.0];

% --- interp1: interpolasi 1D ---
x_query = linspace(0, 5, 100);

y_linear = interp1(x_data, y_data, x_query, 'linear');
y_spline = interp1(x_data, y_data, x_query, 'spline');
y_pchip = interp1(x_data, y_data, x_query, 'pchip');

figure
plot(x_data, y_data, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k')
hold on
plot(x_query, y_linear, 'r-', 'LineWidth', 1.5)
plot(x_query, y_spline, 'b-', 'LineWidth', 1.5)
plot(x_query, y_pchip, 'g--', 'LineWidth', 1.5)
legend('Data', 'Linear', 'Spline', 'PCHIP')
title('Interpolasi 1D')
grid on

% --- interp2: interpolasi 2D ---
[X, Y] = meshgrid(1:5, 1:5);
Z = peaks(5);

[Xq, Yq] = meshgrid(1:0.2:5, 1:0.2:5);
Zq = interp2(X, Y, Z, Xq, Yq, 'spline');

figure
subplot(1, 2, 1)
surf(X, Y, Z)
title('Data Asli (5x5)')

subplot(1, 2, 2)
surf(Xq, Yq, Zq)
title('Interpolasi Spline')

% --- polyfit/polyval: polynomial fitting ---
x = 0:0.5:5;
y = sin(x);

% Fit polinomial derajat 3
p = polyfit(x, y, 3);
y_fit = polyval(p, x);

fprintf('Koefisien polinomial: ')
disp(p)

%% 17.3 Integrasi Numerik

fprintf('\n=== Integrasi Numerik ===\n')

% --- integral: integrasi adaptif ---
f = @(x) exp(-x.^2);  % fungsi Gaussian

% Integral dari -inf sampai inf (seharusnya sqrt(pi))
result = integral(f, -Inf, Inf);
fprintf('∫exp(-x²)dx dari -∞ ke ∞ = %.6f (exact: %.6f)\n', result, sqrt(pi))

% Integral biasa
g = @(x) sin(x).^2;
result2 = integral(g, 0, pi);
fprintf('∫sin²(x)dx dari 0 ke π = %.6f (exact: %.6f)\n', result2, pi/2)

% --- integral2: double integral ---
f2 = @(x, y) x.^2 + y.^2;
result3 = integral2(f2, 0, 1, 0, 1);
fprintf('∬(x²+y²)dxdy pada [0,1]x[0,1] = %.6f (exact: %.6f)\n', result3, 2/3)

% --- integral3: triple integral ---
f3 = @(x, y, z) x + y + z;
result4 = integral3(f3, 0, 1, 0, 1, 0, 1);
fprintf('∭(x+y+z)dxdydz = %.6f (exact: %.6f)\n', result4, 3/2)

% --- trapz: trapezoidal rule (untuk data diskrit) ---
x = linspace(0, pi, 1000);
y = sin(x);
result5 = trapz(x, y);
fprintf('∫sin(x)dx (trapz, n=1000) = %.6f (exact: 2)\n', result5)

% --- cumtrapz: cumulative integral ---
cum_int = cumtrapz(x, y);
figure
subplot(2,1,1), plot(x, y, 'LineWidth', 1.5), title('sin(x)'), grid on
subplot(2,1,2), plot(x, cum_int, 'LineWidth', 1.5), title('∫sin(x)dx'), grid on

%% 17.4 Diferensiasi Numerik

fprintf('\n=== Diferensiasi Numerik ===\n')

x = linspace(0, 2*pi, 200);
y = sin(x);

% --- diff: finite difference ---
dy = diff(y) ./ diff(x);    % turunan numerik
x_mid = (x(1:end-1) + x(2:end)) / 2;  % titik tengah

% --- gradient: central difference ---
dydx = gradient(y, x);      % lebih akurat dari diff

figure
plot(x, y, 'b-', 'LineWidth', 2)
hold on
plot(x, cos(x), 'r--', 'LineWidth', 2)        % turunan exact
plot(x, dydx, 'g:', 'LineWidth', 2)            % gradient
legend('sin(x)', 'cos(x) (exact)', 'gradient')
title('Diferensiasi Numerik')
grid on

fprintf('Max error gradient: %.2e\n', max(abs(dydx - cos(x))))

%% 17.5 ODE (Ordinary Differential Equations)

fprintf('\n=== ODE Solvers ===\n')

% --- Contoh 1: dy/dt = -2y, y(0) = 1 ---
% Solusi exact: y = e^(-2t)

dydt = @(t, y) -2 * y;
[t, y] = ode45(dydt, [0 5], 1);

figure
plot(t, y, 'b-', 'LineWidth', 2)
hold on
plot(t, exp(-2*t), 'r--', 'LineWidth', 2)
legend('ode45 (numerik)', 'Exact: e^{-2t}')
title('ODE: dy/dt = -2y')
xlabel('t'), ylabel('y')
grid on

% --- Contoh 2: Sistem ODE (Lotka-Volterra / Predator-Prey) ---
% dx/dt = αx - βxy    (prey)
% dy/dt = δxy - γy    (predator)

alpha = 1.5; beta = 1.0; delta = 0.5; gamma = 0.75;
lotka_volterra = @(t, Y) [
    alpha*Y(1) - beta*Y(1)*Y(2);    % prey
    delta*Y(1)*Y(2) - gamma*Y(2)    % predator
];

Y0 = [2; 1];  % populasi awal
[t, Y] = ode45(lotka_volterra, [0 30], Y0);

figure
subplot(2, 1, 1)
plot(t, Y(:,1), 'b-', t, Y(:,2), 'r-', 'LineWidth', 2)
legend('Prey', 'Predator')
title('Lotka-Volterra (Predator-Prey)')
xlabel('Waktu'), ylabel('Populasi')
grid on

subplot(2, 1, 2)
plot(Y(:,1), Y(:,2), 'k-', 'LineWidth', 1.5)
xlabel('Prey'), ylabel('Predator')
title('Phase Portrait')
grid on

% --- Contoh 3: ODE dengan event (bola pantul) ---
% d²y/dt² = -g (gravitasi)
% y = posisi, v = kecepatan

g = 9.81;
bouncing_ball = @(t, Y) [Y(2); -g];

opts = odeset('Events', @(t,Y) ballEvent(t, Y), 'MaxStep', 0.01);

function [value, isterminal, direction] = ballEvent(~, Y)
    value = Y(1);       % detect y = 0
    isterminal = 1;     % stop integration
    direction = -1;     % hanya saat turun
end

Y0_ball = [10; 0];  % tinggi 10m, kecepatan awal 0
t_all = []; Y_all = [];

for bounce = 1:10
    [t, Y, ~, ~, ~] = ode45(bouncing_ball, [0 20], Y0_ball, opts);
    t_all = [t_all; t + (isempty(t_all)*0 + ~isempty(t_all)*t_all(end))];
    Y_all = [Y_all; Y];

    % Bola memantul (kehilangan 20% energi)
    Y0_ball = [0; -0.8 * Y(end, 2)];

    if abs(Y0_ball(2)) < 0.1
        break
    end
end

figure
plot(t_all, Y_all(:,1), 'b-', 'LineWidth', 2)
title('Bouncing Ball')
xlabel('Waktu (s)'), ylabel('Tinggi (m)')
grid on

%% 17.6 Optimisasi

fprintf('\n=== Optimisasi ===\n')

% --- fminbnd: minimasi 1D pada interval ---
f = @(x) (x - 3).^2 + 1;
[x_min, f_min] = fminbnd(f, 0, 10);
fprintf('fminbnd: min di x=%.4f, f(x)=%.4f\n', x_min, f_min)

% --- fminsearch: minimasi tanpa constraints (Nelder-Mead) ---
% Rosenbrock function: f(x,y) = (1-x)^2 + 100(y-x^2)^2
rosenbrock = @(x) (1-x(1))^2 + 100*(x(2)-x(1)^2)^2;

x0 = [-1, -1];
[x_opt, f_opt] = fminsearch(rosenbrock, x0);
fprintf('fminsearch: min di (%.4f, %.4f), f=%.6f\n', x_opt(1), x_opt(2), f_opt)

% Visualisasi
figure
[X, Y] = meshgrid(linspace(-2, 2, 100), linspace(-1, 3, 100));
Z = (1-X).^2 + 100*(Y-X.^2).^2;
contourf(X, Y, log10(Z), 30)
hold on
plot(x_opt(1), x_opt(2), 'r*', 'MarkerSize', 15, 'LineWidth', 2)
colorbar
title('Rosenbrock Function (log scale)')
xlabel('x'), ylabel('y')

% --- fmincon: minimasi dengan constraints ---
% Minimize: f(x) = x1^2 + x2^2
% Subject to: x1 + x2 >= 1
f_obj = @(x) x(1)^2 + x(2)^2;
A = [-1 -1];   % constraint: -x1-x2 <= -1 => x1+x2 >= 1
b = [-1];
x0 = [0.5, 0.5];

options = optimoptions('fmincon', 'Display', 'off');
[x_con, f_con] = fmincon(f_obj, x0, A, b, [], [], [], [], [], options);
fprintf('fmincon: min di (%.4f, %.4f), f=%.4f\n', x_con(1), x_con(2), f_con)

% --- linprog: linear programming ---
% Minimize: f = -x1 - 2*x2
% Subject to: x1 + x2 <= 4, x1 <= 3, x2 <= 3, x1,x2 >= 0
f_lp = [-1; -2];
A_lp = [1 1; 1 0; 0 1];
b_lp = [4; 3; 3];
lb = [0; 0];

options_lp = optimoptions('linprog', 'Display', 'off');
[x_lp, f_lp_val] = linprog(f_lp, A_lp, b_lp, [], [], lb, [], options_lp);
fprintf('linprog: optimal di (%.1f, %.1f), f=%.1f\n', x_lp(1), x_lp(2), -f_lp_val)

%% 17.7 Curve Fitting

fprintf('\n=== Curve Fitting ===\n')

% Generate noisy data
x = linspace(0, 10, 50);
y_true = 3*exp(-0.5*x) .* sin(2*x);
y_noisy = y_true + 0.3*randn(size(x));

% --- polyfit ---
p3 = polyfit(x, y_noisy, 3);
p5 = polyfit(x, y_noisy, 5);
p10 = polyfit(x, y_noisy, 10);

x_fit = linspace(0, 10, 200);

figure
plot(x, y_noisy, 'k.', 'MarkerSize', 10)
hold on
plot(x_fit, polyval(p3, x_fit), 'r-', 'LineWidth', 1.5)
plot(x_fit, polyval(p5, x_fit), 'b-', 'LineWidth', 1.5)
plot(x_fit, polyval(p10, x_fit), 'g-', 'LineWidth', 1.5)
legend('Data', 'Degree 3', 'Degree 5', 'Degree 10')
title('Polynomial Curve Fitting')
grid on

% --- Least squares: lsqcurvefit ---
% Model: y = a*exp(b*x)*sin(c*x)
model = @(params, x) params(1)*exp(params(2)*x).*sin(params(3)*x);
params0 = [3, -0.5, 2];  % initial guess
options = optimoptions('lsqcurvefit', 'Display', 'off');
[params_fit, resnorm] = lsqcurvefit(model, params0, x, y_noisy, [], [], options);

fprintf('Fitted params: a=%.3f, b=%.3f, c=%.3f\n', ...
    params_fit(1), params_fit(2), params_fit(3))
fprintf('Residual norm: %.4f\n', resnorm)

figure
plot(x, y_noisy, 'k.', 'MarkerSize', 10)
hold on
plot(x_fit, model(params_fit, x_fit), 'r-', 'LineWidth', 2)
plot(x_fit, y_true(1)*exp(-0.5*x_fit).*sin(2*x_fit)*3, 'b--', 'LineWidth', 1.5)
legend('Data Noisy', 'Fitted', 'True')
title('Nonlinear Curve Fitting (lsqcurvefit)')
grid on

%% Ringkasan Bab 17
% ==================
% - Root finding: fzero, roots, biseksi, Newton-Raphson
% - Interpolasi: interp1, interp2, spline, pchip
% - Integrasi: integral, integral2, integral3, trapz
% - Diferensiasi: diff, gradient
% - ODE: ode45, ode23, ode15s, odeset untuk events
% - Optimisasi: fminbnd, fminsearch, fmincon, linprog
% - Curve fitting: polyfit/polyval, lsqcurvefit

disp('=== Bab 17: Numerical Methods - Selesai! ===')
