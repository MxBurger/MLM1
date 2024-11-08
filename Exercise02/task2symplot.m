% Symbole
syms R1 R2 L C t u x1(t) x2(t)

% Parameterkombinationen
params = [
    2.0, 0.5, 1.0, 1.0;   
    0.5, 20.0, 1.0, 1.0;  
    5.0, 25.0, 1.0, 1.0;
    0.1, 10.0, 0.1, 0.1;  
    0.1, 10.0, 10.0, 10.0; 
    3.0, 6.0, 1.0, 1.0
];

% Anfangsbedingungen
x1_0 = 0;
x2_0 = 0;
u_val = 1;

% Differentialgleichungen definieren
Dx1 = diff(x1, t) == -R1/L * x1 - 1/L * x2 + u/L;
Dx2 = diff(x2, t) == 1/C * x1 - 1/(R2 * C) * x2;

% Lösung berechnen
sol = dsolve([Dx1, Dx2], x1(0) == x1_0, x2(0) == x2_0);

% Zeitspanne für den Plot
time_range = [0, 100];

% Plot für jede Parameterkombination
figure;
hold on;
for i = 1:size(params, 1)
    % Aktuelle Parameterwerte
    R1_val = params(i, 1);
    R2_val = params(i, 2);
    L_val = params(i, 3);
    C_val = params(i, 4);
    
    % Lösungen x2(t) berechnen und substituieren
    x2_sol = subs(sol.x2, [R1, R2, L, C, u], [R1_val, R2_val, L_val, C_val, u_val]);
    
    % Plot x2(t) mit den aktuellen Parameterwerten
    fplot(x2_sol, time_range, 'DisplayName', sprintf('R1=%.2f, R2=%.2f, L=%.2f, C=%.2f', R1_val, R2_val, L_val, C_val));
end

% Plot
title('Spannung y(t) über die Zeit für verschiedene Parameterkombinationen (Symbolische Lösung)');
xlabel('Zeit (s)');
ylabel('Spannung y(t)');
legend show;
grid on;
hold off;