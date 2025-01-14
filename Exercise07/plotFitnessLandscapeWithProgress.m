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