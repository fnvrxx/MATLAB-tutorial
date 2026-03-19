classdef DatabaseConnection < handle
    % DATABASECONNECTION Singleton Pattern
    %   Hanya satu instance koneksi database

    properties (SetAccess = private)
        ConnectionID (1,1) string
        IsConnected (1,1) logical = false
    end

    methods (Access = private)
        function obj = DatabaseConnection()
            obj.ConnectionID = sprintf("DB-%04d", randi(9999));
            obj.IsConnected = true;
            fprintf('Database connected: %s\n', obj.ConnectionID)
        end
    end

    methods (Static)
        function obj = getInstance()
            persistent instance
            if isempty(instance) || ~isvalid(instance)
                instance = DatabaseConnection();
            end
            obj = instance;
        end
    end

    methods
        function query(obj, sql)
            fprintf('[%s] Executing: %s\n', obj.ConnectionID, sql)
        end
    end
end
