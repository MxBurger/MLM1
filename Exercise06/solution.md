# Übung 05

## Task 1

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
