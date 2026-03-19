classdef QueryBuilder < handle
    % QUERYBUILDER Builder Pattern untuk membangun SQL query

    properties (Access = private)
        SelectClause (1,1) string = "*"
        FromClause (1,1) string = ""
        WhereClauses (:,1) string = strings(0)
        OrderByClause (1,1) string = ""
        LimitValue (1,1) double = 0
    end

    methods
        function obj = select(obj, fields)
            obj.SelectClause = fields;
        end

        function obj = from(obj, table)
            obj.FromClause = table;
        end

        function obj = where(obj, condition)
            obj.WhereClauses(end+1) = condition;
        end

        function obj = orderBy(obj, order)
            obj.OrderByClause = order;
        end

        function obj = limit(obj, n)
            obj.LimitValue = n;
        end

        function query = build(obj)
            query = sprintf("SELECT %s FROM %s", obj.SelectClause, obj.FromClause);

            if ~isempty(obj.WhereClauses)
                query = query + " WHERE " + join(obj.WhereClauses, " AND ");
            end

            if obj.OrderByClause ~= ""
                query = query + " ORDER BY " + obj.OrderByClause;
            end

            if obj.LimitValue > 0
                query = query + sprintf(" LIMIT %d", obj.LimitValue);
            end
        end
    end
end
