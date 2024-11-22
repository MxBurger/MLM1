function [s] = mutate(s, delta)
    s.t1 = s.t1 + randn * delta;
    s.t2 = s.t2 + randn * delta;
    s.t3 = s.t3 + randn * delta;
    s.t4 = s.t4 + randn * delta;

    s.quality = [];
    % also the other params are uknown
end