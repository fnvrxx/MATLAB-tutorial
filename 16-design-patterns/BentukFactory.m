classdef BentukFactory
    % BENTUKFACTORY Factory Pattern untuk membuat objek Bentuk

    methods (Static)
        function obj = buat(tipe, varargin)
            switch lower(tipe)
                case 'lingkaran'
                    obj = LingkaranImpl(varargin{1});
                case 'persegi'
                    obj = PersegiImpl(varargin{1});
                case 'segitiga'
                    obj = Segitiga(varargin{1}, varargin{2});
                otherwise
                    error('BentukFactory:UnknownType', ...
                        'Tipe bentuk tidak dikenali: %s', tipe)
            end
        end
    end
end
