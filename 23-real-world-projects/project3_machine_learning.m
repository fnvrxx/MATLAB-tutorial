%% ========================================================================
%  PROYEK 3: MACHINE LEARNING DARI SCRATCH
%  Tutorial MATLAB - Real World Projects
%  ========================================================================
%  Tujuan:
%    - Implementasi algoritma ML dari nol (tanpa toolbox)
%    - Linear Regression
%    - K-Nearest Neighbors (KNN)
%    - K-Means Clustering
%    - Neural Network sederhana
%  ========================================================================

%% 1. Linear Regression dari Scratch
fprintf('=== Proyek 3: Machine Learning dari Scratch ===\n\n')
fprintf('--- 1. Linear Regression ---\n')

rng(42)

% Generate data
n = 100;
X = 2 * rand(n, 1);
y = 3 + 2*X + 0.5*randn(n, 1);  % y = 3 + 2x + noise

% Split train/test
n_train = 80;
X_train = X(1:n_train); y_train = y(1:n_train);
X_test = X(n_train+1:end); y_test = y(n_train+1:end);

% --- Gradient Descent ---
function [w, b, loss_history] = linear_regression_gd(X, y, lr, epochs)
    w = 0; b = 0;
    n = length(y);
    loss_history = zeros(epochs, 1);

    for epoch = 1:epochs
        % Forward pass
        y_pred = w * X + b;

        % Loss (MSE)
        loss = mean((y_pred - y).^2);
        loss_history(epoch) = loss;

        % Gradients
        dw = (2/n) * sum((y_pred - y) .* X);
        db = (2/n) * sum(y_pred - y);

        % Update
        w = w - lr * dw;
        b = b - lr * db;
    end
end

[w, b, loss_hist] = linear_regression_gd(X_train, y_train, 0.1, 200);
fprintf('Gradient Descent: w=%.4f, b=%.4f (true: w=2, b=3)\n', w, b)

% Prediksi
y_pred_test = w * X_test + b;
mse = mean((y_pred_test - y_test).^2);
fprintf('Test MSE: %.4f\n', mse)

% R-squared
SS_res = sum((y_test - y_pred_test).^2);
SS_tot = sum((y_test - mean(y_test)).^2);
R2 = 1 - SS_res/SS_tot;
fprintf('R²: %.4f\n', R2)

figure('Position', [100 100 1000 400])
subplot(1, 2, 1)
scatter(X_train, y_train, 20, 'b', 'filled', 'MarkerFaceAlpha', 0.5)
hold on
scatter(X_test, y_test, 20, 'r', 'filled')
x_line = linspace(0, 2, 100);
plot(x_line, w*x_line + b, 'k-', 'LineWidth', 2)
legend('Train', 'Test', 'Regression Line')
title(sprintf('Linear Regression (R²=%.3f)', R2))
xlabel('X'), ylabel('y'), grid on

subplot(1, 2, 2)
semilogy(loss_hist, 'LineWidth', 2)
title('Training Loss')
xlabel('Epoch'), ylabel('MSE'), grid on

%% 2. K-Nearest Neighbors (KNN) Classification
fprintf('\n--- 2. KNN Classification ---\n')

% Generate 2-class data
n_per_class = 100;
X_c1 = randn(n_per_class, 2) + [2, 2];
X_c2 = randn(n_per_class, 2) + [-1, -1];
X_data = [X_c1; X_c2];
y_labels = [ones(n_per_class, 1); 2*ones(n_per_class, 1)];

% Shuffle
idx = randperm(2*n_per_class);
X_data = X_data(idx, :);
y_labels = y_labels(idx);

% Split
n_tr = 150;
X_tr = X_data(1:n_tr, :); y_tr = y_labels(1:n_tr);
X_ts = X_data(n_tr+1:end, :); y_ts = y_labels(n_tr+1:end);

% --- KNN Implementation ---
function predictions = knn_predict(X_train, y_train, X_test, k)
    n_test = size(X_test, 1);
    predictions = zeros(n_test, 1);

    for i = 1:n_test
        % Hitung jarak ke semua training points
        distances = sqrt(sum((X_train - X_test(i,:)).^2, 2));

        % Cari k tetangga terdekat
        [~, sorted_idx] = sort(distances);
        k_nearest = y_train(sorted_idx(1:k));

        % Voting mayoritas
        predictions(i) = mode(k_nearest);
    end
end

% Test dengan berbagai k
k_values = [1 3 5 7 11];
accuracies = zeros(size(k_values));

for i = 1:length(k_values)
    k = k_values(i);
    y_pred = knn_predict(X_tr, y_tr, X_ts, k);
    accuracies(i) = mean(y_pred == y_ts) * 100;
    fprintf('KNN (k=%d): Accuracy = %.1f%%\n', k, accuracies(i))
end

% Visualisasi dengan k terbaik
[best_acc, best_idx] = max(accuracies);
best_k = k_values(best_idx);
y_pred_best = knn_predict(X_tr, y_tr, X_ts, best_k);

figure('Position', [100 100 1000 400])
subplot(1, 2, 1)
scatter(X_tr(y_tr==1,1), X_tr(y_tr==1,2), 30, 'b', 'filled', 'MarkerFaceAlpha', 0.3)
hold on
scatter(X_tr(y_tr==2,1), X_tr(y_tr==2,2), 30, 'r', 'filled', 'MarkerFaceAlpha', 0.3)
scatter(X_ts(y_pred_best==1,1), X_ts(y_pred_best==1,2), 60, 'b', 'MarkerLineWidth', 2)
scatter(X_ts(y_pred_best==2,1), X_ts(y_pred_best==2,2), 60, 'r', 'MarkerLineWidth', 2)
legend('Train C1', 'Train C2', 'Pred C1', 'Pred C2')
title(sprintf('KNN (k=%d, acc=%.1f%%)', best_k, best_acc))
xlabel('Feature 1'), ylabel('Feature 2'), grid on

subplot(1, 2, 2)
plot(k_values, accuracies, 'bo-', 'LineWidth', 2, 'MarkerFaceColor', 'b')
title('Accuracy vs k')
xlabel('k'), ylabel('Accuracy (%)'), grid on

%% 3. K-Means Clustering
fprintf('\n--- 3. K-Means Clustering ---\n')

% Generate 3 clusters
rng(42)
n_c = 80;
cluster1 = randn(n_c, 2) * 0.5 + [0 0];
cluster2 = randn(n_c, 2) * 0.8 + [4 3];
cluster3 = randn(n_c, 2) * 0.6 + [2 6];
X_cluster = [cluster1; cluster2; cluster3];

% --- K-Means Implementation ---
function [centroids, assignments, loss_hist] = kmeans_custom(X, K, max_iter)
    [n, d] = size(X);

    % Random initialization
    idx = randperm(n, K);
    centroids = X(idx, :);

    assignments = zeros(n, 1);
    loss_hist = zeros(max_iter, 1);

    for iter = 1:max_iter
        % Assignment step: setiap titik ke centroid terdekat
        for i = 1:n
            dists = sum((centroids - X(i,:)).^2, 2);
            [~, assignments(i)] = min(dists);
        end

        % Update step: hitung centroid baru
        new_centroids = zeros(K, d);
        for k = 1:K
            mask = assignments == k;
            if sum(mask) > 0
                new_centroids(k, :) = mean(X(mask, :));
            else
                new_centroids(k, :) = centroids(k, :);
            end
        end

        % Loss (total within-cluster sum of squares)
        loss = 0;
        for i = 1:n
            loss = loss + sum((X(i,:) - centroids(assignments(i),:)).^2);
        end
        loss_hist(iter) = loss;

        % Convergence check
        if max(abs(new_centroids(:) - centroids(:))) < 1e-6
            loss_hist = loss_hist(1:iter);
            fprintf('Converged at iteration %d\n', iter)
            break
        end

        centroids = new_centroids;
    end
end

K = 3;
[centroids, assignments, loss_hist] = kmeans_custom(X_cluster, K, 100);

figure('Position', [100 100 1000 400])
subplot(1, 2, 1)
colors = ['b', 'r', 'g'];
for k = 1:K
    mask = assignments == k;
    scatter(X_cluster(mask,1), X_cluster(mask,2), 30, colors(k), 'filled', ...
        'MarkerFaceAlpha', 0.5)
    hold on
end
scatter(centroids(:,1), centroids(:,2), 200, 'kx', 'LineWidth', 3)
title(sprintf('K-Means Clustering (K=%d)', K))
xlabel('X1'), ylabel('X2'), grid on, legend('C1','C2','C3','Centroids')

subplot(1, 2, 2)
plot(loss_hist, 'bo-', 'LineWidth', 2)
title('K-Means Loss')
xlabel('Iteration'), ylabel('Total Within-Cluster SS'), grid on

%% 4. Neural Network Sederhana (XOR Problem)
fprintf('\n--- 4. Neural Network (XOR) ---\n')

% XOR dataset
X_xor = [0 0; 0 1; 1 0; 1 1];
y_xor = [0; 1; 1; 0];

% Network: 2 input -> 4 hidden (sigmoid) -> 1 output (sigmoid)
function [W1, b1, W2, b2, losses] = train_nn(X, y, hidden_size, lr, epochs)
    [n, input_size] = size(X);
    output_size = size(y, 2);

    % Xavier initialization
    W1 = randn(input_size, hidden_size) * sqrt(2/input_size);
    b1 = zeros(1, hidden_size);
    W2 = randn(hidden_size, output_size) * sqrt(2/hidden_size);
    b2 = zeros(1, output_size);

    sigmoid = @(x) 1 ./ (1 + exp(-x));
    sigmoid_deriv = @(x) x .* (1 - x);

    losses = zeros(epochs, 1);

    for epoch = 1:epochs
        % --- Forward pass ---
        z1 = X * W1 + b1;
        a1 = sigmoid(z1);           % hidden layer
        z2 = a1 * W2 + b2;
        a2 = sigmoid(z2);           % output

        % --- Loss (Binary Cross Entropy) ---
        loss = -mean(y .* log(a2 + 1e-8) + (1-y) .* log(1 - a2 + 1e-8));
        losses(epoch) = loss;

        % --- Backward pass ---
        d2 = (a2 - y);                          % output error
        dW2 = (a1' * d2) / n;
        db2 = mean(d2);

        d1 = (d2 * W2') .* sigmoid_deriv(a1);   % hidden error
        dW1 = (X' * d1) / n;
        db1 = mean(d1);

        % --- Update weights ---
        W2 = W2 - lr * dW2;
        b2 = b2 - lr * db2;
        W1 = W1 - lr * dW1;
        b1 = b1 - lr * db1;

        if mod(epoch, 2000) == 0
            fprintf('Epoch %d, Loss: %.6f\n', epoch, loss)
        end
    end
end

% Train
[W1, b1, W2, b2, losses] = train_nn(X_xor, y_xor, 8, 5, 10000);

% Predict
sigmoid = @(x) 1 ./ (1 + exp(-x));
a1 = sigmoid(X_xor * W1 + b1);
predictions = sigmoid(a1 * W2 + b2);

fprintf('\nXOR Predictions:\n')
for i = 1:4
    fprintf('  [%d, %d] -> %.4f (expected: %d)\n', ...
        X_xor(i,1), X_xor(i,2), predictions(i), y_xor(i))
end

% Decision boundary
figure('Position', [100 100 1000 400])
subplot(1, 2, 1)
[xx, yy] = meshgrid(linspace(-0.5, 1.5, 100));
grid_input = [xx(:), yy(:)];
grid_hidden = sigmoid(grid_input * W1 + b1);
grid_output = sigmoid(grid_hidden * W2 + b2);
contourf(xx, yy, reshape(grid_output, 100, 100), 20)
hold on
scatter(X_xor(y_xor==0,1), X_xor(y_xor==0,2), 100, 'ro', 'LineWidth', 3)
scatter(X_xor(y_xor==1,1), X_xor(y_xor==1,2), 100, 'gx', 'LineWidth', 3)
colorbar
title('Neural Network - XOR Decision Boundary')
xlabel('x1'), ylabel('x2'), legend('', '0', '1')

subplot(1, 2, 2)
semilogy(losses, 'LineWidth', 2)
title('Training Loss')
xlabel('Epoch'), ylabel('Loss'), grid on

fprintf('\n=== Proyek 3: Machine Learning - Selesai! ===\n')
