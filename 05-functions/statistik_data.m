function [rata, stdev, minVal, maxVal] = statistik_data(data)
% STATISTIK_DATA Menghitung statistik dasar dari data
%   [rata, stdev, minVal, maxVal] = STATISTIK_DATA(data)
%
%   Input:
%       data - array numerik
%   Output:
%       rata   - rata-rata
%       stdev  - standar deviasi
%       minVal - nilai minimum
%       maxVal - nilai maksimum

    rata   = mean(data);
    stdev  = std(data);
    minVal = min(data);
    maxVal = max(data);
end
