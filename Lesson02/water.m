%
function water(X0, A, B, u, tStep, tMax)
    if nargin==0 %number of input arguments is 0
        X0 =  100000; % inital value
        A = log(0.95); % waterloss
        B = 1; % weight
        u = 1000; % inflow
        tStep = 0.01;
        tMax = 100;
    end

    x = X0;
    xProgress = [];

    for t = 0:tStep:tMax
        x_ = A*x + B*u;
        x = x + x_*tStep;
        xProgress = [xProgress x ];
    end

plot(0:tStep:tMax , xProgress);

end