function resultant = simpson_integral(f, a, b, n)
% SIMPSON_INTEGRAL  Estimates the integral of `f` using Simpson's Rule.
%
% Arguments:
%   f - A function handle that takes one argument.
%   a - The lower bound of the integral.
%   b - The upper bound of the integral.
%   n - The number of points to use (must be even). Higher values means better accuracy.
% Returns:
%   resultant - The estimated value of `\int_{a}^{b} f(x) dx`.
    if mod(n, 2) ~= 0
        warning('Value %d of n is not even, incrementing by 1.', n);
        n = n + 1;
    end

    h = (b - a) / n;
    % Map `f` to every x in the range.
    f_of_x = arrayfun(f, a:h:b);

    resultant = simpson_integral_array(f_of_x, a, b);
end