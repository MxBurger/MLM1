% Parameterkombinationen
params = [
    2.0, 0.5, 1.0, 1.0;   
    0.5, 20.0, 1.0, 1.0;  
    5.0, 25.0, 1.0, 1.0;
    0.1, 10.0, 0.1, 0.1;  
    0.1, 10.0, 10.0, 10.0; 
    3.0, 6.0, 1.0, 1.0
];

% Anfangswerte
x0 = [0; 0];  % x1(0) = 0 und x2(0) = 0

% Zeitvektor
t = 0:0.01:100;

% Plot für jede Parameterkombination
figure;
hold on;
for i = 1:size(params, 1)
    % Aktuelle Parameterwerte
    R1_val = params(i, 1);
    R2_val = params(i, 2);
    L_val = params(i, 3);
    C_val = params(i, 4);
    u_val = 1;

    % Matrix A, B und C_matrix in Standardform
    A = [ -R1_val / L_val, -1 / L_val;
           1 / C_val,     -1 / (R2_val * C_val) ];

    B = [1 / L_val;
         0];

    C_matrix = [0, 1];

    % Funktion für die Simulation
    dx_dt = @(t, x) A * x + B * u_val;

    % Numerische Lösung mit ode45 (Runge-Kutta)
    [t, x] = ode45(dx_dt, t, x0);

    % Berechnung y(t) = C * x(t)
    x2_t = C_matrix * x';

    % Plot y(t) für aktuelle Parameterkombination
    plot(t, x2_t, 'DisplayName', sprintf('R1=%.2f, R2=%.2f, L=%.2f, C=%.2f', R1_val, R2_val, L_val, C_val));
end

% Plot
title('Spannung y(t) über die Zeit für verschiedene Parameterkombinationen (Numerische Lösung)');
xlabel('Zeit (s)');
ylabel('Spannung y(t)');
legend show;
grid on;
hold off;
