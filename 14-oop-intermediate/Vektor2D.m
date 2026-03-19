classdef Vektor2D
    % VEKTOR2D Demonstrasi operator overloading
    %   Representasi vektor 2D dengan overloaded operators

    properties
        X (1,1) double = 0
        Y (1,1) double = 0
    end

    methods
        function obj = Vektor2D(x, y)
            if nargin >= 1, obj.X = x; end
            if nargin >= 2, obj.Y = y; end
        end

        % --- Operator overloading ---

        % +
        function result = plus(a, b)
            result = Vektor2D(a.X + b.X, a.Y + b.Y);
        end

        % -
        function result = minus(a, b)
            result = Vektor2D(a.X - b.X, a.Y - b.Y);
        end

        % * (dot product atau scalar multiplication)
        function result = mtimes(a, b)
            if isa(a, 'Vektor2D') && isa(b, 'Vektor2D')
                % Dot product
                result = a.X * b.X + a.Y * b.Y;
            elseif isa(a, 'Vektor2D') && isnumeric(b)
                % Scalar multiplication
                result = Vektor2D(a.X * b, a.Y * b);
            elseif isnumeric(a) && isa(b, 'Vektor2D')
                result = Vektor2D(a * b.X, a * b.Y);
            end
        end

        % Unary minus (-v)
        function result = uminus(obj)
            result = Vektor2D(-obj.X, -obj.Y);
        end

        % ==
        function result = eq(a, b)
            result = (a.X == b.X) && (a.Y == b.Y);
        end

        % ~=
        function result = ne(a, b)
            result = ~eq(a, b);
        end

        % < (berdasarkan magnitude)
        function result = lt(a, b)
            result = a.magnitude() < b.magnitude();
        end

        % > (berdasarkan magnitude)
        function result = gt(a, b)
            result = a.magnitude() > b.magnitude();
        end

        % --- Methods ---
        function m = magnitude(obj)
            m = sqrt(obj.X^2 + obj.Y^2);
        end

        function n = normalize(obj)
            m = obj.magnitude();
            if m == 0
                error('Cannot normalize zero vector')
            end
            n = Vektor2D(obj.X/m, obj.Y/m);
        end

        function a = angle(obj)
            a = atan2(obj.Y, obj.X);
        end

        function result = cross2D(a, b)
            % Cross product (scalar in 2D)
            result = a.X * b.Y - a.Y * b.X;
        end

        % --- Display ---
        function disp(obj)
            fprintf('(%g, %g)\n', obj.X, obj.Y)
        end

        function str = char(obj)
            str = sprintf('(%g, %g)', obj.X, obj.Y);
        end
    end
end
