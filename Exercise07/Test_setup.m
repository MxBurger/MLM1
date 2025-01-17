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
