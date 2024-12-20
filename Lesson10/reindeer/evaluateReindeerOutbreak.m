function fitness = evaluateReindeerOutbreak(alpha, beta, plotIt)
    if nargin < 3
        plotIt = false;
    end
    timeStep = 0.01;
    maxTime = 14;

    % observed data
    days = 0:14;
    observedInfected = [1, 5, 12, 40, 90, 180, 240, 210, 170, 120, 80, 40, 20, 5, 1];
    N = 500;

    S = N - 1;
    I = 1;
    R = 0;

    Sprogress = zeros(maxTime/timeStep + 1, 1);
    Iprogress = zeros(maxTime/timeStep + 1, 1);
    Rprogress = zeros(maxTime/timeStep + 1, 1);
    tprogress = zeros(maxTime/timeStep + 1, 1);

    i = 1;
    for t = 0:timeStep:maxTime
        
        Sprogress(i) = S;
        Iprogress(i) = I;
        Rprogress(i) = R;
        tprogress(i) = t;

        dS = -alpha * S * I/N;
        dI = alpha * S * I/N - beta * I;
        dR = beta * I;

        S = S + dS * timeStep;
        I = I + dI * timeStep;
        R = R + dR * timeStep;

        i = i + 1;
    end
    
    % evaluate result
    fitness = 0;
    simulatedInfected = interp1(0:timeStep:maxTime, Iprogress, days);
    for i = 1:length(days)
        fitness = fitness + (simulatedInfected(i) - observedInfected(i))^2;
    end

    if plotIt
        figure;
        plot(tprogress, Iprogress, 'b');
        hold on;
        scatter(days, observedInfected, 'r', 'filled');
        xlabel('Days');
        ylabel('Number of infected reindeer');
        title('Reindeer Cough Outbreak');
        legend('Simulated', 'Observed');
        hold off;
    end

end