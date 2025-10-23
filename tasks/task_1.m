% Include function files in parent directory.
addpath('..');
clc; clear; close all;

% Initialise
init_parameters;
[t, y, ~] = calculate_y_and_v(60 / 1e-3, g, C, K, L);

% Plot for y(t)
figure;
plot(t, y, 'LineWidth', 1.2);
grid on;
hold on;
xlabel('Time (s)');
ylabel('Position (m)');
title('Bungee jump position vs time')

% Automatically count the number of bounces

% Detect minima in y(t) to count bounces
[min_peaks, min_locs] = findpeaks(-y, t); % find negative peaks (lowest points)
num_bounces = length(min_peaks);
fprintf('Number of bounces in %.1f seconds: %d\n', final_T, num_bounces);

if num_bounces >= 10
    fprintf('The 10th bounce occurs at t = %.2f seconds.\n', min_locs(10));
else
    fprintf('Only %d bounces occurred within %.1f seconds .\n', num_bounces, final_T);
end
