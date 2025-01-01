# Übung 05

## Task 1
Assume a disease for which we can model its spread in a population by a logistic model. Calculate
the progress of the disease for N = 10000 and k = 10, 20, 30, 50; produce a time diagram in which all
progresses for all scenarios are shown.

### Lösungsidee
Anwendung der Verhulst-Gleichung:
$x^t=\alpha x(t) - \beta x(t)^2$

$\alpha$ ... Wachstumsrate (Kontakte mit infizierten Personen)

$\beta$ ... Rückgang der Infektion

$\alpha$ wird zu $k$ und $\beta$ zu $\frac{k}{N}$

$I' = kI-\frac{k}{N}I^2$ 

### Implementierung

Berechnungs-Funktion
```matlab
function I = simulate_spread(N, k, t, dt)
    I = zeros(size(t));
    I(1) = 1;  % Initial condition: one infected person
    
    for i = 1:length(t)-1
        dI = k * I(i) * (1 - I(i)/N);
        I(i+1) = I(i) + dI * dt;
    end
end
```

Aufruf mit verschiedenden $k$-Werten
```matlab
function epidemic_simulation(N, k_values, t_max, dt)
    % Default parameters if not provided
    if nargin < 1, N = 10000; end
    if nargin < 2, k_values = [10, 20, 30, 50]; end
    if nargin < 3, t_max = 3; end
    if nargin < 4, dt = 0.001; end
    
    t = 0:dt:t_max;
    figure;
    hold on;
    
    for k = k_values
        I = simulate_spread(N, k, t, dt);
        plot(t, I, 'LineWidth', 1.5);
    end
    
    xlabel('Time (days)');
    ylabel('Number of infected people');
    title('Disease Spread in Population');
    legend(arrayfun(@(k) sprintf('k = %d', k), k_values, 'UniformOutput', false));
    grid on;
    hold off;
end
```
### Aufruf

```
epidemic_simulation()
```

![Task1](Task1.jpg)


## Task 2
>... skipped (for now :D)...

## Task 3

### a) Assume that the basic reproduction number of a measles epidemic is R0 = 7.5, and that the average infectious period of a patient lasts 10 days. Calculate the progress of the epidemic using the standard SIR model without births and deaths.

### Lösungsidee
... wow so much empty ...

### Implementierung
```matlab
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
```

### Aufruf

```
task_2a(100)
```
![alt text](Task2a_100_Evolution.jpg)

![alt text](Task2a_100_Phase.jpg)

```
task_2a(1000)
```
![alt text](Task2a_1000_Evolution.jpg)

![alt text](Task2a_1000_Phase.jpg)

```
task_2a(10000)
```

![](Task2a_10000_Evolution.jpg)

![alt text](Task2a_10000_Phase.jpg)

### b) Calculate the progress of S, I and R for the scenario (a) assuming a birth rate μ = 0.0003. What is the eventual number of diseased persons for t → ∞? Furthermore, calculate p_crit as well as the progress of I(t) assuming an inoculation rate of exactly p_crit.
