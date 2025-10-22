function [t, w] = runge_kutta(f, a, b, alpha, n)
% RUNGE_KUTTA  General implementation of the Fourth Order Runge-Kutta method.
% 
% Arguments:
%   f - The derivative d/dt. Must be a function handle that takes two arguments, t and y.
%   a - The start value of t.
%   b - The end value of t.
%   alpha - The value of f(a).
%   n - The number of steps to do.
% Returns:
%   w - The approximate value of f(b).
    w = zeros(height(alpha), n + 1); % damn fence post problem
    w(:, 1) = alpha;
    h = (b - a) / n;
    t = a:h:b;

    for i = 1:n
        k_1 = h * f(t(i), w(:, i));
        k_2 = h * f(t(i) + h / 2, w(:, i) + k_1 / 2);
        k_3 = h * f(t(i) + h / 2, w(:, i) + k_2 / 2);
        k_4 = h * f(t(i) + h, w(:, i) + k_3);
        w(:, i + 1) = w(:, i) + (k_1 + 2 * k_2 + 2 * k_3 + k_4) / 6;
    end
end