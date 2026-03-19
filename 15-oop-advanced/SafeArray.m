classdef SafeArray < handle
    % SAFEARRAY Custom container dengan safe indexing
    %   Out-of-bounds access mengembalikan 0 daripada error

    properties (Access = private)
        Data (1,:) double
    end

    methods
        function obj = SafeArray(data)
            obj.Data = data;
        end

        function val = subsref(obj, s)
            switch s(1).type
                case '()'
                    idx = s(1).subs{1};
                    if idx >= 1 && idx <= length(obj.Data)
                        val = obj.Data(idx);
                    else
                        val = 0;  % safe default
                    end
                case '.'
                    val = builtin('subsref', obj, s);
                otherwise
                    error('Unsupported indexing')
            end
        end

        function obj = subsasgn(obj, s, val)
            switch s(1).type
                case '()'
                    idx = s(1).subs{1};
                    if idx >= 1
                        if idx > length(obj.Data)
                            obj.Data(end+1:idx) = 0;  % extend with zeros
                        end
                        obj.Data(idx) = val;
                    end
                case '.'
                    obj = builtin('subsasgn', obj, s, val);
                otherwise
                    error('Unsupported indexing')
            end
        end

        function display(obj)
            fprintf('SafeArray: ')
            disp(obj.Data)
        end

        function n = length(obj)
            n = length(obj.Data);
        end
    end
end
