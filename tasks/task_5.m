% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;
number_of_points = 1000;

[t, y, ~] = calculate_y_and_v(number_of_points, g, C, K, L);

camera_height = H - D;
for i = 1:length(y) - 3
    interpolating_y = y(i:i + 3);
    
    % Since y_{i+3} > H-D, break on first value of interpolating_y(3) > H-D
    if interpolating_y(3) > camera_height
        interpolating_t = t(i:i + 3);
        break;
    end
end

interpolating_t
interpolating_y