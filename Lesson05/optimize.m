function [s] = optimize(model_name, mue, lambda, max_time, delta, n_gens)
    % Initialize population
    population = cell(1, mue);
    for i = 1 : mue
        s = init(max_time);
        population{i} = s;
    end
    
    % Parameters for 1/5 success rule
    n = 4;  % Number of parameters (t1-t4)
    success_history = zeros(1, 10*n); % Store last 10n success/failures
    history_index = 1;
    cd = 0.82;      % Decrease factor
    ci = 1/0.82;    % Increase factor
    current_delta = delta;
    
    current_gen_index = 0;
    while (current_gen_index < n_gens)
        fprintf("Generation: %d\n", current_gen_index);
        offspring = cell(1, lambda);
        successes = 0;  % Count successful mutations in this generation

        % Create offspring
        for i = 1 : lambda
            index = ceil(rand * mue);
            parent = population{index};
            child = mutate(parent, current_delta, max_time);
            child = evaluate(model_name, child, max_time);
            offspring{i} = child;
            
            % Check if mutation was successful
            if child.quality > parent.quality
                success_history(history_index) = 1;
                successes = successes + 1;
            else
                success_history(history_index) = 0;
            end
            history_index = mod(history_index, 10*n) + 1;
        end

        % Update delta using 1/5 success rule every n generations
        if mod(current_gen_index, n) == 0
            success_rate = mean(success_history);
            if success_rate < 0.2       % Less than 1/5 successful
                current_delta = ci * current_delta;  % Increase delta
            elseif success_rate > 0.2   % More than 1/5 successful
                current_delta = cd * current_delta;  % Decrease delta
            end
            % If success_rate == 0.2, keep delta unchanged
            fprintf("Success rate: %.2f, New delta: %.4f\n", success_rate, current_delta);
        end

        % Rank quality of mutations
        offspring_quality = zeros(1, lambda);
        for i = 1 : lambda
            offspring_quality(i) = offspring{i}.quality;
        end
        [~, index] = sort(offspring_quality);

        % Generate new generation
        new_gen = cell(1, mue);
        for i = 1 : mue
            new_gen{i} = offspring{index(i)};
        end
        population = new_gen;

        current_gen_index = current_gen_index + 1;
    end

    % Draw final simulation results
    figure;
    hold on
        grid on
        best_solution = new_gen{1};
        param_text = sprintf('Height and Velocity\nt1=%.2f, t2=%.2f, t3=%.2f, t4=%.2f\nImpact Velocity=%.2f m/s', ...
        best_solution.t1, best_solution.t2, best_solution.t3, best_solution.t4, best_solution.quality);
        title(param_text);
    
        plot(best_solution.t_prog, best_solution.h_prog);
        plot(best_solution.t_prog, best_solution.v_prog);
        xlabel("Time [sec]");
        ylabel("H [m], V [m/s]");
        legend("Height", "Velocity");
    hold off
end
