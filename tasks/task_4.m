% Include function files in parent directory.
addpath('..');
clc; clear; close all;

% Initialise
init_parameters
% `points_in_simpson` is the value of `n` for the approximation of the integral.
points_in_simpson = 100000;
[~, ~, v] = calculate_y_and_v(points_in_simpson);

total_distance = simpson_integral_array(abs(v), 0, 60);
fprintf('The jumper will travel approximately %f metres in 60 seconds', total_distance);