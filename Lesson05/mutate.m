function [s] = mutate(s, delta)
    s.t1 = s.t1 + randn * delta;
    s.t2 = s.t2 + randn * delta;
    s.t3 = s.t3 + randn * delta;
    s.t4 = s.t4 + randn * delta;

    s.quality = [];
    s.h_prog = [];
    s.v_prog = [];
    s.t_prog = [];
end