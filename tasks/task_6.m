% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;
jumper_height = 1.75;
rope_length_range = 20:45;
spring_constant_range = 70:90;

% Alter length of bungee rope `L`
for L = rope_length_range
    % Alter spring constant `k` of rope.
    for k = spring_constant_range
        fprintf('Testing model with L = %d and k = %d\n', L, k);
        [t, y, v] = calculate_y_and_v(60 / 1e-3, g, C, k / m, L);
        % Use first-order difference approximation for acceleration.
        a = diff(v) ./ diff(t);
        maximum_acceleration = max(abs(a));

        % Discard unsafe models.
        if maximum_acceleration > 2 * g
            fprintf('Model with parameters L = %d and k = %d rejected due to unsafe acceleration.\n', L, k);
            continue;
        end

        % The minima are defined as the points where a positive velocity is followed by a non-positive velocity.
        minima = find(v(1:end - 1) > 0 & v(2:end) <= 0);
        number_of_bounces = length(minima);
        lowest_height = max(y);
        distance_from_water = H - lowest_height - jumper_height;
    end
end