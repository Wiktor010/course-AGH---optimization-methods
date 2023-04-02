function [out, F_vec] = kara_wew(fun, x0, gi, c0, alpha, eps, n_max)
    options = optimset('MaxIter', 5, 'Display', 'off');
    i = 0;
    x_prev = x0;
    c = c0;
    S = @(x) 0;
    F_vec = {};
    for i = 1:length(gi)
        g = gi{i};
        S = @(x) S(x) - log(-g(x));
    end
    while true
        i = i + 1;
        F = @(x) fun(x) + c.*S(x);
        F_vec{end + 1} = F;
        x = fminsearch(F, x_prev, options);
        if abs(x-x_prev) < eps || c*abs(S(x)) < eps || i >= n_max
            disp("Liczba iteracji: " + num2str(i))
            out = x;
            return 
        end
        c = alpha*c;
        x_prev = x;
    end
end