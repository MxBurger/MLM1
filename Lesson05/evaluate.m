function [s] = evaluate(S, simparams, maxTime)

    params = [0, s.t1, s.t2, s.t3, s.t4];
    %...

    [T, X, Y] = sim('LunarLander_param', maxTime, simparams, params);

    h = Y(:, 1);
    v = Y(:, 2);

    if(min(h) < 0)
        % we have a landing
        index=find(h<0);
        impact = index(1);
        %impact_time = T(impact);
        s.quality = -v(impact);
    else
        % we did not land
        % maybe s.quality = min(h)
    end
end