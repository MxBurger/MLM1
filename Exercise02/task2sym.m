% Parameterwerte
syms R1 R2 L C t u % Definiere symbolische Parameter
R1_val = 0.1;  
R2_val = 10.0;   
L_val = 1.0;  
C_val = 1.0;
u_val = 1;

% Zustandsvariablen als symbolische Funktionen von t definieren
syms x1(t) x2(t)

% Differentialgleichungen definieren
Dx1 = diff(x1, t) == -R1/L * x1 - 1/L * x2 + u/L;
Dx2 = diff(x2, t) == 1/C * x1 - 1/(R2 * C) * x2;

% Anfangsbedingungen
x1_0 = 0;
x2_0 = 0;

% Symbolische Lösung berechnen
sol = dsolve([Dx1, Dx2], x1(0) == x1_0, x2(0) == x2_0);

% Lösungen für x1(t) und x2(t) extrahieren und mit Werten der Parameter berechnen
x1_sol = subs(sol.x1, [R1, R2, L, C, u], [R1_val, R2_val, L_val, C_val, u_val]);
x2_sol = subs(sol.x2, [R1, R2, L, C, u], [R1_val, R2_val, L_val, C_val, u_val]);

% Ausgabe der symbolischen Lösung
disp('Lösung für x1(t):');
disp(x1_sol);
disp('Lösung für x2(t):');
disp(x2_sol);

% Berechnung der Ausgabe y(t) = x2(t)
y_t = x2_sol;

% Plot der symbolischen Lösung
fplot(y_t, [0, 100]); % Plotte y(t) von t = 0 bis t = 100
title('Spannung y(t) über die Zeit (Symbolische Lösung)');
xlabel('Zeit (s)');
ylabel('Spannung y(t)');
grid on;
