function result = fibonacci_recursive(n)
% FIBONACCI_RECURSIVE Menghitung bilangan Fibonacci ke-n secara rekursif
%   result = FIBONACCI_RECURSIVE(n)
%
%   Catatan: Ini TIDAK efisien untuk n besar karena O(2^n)
%   Untuk n besar, gunakan iterasi atau memoization

    if n <= 0
        error('Input harus positif')
    end

    if n <= 2
        result = 1;     % base case: fib(1) = fib(2) = 1
    else
        result = fibonacci_recursive(n-1) + fibonacci_recursive(n-2);
    end
end
