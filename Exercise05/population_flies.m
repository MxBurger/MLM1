function population_flies()
    % Parameters
    a = 1/5;           % Growth rate (alpha)
    b = 1/5175;        % Capacity parameter (beta)
    x0 = 10;           % Initial population
    t_s = 0.01;        % Time step size
    t_max = 100;       % Maximum observation time
    threshold = 0.99;  % 99% of the maximum population

    % Initialization
    t = 0:t_s:t_max;   % Time vector
    P = zeros(length(t), 1); % Population array
    P(1) = x0;         % Set initial population

    % Euler
    for i = 1:length(t)-1
        P_ = a * P(i) - b * P(i)^2; % Compute population derivative
        P(i+1) = P(i) + t_s * P_;   % Update population using Euler step

        % Stop when 99% of the maximum population is reached
        P_max = a / b;  % Analytical maximum population
        if P(i+1) >= threshold * P_max
            t = t(1:i+1); % Trim time vector
            P = P(1:i+1); % Trim population vector
            break;
        end
    end

    % Display results
    fprintf('Population after 12 days: %.2f\n', P(round(12/t_s)));
    fprintf('Asymptotic population size: %.2f\n', a / b);

    % Plot the population growth
    plot(t, P, 'LineWidth', 2);
    xlabel('Time (days)');
    ylabel('Population');
    title('Fruit Fly Population Growth');
    grid on;
    legend('Population over time');
end