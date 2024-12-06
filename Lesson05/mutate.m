function [s] = mutate(s, delta, max_time)
    % Mutate timing parameters with Gaussian noise
    s.t1 = s.t1 + randn * delta;
    s.t2 = s.t2 + randn * delta;
    s.t3 = s.t3 + randn * delta;
    s.t4 = s.t4 + randn * delta;
    
    % Ensure all times are non-negative
    s.t1 = max(0, s.t1);
    s.t2 = max(0, s.t2);
    s.t3 = max(0, s.t3);
    s.t4 = max(0, s.t4);
    
    % Ensure all times are less than max_time
    s.t1 = min(max_time, s.t1);
    s.t2 = min(max_time, s.t2);
    s.t3 = min(max_time, s.t3);
    s.t4 = min(max_time, s.t4);
    
    % Ensure correct ordering of thrust times (t1 < t2 and t3 < t4)
    if s.t1 > s.t2
        % Swap t1 and t2
        temp = s.t1;
        s.t1 = s.t2;
        s.t2 = temp;
    end
    
    if s.t3 > s.t4
        % Swap t3 and t4
        temp = s.t3;
        s.t3 = s.t4;
        s.t4 = temp;
    end
    
    % Reset progress tracking variables
    s.quality = [];
    s.h_prog = [];
    s.v_prog = [];
    s.t_prog = [];
end