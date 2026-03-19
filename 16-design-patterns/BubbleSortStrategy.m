classdef BubbleSortStrategy
    % BUBBLESORTSTRATEGY Strategy implementasi bubble sort

    methods
        function result = sort(~, data)
            result = data;
            n = length(result);
            for i = 1:n-1
                for j = 1:n-i
                    if result(j) > result(j+1)
                        temp = result(j);
                        result(j) = result(j+1);
                        result(j+1) = temp;
                    end
                end
            end
        end
    end
end
