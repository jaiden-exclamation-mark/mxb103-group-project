function resultant = simpson_integral_array(y, a, b)
    n = length(y);

    h = (b - a) / n;
    % Remove x_0 and x_n (the "tail"s)
    y_without_tails = y(2:n - 1)
    odds = y_without_tails(1:2:n - 2)
    evens = y_without_tails(2:2:n - 2)

    resultant = (h / 3) * (y(1) + 4 * sum(odds) + 2 * sum(evens) + y(n));
end