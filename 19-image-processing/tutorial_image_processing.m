%% ========================================================================
%  BAB 19: IMAGE PROCESSING
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Memerlukan: Image Processing Toolbox
%  Topik:
%    19.1 Membaca dan menampilkan gambar
%    19.2 Konversi warna
%    19.3 Transformasi geometri
%    19.4 Image enhancement
%    19.5 Filtering (spatial & frequency)
%    19.6 Segmentasi dan deteksi tepi
%    19.7 Morphological operations
%  ========================================================================

%% 19.1 Membaca dan Menampilkan Gambar

fprintf('=== Image Processing Basics ===\n')

% --- Membuat gambar test (karena tidak ada file gambar) ---
% Membuat gambar sintetis
img_gray = uint8(peaks(256) * 20 + 128);  % grayscale

% Membuat gambar RGB
[X, Y] = meshgrid(linspace(-3, 3, 256));
R = uint8(exp(-(X.^2 + Y.^2)/2) * 255);
G = uint8(exp(-((X-1).^2 + Y.^2)/2) * 255);
B = uint8(exp(-((X+1).^2 + (Y+1).^2)/2) * 255);
img_rgb = cat(3, R, G, B);

% --- Menampilkan gambar ---
figure
subplot(1, 2, 1)
imshow(img_gray)
title('Grayscale Image')
colorbar

subplot(1, 2, 2)
imshow(img_rgb)
title('RGB Image')

% --- Informasi gambar ---
fprintf('Grayscale: size=%s, class=%s\n', mat2str(size(img_gray)), class(img_gray))
fprintf('RGB:       size=%s, class=%s\n', mat2str(size(img_rgb)), class(img_rgb))
fprintf('Min=%d, Max=%d\n', min(img_gray(:)), max(img_gray(:)))

% --- Membaca gambar dari file ---
% img = imread('photo.jpg');         % baca gambar
% imwrite(img, 'output.png');        % simpan gambar
% info = imfinfo('photo.jpg');       % informasi file gambar

% Simpan gambar test
imwrite(img_gray, 'test_gray.png');
imwrite(img_rgb, 'test_rgb.png');
fprintf('Gambar test disimpan\n')

%% 19.2 Konversi Warna

fprintf('\n=== Konversi Warna ===\n')

% --- RGB ke Grayscale ---
gray_from_rgb = rgb2gray(img_rgb);

% --- Manual: weighted average ---
gray_manual = uint8(0.299*double(R) + 0.587*double(G) + 0.114*double(B));

figure
subplot(2, 2, 1)
imshow(img_rgb), title('RGB Original')

subplot(2, 2, 2)
imshow(gray_from_rgb), title('Grayscale (rgb2gray)')

% --- RGB ke HSV ---
img_hsv = rgb2hsv(img_rgb);

subplot(2, 2, 3)
imshow(img_hsv(:,:,1)), title('Hue')

subplot(2, 2, 4)
imshow(img_hsv(:,:,3)), title('Value')

% --- Grayscale ke Binary ---
threshold = 128;
img_binary = img_gray > threshold;
% Atau gunakan: img_binary = imbinarize(img_gray);
% Otsu's method: img_binary = imbinarize(img_gray, 'adaptive');

figure
subplot(1, 2, 1), imshow(img_gray), title('Grayscale')
subplot(1, 2, 2), imshow(img_binary), title('Binary')

%% 19.3 Transformasi Geometri

fprintf('\n=== Transformasi Geometri ===\n')

% --- Resize ---
img_half = imresize(img_gray, 0.5);        % setengah ukuran
img_double = imresize(img_gray, 2);         % dua kali ukuran
img_specific = imresize(img_gray, [100 200]); % ukuran spesifik

fprintf('Original: %s\n', mat2str(size(img_gray)))
fprintf('Half:     %s\n', mat2str(size(img_half)))
fprintf('Double:   %s\n', mat2str(size(img_double)))

% --- Rotate ---
img_rot45 = imrotate(img_gray, 45);           % rotasi 45 derajat
img_rot45_crop = imrotate(img_gray, 45, 'crop'); % rotasi dengan crop

figure
subplot(1, 3, 1), imshow(img_gray), title('Original')
subplot(1, 3, 2), imshow(img_rot45), title('Rotated 45°')
subplot(1, 3, 3), imshow(img_rot45_crop), title('Rotated 45° (Cropped)')

% --- Flip ---
img_fliph = fliplr(img_gray);   % flip horizontal
img_flipv = flipud(img_gray);   % flip vertical

% --- Crop ---
img_crop = img_gray(50:200, 50:200);  % crop region

% --- Affine transform ---
% tform = affine2d([1 0 0; 0.5 1 0; 0 0 1]);  % shear
% img_shear = imwarp(img_gray, tform);

%% 19.4 Image Enhancement

fprintf('\n=== Image Enhancement ===\n')

% Buat gambar gelap untuk demo enhancement
img_dark = uint8(double(img_gray) * 0.3);

figure('Position', [100 100 1000 600])

% --- Brightness adjustment ---
subplot(2, 3, 1)
imshow(img_dark), title('Gelap (Original)')

% imadjust: contrast stretching
subplot(2, 3, 2)
img_adjusted = imadjust(img_dark);
imshow(img_adjusted), title('imadjust')

% --- Histogram equalization ---
subplot(2, 3, 3)
img_histeq = histeq(img_dark);
imshow(img_histeq), title('Histogram Equalization')

% --- Adaptive histogram equalization ---
subplot(2, 3, 4)
img_adapteq = adapthisteq(img_dark);
imshow(img_adapteq), title('Adaptive Hist. Eq. (CLAHE)')

% --- Histogram ---
subplot(2, 3, 5)
imhist(img_dark)
title('Histogram (Gelap)')

subplot(2, 3, 6)
imhist(img_histeq)
title('Histogram (Equalized)')

% --- Noise removal ---
% Tambahkan noise
img_noisy = imnoise(img_gray, 'gaussian', 0, 0.02);
img_sp = imnoise(img_gray, 'salt & pepper', 0.05);

figure
subplot(2, 3, 1)
imshow(img_noisy), title('Gaussian Noise')

subplot(2, 3, 2)
imshow(imgaussfilt(img_noisy, 2)), title('Gaussian Filter')

subplot(2, 3, 3)
imshow(medfilt2(img_noisy, [5 5])), title('Median Filter')

subplot(2, 3, 4)
imshow(img_sp), title('Salt & Pepper Noise')

subplot(2, 3, 5)
imshow(medfilt2(img_sp, [3 3])), title('Median Filter 3x3')

subplot(2, 3, 6)
imshow(medfilt2(img_sp, [5 5])), title('Median Filter 5x5')

sgtitle('Noise Removal', 'FontSize', 14)

%% 19.5 Filtering (Spatial & Frequency)

fprintf('\n=== Image Filtering ===\n')

% --- Spatial filtering: konvolusi dengan kernel ---

% Blur (rata-rata)
kernel_avg = ones(5) / 25;
img_blur = imfilter(img_gray, kernel_avg);

% Gaussian blur
img_gauss = imgaussfilt(img_gray, 3);  % sigma = 3

% Sharpen
kernel_sharp = [0 -1 0; -1 5 -1; 0 -1 0];
img_sharp = imfilter(img_gray, kernel_sharp);

% Emboss
kernel_emboss = [-2 -1 0; -1 1 1; 0 1 2];
img_emboss = imfilter(img_gray, kernel_emboss);

figure
subplot(2, 3, 1), imshow(img_gray), title('Original')
subplot(2, 3, 2), imshow(img_blur), title('Average Blur')
subplot(2, 3, 3), imshow(img_gauss), title('Gaussian Blur')
subplot(2, 3, 4), imshow(img_sharp), title('Sharpened')
subplot(2, 3, 5), imshow(img_emboss + 128), title('Emboss')

% --- Frequency domain filtering ---
subplot(2, 3, 6)
F = fft2(double(img_gray));
F_shift = fftshift(F);
magnitude = log(1 + abs(F_shift));
imshow(magnitude, []), title('FFT Magnitude')
colormap(gca, 'jet'), colorbar

%% 19.6 Segmentasi dan Deteksi Tepi

fprintf('\n=== Edge Detection & Segmentation ===\n')

% --- Edge detection ---
figure

subplot(2, 3, 1)
imshow(img_gray), title('Original')

subplot(2, 3, 2)
edge_sobel = edge(img_gray, 'Sobel');
imshow(edge_sobel), title('Sobel')

subplot(2, 3, 3)
edge_canny = edge(img_gray, 'Canny');
imshow(edge_canny), title('Canny')

subplot(2, 3, 4)
edge_prewitt = edge(img_gray, 'Prewitt');
imshow(edge_prewitt), title('Prewitt')

subplot(2, 3, 5)
edge_log = edge(img_gray, 'log');
imshow(edge_log), title('Laplacian of Gaussian')

% --- Gradient ---
subplot(2, 3, 6)
[Gx, Gy] = imgradientxy(img_gray);
[Gmag, Gdir] = imgradient(Gx, Gy);
imshow(Gmag, []), title('Gradient Magnitude')

sgtitle('Edge Detection Methods', 'FontSize', 14)

% --- Segmentasi ---
% Buat gambar dengan objek untuk segmentasi
img_objects = zeros(256, 256, 'uint8');
img_objects(50:100, 50:100) = 200;      % kotak
img_objects(150:200, 150:200) = 150;    % kotak lain

% Tambahkan lingkaran
[xx, yy] = meshgrid(1:256, 1:256);
circle_mask = ((xx-180).^2 + (yy-80).^2) < 30^2;
img_objects(circle_mask) = 255;

img_objects = imnoise(img_objects, 'gaussian', 0, 0.01);

figure
subplot(2, 2, 1)
imshow(img_objects), title('Gambar dengan Objek')

% Thresholding
subplot(2, 2, 2)
level = graythresh(img_objects);  % Otsu's method
img_bw = imbinarize(img_objects, level);
imshow(img_bw), title(sprintf('Otsu Threshold (%.2f)', level))

% Label connected components
subplot(2, 2, 3)
[L, num] = bwlabel(img_bw);
imshow(label2rgb(L, 'jet', 'k'))
title(sprintf('Connected Components (%d)', num))

% Properties of regions
props = regionprops(L, 'Area', 'Centroid', 'BoundingBox');
subplot(2, 2, 4)
imshow(img_objects), hold on
for i = 1:length(props)
    bb = props(i).BoundingBox;
    rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 2)
    text(props(i).Centroid(1), props(i).Centroid(2), ...
        sprintf('%d', i), 'Color', 'r', 'FontSize', 14, 'FontWeight', 'bold')
end
title('Detected Objects')

%% 19.7 Morphological Operations

fprintf('\n=== Morphological Operations ===\n')

% Buat gambar binary
img_morph = img_bw;

% Structuring element
se_disk = strel('disk', 5);
se_square = strel('square', 5);

figure
subplot(2, 3, 1)
imshow(img_morph), title('Original Binary')

% Erosion: mengecilkan objek
subplot(2, 3, 2)
imshow(imerode(img_morph, se_disk)), title('Erode')

% Dilation: membesarkan objek
subplot(2, 3, 3)
imshow(imdilate(img_morph, se_disk)), title('Dilate')

% Opening: erode lalu dilate (hapus noise kecil)
subplot(2, 3, 4)
imshow(imopen(img_morph, se_disk)), title('Opening')

% Closing: dilate lalu erode (isi lubang kecil)
subplot(2, 3, 5)
imshow(imclose(img_morph, se_disk)), title('Closing')

% Fill holes
subplot(2, 3, 6)
imshow(imfill(img_morph, 'holes')), title('Fill Holes')

sgtitle('Morphological Operations', 'FontSize', 14)

%% Ringkasan Bab 19
% ==================
% - imread/imshow/imwrite: baca, tampilkan, simpan
% - rgb2gray, im2bw, imbinarize: konversi warna
% - imresize, imrotate, imcrop: transformasi geometri
% - imadjust, histeq, adapthisteq: enhancement
% - imfilter, imgaussfilt, medfilt2: filtering
% - edge (Sobel, Canny): deteksi tepi
% - bwlabel, regionprops: segmentasi
% - imerode, imdilate, imopen, imclose: morphology

disp('=== Bab 19: Image Processing - Selesai! ===')
