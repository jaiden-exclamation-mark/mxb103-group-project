function w = runge_kutta(f, a, b, alpha, n)
% RUNGE_KUTTA  General implementation of the Fourth Order Runge-Kutta method.
% 
% Arguments:
%   f - The derivative d/dt.
%   a - The start value of t.
%   b - The end value of t.
%   alpha - The value of f(a).
%   n - The number of steps to do.
% Returns:
%   w - The approximate value of f(b).
    t = a;
    w = alpha;
    h = (b - a) / n;
    % TODO: convert to `for` loop.
    while t < b
        k_1 = h * f(t, w);
        k_2 = h * f(t + h / 2, w + k_1 / 2);
        k_3 = h * f(t + h / 2, w + k_2 / 2);
        k_4 = h * f(t + h, w + k_3);
        w = w + (k_1 + 2 * k_2 + 2 * k_3 + k_4) / 6;
        t = t + h;
    end
end