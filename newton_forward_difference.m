function p = newton_forward_difference(x, abscissas, values)
% NEWTON_FORWARD_DIFFERENCE  Computes the Newton forward difference form of the interpolating polynomial P_{n}(x) for a given value `x` and a array of points.
%
% Arguments:
%   x - The `x` value to calculate the polynomial at.
%   abscissas - The `x` components of the points. (these must be equally spaced)
%   values - The `y` components of the points.
% Returns:
%   p - The value yielded by P_{n}(x)
    % Ensure abcissas are equally spaced.
    deltas = diff(abscissas);
    if any(deltas ~= deltas(1))
        error("Newton forward difference requires equally spaced values in `abscissas`!");
    end

    h = deltas(1);
    s = (x - abscissas(1)) / h;

    n = length(values);
    p = 0;
    forward_difference_table = values;
    for k = 0:n - 1
        s_choose_k = prod(s - (0:k - 1)) / factorial(k);
        delta_k_y = forward_difference_table(1);
        forward_difference_table = diff(forward_difference_table);
        p = p + s_choose_k * delta_k_y;
    end
end