B = 0.2;
R = 0.2;

tMax = 200;
tStepSize = 0.00001;

a1 = 1;
a2 = 1;
a3 = 1.5;
a4 = 0.2;
a5 = 0.4;
a6 = 1;

bProgress = zeros(tMax/tStepSize + 1, 1);
rProgress = zeros(tMax/tStepSize + 1, 1);
tProgress = zeros(tMax/tStepSize + 1, 1);

i = 1;

for t=0:tStepSize:tMax
    % derivatives
    b_ = B * (a1 * (1 - B / a2) - a3 *R / (B + a4));
    r_ = R * a5 * (1 - a6 *(R/B));

    B = B + b_ * tStepSize;
    R = R + r_ * tStepSize;

    bProgress(i) = B;
    rProgress(i) = R;
    tProgress(i) = t;

    i = i + 1;

end

plot(tProgress, bProgress, 'b');
hold on;
plot(tProgress, rProgress, 'r');
hold off;

figure;
plot(bProgress, rProgress);
xlabel('Prey');
ylabel('Predator');