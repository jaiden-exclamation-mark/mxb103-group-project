% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;

% Alter length of bungee rope `L`
for L = 40:45
    % Alter spring constant `k` of rope.
    for k = 75:85
        [t, y, v] = calculate_y_and_v(60 / 1e-3, g, C, k / m, L);
        % Use first-order difference approximation for acceleration.
        a = diff(v) ./ diff(t);

        if max(a) > 2 * g
            fprintf('Model with parameters L = %d and k = %d rejected due to unsafe acceleration.', L, k);
            continue;
        end

        
    end
end