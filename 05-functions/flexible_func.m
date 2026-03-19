function [out1, out2] = flexible_func(a, b)
% FLEXIBLE_FUNC Demonstrasi nargin dan nargout
%   flexible_func(a)       - hanya satu input
%   flexible_func(a, b)    - dua input
%   [x, y] = flexible_func(a, b) - dua output

    if nargin < 2
        b = 1;  % default value
        fprintf('Hanya satu input, b default = %d\n', b)
    end

    out1 = a + b;
    out2 = a * b;

    if nargout == 0
        fprintf('Hasil: a+b = %d, a*b = %d\n', out1, out2)
    elseif nargout == 1
        fprintf('Hanya mengembalikan a+b = %d\n', out1)
    end
end
