tStep = 0.01;
tMax = 100;

a = 1;
c = 5;

x = 1;
y = 0;
z = 0;


xProgress = zeros(tMax/tStep, 1);
yProgress = zeros(tMax/tStep, 1);
zProgress = zeros(tMax/tStep, 1);
tProgress = zeros(tMax/tStep, 1);

i = 1;

for t=0:tStep:tMax
    % save state
    tProgress(i) = t;
    xProgress(i) = x;
    yProgress(i) = y;
    zProgress(i) = z;

    % compute derivatives
    x_ = z * y - a * x;
    y_ = (z - c) * x - a * y;
    z_ = 1 - x * y;

    x = x + x_ * tStep;
    y = y + y_ * tStep;
    z = z + z_ * tStep;

    i = i + 1;
end

figure;
plot(tProgress, [xProgress, yProgress, zProgress]);

figure;
plot(xProgress, yProgress);
hold on;
plot(xProgress, zProgress, 'g');
hold off;