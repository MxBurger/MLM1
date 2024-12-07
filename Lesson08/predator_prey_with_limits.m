B = 400;
R = 80;

tMax = 200;
tStepSize = 0.001;

alpha = 0.1;
beta = 0.002;
gamma = 0.05;
delta = 0.001;

e1 = 0.01;
e2 = 0.02;

bProgress = zeros(tMax/tStepSize + 1, 1);
rProgress = zeros(tMax/tStepSize + 1, 1);
tProgress = zeros(tMax/tStepSize + 1, 1);

i = 1;

for t=0:tStepSize:tMax
    % derivatives
    b_ = alpha*B - beta*B*R - e1*B;
    r_ = -gamma*R + delta*B*R - e2*R;

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