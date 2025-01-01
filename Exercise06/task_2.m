function task_2(alpha, a, b, t_end, t_step, A0)

    % default values
    if nargin < 1, alpha = 0.2; end
    if nargin < 2, a = 0.1; end
    if nargin < 3, b = 0.025; end
    if nargin < 4, t_end = 48; end
    if nargin < 5, t_step = 0.01; end
    if nargin < 6, A0 = 1; end
    
    % initialization
    t = 0:t_step:t_end;
    N = length(t);
    
    A = zeros(1,N);
    A(1) = A0;
    
    % euler method 
    for i = 1:N-1
        f = a + b*cos(pi*(t(i)-8)/12);
        A(i+1) = A(i) + t_step*(f - alpha*A(i));
    end
    
    % create plot
    figure;
    plot(t, A, 'b-', 'LineWidth', 1.5);
    xlabel('Time (hours)');
    ylabel('Adrenaline Concentration');
    title(sprintf('Adrenaline Concentration over Time\n(α=%.2f, a=%.3f, b=%.3f)', alpha, a, b));
    grid on;
end