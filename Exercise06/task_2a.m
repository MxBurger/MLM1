function task_2a(N)
   % Model parameters
   if nargin < 1, N = 100;  end
   % Population size
   beta = 0.1;     % Recovery rate (1/10 days)
   R0 = 7.5;       % Basic reproduction number
   alpha = R0 * beta;  % Infection rate
   tMax = 30;      % Simulation time
   dt = 0.01;      % Time step

   % Initial conditions
   S = N - 1;
   I = 1;
   R = 0;

   % Arrays for storing results
   steps = tMax/dt;
   Sprogress = zeros(steps, 1);  
   Iprogress = zeros(steps, 1);
   Rprogress = zeros(steps, 1);
   time = zeros(steps, 1);

   % Simulate using Euler method
   for i = 1:steps
       % Store current state
       Sprogress(i) = S;
       Iprogress(i) = I;
       Rprogress(i) = R;
       time(i) = (i-1)*dt;

       % Calculate derivatives
       dSdt = -alpha * S * I / N;
       dIdt = alpha * S * I / N - beta * I;
       dRdt = beta * I;

       % Update using Euler step
       S = S + dSdt * dt;
       I = I + dIdt * dt;
       R = R + dRdt * dt;
   end

   % Plot time evolution
   figure(1);
   plot(time, [Sprogress Iprogress Rprogress]);
   legend('Susceptible', 'Infected', 'Recovered');
   xlabel('Time (days)');
   ylabel('Population');
   title('SIR Model Time Evolution');
   grid on;

   % Plot phase portrait
   figure(2);
   plot(Sprogress, Iprogress);
   xlabel('Susceptible Population');
   ylabel('Infected Population');
   title('Phase Portrait (S-I)');
   grid on;
end