% Parameterwerte
R1_val = 0.1;  
R2_val = 10.0;   
L_val = 1.0;  
C_val = 1.0;

% Matrix A, B, und C für den Zustand
A = [ -R1_val / L_val, -1 / L_val;
       1 / C_val,     -1 / (R2_val * C_val) ];

B = [1 / L_val;
     0];

C_matrix = [0, 1];  % Ausgabe y(t) = x2

% Eingangsgröße u(t) als Schrittfunktion (u_val = 1)
u_val = 1;

% Funktion für die Ableitungen der Zustandsvariablen definieren
dx_dt = @(t, x) A * x + B * u_val;

% Anfangswerte
x0 = [0; 0];  % x1(0) = 0 und x2(0) = 0

% Zeitbereich für die Simulation
t_span = 0:0.01:100;

% Numerische Lösung mit ode45
[t, x] = ode45(dx_dt, t_span, x0);

% Berechnung von y(t) = C * x(t)
y_t = C_matrix * x';

% Plot von y(t) über den Zeitbereich
figure;
plot(t, y_t);
title('Spannung y(t) über die Zeit');
xlabel('Zeit (s)');
ylabel('Spannung y(t)');
grid on;