classdef QuickSortStrategy
    % QUICKSORTSTRATEGY Strategy implementasi quick sort

    methods
        function result = sort(obj, data)
            result = obj.quicksort(data);
        end
    end

    methods (Access = private)
        function result = quicksort(obj, arr)
            if length(arr) <= 1
                result = arr;
                return
            end

            pivot = arr(1);
            left = arr(arr < pivot);
            middle = arr(arr == pivot);
            right = arr(arr > pivot);

            result = [obj.quicksort(left), middle, obj.quicksort(right)];
        end
    end
end
