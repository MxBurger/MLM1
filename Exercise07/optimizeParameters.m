function [bestAlpha, bestBeta, bestFitness, alphaProgress, betaProgress] = optimizeParameters(alphaMax,betaMax)
    maxRounds = 1000;
    sigma = 1;
    lambda = 50;

    alpha = rand * alphaMax;
    beta = rand * betaMax;
    bestFitness = evaluateReindeerOutbreak(alpha, beta, false);

    % evolution
    for round = 1:maxRounds
        alphaProgress(round) = alpha;
        betaProgress(round) = beta;
        

        % generate lambda offspring with random mutations
        offspring = zeros(lambda, 3);
        for i = 1:lambda
            newAlpha = alpha + randn * sigma;
            newBeta = beta + randn * sigma;
            newFitness = evaluateReindeerOutbreak(newAlpha, newBeta, false);
            offspring(i, :) = [newAlpha, newBeta, newFitness];
        end
        
        % select the best offspring
        [minFitness, bestOffspringIdx] = min(offspring(:, 3));
        bestOffspring = offspring(bestOffspringIdx, :);

        % update parent if the best offspring improves fitness
        if minFitness < bestFitness
            alpha = bestOffspring(1);
            beta = bestOffspring(2);
            bestFitness = minFitness;
            sigma = sigma / 0.9;
        else
            sigma = sigma * 0.9;
        end


        % stop if mutation size is too small
        if sigma < 0.01
            sigma = 0.01;
        end
    end
    
    % return optimal parameters and progress
    bestAlpha = alpha;
    bestBeta = beta;
end