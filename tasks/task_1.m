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

% Detect minima in y(t) to count bounces
approx_velocity = gradient(y, t);
low_points = find(approx_velocity(1:end-1) < 0 & approx_velocity(2:end) > 0); %finds negative peaks
num_bounces = length(low_points);
fprintf('Number of bounces in %.1f seconds: %d\n', final_T, num_bounces);

if num_bounces >= 10
    fprintf('The 10th bounce occurs at t = %.2f seconds.\n', t(low_points(10)));
else
    fprintf('Only %d bounces occurred within %.1f seconds.\n', num_bounces, final_T);
    
    % Estimate time of 10th bounce if after 10 seconds by using average
    % period between last two bounces.
    if length(low_points) > 2 
        gap = (t(low_points(end)) - t(low_points(end-1)));
        estimate = t(low_points(end)) + gap;
        fprintf('Estimated 10th bounce at approximately %.2f seconds. \n', estimate);
    end
    
end
% Marks the lowest points (bounces)
plot(t(low_points), y(low_points), 'r*');
