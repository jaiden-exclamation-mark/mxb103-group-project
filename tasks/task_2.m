% Include function files in parent directory.
addpath('..');

% Extract velocity from RK4 results
v = w(2, :);

% Plot velocity vs time
figure;
plot(t, v, 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Velocity (m/s)');
title('Bungee Jumper Velocity vs Time');

% I did part of this question, i showed the displaying of velocity-time graph
% and see when the max speed occurs visually. Need to show how fast the jumper
%goes at their fastest point and also when it happens
