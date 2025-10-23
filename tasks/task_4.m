% Include function files in parent directory.
addpath('..');
clc; clear; close all;

% Increases `n` for the approximation of the integral.
points_in_simpson = 100;

% Parameters
H = 74;     % Height of jump point
D = 31;     % Deck height
c = 0.9;    % Drag coefficient
m = 80;     % Mass of jumper
L = 25;     % Length of bungee rope
k = 90;     % Spring constant of bungee rope
g = 9.8;    % Gravitational acceleration

C = c / m;  % Drag per unit mass with units 1/m
K = k / m;  % Stiffness per unit mass with units 1/s^2

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

% Curry `rhs_bungee` so then g, C, K, L are essentially "baked in"to the function.
f = @(t, w) rhs_bungee(w, g, C, K, L);
[t, w] = runge_kutta(f, 0, 60, [y_0; v_0], points_in_simpson);
y = w(1, :);
v = w(2, :)

total_distance = simpson_integral_array(v, 0, 60);
fprintf('The jumper will travel approximately %d metres in 60 seconds', total_distance);