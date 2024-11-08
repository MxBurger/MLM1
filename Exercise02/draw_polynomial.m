function draw_polynomial(coeffs, range, step_size)
arguments
    coeffs double
    range double % range vector
    step_size double = 0.01
end
% define s-vector
s = range(1):step_size:range(2);

% initialize y_vals with 0s
p = zeros(size(s));

% get size of only columns
n_coeffs = size(coeffs, 2);

legend_text = 'p = ';

for i = 1:n_coeffs
    % calculate p vector
    p = p + coeffs(i) * s.^(n_coeffs - i);

    % generate fancy title
        if coeffs(i) < 0
            legend_text(end) = [];
        end
        legend_text = [legend_text, num2str(coeffs(i)), '*s^', num2str(n_coeffs-i), '+'];
end

legend_text(end) = [];

figure;
plot(s, p);
xlabel('s')
ylabel('p(s)')
legend(legend_text);
title(['Polynom with stepsize = ', num2str(step_size)]);
grid minor;
end

