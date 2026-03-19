classdef (Abstract) Serializable
    % SERIALIZABLE Interface untuk objek yang bisa di-serialize

    methods (Abstract)
        json = serialize(obj)
    end

    methods (Static, Abstract)
        obj = deserialize(json)
    end
end
