function dydv = rhs_bungee(w, g, C, K, L)
    y = w(1);
    v = w(2);

    % dy/dt = v
    dydt = v;

    % dv/dt = g - C|v|V - max(0, K(y - L))\
    dvdt = g - C * abs(v) * v - max(0, K * (y - L));

    dydv = [dydt; dvdt];
end