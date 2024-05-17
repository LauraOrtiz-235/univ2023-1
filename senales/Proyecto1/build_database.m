
% Proyecto 1 - Parte 1

% Directorio donde se encuentran las canciones
folder_path = '/home/laura/Desktop/univ/univ2023-1/senales/Proyecto1/songa';

file_list = dir(fullfile(folder_path, '*.mp3'));

disp(length(file_list));

% Crear la estructura de base de datos
database = struct('song', struct('title', {}, 'artist', {}, 'spectrogram', {}), 'n_songs', 0);

% Iterar sobre la lista de archivos
for i = 1:length(file_list)
    fprintf('Procesando canción %d de %d\n', i, length(file_list));
    % Obtener la ruta completa del archivo
    %file_path = fullfile(file_list(i).folder, file_list(i).name);
    file_path = fullfile(folder_path, file_list(i).name);
    disp(file_path);
    
    % Leer el archivo de audio
    [audio, fs] = audioread(file_path);

    fprintf('a');

    % Promediar los canales, restar la media y reducir la frecuencia de muestreo
    audio = mean(audio, 2);
    audio = audio - mean(audio);
    %audio = resample(audio, 8000, fs);
    fs = 8000;

    % Calcular el espectrograma
    window = ones(1024, 1);
    noverlap = length(window) - 100;
    nfft = 4096;
    [S, F, T] = spectrogram(audio, window, noverlap, nfft, 8000);

    % Convertir el espectrograma a dB
    S = 20*log10(abs(S) + eps);

    % Calcular el hash de la canción
    hash_table = generate_hash_table(S);

    % Agregar la canción a la base de datos
    song = struct('title', files(i).name, 'artist', 'Unknown', 'spectrogram', S, 'hash_table', hash_table);
    database.song(end+1) = song;
    database.n_songs = database.n_songs + 1;

    fprintf('Error al procesar la canción %s\n', files(i).name);

end

% Guardar la base de datos en un archivo MAT
save('database.mat', 'database');

fprintf('Proceso finalizado. %d canciones procesadas.\n', database.n_songs);


% Mostrar información de la base de datos
load("database.mat");
whos;
disp(database);