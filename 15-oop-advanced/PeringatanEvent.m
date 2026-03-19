classdef PeringatanEvent < event.EventData
    % PERINGATANEVENT Custom event data untuk peringatan

    properties
        Message (1,1) string
    end

    methods
        function obj = PeringatanEvent(msg)
            obj.Message = msg;
        end
    end
end
