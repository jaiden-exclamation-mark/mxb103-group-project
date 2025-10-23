% Include function files in parent directory.
addpath('..');
clc; clear; close all;



total_distance = simpson_integral(@(v) abs(v), 0, 60, 60 * 2);
print('The jumper will travel approximately %d metres in 60 seconds', total_distance);