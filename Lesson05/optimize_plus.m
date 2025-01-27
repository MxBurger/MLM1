function [s] = optimize_plus(model_name, mue, lambda, max_time, delta, n_gens)
    % Initialize population
    population = cell(1, mue);
    for i = 1 : mue
        s = init(max_time);
        s = evaluate(model_name, s, max_time);
        population{i} = s;
    end
    
    % Parameters for 1/5 success rule
    n = 4; % Number of parameters (t1-t4)
    success_history = zeros(1, 10*n);
    history_index = 1;
    cd = 0.82;
    ci = 1/0.82;
    current_delta = delta;
    
    current_gen_index = 0;
    while (current_gen_index < n_gens)
        fprintf("Generation: %d\n", current_gen_index);
        offspring = cell(1, lambda);
        successes = 0;
        
        % Create offspring
        for i = 1 : lambda
            index = ceil(rand * mue);
            parent = population{index};
            child = mutate(parent, current_delta, max_time);
            child = evaluate(model_name, child, max_time);
            offspring{i} = child;
            
            % Korrektur der Erfolgsbedingung: Kleinere Werte sind besser
            if child.quality < parent.quality
                success_history(history_index) = 1;
                successes = successes + 1;
            else
                success_history(history_index) = 0;
            end
            history_index = mod(history_index, 10*n) + 1;
        end
        
        % Update delta using 1/5 success rule
        if mod(current_gen_index + 1, n) == 0
            success_rate = mean(success_history);
            if success_rate < 0.2
                current_delta = ci * current_delta;
            elseif success_rate > 0.2
                current_delta = cd * current_delta;
            end
            fprintf("Success rate: %.2f, New delta: %.4f\n", success_rate, current_delta);
        end
        
        % Kombiniere Eltern und Nachkommen
        combined_population = [population, offspring];
        combined_quality = zeros(1, mue + lambda);
        
        % Evaluiere kombinierte Population
        for i = 1:(mue + lambda)
            combined_quality(i) = combined_population{i}.quality;
        end
        
        % Sortiere aufsteigend (kleinere Werte sind besser)
        [~, indices] = sort(combined_quality, 'ascend');
        new_population = cell(1, mue);
        for i = 1:mue
            new_population{i} = combined_population{indices(i)};
        end
        
        population = new_population;
        current_gen_index = current_gen_index + 1;
        
        fprintf('Best solution in generation %d: %.4f m/s\n', ...
                current_gen_index, population{1}.quality);
    end
    
    % Finale Ergebnisse
    figure;
    hold on
    grid on
    best_solution = population{1};
    param_text = sprintf('Height and Velocity\nt1=%.2f, t2=%.2f, t3=%.2f, t4=%.2f\nImpact Velocity=%.2f m/s', ...
        best_solution.t1, best_solution.t2, best_solution.t3, best_solution.t4, best_solution.quality);
    title(param_text);
    
    plot(best_solution.t_prog, best_solution.h_prog);
    plot(best_solution.t_prog, best_solution.v_prog);
    xlabel("Time [sec]");
    ylabel("H [m], V [m/s]");
    legend("Height", "Velocity");
    hold off
    s = best_solution;
end