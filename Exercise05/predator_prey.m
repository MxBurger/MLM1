function predator_prey(b0, r0, alpha, beta, gamma, delta, t_s, t_max)
    % Default parameters
    if nargin == 0
        alpha = 0.4;   % Growth rate of prey
        beta = 0.008;  % Interaction coefficient prey-predator
        gamma = 0.3;   % Loss rate of predators
        delta = 0.001; % Growth rate of predators from prey
        b0 = 500;      % Initial prey population
        r0 = 5;        % Initial predator population
        t_s = 0.001;   % Time step size
        t_max = 50;    % Maximum simulation time
    end

    % Initialization
    t = 0:t_s:t_max;
    n_steps = length(t);
    b_prog = zeros(n_steps, 1);
    r_prog = zeros(n_steps, 1);
    b = b0;
    r = r0;

    % Euler
    for i = 1:n_steps
        b_ = alpha * b - beta * b * r;   % Change in prey
        r_ = -gamma * r + delta * b * r; % Change in predator
        b = b + b_ * t_s;                % Update prey population
        r = r + r_ * t_s;                % Update predator population
        b_prog(i) = b;                   % Save prey population
        r_prog(i) = r;                   % Save predator population
    end

    % Plot the results
    plot(t, b_prog, 'LineWidth', 2);
    hold on;
    plot(t, r_prog, 'LineWidth', 2);
    xlabel('Time (t)');
    ylabel('Population size');
    title('Predator-Prey Population Dynamics');
    legend('Prey', 'Predator');
    grid on;
    hold off;
end