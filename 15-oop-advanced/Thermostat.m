classdef Thermostat < handle
    % THERMOSTAT Demonstrasi Events & Listeners

    properties (SetAccess = private)
        Suhu (1,1) double = 20
    end

    properties (Constant)
        BATAS_ATAS = 35
        BATAS_BAWAH = 10
    end

    events
        SuhuBerubah         % event sederhana
        PeringatanSuhu      % event dengan data
    end

    methods
        function obj = Thermostat(suhuAwal)
            if nargin > 0
                obj.Suhu = suhuAwal;
            end
        end

        function setSuhu(obj, suhuBaru)
            suhuLama = obj.Suhu;
            obj.Suhu = suhuBaru;

            fprintf('Suhu: %.1f°C -> %.1f°C\n', suhuLama, suhuBaru)

            % Trigger event SuhuBerubah
            notify(obj, 'SuhuBerubah')

            % Cek batas dan trigger peringatan
            if suhuBaru > obj.BATAS_ATAS
                evt = PeringatanEvent(sprintf( ...
                    'Suhu terlalu tinggi: %.1f°C (batas: %.1f°C)', ...
                    suhuBaru, obj.BATAS_ATAS));
                notify(obj, 'PeringatanSuhu', evt)
            elseif suhuBaru < obj.BATAS_BAWAH
                evt = PeringatanEvent(sprintf( ...
                    'Suhu terlalu rendah: %.1f°C (batas: %.1f°C)', ...
                    suhuBaru, obj.BATAS_BAWAH));
                notify(obj, 'PeringatanSuhu', evt)
            end
        end
    end
end
