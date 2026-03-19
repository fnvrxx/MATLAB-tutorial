function result = terapkan_fungsi(func, data)
% TERAPKAN_FUNGSI Menerapkan function handle ke data
%   result = TERAPKAN_FUNGSI(func, data)
%
%   Input:
%       func - function handle
%       data - array numerik
%   Output:
%       result - hasil penerapan fungsi

    result = func(data);
end
