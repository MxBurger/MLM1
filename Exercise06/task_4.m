function task_4()
    % Simulation parameters
    tMax = 50;
    tStep = 0.01;
    timePoints = 0:tStep:tMax;
    
    % Population parameters
    N = [1000, 100, 500];  % Population sizes
    contacts = [2, 10, 4];  % Contacts per week
    infectionProb = 0.15;   % Infection probability at contact
    recoveryTime = [2, 2, 1.5];  % Weeks until recovery
    
    % Contact matrix
    M = [0.9, 0.05, 0.05;
         0.1, 0.7,  0.2;
         0.3, 0.3,  0.4];
    
    % Calculate alpha and beta for each group
    alpha = contacts * infectionProb;
    beta = 1 ./ recoveryTime;
    
    % Initialize state variables
    S = zeros(length(timePoints), 3);
    I = zeros(length(timePoints), 3);
    R = zeros(length(timePoints), 3);
    
    % Initial conditions
    S(1,:) = N;
    I(1,:) = [0, 0, 5];  % 5 initial infected in group 3
    S(1,:) = S(1,:) - I(1,:);
    R(1,:) = zeros(1,3);
    
    % Time integration using Euler method
    for t = 1:length(timePoints)-1
        for i = 1:3
            % Calculate infection term
            infectionTerm = 0;
            for j = 1:3
                infectionTerm = infectionTerm + M(i,j) * I(t,j) / N(j);
            end
            
            % Calculate derivatives
            dS = -alpha(i) * S(t,i) * infectionTerm;
            dI = alpha(i) * S(t,i) * infectionTerm - beta(i) * I(t,i);
            dR = beta(i) * I(t,i);
            
            % Euler step
            S(t+1,i) = S(t,i) + dS * tStep;
            I(t+1,i) = I(t,i) + dI * tStep;
            R(t+1,i) = R(t,i) + dR * tStep;
        end
    end
    
    % Plotting
    figure('Position', [100, 100, 800, 500]);
    plot(timePoints, I(:,1), 'LineWidth', 2);
    hold on;
    plot(timePoints, I(:,2), 'LineWidth', 2);
    plot(timePoints, I(:,3), 'LineWidth', 2);
    grid on;
    xlabel('Time [weeks]');
    ylabel('Number of infected people I(t)');
    title('SIR Model for Heterogeneous Population');
    legend('Group 1 (n=1000)', 'Group 2 (n=100)', 'Group 3 (n=500)');
end