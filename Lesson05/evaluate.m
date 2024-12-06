function [s] = evaluate(model_name, s, maxTime)

    sim_params = simget(model_name);
    params = [0, s.t1, s.t2, s.t3, s.t4];

    [T, ~, Y] = sim(model_name, maxTime, sim_params, params);

    s.h_prog = Y(:, 1);
    s.v_prog = Y(:, 2);
    s.t_prog = T;

    if(min(s.h_prog) < 0)
        % Houston, we have a landing
        index = find(s.h_prog < 0);
        impact = index(1);
        s.quality = -s.v_prog(impact);
    else
        % We did not land, bye major tom
        s.quality = min(s.h_prog) * 1.5; % Maybe define quality of no landing in another way
    end
end