%% ========================================================================
%  LATIHAN BAB 13-16: OOP
%  ========================================================================

%% Latihan OOP.1 - Class Dasar
% Buat class "Mahasiswa" dengan:
%   - Properties: Nama, NIM, IPK, Semester
%   - Constructor yang menerima semua parameter
%   - Method: apakahLulus() - IPK >= 2.75 dan Semester >= 8
%   - Method: tampilkan() - print info mahasiswa
%   - Dependent property: Status ('Aktif' jika Semester <= 14)

% --- Buat file Mahasiswa.m ---


%% Latihan OOP.2 - Inheritance
% Buat hierarki class untuk Hewan:
%   - Animal (parent): nama, umur, method bersuara()
%   - Kucing < Animal: warnaBulu, override bersuara() -> "Meow!"
%   - Anjing < Animal: ras, override bersuara() -> "Woof!"
% Test polymorphism: buat array hewan dan panggil bersuara()

% --- Buat file Animal.m, Kucing.m, Anjing.m ---


%% Latihan OOP.3 - Handle Class
% Buat class "TodoList" (handle class) dengan:
%   - Properties: items (cell array of strings), completed (logical array)
%   - Methods: addItem(text), completeItem(index), removeItem(index)
%   - Method: displayList() - tampilkan todo list dengan status
%   - Method: progress() - persentase yang sudah selesai

% --- Buat file TodoList.m ---


%% Latihan OOP.4 - Design Pattern
% Implementasikan Logger menggunakan Singleton pattern:
%   - Hanya satu instance Logger
%   - Method: log(level, message) - level: INFO, WARNING, ERROR
%   - Simpan semua log dalam cell array dengan timestamp
%   - Method: displayLogs() - tampilkan semua log

% --- Buat file Logger.m ---


%% Latihan OOP.5 (Tantangan)
% Buat mini game "RPG Character System":
%   - Abstract class: Character (nama, HP, attack, defense)
%   - Subclass: Warrior, Mage, Archer (stats berbeda)
%   - Method: attack(target), defend(), heal()
%   - Interface: Castable (untuk Mage: castSpell)
%   - Simulasikan pertarungan antara 2 character

% --- Buat beberapa file class ---

