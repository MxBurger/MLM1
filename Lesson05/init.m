function [s] = init(maxValue,inputArg2)
    s.t1 = rand * maxValue;
    s.t2 = rand * maxValue;
    s.t3 = rand * maxValue;
    s.t4 = rand * maxValue;

    %if t1 > t2 -> swap
    %if t3 > t4 -> swap

    s.quality = [];
    s.h_progress = [];
    s.v_progress = [];
end