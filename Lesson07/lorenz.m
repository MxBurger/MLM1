tStep = 0.01;
tMax = 20;

a = 0.5;
b = 0.3;
c = 0.4;

x = 20;
y = 10;
z = 15;


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
    x_ = a * (y - x);
    y_ = -x * z + b * x - y;
    z_ = x * y - c * x;

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