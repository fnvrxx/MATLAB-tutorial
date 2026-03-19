classdef DataObject < Serializable & Printable
    % DATAOBJECT Demonstrasi multiple inheritance (interfaces)

    properties
        Nama (1,1) string
        Data
    end

    methods
        function obj = DataObject(nama, data)
            obj.Nama = nama;
            obj.Data = data;
        end

        % Implementasi Serializable
        function json = serialize(obj)
            s = struct('nama', char(obj.Nama), 'data', obj.Data);
            json = jsonencode(s);
        end

        % Implementasi Printable
        function printToConsole(obj)
            fprintf('[DataObject] %s: ', obj.Nama)
            disp(obj.Data)
        end
    end

    methods (Static)
        function obj = deserialize(json)
            s = jsondecode(json);
            obj = DataObject(string(s.nama), s.data);
        end
    end
end
