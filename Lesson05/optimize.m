% main function
function [s] = optimize(model_name, mue, lambda, max_time, delta, n_gens)

    population = cell(1, mue);
    for i = 1 : mue
        s = init(max_time);
        population{i} = s;
    end

    current_gen_index = 0;
    while (current_gen_index < n_gens)
        fprintf("Generation: " + current_gen_index + "\n")
        offspring = cell(1, lambda);

        % create offspring
        for i = 1 : lambda
            index = ceil(rand * mue);
            parent = population{index};
            child = mutate(parent, delta);
            fprintf("T1 : %.2f\n", s.t1);
            fprintf("T2 : %.2f\n", s.t2);
            fprintf("T3 : %.2f\n", s.t3);
            fprintf("T4 : %.2f\n", s.t4);
            child = evaluate(model_name, child, max_time);
            offspring{i} = child;
        end

        % rank quality of mutations
        offspring_quality = zeros(1, lambda);
        for i = 1 : lambda
            offspring_quality(i) = offspring{i}.quality;
        end
        [~, index] = sort(offspring_quality);

        % generate new generation
        new_gen = cell(1, mue);
        for i = 1 : mue
            new_gen{i} = offspring{index(i)};
        end
        population = new_gen;

        current_gen_index = current_gen_index + 1;
    end

    % draw Simulation
    hold on
        grid on
        title("Height and Velocity");
        plot(new_gen{1}.t_prog, new_gen{1}.h_prog);
        plot(new_gen{1}.t_prog, new_gen{1}.v_prog);
        xlabel("Time [sec]");
        ylabel("H [m], V [m/s]");
        legend("Height','Velocity");
    hold off
end