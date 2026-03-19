%% ========================================================================
%  BAB 6: ARRAYS & MATRICES
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    6.1 Membuat vektor dan matriks
%    6.2 Indexing dan slicing
%    6.3 Operasi matriks
%    6.4 Fungsi matriks bawaan
%    6.5 Reshape dan manipulasi dimensi
%    6.6 Matriks khusus
%    6.7 Aljabar linear
%    6.8 Sparse matrices
%  ========================================================================

%% 6.1 Membuat Vektor dan Matriks

% --- Vektor baris ---
v_baris = [1 2 3 4 5];         % spasi sebagai pemisah
v_baris2 = [1, 2, 3, 4, 5];   % koma juga bisa
fprintf('Vektor baris: ')
disp(v_baris)

% --- Vektor kolom ---
v_kolom = [1; 2; 3; 4; 5];    % titik koma sebagai pemisah
fprintf('Vektor kolom:\n')
disp(v_kolom)

% --- Matriks 2D ---
M = [1 2 3; 4 5 6; 7 8 9];   % 3x3
fprintf('Matriks 3x3:\n')
disp(M)

% --- Dengan colon operator ---
seq = 1:10;            % [1 2 3 ... 10]
seq2 = 0:0.5:3;        % [0 0.5 1 1.5 2 2.5 3]
seq3 = linspace(0, 1, 5);  % 5 elemen merata dari 0 sampai 1

% --- Membuat matriks dengan fungsi ---
Z = zeros(3, 4);       % matriks 3x4 berisi nol
O = ones(2, 3);        % matriks 2x3 berisi satu
E = eye(4);            % matriks identitas 4x4
R = rand(3, 3);        % matriks random 3x3 (uniform 0-1)
RN = randn(3, 3);      % matriks random 3x3 (normal distribution)
RI = randi(100, 3, 3); % matriks random integer 1-100

fprintf('Zeros 3x4:\n')
disp(Z)
fprintf('Identity 4x4:\n')
disp(E)

%% 6.2 Indexing dan Slicing

M = [10 20 30 40; 50 60 70 80; 90 100 110 120];
fprintf('Matriks M:\n')
disp(M)

% --- Akses elemen tunggal ---
fprintf('M(2,3) = %d\n', M(2,3))    % baris 2, kolom 3 = 70

% --- Linear indexing (kolom-major) ---
fprintf('M(5) = %d\n', M(5))    % elemen ke-5 (kolom-major) = 60
% Urutan linear: 10, 50, 90, 20, 60, 100, 30, 70, 110, 40, 80, 120

% --- Slicing (mengambil sebagian) ---
fprintf('Baris 2: ')
disp(M(2, :))           % seluruh baris 2: [50 60 70 80]

fprintf('Kolom 3: ')
disp(M(:, 3)')           % seluruh kolom 3: [30; 70; 110]

fprintf('Sub-matriks:\n')
disp(M(1:2, 2:3))       % baris 1-2, kolom 2-3

% --- end keyword ---
fprintf('Elemen terakhir baris 1: %d\n', M(1, end))        % 40
fprintf('2 kolom terakhir:\n')
disp(M(:, end-1:end))

% --- Logical indexing ---
fprintf('Elemen > 50:\n')
disp(M(M > 50)')

% --- Mengubah elemen ---
M(1, 1) = 999;
fprintf('Setelah M(1,1) = 999:\n')
disp(M)

% Mengubah seluruh baris
M(3, :) = [0 0 0 0];
fprintf('Setelah baris 3 = 0:\n')
disp(M)

% --- Menghapus baris/kolom ---
M(:, 2) = [];   % hapus kolom 2
fprintf('Setelah hapus kolom 2:\n')
disp(M)

%% 6.3 Operasi Matriks

A = [1 2; 3 4];
B = [5 6; 7 8];

% Penjumlahan dan pengurangan
fprintf('A + B:\n')
disp(A + B)

fprintf('A - B:\n')
disp(A - B)

% Perkalian matriks
fprintf('A * B (matriks):\n')
disp(A * B)

% Perkalian element-wise
fprintf('A .* B (element-wise):\n')
disp(A .* B)

% Transpose
fprintf('A'':\n')
disp(A')

% Determinan
fprintf('det(A) = %.2f\n', det(A))

% Invers
fprintf('inv(A):\n')
disp(inv(A))

% Verifikasi A * inv(A) = I
fprintf('A * inv(A):\n')
disp(A * inv(A))

% Trace (jumlah diagonal)
fprintf('trace(A) = %d\n', trace(A))

% Rank
fprintf('rank(A) = %d\n', rank(A))

%% 6.4 Fungsi Matriks Bawaan

M = [4 2 7 1; 8 3 5 9; 6 1 3 2];

% --- Ukuran ---
fprintf('size(M) = %dx%d\n', size(M, 1), size(M, 2))
fprintf('numel(M) = %d\n', numel(M))       % total elemen
fprintf('length(M) = %d\n', length(M))     % dimensi terbesar

% --- Statistik ---
fprintf('sum(M(:)) = %d\n', sum(M(:)))     % jumlah semua elemen
fprintf('mean(M(:)) = %.2f\n', mean(M(:))) % rata-rata semua
fprintf('max(M(:)) = %d\n', max(M(:)))     % max semua
fprintf('min(M(:)) = %d\n', min(M(:)))     % min semua

% Per kolom (default)
fprintf('\nSum per kolom: ')
disp(sum(M))

% Per baris
fprintf('Sum per baris: ')
disp(sum(M, 2)')

% --- Sorting ---
fprintf('Sort tiap kolom (ascending):\n')
disp(sort(M))

fprintf('Sort tiap baris (descending):\n')
disp(sort(M, 2, 'descend'))

% --- Flipping ---
fprintf('fliplr (flip kiri-kanan):\n')
disp(fliplr(M))

fprintf('flipud (flip atas-bawah):\n')
disp(flipud(M))

% --- Rotasi ---
fprintf('rot90 (rotasi 90 derajat):\n')
disp(rot90(M))

%% 6.5 Reshape dan Manipulasi Dimensi

A = 1:12;
fprintf('Array asli: ')
disp(A)

% Reshape ke matriks
B = reshape(A, 3, 4);   % 3 baris, 4 kolom
fprintf('Reshape 3x4:\n')
disp(B)

C = reshape(A, 4, 3);   % 4 baris, 3 kolom
fprintf('Reshape 4x3:\n')
disp(C)

% Reshape ke 3D
D = reshape(A, 2, 2, 3);  % 2x2x3
fprintf('Reshape 2x2x3, slice 1:\n')
disp(D(:,:,1))

% --- Concatenation ---
X = [1 2; 3 4];
Y = [5 6; 7 8];

% Horizontal (kolom bertambah)
H = [X, Y];    % atau horzcat(X, Y)
fprintf('Horizontal concat:\n')
disp(H)

% Vertical (baris bertambah)
V = [X; Y];    % atau vertcat(X, Y)
fprintf('Vertical concat:\n')
disp(V)

% --- repmat: repeat matrix ---
R = repmat([1 2; 3 4], 2, 3);  % ulangi 2 kali vertikal, 3 kali horizontal
fprintf('repmat 2x3:\n')
disp(R)

% --- Squeeze: hapus dimensi singleton ---
T = ones(3, 1, 4);     % 3x1x4
S = squeeze(T);         % 3x4
fprintf('Sebelum squeeze: %dx%dx%d\n', size(T))
fprintf('Setelah squeeze: %dx%d\n', size(S))

% --- permute: transpose multi-dimensi ---
P = rand(2, 3, 4);
Q = permute(P, [2 1 3]);   % tukar dimensi 1 dan 2
fprintf('Sebelum permute: %dx%dx%d\n', size(P))
fprintf('Setelah permute: %dx%dx%d\n', size(Q))

%% 6.6 Matriks Khusus

% --- Magic square ---
M = magic(4);   % baris, kolom, diagonal semua berjumlah sama
fprintf('Magic 4x4 (sum = %d):\n', sum(M(1,:)))
disp(M)

% --- Hilbert matrix ---
H = hilb(4);
fprintf('Hilbert 4x4:\n')
disp(H)

% --- Vandermonde matrix ---
v = [1 2 3 4];
V = vander(v);
fprintf('Vandermonde:\n')
disp(V)

% --- Diagonal matrix ---
d = [1 2 3 4];
D = diag(d);        % buat matriks diagonal dari vektor
fprintf('Diagonal matrix:\n')
disp(D)

% Ekstrak diagonal dari matriks
A = magic(4);
d = diag(A);         % ekstrak diagonal utama
fprintf('Diagonal dari magic(4): ')
disp(d')

% --- Block diagonal ---
B = blkdiag([1 2; 3 4], [5; 6], [7 8 9]);
fprintf('Block diagonal:\n')
disp(B)

%% 6.7 Aljabar Linear

% --- Sistem persamaan linear: Ax = b ---
% 2x + 3y = 8
% 4x + y = 6
A = [2 3; 4 1];
b = [8; 6];

% Metode 1: menggunakan backslash (recommended!)
x = A \ b;
fprintf('\nSolusi Ax = b:\n')
fprintf('x = %.2f, y = %.2f\n', x(1), x(2))

% Metode 2: menggunakan inv (kurang efisien)
x2 = inv(A) * b;

% --- Eigenvalues dan eigenvectors ---
M = [4 1; 2 3];
[V, D] = eig(M);
fprintf('\nEigenvalues:\n')
disp(diag(D)')
fprintf('Eigenvectors:\n')
disp(V)

% --- SVD (Singular Value Decomposition) ---
A = [1 2; 3 4; 5 6];
[U, S, V] = svd(A);
fprintf('Singular values: ')
disp(diag(S)')

% --- Norm ---
v = [3 4];
fprintf('\n||v||_2 = %.2f\n', norm(v))       % Euclidean norm
fprintf('||v||_1 = %.2f\n', norm(v, 1))     % L1 norm
fprintf('||v||_inf = %.2f\n', norm(v, inf)) % infinity norm

% --- Condition number ---
A = [1 2; 3 4];
fprintf('cond(A) = %.4f\n', cond(A))

% --- Null space ---
A = [1 2 3; 4 5 6; 7 8 9];  % singular matrix
N = null(A);
fprintf('Null space of A:\n')
disp(N)

% --- Cross product dan dot product ---
a = [1 2 3];
b = [4 5 6];
fprintf('dot(a,b) = %d\n', dot(a, b))
fprintf('cross(a,b) = ')
disp(cross(a, b))

%% 6.8 Sparse Matrices

% Untuk matriks besar dengan banyak elemen nol
% Menghemat memori dan mempercepat komputasi

% Membuat sparse matrix
S = sparse(5, 5);    % matriks sparse 5x5 (semua nol)
S(1,1) = 1;
S(2,3) = 5;
S(4,2) = 3;
S(5,5) = 7;

fprintf('Sparse matrix:\n')
disp(full(S))           % konversi ke full untuk display

fprintf('Elemen non-zero: %d\n', nnz(S))
fprintf('Sparsity: %.1f%%\n', (1 - nnz(S)/numel(full(S))) * 100)

% Membuat sparse dari triplet (row, col, val)
rows = [1 2 3 3];
cols = [1 3 2 3];
vals = [10 20 30 40];
T = sparse(rows, cols, vals, 4, 4);
fprintf('\nSparse dari triplet:\n')
disp(full(T))

% Konversi full ke sparse
F = eye(100);           % full 100x100 identity
S = sparse(F);          % sparse version
fprintf('Full memory: %d bytes\n', whos('F').bytes)
fprintf('Sparse memory: %d bytes\n', whos('S').bytes)

% speye, sprand, sprandn
SI = speye(100);         % sparse identity
SR = sprand(100, 100, 0.01);  % sparse random, density 1%

%% Ringkasan Bab 6
% ==================
% - Vektor: baris [1 2 3], kolom [1; 2; 3]
% - Matriks: M(row, col), linear indexing M(n)
% - Slicing: M(1:3, :), M(:, end), M(M > 5)
% - Operasi: * vs .*, / vs ./, ^ vs .^
% - Fungsi: size, sum, mean, sort, reshape, repmat
% - Aljabar linear: \, eig, svd, det, inv, norm
% - Sparse: efisien untuk matriks besar dan jarang

disp('=== Bab 6: Arrays & Matrices - Selesai! ===')
