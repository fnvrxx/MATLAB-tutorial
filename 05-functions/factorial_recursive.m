function result = factorial_recursive(n)
% FACTORIAL_RECURSIVE Menghitung faktorial secara rekursif
%   result = FACTORIAL_RECURSIVE(n)
%
%   Base case: 0! = 1, 1! = 1
%   Recursive case: n! = n * (n-1)!

    if n < 0
        error('Input harus non-negatif')
    end

    if n <= 1
        result = 1;     % base case
    else
        result = n * factorial_recursive(n - 1);    % recursive case
    end
end
