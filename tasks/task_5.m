% Include function files in parent directory.
addpath('..');
clear; close all;

% Initialise
init_parameters;
number_of_points = 1000;
tolerance = 0;
max_binary_search_iterations = 1e6;

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

% Create interpolating polynomial p(t) using Newton forward difference method

p = @(x) newton_forward_difference(x, interpolating_t, interpolating_y);

% Rootfind to find p(t) = H - D using bisection method/binary search

f = @(x) p(x) - camera_height;

a = interpolating_t(1);
b = interpolating_t(4);

for iteration = 1:max_binary_search_iterations
    midpoint = (a + b) / 2;
    if abs(f(midpoint)) <= tolerance
        break;
    end

    if sign(f(midpoint)) == sign(f(a))
        a = midpoint;
    else
        b = midpoint;
    end
end

fprintf('The bungee jumper first reaches a displacement of %dm is at %fs\n', camera_height, midpoint);
fprintf('Tolerance = %d, f(%.2f) = %f, p(%.2f) = %f\n', tolerance, midpoint, f(midpoint), midpoint, p(midpoint));
fprintf('Calculated using %d iterations of bisection method.\n', iteration);