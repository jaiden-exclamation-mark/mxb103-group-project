% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;
jumper_height = 1.75;
rope_length_range = 25:2:45;
spring_constant_range = 70:90;
tolerance = 2;
minimum_bounce_criteria = 9;
output_file = "task_6_table.txt";

file_id = fopen(output_file, 'w');
fprintf(file_id, '\\begin{tabular}{|c|c|c|c|c|c|}\n\\hline\n');
fprintf(file_id, '$L$ & $k$ & No. bounces & Peak accel. ($g$s) & Distance to water (m) \\\\\\hline\n');

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

        % Discard models that do not have 10 bounces.
        if number_of_bounces < minimum_bounce_criteria
            fprintf('Model with parameters L = %d and k = %d rejected due to lack of bounces.\n', L, k);
            continue;
        end

        lowest_height = max(y);
        distance_from_water = H - lowest_height - jumper_height;

        if abs(distance_from_water) <= tolerance
            fprintf(file_id, '    %d & %d & %d & %.2f & %.2f \\\\\\hline\n', L, k, number_of_bounces, maximum_acceleration / g, distance_from_water);
        else
            fprintf('Model with parameters L = %d and k = %d not close enough to water.\n', L, k);
        end
    end
end

fprintf(file_id, '\\end{tabular}');