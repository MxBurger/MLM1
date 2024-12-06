% Batch optimization script
clear all;
close all;

% Parameters for optimization
model_name = 'LunarLander_param';
mue = 20;
lambda = 40;
max_time = 100;
delta = 1;
n_gens = 36;

% Number of runs
n_runs = 100;

% Storage for best results
best_quality = Inf;
best_solution = [];
best_run = 0;

% Create results directory if it doesn't exist
if ~exist('results', 'dir')
    mkdir('results');
end

% Run optimizations
for i = 1:n_runs
    fprintf('\nRun %d of %d\n', i, n_runs);
    
    % Run optimization
    solution = optimize(model_name, mue, lambda, max_time, delta, n_gens);
    
    % Evaluate the solution to get the trajectories
    solution = evaluate(model_name, solution, max_time);
    
    % Save every run
    fig = gcf;  % get current figure
    filename = sprintf('results/solution_run_%d_velocity_%.2f.png', i, abs(solution.quality));
    saveas(fig, filename);
    
    % Store if best solution so far
    if solution.quality < best_quality
        best_quality = solution.quality;
        best_solution = solution;
        best_run = i;
    end
    
    % Close figure to prevent memory issues
    close(gcf);
end

% Final output
fprintf('\nBest solution found:\n');
fprintf('Run: %d\n', best_run);
fprintf('Impact Velocity: %.2f m/s\n', abs(best_quality));
fprintf('Parameters:\n');
fprintf('t1: %.2f\n', best_solution.t1);
fprintf('t2: %.2f\n', best_solution.t2);
fprintf('t3: %.2f\n', best_solution.t3);
fprintf('t4: %.2f\n', best_solution.t4);

% Plot and save best overall result
figure;
hold on
    grid on
    param_text = sprintf('BEST SOLUTION (V=%.2f m/s)\nt1=%.2f, t2=%.2f, t3=%.2f, t4=%.2f\nRun %d of %d', ...
        abs(best_quality), best_solution.t1, best_solution.t2, best_solution.t3, best_solution.t4, best_run, n_runs);
    title(param_text);
    
    plot(best_solution.t_prog, best_solution.h_prog);
    plot(best_solution.t_prog, best_solution.v_prog);
    xlabel("Time [sec]");
    ylabel("H [m], V [m/s]");
    legend("Height", "Velocity");
hold off

% Save final best plot
saveas(gcf, 'results/final_best_solution.png');