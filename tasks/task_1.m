% Include function files in parent directory.
addpath('..');
clc; clear; close all;

% Initialise
final_T = 60;
init_parameters;
[t, y, ~] = calculate_y_and_v(final_T / 1e-3, g, C, K, L);

% Plot for y(t)
figure;
plot(t, y, 'LineWidth', 1.2);
grid on;
hold on;
xlabel('Time (s)');
ylabel('Position (m)');
title('Bungee jump position vs time')

% Detect maxima in y(t) to count bounces
approx_velocity = gradient(y, t);
max_points = find(approx_velocity(1:end-1) > 0 & approx_velocity(2:end) <= 0); %finds negative peaks
num_bounces = length(max_points);
fprintf('Number of bounces in %.1f seconds: %d\n', final_T, num_bounces);
fprintf('The 10th bounce occurs at t = %.2f seconds.\n', t(max_points(end)));


% Marks the highest points (bounces)
plot(t(max_points), y(max_points), 'r*');
legend({'Position','Bounce points'}, 'Location','best');
