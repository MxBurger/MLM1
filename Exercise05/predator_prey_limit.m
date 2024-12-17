function predator_prey_limit(alpha4_values)
    % Parameters
    alpha1 = 0.6; % Prey growth rate
    alpha2 = 500; % Prey capacity
    alpha3 = 0.2; % Predation rate
    alpha5 = 0.4; % Predator growth rate
    alpha6 = 0.1; % Predator saturation parameter
    b0 = 300;     % Initial prey population
    r0 = 50;      % Initial predator population
    t_s = 0.01;   % Time step
    t_max = 100;  % Total simulation time

    % Time vector
    t = 0:t_s:t_max;
    n_steps = length(t);
    
    % Loop through different alpha4 values
    for alpha4 = alpha4_values
        % Initialize populations
        b = b0;
        r = r0;
        b_progress = zeros(n_steps, 1);
        r_progress = zeros(n_steps, 1);
        
        % Euler
        for i = 1:n_steps
            db_dt = b * (alpha1 * (1 - b / alpha2) - (alpha3 * r) / (b + alpha4));
            dr_dt = r * alpha5 * (1 - (alpha6 * r) / b);
            b = b + db_dt * t_s;
            r = r + dr_dt * t_s;
            b_progress(i) = b;
            r_progress(i) = r;
        end
        
        % Plot results
        figure;
        plot(t, b_progress, 'LineWidth', 2);
        hold on;
        plot(t, r_progress, 'LineWidth', 2);
        xlabel('Time (t)');
        ylabel('Population');
        title(['Predator-Prey Dynamics with \alpha_4 = ', num2str(alpha4)]);
        legend('Prey', 'Predator');
        grid on;
        hold off;
    end
end
