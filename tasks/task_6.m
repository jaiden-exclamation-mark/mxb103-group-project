% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;
jumper_height = 1.75;

% Alter length of bungee rope `L` (doing +/- 10m)
for L = 15:35
    % Alter spring constant `k` of rope. (doing +/- 10 N/m)
    for k = 80:100
        fprintf('Testing model with L = %d and k = %d\n', L, k);
        [t, y, v] = calculate_y_and_v(60 / 1e-3, g, C, k / m, L);
        % Use first-order difference approximation for acceleration.
        a = diff(v) ./ diff(t);

        if max(abs(a)) > 2 * g
            fprintf('Model with parameters L = %d and k = %d rejected due to unsafe acceleration.\n', L, k);
            continue;
        end

        
    end
end