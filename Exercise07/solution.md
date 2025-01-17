# Übung 07

## **Aufgabe 1** SIR models and model identification

Implement a parameter identification algorithm for SIR models and identify a concrete SIR model for the disease defined in the lecture slides. Especially evolution strategies should be perfect for this task. Document which parameter settings work well, and which ones lead to failures; choose various $\mu +\lambda$ / $\mu, \lambda$ strategies with / without
adaptation of mutation strength.

### Lösungsidee

### Implementierung

Optimierungs-Funktion
```matlab
function [bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = ...
    optimizeParametersAdvanced(alphaMax, betaMax, strategy, mu, lambda, adaptMutation, maxRounds, initialSigma)
    
    % default values
    if nargin < 3
        strategy = 'plus';  % 'plus' for (μ+λ) or 'comma' for (μ,λ)
    end
    if nargin < 4
        mu = 1;  % number of parents
    end
    if nargin < 5
        lambda = 50;  % number of offspring
    end
    if nargin < 6
        adaptMutation = true;  % adapt mutation strength or not
    end
    if nargin < 7
        maxRounds = 1000;  % maximum number of generations
    end
    if nargin < 8
        initialSigma = 1.0;  % initial mutation strength
    end
    
    % Initialize parent population
    parents = zeros(mu, 4); % [alpha, beta, fitness, sigma]
    for i = 1:mu
        alpha = rand * alphaMax;
        beta = rand * betaMax;
        fitness = evaluateReindeerOutbreak(alpha, beta, false);
        parents(i,:) = [alpha, beta, fitness, initialSigma];
    end

    % ascending sort parents by fitness 
    parents = sortrows(parents, 3);
    bestFitness = parents(1,3);
    
    % init progress
    alphaProgress = zeros(1, maxRounds);
    betaProgress = zeros(1, maxRounds);

    % evolution
    for round = 1:maxRounds
        % store current best
        alphaProgress(round) = parents(1,1);
        betaProgress(round) = parents(1,2);
        
        % generate lambda offspring with random mutations
        offspring = zeros(lambda, 4);
        for i = 1:lambda
            % select random parent
            parentIdx = randi(mu);
            parentSigma = parents(parentIdx,4);
            
            newAlpha = parents(parentIdx,1) + randn * parentSigma;
            newBeta = parents(parentIdx,2) + randn * parentSigma;
            newFitness = evaluateReindeerOutbreak(newAlpha, newBeta, false);
            
            % Adapt mutation strength if enabled
            if adaptMutation
                newSigma = parentSigma * exp(randn * 0.1);
                newSigma = max(0.01, min(2.0, newSigma)); % Bound sigma
            else
                newSigma = parentSigma;
            end
            
            offspring(i,:) = [newAlpha, newBeta, newFitness, newSigma];
        end

        % Selection based on selected strategy
        if strcmp(strategy, 'plus')
            % (μ+λ) strategy: select from both parents and offspring
            combined = [parents; offspring];
            sorted = sortrows(combined, 3); % Sort by fitness
            parents = sorted(1:mu,:);
        else
            % (μ,λ) strategy: select only from offspring
            sorted = sortrows(offspring, 3);
            parents = sorted(1:mu,:);
        end
        
        % assign new best fitness
        if parents(1,3) < bestFitness
            bestFitness = parents(1,3);
        end
        
        % stop if mutation size is too small (4th col is sigma)
        if all(parents(:,4) < 0.01) 
            break;
        end
    end
    
    % return optimal parameters
    bestAlpha = parents(1,1);
    bestBeta = parents(1,2);
end
```

Evaluierungs-Funktion (übernommen aus der gemeinsamen Übung)
```matlab
function fitness = evaluateReindeerOutbreak(alpha, beta, plotIt)
    if nargin < 3
        plotIt = false;
    end
    timeStep = 0.01;
    maxTime = 14;

    % observed data
    days = 0:14;
    observedInfected = [1, 5, 10, 30, 90, 220, 280, 240, 230, 190, 130, 80, 55, 15, 4];
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
```

Hilfsfunktion zum Plotten (übernommen aus der gemeinsamen Übung)
```matlab
function plotFitnessLandscapeWithProgress(alpha, beta, alphaProgress, betaProgress)
    fitnessGrid = zeros(length(alpha), length(beta));
    xGrid = zeros(size(fitnessGrid));
    yGrid = zeros(size(fitnessGrid));

    for a = 1:length(alpha)
        for b = 1:length(beta)
            fitnessGrid(b, a) = log(evaluateReindeerOutbreak(alpha(a), beta(b), false));
            xGrid(b, a) = alpha(a);
            yGrid(b, a) = beta(b);
        end
    end

    figure;
    pcolor(xGrid, yGrid, fitnessGrid);
    shading interp;
    xlabel('Infectionrate');
    ylabel('Recoveryrate');

    title('Fitnesslandscape');
    colorbar;
    hold on;

    plot(alphaProgress, betaProgress, 'r');
    hold off;
end
```


### Aufruf
(als Matlab-LiveScript)

```matlab
alphaMax = 3;
betaMax = 3;

% we need that for plots (no other purpose)
alphaStep = 0.1;
betaStep = 0.1;
alpha = 0:alphaStep:alphaMax;
beta = 0:betaStep:betaMax;
```
```matlab
fprintf('function from the lecture');
[bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = optimizeParameters(alphaMax, betaMax);
plotFitnessLandscapeWithProgress(alpha, beta, alphaProgress, betaProgress);
evaluateReindeerOutbreak(bestAlpha, bestBeta, true);
fprintf('best fitness: %f\n', bestFitness);

fprintf('(1+50)-ES with mutation-adaption');
[bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = optimizeParametersAdvanced(alphaMax, betaMax);
plotFitnessLandscapeWithProgress(alpha, beta, alphaProgress, betaProgress);
evaluateReindeerOutbreak(bestAlpha, bestBeta, true);
fprintf('best fitness: %f\n', bestFitness);

fprintf('(1,50)-ES without mutation-adaption');
[bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = optimizeParametersAdvanced(alphaMax, betaMax,  'comma', 1, 50, false);
plotFitnessLandscapeWithProgress(alpha, beta, alphaProgress, betaProgress);
evaluateReindeerOutbreak(bestAlpha, bestBeta, true);
fprintf('best fitness: %f\n', bestFitness);

fprintf('(5+30)-ES with mutation-adaption');
[bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = optimizeParametersAdvanced(alphaMax, betaMax, 'plus', 5, 30, true, 500, 0.5);
plotFitnessLandscapeWithProgress(alpha, beta, alphaProgress, betaProgress);
evaluateReindeerOutbreak(bestAlpha, bestBeta, true);
fprintf('best fitness: %f\n', bestFitness);
```

### Ausgabe

```
function from the lecture
```
![alt text](lecture_map.jpg)
![alt text](lecture_plot.jpg)
```
best fitness: 6880.981981
```
```
(1+50)-ES with mutation-adaption
```
![alt text](1+50_map.jpg)
![alt text](lecture_plot.jpg)
```
best fitness: 6896.179022
```
```
(1,50)-ES without mutation-adaption
```
![alt text](1comma50_map.jpg)
![alt text](1comma50_plot.jpg)
```
best fitness: 6918.655194
```
```
(5+30)-ES with mutation-adaption
```
![alt text](5+30_map.jpg)
![alt text](5+30_plot.jpg)
```
best fitness: 6883.870593
```

### Tests mit verschiedenen Parametern

```
Test                                               | Alpha  | Beta   | Fitness  | Mu    | Sigma     
------------------------------------------------------------------------------------------
(1 plus 3)-ES, sigma=0.3                           |  1.581 |  0.278 | 6980.8097 |     1 |      0.300
(1 plus 3)-ES, sigma=0.7                           |  1.563 |  0.291 | 7123.4262 |     1 |      0.700
(1 plus 3)-ES, sigma=1.0                           |  1.580 |  0.281 | 6945.9835 |     1 |      1.000
(1 comma 3)-ES, sigma=0.3                          |  3.372 |  0.432 | 6901.6648 |     1 |      0.300
(1 comma 3)-ES, sigma=0.7                          |  1.978 |  0.409 | 6920.3906 |     1 |      0.700
(1 comma 3)-ES, sigma=1.0                          |  0.000 |  0.000 | 6982.2265 |     1 |      1.000
(1 plus 7)-ES, sigma=0.3                           |  1.573 |  0.283 | 6897.9234 |     1 |      0.300
(1 plus 7)-ES, sigma=0.7                           |  1.567 |  0.280 | 6883.3144 |     1 |      0.700
(1 plus 7)-ES, sigma=1.0                           |  1.579 |  0.274 | 7092.1450 |     1 |      1.000
(1 comma 7)-ES, sigma=0.3                          |  1.651 |  0.502 | 7103.2311 |     1 |      0.300
(1 comma 7)-ES, sigma=0.7                          |  1.566 |  0.287 | 6881.2796 |     1 |      0.700
(1 comma 7)-ES, sigma=1.0                          |  1.592 |  0.325 | 6881.1707 |     1 |      1.000
(1 plus 10)-ES, sigma=0.3                          |  1.570 |  0.282 | 6883.2462 |     1 |      0.300
(1 plus 10)-ES, sigma=0.7                          |  1.583 |  0.283 | 6970.7361 |     1 |      0.700
(1 plus 10)-ES, sigma=1.0                          |  1.548 |  0.277 | 7057.8030 |     1 |      1.000
(1 comma 10)-ES, sigma=0.3                         |  1.828 |  0.223 | 6881.8774 |     1 |      0.300
(1 comma 10)-ES, sigma=0.7                         |  1.568 |  0.243 | 6935.9375 |     1 |      0.700
(1 comma 10)-ES, sigma=1.0                         |  1.601 |  0.385 | 7042.6196 |     1 |      1.000
(1 plus 20)-ES, sigma=0.3                          |  1.566 |  0.282 | 6884.5483 |     1 |      0.300
(1 plus 20)-ES, sigma=0.7                          |  1.568 |  0.273 | 7056.6808 |     1 |      0.700
(1 plus 20)-ES, sigma=1.0                          |  1.568 |  0.292 | 7162.8563 |     1 |      1.000
(1 comma 20)-ES, sigma=0.3                         |  2.536 |  1.142 | 6883.4211 |     1 |      0.300
(1 comma 20)-ES, sigma=0.7                         |  1.735 |  0.291 | 6889.5722 |     1 |      0.700
(1 comma 20)-ES, sigma=1.0                         |  1.560 |  0.280 | 6881.9860 |     1 |      1.000
(3 plus 9)-ES, sigma=0.3                           |  1.567 |  0.282 | 6882.2483 |     3 |      0.300
(3 plus 9)-ES, sigma=0.7                           |  1.572 |  0.273 | 7066.9276 |     3 |      0.700
(3 plus 9)-ES, sigma=1.0                           |  1.559 |  0.287 | 7002.9780 |     3 |      1.000
(3 comma 9)-ES, sigma=0.3                          |  1.588 |  0.276 | 6880.9997 |     3 |      0.300
(3 comma 9)-ES, sigma=0.7                          |  1.559 |  0.280 | 6881.0522 |     3 |      0.700
(3 comma 9)-ES, sigma=1.0                          |  1.574 |  0.281 | 6881.1068 |     3 |      1.000
(3 plus 21)-ES, sigma=0.3                          |  1.567 |  0.283 | 6884.9161 |     3 |      0.300
(3 plus 21)-ES, sigma=0.7                          |  1.564 |  0.282 | 6887.7500 |     3 |      0.700
(3 plus 21)-ES, sigma=1.0                          |  1.578 |  0.286 | 6953.3136 |     3 |      1.000
(3 comma 21)-ES, sigma=0.3                         |  1.566 |  0.282 | 6880.9985 |     3 |      0.300
(3 comma 21)-ES, sigma=0.7                         |  1.572 |  0.281 | 6881.0006 |     3 |      0.700
(3 comma 21)-ES, sigma=1.0                         |  1.567 |  0.279 | 6881.0552 |     3 |      1.000
(3 plus 30)-ES, sigma=0.3                          |  1.563 |  0.278 | 6912.6904 |     3 |      0.300
(3 plus 30)-ES, sigma=0.7                          |  1.564 |  0.284 | 6911.0755 |     3 |      0.700
(3 plus 30)-ES, sigma=1.0                          |  1.578 |  0.281 | 6922.7604 |     3 |      1.000
(3 comma 30)-ES, sigma=0.3                         |  1.573 |  0.281 | 6881.0050 |     3 |      0.300
(3 comma 30)-ES, sigma=0.7                         |  1.564 |  0.282 | 6880.9836 |     3 |      0.700
(3 comma 30)-ES, sigma=1.0                         |  1.571 |  0.282 | 6881.0089 |     3 |      1.000
(3 plus 60)-ES, sigma=0.3                          |  1.565 |  0.280 | 6886.9421 |     3 |      0.300
(3 plus 60)-ES, sigma=0.7                          |  1.567 |  0.283 | 6886.1483 |     3 |      0.700
(3 plus 60)-ES, sigma=1.0                          |  1.563 |  0.280 | 6891.8401 |     3 |      1.000
(3 comma 60)-ES, sigma=0.3                         |  1.566 |  0.280 | 6880.9870 |     3 |      0.300
(3 comma 60)-ES, sigma=0.7                         |  1.560 |  0.281 | 6880.9900 |     3 |      0.700
(3 comma 60)-ES, sigma=1.0                         |  1.568 |  0.279 | 6880.9824 |     3 |      1.000
(7 plus 21)-ES, sigma=0.3                          |  1.574 |  0.281 | 6895.9432 |     7 |      0.300
(7 plus 21)-ES, sigma=0.7                          |  1.567 |  0.285 | 6920.1601 |     7 |      0.700
(7 plus 21)-ES, sigma=1.0                          |  1.565 |  0.272 | 7080.6929 |     7 |      1.000
(7 comma 21)-ES, sigma=0.3                         |  1.570 |  0.282 | 6880.9818 |     7 |      0.300
(7 comma 21)-ES, sigma=0.7                         |  1.568 |  0.282 | 6881.0010 |     7 |      0.700
(7 comma 21)-ES, sigma=1.0                         |  1.568 |  0.282 | 6880.9931 |     7 |      1.000
(7 plus 49)-ES, sigma=0.3                          |  1.567 |  0.281 | 6881.2723 |     7 |      0.300
(7 plus 49)-ES, sigma=0.7                          |  1.565 |  0.281 | 6885.1844 |     7 |      0.700
(7 plus 49)-ES, sigma=1.0                          |  1.569 |  0.281 | 6881.3700 |     7 |      1.000
(7 comma 49)-ES, sigma=0.3                         |  1.570 |  0.282 | 6880.9815 |     7 |      0.300
(7 comma 49)-ES, sigma=0.7                         |  1.569 |  0.280 | 6880.9865 |     7 |      0.700
(7 comma 49)-ES, sigma=1.0                         |  1.572 |  0.282 | 6880.9817 |     7 |      1.000
(7 plus 70)-ES, sigma=0.3                          |  1.570 |  0.281 | 6883.4103 |     7 |      0.300
(7 plus 70)-ES, sigma=0.7                          |  1.570 |  0.281 | 6883.1114 |     7 |      0.700
(7 plus 70)-ES, sigma=1.0                          |  1.571 |  0.281 | 6885.0751 |     7 |      1.000
(7 comma 70)-ES, sigma=0.3                         |  1.565 |  0.282 | 6880.9872 |     7 |      0.300
(7 comma 70)-ES, sigma=0.7                         |  1.568 |  0.281 | 6880.9816 |     7 |      0.700
(7 comma 70)-ES, sigma=1.0                         |  1.568 |  0.282 | 6880.9832 |     7 |      1.000
(7 plus 140)-ES, sigma=0.3                         |  1.567 |  0.281 | 6881.1909 |     7 |      0.300
(7 plus 140)-ES, sigma=0.7                         |  1.568 |  0.284 | 6892.0834 |     7 |      0.700
(7 plus 140)-ES, sigma=1.0                         |  1.563 |  0.281 | 6891.8357 |     7 |      1.000
(7 comma 140)-ES, sigma=0.3                        |  1.566 |  0.281 | 6880.9845 |     7 |      0.300
(7 comma 140)-ES, sigma=0.7                        |  1.568 |  0.281 | 6880.9813 |     7 |      0.700
(7 comma 140)-ES, sigma=1.0                        |  1.567 |  0.281 | 6880.9814 |     7 |      1.000
(10 plus 30)-ES, sigma=0.3                         |  1.566 |  0.282 | 6883.2258 |    10 |      0.300
(10 plus 30)-ES, sigma=0.7                         |  1.568 |  0.282 | 6883.8309 |    10 |      0.700
(10 plus 30)-ES, sigma=1.0                         |  1.570 |  0.285 | 6918.9759 |    10 |      1.000
(10 comma 30)-ES, sigma=0.3                        |  1.565 |  0.280 | 6880.9941 |    10 |      0.300
(10 comma 30)-ES, sigma=0.7                        |  1.569 |  0.283 | 6881.0168 |    10 |      0.700
(10 comma 30)-ES, sigma=1.0                        |  1.567 |  0.282 | 6881.0012 |    10 |      1.000
(10 plus 70)-ES, sigma=0.3                         |  1.565 |  0.282 | 6884.6621 |    10 |      0.300
(10 plus 70)-ES, sigma=0.7                         |  1.563 |  0.281 | 6891.3251 |    10 |      0.700
(10 plus 70)-ES, sigma=1.0                         |  1.567 |  0.282 | 6882.0074 |    10 |      1.000
(10 comma 70)-ES, sigma=0.3                        |  1.569 |  0.282 | 6880.9858 |    10 |      0.300
(10 comma 70)-ES, sigma=0.7                        |  1.567 |  0.280 | 6880.9819 |    10 |      0.700
(10 comma 70)-ES, sigma=1.0                        |  1.573 |  0.282 | 6880.9805 |    10 |      1.000
(10 plus 100)-ES, sigma=0.3                        |  1.568 |  0.281 | 6882.2645 |    10 |      0.300
(10 plus 100)-ES, sigma=0.7                        |  1.564 |  0.280 | 6887.5890 |    10 |      0.700
(10 plus 100)-ES, sigma=1.0                        |  1.569 |  0.282 | 6883.8717 |    10 |      1.000
(10 comma 100)-ES, sigma=0.3                       |  1.569 |  0.281 | 6880.9814 |    10 |      0.300
(10 comma 100)-ES, sigma=0.7                       |  1.568 |  0.281 | 6880.9849 |    10 |      0.700
(10 comma 100)-ES, sigma=1.0                       |  1.566 |  0.282 | 6880.9863 |    10 |      1.000
(10 plus 200)-ES, sigma=0.3                        |  1.568 |  0.281 | 6881.0101 |    10 |      0.300
(10 plus 200)-ES, sigma=0.7                        |  1.567 |  0.282 | 6881.3778 |    10 |      0.700
(10 plus 200)-ES, sigma=1.0                        |  1.563 |  0.282 | 6890.4346 |    10 |      1.000
(10 comma 200)-ES, sigma=0.3                       |  1.567 |  0.281 | 6880.9825 |    10 |      0.300
(10 comma 200)-ES, sigma=0.7                       |  1.568 |  0.282 | 6880.9817 |    10 |      0.700
(10 comma 200)-ES, sigma=1.0                       |  1.568 |  0.281 | 6880.9804 |    10 |      1.000
(20 plus 60)-ES, sigma=0.3                         |  1.567 |  0.282 | 6881.1196 |    20 |      0.300
(20 plus 60)-ES, sigma=0.7                         |  1.567 |  0.281 | 6881.6941 |    20 |      0.700
(20 plus 60)-ES, sigma=1.0                         |  1.569 |  0.282 | 6882.0643 |    20 |      1.000
(20 comma 60)-ES, sigma=0.3                        |  1.568 |  0.281 | 6880.9877 |    20 |      0.300
(20 comma 60)-ES, sigma=0.7                        |  1.564 |  0.283 | 6880.9846 |    20 |      0.700
(20 comma 60)-ES, sigma=1.0                        |  1.560 |  0.280 | 6880.9855 |    20 |      1.000
(20 plus 140)-ES, sigma=0.3                        |  1.568 |  0.281 | 6881.0325 |    20 |      0.300
(20 plus 140)-ES, sigma=0.7                        |  1.568 |  0.281 | 6881.1832 |    20 |      0.700
(20 plus 140)-ES, sigma=1.0                        |  1.568 |  0.282 | 6883.1588 |    20 |      1.000
(20 comma 140)-ES, sigma=0.3                       |  1.570 |  0.282 | 6880.9813 |    20 |      0.300
(20 comma 140)-ES, sigma=0.7                       |  1.569 |  0.282 | 6880.9847 |    20 |      0.700
(20 comma 140)-ES, sigma=1.0                       |  1.569 |  0.282 | 6880.9816 |    20 |      1.000
(20 plus 200)-ES, sigma=0.3                        |  1.568 |  0.281 | 6881.2651 |    20 |      0.300
(20 plus 200)-ES, sigma=0.7                        |  1.567 |  0.281 | 6882.8642 |    20 |      0.700
(20 plus 200)-ES, sigma=1.0                        |  1.568 |  0.282 | 6881.8198 |    20 |      1.000
(20 comma 200)-ES, sigma=0.3                       |  1.568 |  0.281 | 6880.9809 |    20 |      0.300
(20 comma 200)-ES, sigma=0.7                       |  1.567 |  0.282 | 6880.9832 |    20 |      0.700
(20 comma 200)-ES, sigma=1.0                       |  1.566 |  0.281 | 6880.9808 |    20 |      1.000
(20 plus 400)-ES, sigma=0.3                        |  1.568 |  0.281 | 6880.9989 |    20 |      0.300
(20 plus 400)-ES, sigma=0.7                        |  1.566 |  0.281 | 6882.9837 |    20 |      0.700
(20 plus 400)-ES, sigma=1.0                        |  1.569 |  0.282 | 6881.4605 |    20 |      1.000
(20 comma 400)-ES, sigma=0.3                       |  1.568 |  0.282 | 6880.9818 |    20 |      0.300
(20 comma 400)-ES, sigma=0.7                       |  1.569 |  0.281 | 6880.9806 |    20 |      0.700
(20 comma 400)-ES, sigma=1.0                       |  1.568 |  0.281 | 6880.9815 |    20 |      1.000
(1plus10)-ES ohne Adapt, sigma=0.3                 |  1.565 |  0.281 | 6885.0476 |     1 |      0.300
(1plus10)-ES ohne Adapt, sigma=0.7                 |  1.560 |  0.281 | 6908.2036 |     1 |      0.700
(1comma10)-ES ohne Adapt, sigma=0.3                |  1.785 |  0.284 | 6910.1096 |     1 |      0.300
(1comma10)-ES ohne Adapt, sigma=0.7                |  1.871 |  0.246 | 6948.1251 |     1 |      0.700
(1plus15)-ES ohne Adapt, sigma=0.3                 |  1.566 |  0.281 | 6882.7149 |     1 |      0.300
(1plus15)-ES ohne Adapt, sigma=0.7                 |  1.564 |  0.278 | 6908.4689 |     1 |      0.700
(1comma15)-ES ohne Adapt, sigma=0.3                |  1.696 |  0.325 | 6935.2220 |     1 |      0.300
(1comma15)-ES ohne Adapt, sigma=0.7                |  1.348 |  0.425 | 6939.9874 |     1 |      0.700
(5plus50)-ES ohne Adapt, sigma=0.3                 |  1.567 |  0.281 | 6882.6107 |     5 |      0.300
(5plus50)-ES ohne Adapt, sigma=0.7                 |  1.557 |  0.286 | 6996.5956 |     5 |      0.700
(5comma50)-ES ohne Adapt, sigma=0.3                |  1.530 |  0.288 | 6892.5603 |     5 |      0.300
(5comma50)-ES ohne Adapt, sigma=0.7                |  1.431 |  0.278 | 6884.7090 |     5 |      0.700
(5plus75)-ES ohne Adapt, sigma=0.3                 |  1.566 |  0.280 | 6886.7405 |     5 |      0.300
(5plus75)-ES ohne Adapt, sigma=0.7                 |  1.561 |  0.279 | 6904.1724 |     5 |      0.700
(5comma75)-ES ohne Adapt, sigma=0.3                |  1.591 |  0.305 | 6886.4315 |     5 |      0.300
(5comma75)-ES ohne Adapt, sigma=0.7                |  1.556 |  0.254 | 6917.1970 |     5 |      0.700
(10plus100)-ES ohne Adapt, sigma=0.3               |  1.568 |  0.281 | 6881.2353 |    10 |      0.300
(10plus100)-ES ohne Adapt, sigma=0.7               |  1.568 |  0.283 | 6888.5109 |    10 |      0.700
(10comma100)-ES ohne Adapt, sigma=0.3              |  1.585 |  0.265 | 6882.2348 |    10 |      0.300
(10comma100)-ES ohne Adapt, sigma=0.7              |  1.750 |  0.288 | 6885.0769 |    10 |      0.700
(10plus150)-ES ohne Adapt, sigma=0.3               |  1.569 |  0.282 | 6881.8258 |    10 |      0.300
(10plus150)-ES ohne Adapt, sigma=0.7               |  1.571 |  0.281 | 6888.6397 |    10 |      0.700
(10comma150)-ES ohne Adapt, sigma=0.3              |  1.622 |  0.295 | 6883.4378 |    10 |      0.300
(10comma150)-ES ohne Adapt, sigma=0.7              |  1.657 |  0.262 | 6881.4085 |    10 |      0.700

Beste Konfiguration insgesamt:
(10 comma 200)-ES, sigma=1.0 (Adaptiv: 1) 
Alpha: 1.5678, Beta: 0.2810, Fitness: 6880.9804

=== Statistische Analyse ===

comma-Strategie, Adaptiv: 1
Anzahl Tests: 60
Mittlere Fitness: 6891.2171 (±37.8599)
Beste Fitness: 6880.9804

comma-Strategie, Adaptiv: 0
Anzahl Tests: 12
Mittlere Fitness: 6903.8750 (±25.2350)
Beste Fitness: 6881.4085

plus-Strategie, Adaptiv: 1
Anzahl Tests: 60
Mittlere Fitness: 6918.7102 (±69.4245)
Beste Fitness: 6880.9989

plus-Strategie, Adaptiv: 0
Anzahl Tests: 12
Mittlere Fitness: 6899.5638 (±32.2334)
Beste Fitness: 6881.2353
```

## **Aufgabe 2** Control of a water tank

Model the control of the water tank discussed in the lecture; design and test both P - and PI -controllers. Document your parameter settings and the corresponding test results. In how far do we see that the P-controller has advantages and disadvantages? Is this also the case for PI controllers? How do different control parameters affect the results?


### P-Regler

![alt text](p_regler.png)

![alt text](p_regler_plot.png)

### PI-Regler

![alt text](pi_regler.png)

![alt text](pi_regler_plot.png)

### Beobachtungen

#### P-Regler
**Vorteile:**

- Einfache Implementierung und Einstellung über einen einzigen Parameter ($Kp$)
- Schnelle Reaktion auf Störungen
- Stabil bei richtig gewähltem $Kp$

**Nachteile:**

- Bleibende Regelabweichung im stabilen Zustand
- Bei zu hohem $Kp$ kann es zu Oszillationen kommen
- Kompromiss zwischen Schnelligkeit und Genauigkeit notwendig

#### PI-Regler
**Vorteile:**

- Keine bleibende Regelabweichung durch den I-Anteil

**Nachteile:**

- Komplexere Parametereinstellung ($Kp$ und $Tn$ müssen aufeinander abgestimmt werden)
- Langsamere Reaktion als reiner P-Regler
- Mögliche Überschwinger durch I-Anteil
- Potentiell längere Ausregelzeit

#### Parameter

**P-Regler:**
- Höheres $Kp$: schnellere Reaktion, aber mehr Schwingungsneigung
- Niedrigeres $Kp$: stabileres Verhalten, aber größere bleibende Regelabweichung

**PI-Regler:**
- $Kp$ beeinflusst hauptsächlich die Schnelligkeit der Regelung
- Kleines $Tn$: schnellerer Ausgleich der Regelabweichung, aber mehr Überschwinger
- Großes $Tn$: stabileres Verhalten, aber langsamerer Ausgleich


## Anhang Testcode für Aufgabe 1

```matlab
% constants for all tests
global testCounter results alphaMax betaMax maxRounds;
alphaMax = 5;
betaMax = 5;
maxRounds = 1000;

% test init
testCounter = 1;
results = struct();

% helper function to run a test
function runTest(testName, mu, lambda, strategy, adaptMutation, initialSigma)
    global testCounter results alphaMax betaMax maxRounds;
    fprintf('Test %d: %s\n', testCounter, testName);
    
    % perform ES
    [bestAlpha, bestBeta, bestFitness] = ...
        optimizeParametersAdvanced(alphaMax, betaMax, strategy, mu, lambda, ...
        adaptMutation, maxRounds, initialSigma);

    evaluateReindeerOutbreak(bestAlpha, bestBeta, false);
    
    % store result in structure
    results(testCounter).name = testName;
    results(testCounter).bestAlpha = bestAlpha;
    results(testCounter).bestBeta = bestBeta;
    results(testCounter).bestFitness = bestFitness;
    results(testCounter).strategy = strategy;
    results(testCounter).adaptMutation = adaptMutation;
    results(testCounter).lambda = lambda;
    results(testCounter).mu = mu;
    results(testCounter).initialSigma = initialSigma;
    
    testCounter = testCounter + 1;
end

mu_values = [1, 3, 7, 10, 20];
lambda_factors = [3, 7, 10, 20];  % lambda = mu * lambda_factor
strategies = {'plus', 'comma'};
sigma_values = [0.3, 0.7, 1.0];

% test loop(s)
for mu = mu_values
    for lambda_factor = lambda_factors
        lambda = mu * lambda_factor;
        for strategy = strategies
            for sigma = sigma_values
                testName = sprintf('(%d %s %d)-ES, sigma=%.1f', ...
                    mu, char(strategy), lambda, sigma);
                runTest(testName, mu, lambda, char(strategy), true, sigma);
            end
        end
    end
end

% tests without mutation adaption
selected_mus = [1, 5, 10];
selected_lambda_factors = [10, 15];
selected_sigmas = [0.3, 0.7];

for mu = selected_mus
    for lambda_factor = selected_lambda_factors
        lambda = mu * lambda_factor;
        for strategy = strategies
            for sigma = selected_sigmas
                testName = sprintf('(%d%s%d)-ES ohne Adapt, sigma=%.1f', ...
                    mu, char(strategy), lambda, sigma);
                runTest(testName, mu, lambda, char(strategy), false, sigma);
            end
        end
    end
end

% print table
fprintf('\n=== Vergleich aller Tests ===\n');
fprintf('%-50s | %-6s | %-6s | %-8s | %-5s | %-10s\n', ...
    'Test', 'Alpha', 'Beta', 'Fitness', 'Mu', 'Sigma');
fprintf('%s\n', repmat('-', 1, 90));

for i = 1:length(results)
    fprintf('%-50s | %6.3f | %6.3f | %8.4f | %5d | %10.3f\n', ...
        results(i).name, ...
        results(i).bestAlpha, ...
        results(i).bestBeta, ...
        results(i).bestFitness, ...
        results(i).mu, ...
        results(i).initialSigma);
end

% find best configuration
[~, bestIdx] = min([results.bestFitness]);
fprintf('\nBeste Konfiguration insgesamt:\n');
fprintf('%s (Adaptiv: %d) \n', results(bestIdx).name, results(bestIdx).adaptMutation);
fprintf('Alpha: %.4f, Beta: %.4f, Fitness: %.4f\n', ...
    results(bestIdx).bestAlpha, ...
    results(bestIdx).bestBeta, ...
    results(bestIdx).bestFitness);

% analysis
strategies_used = unique({results.strategy});
adapt_options = [true, false];

fprintf('\n=== Statistische Analyse ===\n');
for strat = strategies_used
    for adapt = adapt_options
        idx = strcmp({results.strategy}, strat) & [results.adaptMutation] == adapt;
        if any(idx)
            fprintf('\n%s-Strategie, Adaptiv: %d\n', char(strat), adapt);
            fprintf('Anzahl Tests: %d\n', sum(idx));
            fprintf('Mittlere Fitness: %.4f (±%.4f)\n', ...
                mean([results(idx).bestFitness]), ...
                std([results(idx).bestFitness]));
            fprintf('Beste Fitness: %.4f\n', min([results(idx).bestFitness]));
        end
    end
end
```


