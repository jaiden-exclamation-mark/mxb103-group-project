function p = newton_forward_difference(abscissas, values)
    % Ensure abcissas are equally spaced.
    deltas = diff(abscissas);
    if any(deltas ~= deltas(1))
        error("Newton forward difference requires equally spaced values in `abscissas`!");
    end

    h = deltas(1);
    s = (x - abscissas(0)) / h;

    n = length(values);
    p = 0;
    forward_difference_table = values;
    for k = 0:n - 1
        s_choose_k = prod(s - 0:n - 1) / factorial(k);
        delta_k_y = forward_difference_table(1);
        forward_difference_table = diff(forward_difference_table);
        p = p + s_choose_k * delta_k_y;
    end
end