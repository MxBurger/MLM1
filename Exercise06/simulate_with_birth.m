function [t, S, I, R] = simulate_with_birth(N, alpha, beta, mu, p, tMax, dt)
   steps = tMax/dt;
   S = zeros(steps, 1);
   I = zeros(steps, 1);
   R = zeros(steps, 1);
   t = (0:dt:tMax-dt)';

   % Initial conditions
   S(1) = N-1;
   I(1) = 1;
   R(1) = 0;

   % Simulate using Euler method
   for i = 1:steps-1
       dSdt = -alpha*S(i)*I(i)/N - mu*S(i) + mu*N*(1-p);
       dIdt = alpha*S(i)*I(i)/N - beta*I(i) - mu*I(i);
       dRdt = beta*I(i) - mu*R(i) + mu*N*p;

       S(i+1) = S(i) + dSdt*dt;
       I(i+1) = I(i) + dIdt*dt;
       R(i+1) = R(i) + dRdt*dt;
   end
end