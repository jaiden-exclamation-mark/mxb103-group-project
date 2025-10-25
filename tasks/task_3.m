% Include function files in parent directory.
addpath('..');

% Use numerical differentiation to find acceleration
a = diff(v) ./ diff(t);
t_mid = t(1:end - 1);

% Plot acceleration vs time
figure;
plot(t_mid, a, 'LineWidth', 1.2);
grid on;
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Bungee Jumper Acceleration vs Time');

% Find max acceleration magnitude and when it occurs
[max_accel, idx] = max(abs(a));
time_of_max_accel = t_mid(idx);

% Display results in Command Window
fprintf('Maximum acceleration: %.2f m/s^2 at t = %.2f seconds .\n, max_accel, time_of_max_accel', max_accel, idx);
fprintf('2g = %.2f m/s^2 for comparison .\n', 2 * 9.8);

% Add a marker on the plot for the maximum acceleration point
hold on;
plot(time_of_max_accel, a(idx), 'ro', 'MarkerSize', 8, 'DisplayName', 'Max Acceleration');
legend('Acceleration', 'Max Acceleration', 'Location', 'best');
