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
            
            newAlpha = max(0, min(alphaMax, parents(parentIdx,1) + randn * parentSigma));
            newBeta = max(0, min(betaMax, parents(parentIdx,2) + randn * parentSigma));
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