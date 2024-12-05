function [s] = init(max_time)
    s.t1 = rand * max_time;
    s.t2 = rand * max_time;
    s.t3 = rand * max_time;
    s.t4 = rand * max_time;

    % swap if thrust-times are reversed
    if s.t1 > s.t2
        x = s.t1;
        s.t1 = s.t2;
        s.t2 = x;
    end

    if s.t3 > s.t4
        x = s.t3;
        s.t4 = s.t3;
        s.t3 = x;
    end

    s.quality = [];
    s.h_progress = [];
    s.v_progress = [];
end