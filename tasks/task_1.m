% Include function files in parent directory.
addpath('..');

function dydv = rhs_bungee(w, g, C, K, L)
    y = w(1);
    v = w(2);

    % dy/dt = v
    dydt = v;

    % dv/dt = g - C|v|V - max(0, K(y - L))\
    dvdt = g - C * abs(v) * v - max(0, K * (y - L));

    dydv = [dydt; dvdt];
end

% Parameters as given in task sheet
H = 74;     % height of jump point
D = 31;     % deck height
c = 0.9;    % drag coefficient
m = 80;     % mass of jumper
L = 25;     % length of bungee rope
k = 90;     % spring constant of bungee rope
g = 9.8;    % gravitational acceleration

C = c / m;  % drag per unit mass with units 1/m
K = k / m;  % stiffness per unit mass with units 1/s^2

final_T = 60;
h = 1e-3;
t = 0 : h : final_T;
N = length(t);

clc; clear; close all;

y0 = 0;
v0 = 0;z
w = zeros(2, N);
w(:,1) = [y0, v0];

for i = 2:N
    k1 = h * rhs_bungee(w(:, i - 1), g, C, K, L);
    k2 = h * rhs_bungee(w(:, i - 1) + 0.5 * k1, g, C, K, L);
    k3 = h * rhs_bungee(w(:, i - 1) + 0.5 * k2, g, C, K, L);
    k4 = h * rhs_bungee(w(:, i - 1) + k3, g, C, K, L);
    w(:, i) = w(:, i - 1) + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
end

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
