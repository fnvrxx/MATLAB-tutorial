classdef Hari
    % HARI Enumeration class untuk hari dalam seminggu

    enumeration
        Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu
    end

    methods
        function tf = isWeekend(obj)
            tf = (obj == Hari.Sabtu) || (obj == Hari.Minggu);
        end

        function tf = isWeekday(obj)
            tf = ~obj.isWeekend();
        end
    end
end
