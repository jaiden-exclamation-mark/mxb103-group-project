% Include function files in parent directory.
addpath('..');
clc; clear; close all;

% Parameters as given in task sheet
H = 74;     % height of jump point
D = 31;     % deck height
c = 0.9;    % drag coefficient
m = 80;     % mass of jumper
L = 25;     % length of bungee rope
k = 90;     % spring constant of bungee rope
g = 9.8;    % gravitational acceleration
final_t = 60;

C = c / m;  % drag per unit mass with units 1/m
K = k / m;  % stiffness per unit mass with units 1/s^2

function dydv = rhs_bungee(w, g, C, K, L)
    y = w(1);
    v = w(2);

    % dy/dt = v
    dydt = v;

    % dv/dt = g - C|v|V - max(0, K(y - L))\
    dvdt = g - C * abs(v) * v - max(0, K * (y - L));

    dydv = [dydt; dvdt];
end

y_0 = 0;
v_0 = 0;

f = @(t, w) rhs_bungee(w, g, C, K, L);
[t, w] = runge_kutta(f, 0, 60, [y_0; v_0], 60 / 1e-3);
y = w(1, :);
v = w(2, :);

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
