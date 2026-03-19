%% ========================================================================
%  BAB 12: ADVANCED FUNCTIONS
%  Tutorial MATLAB Lengkap - Dari Dasar hingga Advanced
%  ========================================================================
%  Topik:
%    12.1 varargin & varargout
%    12.2 Name-value pair arguments
%    12.3 Nested functions & closures
%    12.4 Function handles lanjutan
%    12.5 Callbacks
%    12.6 Decorators/wrappers
%    12.7 Memoization
%    12.8 arguments block (R2019b+)
%  ========================================================================

%% 12.1 varargin & varargout

% varargin: menerima jumlah input variabel (cell array)
% varargout: mengembalikan jumlah output variabel

% --- Contoh: fungsi yang menerima input variabel ---
function result = jumlahkan(varargin)
    result = 0;
    for i = 1:nargin
        result = result + varargin{i};
    end
end

fprintf('jumlahkan(1,2) = %d\n', jumlahkan(1, 2))
fprintf('jumlahkan(1,2,3,4,5) = %d\n', jumlahkan(1, 2, 3, 4, 5))

% --- Contoh: fungsi dengan parameter wajib + opsional ---
function displayInfo(nama, varargin)
    fprintf('Nama: %s\n', nama)
    if nargin >= 2
        fprintf('Umur: %d\n', varargin{1})
    end
    if nargin >= 3
        fprintf('Kota: %s\n', varargin{2})
    end
end

displayInfo('Budi')
displayInfo('Ani', 23)
displayInfo('Charlie', 28, 'Jakarta')

% --- varargout: output variabel ---
function varargout = multiple_stats(data)
    varargout{1} = mean(data);     % selalu dikembalikan
    if nargout >= 2
        varargout{2} = std(data);
    end
    if nargout >= 3
        varargout{3} = median(data);
    end
    if nargout >= 4
        varargout{4} = mode(data);
    end
end

data = [1 2 2 3 4 5 5 5 6 7];
[m] = multiple_stats(data);
fprintf('\nMean: %.2f\n', m)

[m, s, med] = multiple_stats(data);
fprintf('Mean: %.2f, Std: %.2f, Median: %.1f\n', m, s, med)

%% 12.2 Name-Value Pair Arguments

% Pattern klasik untuk name-value pairs menggunakan varargin

function plotData(x, y, varargin)
    % Default values
    color = 'b';
    lineWidth = 1;
    marker = 'none';
    titleStr = '';

    % Parse name-value pairs
    for i = 1:2:length(varargin)
        switch lower(varargin{i})
            case 'color'
                color = varargin{i+1};
            case 'linewidth'
                lineWidth = varargin{i+1};
            case 'marker'
                marker = varargin{i+1};
            case 'title'
                titleStr = varargin{i+1};
            otherwise
                error('Unknown parameter: %s', varargin{i})
        end
    end

    fprintf('Plotting: color=%s, lineWidth=%d, marker=%s\n', ...
        color, lineWidth, marker)
    if ~isempty(titleStr)
        fprintf('Title: %s\n', titleStr)
    end
end

plotData(1:10, rand(1,10), 'Color', 'red', 'LineWidth', 2, 'Title', 'Demo')

% --- Menggunakan inputParser (lebih robust) ---
function result = parseDemo(x, varargin)
    p = inputParser;

    % Required
    addRequired(p, 'x', @isnumeric);

    % Optional positional
    addOptional(p, 'y', 0, @isnumeric);

    % Name-value pairs
    addParameter(p, 'Method', 'linear', ...
        @(s) any(validatestring(s, {'linear', 'cubic', 'spline'})));
    addParameter(p, 'Verbose', false, @islogical);
    addParameter(p, 'MaxIter', 100, @(x) isnumeric(x) && x > 0);

    parse(p, x, varargin{:});

    fprintf('x = %g, y = %g\n', p.Results.x, p.Results.y)
    fprintf('Method = %s, Verbose = %d, MaxIter = %d\n', ...
        p.Results.Method, p.Results.Verbose, p.Results.MaxIter)

    result = p.Results;
end

fprintf('\n--- inputParser demo ---\n')
parseDemo(5)
parseDemo(5, 3, 'Method', 'cubic', 'Verbose', true)

%% 12.3 Nested Functions & Closures

% Nested function bisa mengakses variabel dari parent function
function result = outerFunction(x)
    multiplier = 3;   % variabel outer

    function y = innerFunction(val)
        y = val * multiplier;   % akses variabel outer
    end

    result = innerFunction(x) + innerFunction(x+1);
end

fprintf('\nouterFunction(5) = %d\n', outerFunction(5))
% (5*3) + (6*3) = 15 + 18 = 33

% --- Closure: mengembalikan function handle ke nested function ---
function f = createMultiplier(factor)
    function result = multiply(x)
        result = x * factor;
    end
    f = @multiply;
end

double_it = createMultiplier(2);
triple_it = createMultiplier(3);
fprintf('double(5) = %d\n', double_it(5))    % 10
fprintf('triple(5) = %d\n', triple_it(5))    % 15

% --- Counter using closure ---
function [increment, getCount, resetCount] = createCounter()
    count = 0;

    function increment()
        count = count + 1;
    end

    function c = getCount()
        c = count;
    end

    function resetCount()
        count = 0;
    end
end

% Demo counter (dalam konteks function)
% [inc, get, reset] = createCounter();
% inc(); inc(); inc();
% fprintf('Count: %d\n', get());   % 3

%% 12.4 Function Handles Lanjutan

% --- Menyimpan function handles dalam struct ---
math = struct();
math.add = @(a, b) a + b;
math.sub = @(a, b) a - b;
math.mul = @(a, b) a * b;
math.div = @(a, b) a / b;

fprintf('\nMath operations:\n')
fprintf('5 + 3 = %d\n', math.add(5, 3))
fprintf('5 - 3 = %d\n', math.sub(5, 3))
fprintf('5 * 3 = %d\n', math.mul(5, 3))
fprintf('5 / 3 = %.2f\n', math.div(5, 3))

% --- Higher-order functions ---
function result = apply(func, data)
    result = func(data);
end

fprintf('Sum: %d\n', apply(@sum, [1 2 3 4 5]))
fprintf('Max: %d\n', apply(@max, [1 2 3 4 5]))

% --- Map, Filter, Reduce patterns ---
% Map: arrayfun / cellfun
data = [1 2 3 4 5];
squared = arrayfun(@(x) x^2, data);
fprintf('Map (square): ')
disp(squared)

% Filter: logical indexing
even = data(arrayfun(@(x) mod(x,2)==0, data));
fprintf('Filter (even): ')
disp(even)

% Reduce: manual implementation
function result = reduce(func, data, initial)
    result = initial;
    for i = 1:length(data)
        result = func(result, data(i));
    end
end

total = reduce(@(acc, x) acc + x, [1 2 3 4 5], 0);
fprintf('Reduce (sum): %d\n', total)

product = reduce(@(acc, x) acc * x, [1 2 3 4 5], 1);
fprintf('Reduce (product): %d\n', product)

% --- Composing functions ---
function h = compose(f, g)
    h = @(x) f(g(x));
end

sincos = compose(@sin, @cos);
fprintf('sin(cos(pi)) = %.4f\n', sincos(pi))

% Chain multiple functions
function h = pipeline(varargin)
    h = varargin{1};
    for i = 2:length(varargin)
        h = compose(varargin{i}, h);
    end
end

% abs(round(sin(x)))
transform = pipeline(@sin, @round, @abs);
fprintf('pipeline(pi/4) = %d\n', transform(pi/4))

%% 12.5 Callbacks

% Callback = fungsi yang dipanggil saat event tertentu terjadi
% Banyak dipakai di GUI dan timer

% --- Timer callback ---
% t = timer('TimerFcn', @(~,~) disp('Tick!'), ...
%           'Period', 1, ...
%           'ExecutionMode', 'fixedRate');
% start(t)
% pause(3)
% stop(t)
% delete(t)

% --- Custom event system ---
function eventSystem()
    listeners = containers.Map();

    function on(event, callback)
        if ~isKey(listeners, event)
            listeners(event) = {};
        end
        cbs = listeners(event);
        cbs{end+1} = callback;
        listeners(event) = cbs;
    end

    function emit(event, data)
        if isKey(listeners, event)
            cbs = listeners(event);
            for i = 1:length(cbs)
                cbs{i}(data);
            end
        end
    end

    % Register callbacks
    on('data', @(d) fprintf('Listener 1: received %d\n', d));
    on('data', @(d) fprintf('Listener 2: received %d\n', d));

    % Emit event
    emit('data', 42);
end

fprintf('\n--- Event System ---\n')
eventSystem()

%% 12.6 Decorator/Wrapper Pattern

% --- Timing wrapper ---
function wrappedFunc = withTiming(func, funcName)
    if nargin < 2
        funcName = func2str(func);
    end

    function varargout = timedFunc(varargin)
        tic;
        [varargout{1:nargout}] = func(varargin{:});
        elapsed = toc;
        fprintf('[%s] Elapsed: %.4f s\n', funcName, elapsed)
    end

    wrappedFunc = @timedFunc;
end

% Logging wrapper
function wrappedFunc = withLogging(func, funcName)
    if nargin < 2
        funcName = func2str(func);
    end

    function varargout = loggedFunc(varargin)
        fprintf('[LOG] Calling %s with %d args\n', funcName, nargin)
        [varargout{1:nargout}] = func(varargin{:});
        fprintf('[LOG] %s completed\n', funcName)
    end

    wrappedFunc = @loggedFunc;
end

% Demo
fprintf('\n--- Decorator Pattern ---\n')
timedSort = withTiming(@sort, 'sort');
result = timedSort(rand(1, 100000));

%% 12.7 Memoization

% Cache hasil komputasi untuk menghindari perhitungan ulang

function func = memoize_func(original_func)
    cache = containers.Map('KeyType', 'char', 'ValueType', 'any');

    function result = cachedFunc(varargin)
        key = mat2str(cell2mat(varargin));  % sederhana, untuk numerik
        if isKey(cache, key)
            result = cache(key);
            fprintf('(cached) ')
        else
            result = original_func(varargin{:});
            cache(key) = result;
        end
    end

    func = @cachedFunc;
end

% MATLAB juga punya memoize() bawaan (R2017a+)
% memoizedFcn = memoize(@expensiveFunction);

% Demo sederhana
fprintf('\n--- Memoization ---\n')
slow_square = @(x) (pause(0.1) + x^2 + 0*disp('Computing...'));
memo_square = memoize_func(@(x) x^2);

fprintf('memo_square(5) = %d\n', memo_square(5))     % compute
fprintf('memo_square(5) = %d\n', memo_square(5))     % cached!
fprintf('memo_square(10) = %d\n', memo_square(10))   % compute

%% 12.8 arguments Block (R2019b+)

% Cara modern dan elegan untuk validasi input

function result = modernFunc(x, y, options)
    arguments
        x (1,:) double {mustBePositive}
        y (1,1) double {mustBeFinite} = 1
        options.Method (1,1) string {mustBeMember(options.Method, ["linear","cubic","spline"])} = "linear"
        options.Tolerance (1,1) double {mustBePositive} = 1e-6
        options.Verbose (1,1) logical = false
    end

    if options.Verbose
        fprintf('x = [%s], y = %g\n', num2str(x), y)
        fprintf('Method = %s, Tol = %g\n', options.Method, options.Tolerance)
    end

    result = sum(x) * y;
end

fprintf('\n--- arguments block demo ---\n')
r1 = modernFunc([1 2 3]);
fprintf('r1 = %d\n', r1)

r2 = modernFunc([1 2 3], 2, 'Method', 'cubic', 'Verbose', true);
fprintf('r2 = %d\n', r2)

%% Ringkasan Bab 12
% ==================
% - varargin/varargout: input/output jumlah variabel
% - Name-value pairs: inputParser atau manual parsing
% - Nested functions: closure, akses variabel parent
% - Function handles: higher-order, compose, pipeline
% - Callbacks: event-driven programming
% - Decorators: wrapping functions (timing, logging)
% - Memoization: caching hasil komputasi
% - arguments block: validasi input modern (R2019b+)

disp('=== Bab 12: Advanced Functions - Selesai! ===')
