%% ========================================================================
%  BAB 18: SIGNAL PROCESSING
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Memerlukan: Signal Processing Toolbox
%  Topik:
%    18.1 Sinyal dasar
%    18.2 Fourier Transform (FFT)
%    18.3 Filter design
%    18.4 Spektral analisis
%    18.5 Windowing
%    18.6 Convolution dan correlation
%  ========================================================================

%% 18.1 Sinyal Dasar

fprintf('=== Sinyal Dasar ===\n')

Fs = 1000;               % Sampling frequency (Hz)
T = 1/Fs;                 % Sampling period
t = 0:T:1-T;              % Time vector (1 detik)

% --- Sinusoidal ---
f1 = 50;   % 50 Hz
f2 = 120;  % 120 Hz
sinyal_bersih = 0.7*sin(2*pi*f1*t) + sin(2*pi*f2*t);

% Tambahkan noise
noise = 2*randn(size(t));
sinyal_noisy = sinyal_bersih + noise;

% Plot
figure
subplot(3, 1, 1)
plot(t(1:200), sinyal_bersih(1:200), 'b-', 'LineWidth', 1.5)
title('Sinyal Bersih (50Hz + 120Hz)')
ylabel('Amplitudo'), grid on

subplot(3, 1, 2)
plot(t(1:200), noise(1:200), 'r-')
title('Noise (Random)')
ylabel('Amplitudo'), grid on

subplot(3, 1, 3)
plot(t(1:200), sinyal_noisy(1:200), 'k-')
title('Sinyal + Noise')
xlabel('Waktu (s)'), ylabel('Amplitudo'), grid on

sgtitle('Sinyal Dasar', 'FontSize', 14)

% --- Sinyal lainnya ---
figure

% Square wave
subplot(2, 3, 1)
sq = square(2*pi*10*t);
plot(t(1:200), sq(1:200), 'LineWidth', 1.5)
title('Square Wave'), ylim([-1.5 1.5]), grid on

% Sawtooth wave
subplot(2, 3, 2)
sw = sawtooth(2*pi*10*t);
plot(t(1:200), sw(1:200), 'LineWidth', 1.5)
title('Sawtooth Wave'), grid on

% Impulse
subplot(2, 3, 3)
imp = zeros(size(t));
imp(500) = 1;
stem(t(490:510), imp(490:510), 'filled')
title('Impulse'), grid on

% Chirp (frequency sweep)
subplot(2, 3, 4)
chirp_sig = chirp(t, 10, 1, 200);  % 10Hz to 200Hz
plot(t(1:500), chirp_sig(1:500), 'LineWidth', 1)
title('Chirp Signal'), grid on

% Gaussian pulse
subplot(2, 3, 5)
gauss = exp(-(t-0.5).^2 / (2*0.01^2));
plot(t, gauss, 'LineWidth', 1.5)
title('Gaussian Pulse'), grid on

% AM signal
subplot(2, 3, 6)
carrier = sin(2*pi*200*t);
modulator = 0.5 + 0.5*sin(2*pi*5*t);
am = modulator .* carrier;
plot(t(1:500), am(1:500), 'LineWidth', 1)
title('AM Signal'), grid on

%% 18.2 Fourier Transform (FFT)

fprintf('\n=== FFT ===\n')

% FFT dari sinyal noisy
N = length(sinyal_noisy);
Y = fft(sinyal_noisy);

% Spektrum dua sisi
P2 = abs(Y/N);

% Spektrum satu sisi
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% Frequency axis
f = Fs*(0:(N/2))/N;

figure
subplot(2, 1, 1)
plot(t(1:200), sinyal_noisy(1:200))
title('Sinyal Noisy (Time Domain)')
xlabel('Waktu (s)')
grid on

subplot(2, 1, 2)
plot(f, P1, 'b-', 'LineWidth', 1.5)
title('Spektrum Frekuensi (FFT)')
xlabel('Frekuensi (Hz)')
ylabel('|P1(f)|')
xlim([0 200])
grid on

% Identifikasi puncak frekuensi
[peaks_val, peaks_idx] = findpeaks(P1, 'MinPeakHeight', 0.3);
fprintf('Frekuensi dominan:\n')
for i = 1:length(peaks_idx)
    fprintf('  %.1f Hz (amplitudo: %.3f)\n', f(peaks_idx(i)), peaks_val(i))
end

% --- IFFT: inverse FFT ---
% Rekonstruksi sinyal dari domain frekuensi
Y_filtered = Y;
% Zero-out frekuensi di luar 40-130 Hz
freq_axis = (0:N-1) * Fs / N;
mask = (freq_axis > 40 & freq_axis < 130) | ...
       (freq_axis > Fs-130 & freq_axis < Fs-40);
Y_filtered(~mask) = 0;

sinyal_filtered = real(ifft(Y_filtered));

figure
plot(t(1:200), sinyal_bersih(1:200), 'b-', 'LineWidth', 2)
hold on
plot(t(1:200), sinyal_filtered(1:200), 'r--', 'LineWidth', 1.5)
legend('Asli', 'Filtered via FFT')
title('Rekonstruksi Sinyal via FFT')
grid on

%% 18.3 Filter Design

fprintf('\n=== Filter Design ===\n')

% --- Lowpass filter ---
% Rancang filter Butterworth orde 6, cutoff 100 Hz
order = 6;
Wn = 100 / (Fs/2);  % Normalized frequency (0 to 1, 1 = Nyquist)
[b_lp, a_lp] = butter(order, Wn, 'low');

% Apply filter
y_lowpass = filter(b_lp, a_lp, sinyal_noisy);

% filtfilt: zero-phase filtering (no delay)
y_lowpass_zp = filtfilt(b_lp, a_lp, sinyal_noisy);

figure
subplot(3, 1, 1)
plot(t(1:200), sinyal_noisy(1:200))
title('Sinyal Asli (Noisy)'), grid on

subplot(3, 1, 2)
plot(t(1:200), y_lowpass(1:200), 'r-', 'LineWidth', 1.5)
hold on
plot(t(1:200), sinyal_bersih(1:200), 'b--', 'LineWidth', 1)
title('Lowpass Filtered (< 100 Hz) - hanya 50Hz tersisa')
legend('Filtered', 'Original'), grid on

subplot(3, 1, 3)
plot(t(1:200), y_lowpass_zp(1:200), 'r-', 'LineWidth', 1.5)
hold on
plot(t(1:200), sinyal_bersih(1:200), 'b--', 'LineWidth', 1)
title('Zero-Phase Filtered (filtfilt)')
legend('Filtered', 'Original'), grid on

% --- Frequency response ---
figure
freqz(b_lp, a_lp, 1024, Fs)
title('Frequency Response - Butterworth Lowpass')

% --- Highpass filter ---
[b_hp, a_hp] = butter(order, Wn, 'high');
y_highpass = filtfilt(b_hp, a_hp, sinyal_noisy);

% --- Bandpass filter ---
Wn_bp = [40 130] / (Fs/2);  % 40-130 Hz
[b_bp, a_bp] = butter(4, Wn_bp, 'bandpass');
y_bandpass = filtfilt(b_bp, a_bp, sinyal_noisy);

figure
subplot(2, 1, 1)
plot(t(1:500), y_highpass(1:500), 'LineWidth', 1.5)
title('Highpass (> 100 Hz) - hanya 120Hz tersisa'), grid on

subplot(2, 1, 2)
plot(t(1:500), y_bandpass(1:500), 'LineWidth', 1.5)
hold on
plot(t(1:500), sinyal_bersih(1:500), 'r--')
title('Bandpass (40-130 Hz) - kedua frekuensi tersisa')
legend('Filtered', 'Original'), grid on

% --- FIR filter (menggunakan fir1) ---
n_fir = 50;
b_fir = fir1(n_fir, Wn);   % FIR lowpass
y_fir = filtfilt(b_fir, 1, sinyal_noisy);

% --- Moving average filter ---
window_size = 20;
b_ma = ones(1, window_size) / window_size;
y_ma = filter(b_ma, 1, sinyal_noisy);

%% 18.4 Spektral Analisis

fprintf('\n=== Spektral Analisis ===\n')

% --- Power Spectral Density (PSD) ---
figure

% Metode: periodogram
subplot(2, 1, 1)
[pxx, f_psd] = periodogram(sinyal_noisy, [], [], Fs);
plot(f_psd, 10*log10(pxx), 'LineWidth', 1.5)
title('PSD - Periodogram')
xlabel('Frekuensi (Hz)'), ylabel('Power/Frequency (dB/Hz)')
xlim([0 200]), grid on

% Metode: Welch (lebih smooth)
subplot(2, 1, 2)
[pxx_w, f_w] = pwelch(sinyal_noisy, 256, 128, 256, Fs);
plot(f_w, 10*log10(pxx_w), 'LineWidth', 1.5)
title('PSD - Welch Method')
xlabel('Frekuensi (Hz)'), ylabel('Power/Frequency (dB/Hz)')
xlim([0 200]), grid on

% --- Spectrogram (time-frequency analysis) ---
% Buat sinyal dengan frekuensi berubah (chirp)
t_chirp = 0:1/Fs:2;
chirp_signal = chirp(t_chirp, 10, 2, 400);

figure
spectrogram(chirp_signal, 256, 200, 256, Fs, 'yaxis')
title('Spectrogram - Chirp Signal')
colorbar

%% 18.5 Windowing

fprintf('\n=== Windowing ===\n')

N_win = 64;

% Jenis-jenis window
w_rect = rectwin(N_win);
w_hann = hann(N_win);
w_hamm = hamming(N_win);
w_black = blackman(N_win);
w_kaiser = kaiser(N_win, 5);

figure
subplot(2, 1, 1)
plot(w_rect, 'LineWidth', 1.5), hold on
plot(w_hann, 'LineWidth', 1.5)
plot(w_hamm, 'LineWidth', 1.5)
plot(w_black, 'LineWidth', 1.5)
plot(w_kaiser, 'LineWidth', 1.5)
legend('Rectangular', 'Hanning', 'Hamming', 'Blackman', 'Kaiser')
title('Window Functions'), grid on

subplot(2, 1, 2)
[H_rect, f_w] = freqz(w_rect, 1, 512);
[H_hann, ~] = freqz(w_hann, 1, 512);
[H_hamm, ~] = freqz(w_hamm, 1, 512);

plot(f_w/pi, 20*log10(abs(H_rect)/max(abs(H_rect))), 'LineWidth', 1.5), hold on
plot(f_w/pi, 20*log10(abs(H_hann)/max(abs(H_hann))), 'LineWidth', 1.5)
plot(f_w/pi, 20*log10(abs(H_hamm)/max(abs(H_hamm))), 'LineWidth', 1.5)
legend('Rectangular', 'Hanning', 'Hamming')
title('Frequency Response of Windows')
ylabel('Magnitude (dB)'), xlabel('Normalized Frequency')
ylim([-80 5]), grid on

%% 18.6 Convolution dan Correlation

fprintf('\n=== Convolution & Correlation ===\n')

% --- Convolution ---
x = [1 2 3 4 5];
h = [1 1 1] / 3;    % moving average kernel

y_conv = conv(x, h, 'full');    % full convolution
y_same = conv(x, h, 'same');    % same size as x
y_valid = conv(x, h, 'valid');  % valid region only

fprintf('x     = '), disp(x)
fprintf('h     = '), disp(h)
fprintf('full  = '), disp(y_conv)
fprintf('same  = '), disp(y_same)
fprintf('valid = '), disp(y_valid)

% --- Cross-correlation ---
% Mendeteksi delay antara dua sinyal
t_cc = 0:1/Fs:0.1;
sig1 = sin(2*pi*50*t_cc);
sig2 = sin(2*pi*50*(t_cc - 0.01));  % delayed 10ms

[r, lags] = xcorr(sig1, sig2);
[~, max_idx] = max(r);
delay = lags(max_idx) / Fs;
fprintf('Detected delay: %.4f s (actual: 0.01 s)\n', delay)

figure
subplot(2, 1, 1)
plot(t_cc, sig1, 'b-', t_cc, sig2, 'r--', 'LineWidth', 1.5)
legend('Signal 1', 'Signal 2 (delayed)')
title('Two Signals'), grid on

subplot(2, 1, 2)
plot(lags/Fs, r, 'LineWidth', 1.5)
title('Cross-Correlation')
xlabel('Lag (s)'), ylabel('Correlation')
grid on

% --- Autocorrelation ---
[r_auto, lags_auto] = xcorr(sinyal_bersih, 'normalized');

figure
plot(lags_auto/Fs, r_auto, 'LineWidth', 1.5)
title('Autocorrelation')
xlabel('Lag (s)'), ylabel('Normalized Correlation')
xlim([-0.1 0.1])
grid on

%% Ringkasan Bab 18
% ==================
% - Sinyal dasar: sinusoidal, square, sawtooth, chirp
% - FFT/IFFT: transformasi domain waktu <-> frekuensi
% - Filter: Butterworth, FIR, moving average, filter/filtfilt
% - PSD: periodogram, pwelch, spectrogram
% - Windowing: hann, hamming, blackman, kaiser
% - Convolution: conv, xcorr (cross/auto-correlation)

disp('=== Bab 18: Signal Processing - Selesai! ===')
