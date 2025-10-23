function [t, y, v] = calculate_y_and_v(n, g, C, K, L)
    y_0 = 0;
    v_0 = 0;

    % Curry `rhs_bungee` so then g, C, K, L are essentially "baked in"to the function.
    f = @(t, w) rhs_bungee(w, g, C, K, L);
    [t, w] = runge_kutta(f, 0, 60, [y_0; v_0], n);
    y = w(1, :);
    v = w(2, :);
end