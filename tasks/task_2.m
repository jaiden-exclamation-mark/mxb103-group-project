% Include function files in parent directory.
addpath('..');
clc; clear; close all;

init_parameters;
y0 = 0; v0 =0;
final_T = 60; h = 1e-3;

f = @(t,w) rhs_bungee(w, g, C, K, L);
[t, w] = runge_kutta(f, 0, final_T, [y0; v0], final_T/h);

% Extract velocity from RK4 results
v = w(2, :);

% Plot velocity vs time
figure;
plot(t, v, 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Bungee Jumper Velocity vs Time');

% Find and display the maximum speed of jumper and when it occurs
speed = abs(v);
max_speed = max(speed);
time_of_max_speed = t(speed == max_speed);

% Mark maximum speed point on graph
hold on
plot(time_of_max_speed, v(speed == max_speed), 'r*')
legend('Velocity', 'Maximum speed', 'Location', 'best')

% Display results in command window

fprintf('Maximum speed: %.2f m/s at time: %.2f seconds. \n', max_speed, time_of_max_speed);

