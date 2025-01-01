function task_3b(N)
   % Model parameters
   if nargin < 1, N = 1000; end
   beta = 0.1;         % Recovery rate (1/10 days)
   R0 = 7.5;          % Basic reproduction number
   alpha = R0 * beta;  % Infection rate
   mu = 0.0003;       % Birth/death rate
   pcrit = 1 - 1/R0;  % Critical vaccination rate
   tMax = 100;        % Simulation time in weeks
   dt = 0.01;         % Time step

   % Initial conditions
   % No vaccination
   S1 = N - 1;
   I1 = 1;
   R1 = 0;
   % With vaccination
   S2 = N - 1;
   I2 = 1;
   R2 = 0;  

   % Arrays for storing results
   steps = tMax/dt;
   S1_prog = zeros(steps, 1);
   I1_prog = zeros(steps, 1);
   R1_prog = zeros(steps, 1);

   S2_prog = zeros(steps, 1);
   I2_prog = zeros(steps, 1);
   R2_prog = zeros(steps, 1);
   time = zeros(steps, 1);

   % Simulate using Euler method
   for i = 1:steps
       % Store current state
       S1_prog(i) = S1; I1_prog(i) = I1; R1_prog(i) = R1;
       S2_prog(i) = S2; I2_prog(i) = I2; R2_prog(i) = R2;
       time(i) = (i-1)*dt;

       % No vaccination
       dS1 = -alpha*S1*I1/N - mu*S1 + mu*N;
       dI1 = alpha*S1*I1/N - beta*I1 - mu*I1;
       dR1 = beta*I1 - mu*R1;

       % With vaccination
       dS2 = -alpha*S2*I2/N - mu*S2 + mu*N*(1-pcrit);
       dI2 = alpha*S2*I2/N - beta*I2 - mu*I2;
       dR2 = beta*I2 - mu*R2 + mu*N*pcrit;

       % Update using Euler step
       S1 = S1 + dS1*dt; I1 = I1 + dI1*dt; R1 = R1 + dR1*dt;
       S2 = S2 + dS2*dt; I2 = I2 + dI2*dt; R2 = R2 + dR2*dt;
   end

   % Plot time evolution
   figure(1);
   subplot(2,1,1);
   plot(time, [S1_prog I1_prog R1_prog]);
   title('SIR with Demographics (No Vaccination)');
   legend('S', 'I', 'R');
   xlabel('Time (weeks)');
   ylabel('Population');
   grid on;

   subplot(2,1,2);
   plot(time, [S2_prog I2_prog R2_prog]);
   title(['SIR with Demographics (p = ' num2str(pcrit) ')']);
   legend('S', 'I', 'R');
   xlabel('Time (weeks)');
   ylabel('Population');
   grid on;

   % Plot phase portraits
   figure(2);
   subplot(2,1,1);
   plot(S1_prog, I1_prog);
   title('Phase Portrait (No Vaccination)');
   xlabel('Susceptible');
   ylabel('Infected');
   grid on;

   subplot(2,1,2);
   plot(S2_prog, I2_prog);
   title(['Phase Portrait (p = ' num2str(pcrit) ')']);
   xlabel('Susceptible');
   ylabel('Infected');
   grid on;
end