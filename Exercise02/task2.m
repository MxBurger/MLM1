% Parameterwerte
R1_val = 0.1;  
R2_val = 10.0;   
L_val = 1.0;  
C_val = 1.0;
u_val = 1;

% Matrix A, B, und C in Standardform
A = [ -R1_val / L_val, -1 / L_val;
       1 / C_val,     -1 / (R2_val * C_val) ];

B = [1 / L_val;
     0];

C_matrix = [0, 1];

% Anfangswerte
x0 = [0; 0];  % x1(0) = 0 und x2(0) = 0

% Zeitvektor
t = 0:0.01:100;

% Funktion für die Simulation
dx_dt = @(t, x) A * x + B * u_val;

% Numerische Lösung mit ode45 (Runge Kutta)
[t, x] = ode45(dx_dt, t, x0);

% Berechnung von y(t) = C * x(t)
x2_t = C_matrix * x';

% Plot
plot(t, x2_t);
title('Spannung y(t) über die Zeit (Numerische Lösung)');
xlabel('Zeit (s)');
ylabel('Spannung y(t)');
grid on;
