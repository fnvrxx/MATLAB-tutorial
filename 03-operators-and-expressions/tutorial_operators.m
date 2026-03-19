%% ========================================================================
%  BAB 3: OPERATORS & EXPRESSIONS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    3.1 Operator Aritmatika
%    3.2 Operator Relasional (Perbandingan)
%    3.3 Operator Logika
%    3.4 Operator Bitwise
%    3.5 Operator Matriks vs Element-wise
%    3.6 Operator Assignment
%    3.7 Prioritas Operator
%    3.8 Colon Operator
%  ========================================================================

%% 3.1 Operator Aritmatika

a = 10;
b = 3;

fprintf('a = %d, b = %d\n', a, b)
fprintf('a + b = %d    (Penjumlahan)\n', a + b)        % 13
fprintf('a - b = %d    (Pengurangan)\n', a - b)        % 7
fprintf('a * b = %d    (Perkalian)\n', a * b)           % 30
fprintf('a / b = %.4f  (Pembagian)\n', a / b)           % 3.3333
fprintf('a \\ b = %.4f  (Pembagian kiri: b/a)\n', a\b) % 0.3000
fprintf('a ^ b = %d    (Pangkat)\n', a ^ b)             % 1000

% Modulo (sisa bagi)
fprintf('mod(a, b) = %d  (Modulo)\n', mod(a, b))        % 1
fprintf('rem(a, b) = %d  (Remainder)\n', rem(a, b))     % 1

% Perbedaan mod vs rem untuk bilangan negatif
fprintf('mod(-7, 3) = %d\n', mod(-7, 3))    % 2 (selalu positif)
fprintf('rem(-7, 3) = %d\n', rem(-7, 3))    % -1 (mengikuti tanda pembilang)

% Pembagian integer
fprintf('floor(7/2) = %d  (Pembulatan ke bawah)\n', floor(7/2))    % 3
fprintf('ceil(7/2) = %d   (Pembulatan ke atas)\n', ceil(7/2))      % 4
fprintf('round(7/2) = %d  (Pembulatan terdekat)\n', round(7/2))    % 4
fprintf('fix(7/2) = %d    (Pembulatan ke nol)\n', fix(7/2))        % 3

%% 3.2 Operator Relasional (Perbandingan)

x = 5;
y = 10;

fprintf('\nx = %d, y = %d\n', x, y)
fprintf('x == y : %d  (Sama dengan)\n', x == y)      % 0
fprintf('x ~= y : %d  (Tidak sama dengan)\n', x ~= y) % 1
fprintf('x > y  : %d  (Lebih besar)\n', x > y)        % 0
fprintf('x < y  : %d  (Lebih kecil)\n', x < y)        % 1
fprintf('x >= y : %d  (Lebih besar atau sama)\n', x >= y) % 0
fprintf('x <= y : %d  (Lebih kecil atau sama)\n', x <= y) % 1

% Perbandingan array (element-wise)
A = [1 2 3 4 5];
B = [5 4 3 2 1];

disp('A == B:')
disp(A == B)    % [0 0 1 0 0]

disp('A > B:')
disp(A > B)     % [0 0 0 1 1]

% Perbandingan dengan skalar
disp('A > 3:')
disp(A > 3)     % [0 0 0 1 1]

%% 3.3 Operator Logika

% --- Operator element-wise: &, |, ~ ---
p = true;
q = false;

fprintf('\np = %d, q = %d\n', p, q)
fprintf('p & q  = %d  (AND)\n', p & q)      % 0
fprintf('p | q  = %d  (OR)\n', p | q)       % 1
fprintf('~p     = %d  (NOT)\n', ~p)          % 0
fprintf('xor(p,q) = %d (XOR)\n', xor(p, q)) % 1

% --- Short-circuit operators: &&, || ---
% Hanya mengevaluasi operand kedua jika perlu
% Hanya untuk skalar!

a = 5;
% Short-circuit AND: jika operand pertama false, yang kedua diabaikan
if a > 0 && a < 10
    disp('a antara 0 dan 10')
end

% Short-circuit OR: jika operand pertama true, yang kedua diabaikan
if a < 0 || a > 3
    disp('a di luar range 0-3')
end

% Contoh penggunaan short-circuit untuk menghindari error
arr = [];
if ~isempty(arr) && arr(1) > 0
    disp('Elemen pertama positif')
else
    disp('Array kosong atau elemen pertama tidak positif')
end

% Logika pada array
X = [1 0 1 0 1];
Y = [1 1 0 0 1];

disp('X & Y:')
disp(X & Y)     % [1 0 0 0 1]

disp('X | Y:')
disp(X | Y)     % [1 1 1 0 1]

disp('~X:')
disp(~X)        % [0 1 0 1 0]

%% 3.4 Operator Bitwise

a = uint8(12);   % binary: 00001100
b = uint8(10);   % binary: 00001010

fprintf('\na = %d (bin: %s)\n', a, dec2bin(a, 8))
fprintf('b = %d (bin: %s)\n', b, dec2bin(b, 8))

fprintf('bitand(a,b) = %d  (bin: %s)\n', bitand(a,b), dec2bin(bitand(a,b), 8))
% 8 = 00001000

fprintf('bitor(a,b)  = %d (bin: %s)\n', bitor(a,b), dec2bin(bitor(a,b), 8))
% 14 = 00001110

fprintf('bitxor(a,b) = %d  (bin: %s)\n', bitxor(a,b), dec2bin(bitxor(a,b), 8))
% 6 = 00000110

fprintf('bitcmp(a)   = %d (bin: %s)\n', bitcmp(a), dec2bin(bitcmp(a), 8))
% 243 = 11110011

% Bit shift
fprintf('bitshift(a, 2)  = %d  (shift left 2)\n', bitshift(a, 2))   % 48
fprintf('bitshift(a, -2) = %d   (shift right 2)\n', bitshift(a, -2)) % 3

%% 3.5 Operator Matriks vs Element-wise

% Ini adalah perbedaan KRUSIAL di MATLAB!

A = [1 2; 3 4];
B = [5 6; 7 8];

fprintf('\nA = \n')
disp(A)
fprintf('B = \n')
disp(B)

% --- Perkalian Matriks vs Element-wise ---
C_matrix = A * B;      % Perkalian matriks (dot product)
C_elem = A .* B;       % Perkalian element-wise

fprintf('A * B (matriks):\n')
disp(C_matrix)
% [1*5+2*7  1*6+2*8]   = [19  22]
% [3*5+4*7  3*6+4*8]     [43  50]

fprintf('A .* B (element-wise):\n')
disp(C_elem)
% [1*5  2*6]   = [5  12]
% [3*7  4*8]     [21 32]

% --- Pembagian ---
D_right = A / B;        % A * inv(B) - pembagian matriks kanan
D_left = A \ B;         % inv(A) * B - pembagian matriks kiri
D_elem = A ./ B;        % Pembagian element-wise

fprintf('A ./ B (element-wise):\n')
disp(D_elem)

% --- Pangkat ---
P_matrix = A ^ 2;       % A * A - pangkat matriks
P_elem = A .^ 2;        % Pangkat element-wise

fprintf('A ^ 2 (matriks, A*A):\n')
disp(P_matrix)

fprintf('A .^ 2 (element-wise):\n')
disp(P_elem)
% [1  4]
% [9  16]

% --- Transpose ---
T_normal = A';           % Transpose konjugat (untuk complex)
T_dot = A.';             % Transpose tanpa konjugat

fprintf('A'' (transpose):\n')
disp(T_normal)
% [1  3]
% [2  4]

%% 3.6 Operator Assignment (tidak ada +=, -= di MATLAB)

x = 10;

% MATLAB TIDAK mendukung +=, -=, *=, /=
% Cara yang benar:
x = x + 5;     % bukan x += 5
x = x - 3;     % bukan x -= 3
x = x * 2;     % bukan x *= 2
x = x / 4;     % bukan x /= 4

fprintf('x setelah operasi: %.1f\n', x)

%% 3.7 Prioritas Operator (dari tertinggi ke terendah)

% 1. ()                    - Parentheses
% 2. '  .'  ^  .^          - Transpose, Power
% 3. + (unary) - (unary) ~ - Unary plus, minus, NOT
% 4. *  /  \  .*  ./  .\   - Multiplication, Division
% 5. + -                    - Addition, Subtraction
% 6. :                      - Colon
% 7. < <= > >= == ~=        - Relational
% 8. &                      - Element-wise AND
% 9. |                      - Element-wise OR
% 10. &&                    - Short-circuit AND
% 11. ||                    - Short-circuit OR

% Contoh prioritas
result1 = 2 + 3 * 4;       % = 2 + 12 = 14 (bukan 20)
result2 = (2 + 3) * 4;     % = 5 * 4 = 20
result3 = 2 ^ 3 ^ 2;       % = 2 ^ 9 = 512 (right-to-left)

fprintf('2 + 3 * 4 = %d\n', result1)
fprintf('(2 + 3) * 4 = %d\n', result2)
fprintf('2 ^ 3 ^ 2 = %d\n', result3)

% Tips: gunakan tanda kurung untuk kejelasan!
% Lebih baik: (a * b) + (c * d) daripada a * b + c * d

%% 3.8 Colon Operator (:)

% Membuat sequence
seq1 = 1:5;           % [1 2 3 4 5]
seq2 = 1:2:10;        % [1 3 5 7 9] (step = 2)
seq3 = 10:-2:0;       % [10 8 6 4 2 0] (countdown)
seq4 = 0:0.5:3;       % [0 0.5 1.0 1.5 2.0 2.5 3.0]

fprintf('1:5     = ')
disp(seq1)

fprintf('1:2:10  = ')
disp(seq2)

fprintf('10:-2:0 = ')
disp(seq3)

fprintf('0:0.5:3 = ')
disp(seq4)

% linspace - alternatif untuk membuat sequence dengan jumlah elemen tertentu
lin = linspace(0, 1, 5);   % 5 elemen dari 0 sampai 1
fprintf('linspace(0,1,5) = ')
disp(lin)
% >>> [0  0.25  0.50  0.75  1.00]

% logspace - sequence logaritmik
logs = logspace(0, 3, 4);  % 10^0 sampai 10^3, 4 elemen
fprintf('logspace(0,3,4) = ')
disp(logs)
% >>> [1  10  100  1000]

%% Ringkasan Bab 3
% ==================
% - Aritmatika: + - * / \ ^ mod() rem()
% - Relasional: == ~= > < >= <= (menghasilkan logical)
% - Logika: & | ~ xor (element-wise), && || (short-circuit)
% - PENTING: * vs .*, / vs ./, ^ vs .^ (matriks vs element-wise)
% - MATLAB tidak punya +=, -=, *=, /=
% - Colon operator (:) untuk membuat sequence
% - Gunakan tanda kurung untuk kejelasan prioritas

disp('=== Bab 3: Operators & Expressions - Selesai! ===')
