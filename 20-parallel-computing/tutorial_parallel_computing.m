%% ========================================================================
%  BAB 20: PARALLEL COMPUTING
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Memerlukan: Parallel Computing Toolbox
%  Topik:
%    20.1 Konsep parallel computing
%    20.2 parfor (parallel for loop)
%    20.3 parfeval (background tasks)
%    20.4 spmd (Single Program Multiple Data)
%    20.5 GPU computing
%    20.6 Practical examples
%  ========================================================================

%% 20.1 Konsep Parallel Computing

fprintf('=== Parallel Computing ===\n')

% MATLAB menggunakan "parallel pool" dari workers
% Setiap worker = satu MATLAB instance terpisah

% --- Membuka parallel pool ---
% parpool()              % default: sesuai jumlah core
% parpool(4)             % 4 workers
% parpool('local', 8)    % 8 local workers

% --- Menutup pool ---
% delete(gcp('nocreate'))

% --- Cek info ---
% p = gcp('nocreate');    % get current pool
% if ~isempty(p)
%     fprintf('Pool size: %d workers\n', p.NumWorkers)
% end

% Untuk tutorial ini, gunakan simulasi tanpa pool jika tidak tersedia
hasParallel = license('test', 'Distrib_Computing_Toolbox');
fprintf('Parallel Computing Toolbox: %s\n', ...
    ternary(hasParallel, 'Available', 'Not Available'))

%% 20.2 parfor (Parallel For Loop)

fprintf('\n=== parfor ===\n')

% --- Contoh dasar ---
n = 100;
results = zeros(1, n);

% Serial version (benchmark)
tic
for i = 1:n
    results(i) = sum(eig(rand(100)));
end
t_serial = toc;
fprintf('Serial:   %.2f s\n', t_serial)

% Parallel version
results_par = zeros(1, n);
tic
parfor i = 1:n
    results_par(i) = sum(eig(rand(100)));
end
t_parallel = toc;
fprintf('Parallel: %.2f s\n', t_parallel)
fprintf('Speedup:  %.1fx\n', t_serial / t_parallel)

% --- Aturan parfor ---
% 1. Iterasi harus INDEPENDEN (tidak bergantung iterasi lain)
% 2. Tidak boleh mengubah variabel yang dibaca iterasi lain
% 3. Index harus integer berurutan
% 4. Tidak boleh break/return dari dalam parfor

% VALID parfor patterns:
% - Reduction: x = x + something (sum, prod, min, max)
% - Sliced: array(i) = ...
% - Broadcast: menggunakan variabel dari luar yang tidak diubah

% CONTOH VALID: Reduction variable
total = 0;
parfor i = 1:1000
    total = total + rand();  % reduction (sum)
end
fprintf('Reduction total: %.2f\n', total)

% CONTOH VALID: Sliced output
output = zeros(1, 100);
parfor i = 1:100
    output(i) = i^2;  % sliced variable
end

% CONTOH TIDAK VALID (JANGAN dilakukan):
% parfor i = 1:n
%     x(i) = x(i-1) + 1;   % ERROR: bergantung pada iterasi sebelumnya
% end

%% 20.3 parfeval (Asynchronous Tasks)

fprintf('\n=== parfeval ===\n')

% parfeval menjalankan fungsi di background tanpa menunggu hasilnya

% --- Contoh: menjalankan beberapa tugas paralel ---
% Simulasi tugas yang memakan waktu
function result = heavy_computation(n, id)
    pause(0.5)  % simulasi kerja berat
    result = sum(eig(rand(n)));
    fprintf('Task %d selesai\n', id)
end

% Tanpa pool, kita simulasikan konsep
fprintf('\nKonsep parfeval:\n')
fprintf('  f1 = parfeval(@heavy_computation, 1, 100, 1);\n')
fprintf('  f2 = parfeval(@heavy_computation, 1, 200, 2);\n')
fprintf('  f3 = parfeval(@heavy_computation, 1, 300, 3);\n')
fprintf('  [idx, result] = fetchNext(f1, f2, f3); %% ambil yg selesai duluan\n')

% Demonstrasi sequential
results_pf = zeros(1, 3);
for id = 1:3
    results_pf(id) = heavy_computation(50, id);
end

% Dengan parfeval (pseudo-code):
% futures = parfeval(@heavy_computation, 1, 100, 1);
% for i = 1:3
%     futures(i) = parfeval(@heavy_computation, 1, i*50, i);
% end
% for i = 1:3
%     [completedIdx, value] = fetchNext(futures);
%     fprintf('Task %d result: %.2f\n', completedIdx, value);
% end

%% 20.4 spmd (Single Program Multiple Data)

fprintf('\n=== spmd ===\n')

% spmd menjalankan kode yang sama di semua workers
% Setiap worker bisa memiliki data berbeda

% --- Konsep dasar ---
fprintf('Konsep spmd:\n')
fprintf('  spmd\n')
fprintf('    labindex  %% ID worker (1, 2, 3, ...)\n')
fprintf('    numlabs   %% total workers\n')
fprintf('    data = labindex * 10  %% setiap worker data berbeda\n')
fprintf('  end\n')
fprintf('  %% data{1} = 10, data{2} = 20, ...\n')

% --- Distributed arrays ---
fprintf('\nDistributed arrays:\n')
fprintf('  D = distributed(rand(1000));  %% distribusikan ke workers\n')
fprintf('  result = sum(D, "all");       %% komputasi paralel otomatis\n')

% --- codistributed ---
fprintf('\nCodistributed:\n')
fprintf('  spmd\n')
fprintf('    local_part = rand(250, 1000);  %% setiap worker punya bagian\n')
fprintf('    D = codistributed(local_part, codistributor1d(1));\n')
fprintf('  end\n')

%% 20.5 GPU Computing

fprintf('\n=== GPU Computing ===\n')

% Cek ketersediaan GPU
hasGPU = false;
try
    gpu = gpuDevice();
    hasGPU = true;
    fprintf('GPU: %s (Compute %.1f)\n', gpu.Name, gpu.ComputeCapability)
    fprintf('Memory: %.1f GB\n', gpu.TotalMemory / 1e9)
catch
    fprintf('GPU tidak tersedia (butuh NVIDIA + CUDA)\n')
end

% --- Konsep GPU computing ---
fprintf('\nKonsep GPU computing:\n')

% Transfer data ke GPU
fprintf('  A_gpu = gpuArray(rand(1000));    %% CPU -> GPU\n')
fprintf('  B_gpu = gpuArray(rand(1000));    %% CPU -> GPU\n')

% Operasi di GPU (otomatis)
fprintf('  C_gpu = A_gpu * B_gpu;           %% komputasi di GPU\n')

% Transfer hasil balik ke CPU
fprintf('  C_cpu = gather(C_gpu);           %% GPU -> CPU\n')

% --- Benchmark CPU vs GPU (simulasi) ---
n = 2000;
fprintf('\nBenchmark Matrix Multiplication (%dx%d):\n', n, n)

A = rand(n);
B = rand(n);

% CPU
tic
C_cpu = A * B;
t_cpu = toc;
fprintf('  CPU: %.4f s\n', t_cpu)

% GPU (jika tersedia)
if hasGPU
    A_gpu = gpuArray(A);
    B_gpu = gpuArray(B);

    tic
    C_gpu = A_gpu * B_gpu;
    wait(gpuDevice)    % tunggu GPU selesai
    t_gpu = toc;

    fprintf('  GPU: %.4f s\n', t_gpu)
    fprintf('  Speedup: %.1fx\n', t_cpu / t_gpu)

    C_back = gather(C_gpu);
end

% --- Fungsi yang mendukung GPU ---
fprintf('\nFungsi GPU-compatible: fft, ifft, svd, eig, sort, sum, dll.\n')
fprintf('  gpuArray.ones(1000)\n')
fprintf('  gpuArray.zeros(1000)\n')
fprintf('  gpuArray.rand(1000)\n')

%% 20.6 Practical Examples

fprintf('\n=== Practical Examples ===\n')

% --- Example 1: Monte Carlo Pi estimation ---
fprintf('\n--- Monte Carlo Pi Estimation ---\n')
N = 1000000;

% Serial
tic
count_serial = 0;
for i = 1:N
    x = rand(); y = rand();
    if x^2 + y^2 <= 1
        count_serial = count_serial + 1;
    end
end
pi_serial = 4 * count_serial / N;
t_serial = toc;

% Parallel (vectorized + parfor)
tic
count_parallel = 0;
parfor i = 1:N
    x = rand(); y = rand();
    if x^2 + y^2 <= 1
        count_parallel = count_parallel + 1;
    end
end
pi_parallel = 4 * count_parallel / N;
t_parallel = toc;

% Vectorized (fastest!)
tic
x = rand(N, 1); y = rand(N, 1);
pi_vec = 4 * sum(x.^2 + y.^2 <= 1) / N;
t_vec = toc;

fprintf('Serial:     pi ≈ %.6f (%.4f s)\n', pi_serial, t_serial)
fprintf('Parallel:   pi ≈ %.6f (%.4f s)\n', pi_parallel, t_parallel)
fprintf('Vectorized: pi ≈ %.6f (%.4f s)\n', pi_vec, t_vec)

% --- Example 2: Parameter sweep ---
fprintf('\n--- Parameter Sweep ---\n')

params = linspace(0.1, 10, 50);
results_sweep = zeros(size(params));

parfor i = 1:length(params)
    % Simulasi: optimasi untuk setiap parameter
    f = @(x) (x - params(i))^2 + sin(x * params(i));
    [~, fval] = fminsearch(f, 0);
    results_sweep(i) = fval;
end

figure
plot(params, results_sweep, 'bo-', 'LineWidth', 1.5)
title('Parameter Sweep (parfor)')
xlabel('Parameter'), ylabel('Minimum Value')
grid on

%% Fungsi helper
function result = ternary(condition, trueVal, falseVal)
    if condition
        result = trueVal;
    else
        result = falseVal;
    end
end

%% Ringkasan Bab 20
% ==================
% - parpool: membuat parallel pool workers
% - parfor: parallel for loop (iterasi independen)
% - parfeval: menjalankan fungsi di background
% - spmd: same code, different data per worker
% - gpuArray: komputasi di GPU (NVIDIA CUDA)
% - Tips: vectorization sering lebih cepat daripada parfor
% - Use cases: Monte Carlo, parameter sweep, large matrix ops

disp('=== Bab 20: Parallel Computing - Selesai! ===')
