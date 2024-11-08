# Aufgabe 1
## Subüberschrift
### Subüberschrift

Um die Schriftgröße der Code-Blöcke in der Markdown Preview Enhanced Extension für VS Code anzupassen, kannst du das Custom CSS-Feature verwenden. Gehe dabei wie folgt vor:
```matlab
function draw_polynomial(coeffs, range, step_size)
arguments
    coeffs double
    range double % range vector
    step_size double = 0.01
end
% define s-vector
s = range(1):step_size:range(2);

% initialize y_vals with 0s
p = zeros(size(s));

% get size of only columns
n_coeffs = size(coeffs, 2);

legend_text = 'p = ';

for i = 1:n_coeffs
    % calculate p vector
    p = p + coeffs(i) * s.^(n_coeffs - i);

    % generate fancy title
        if coeffs(i) < 0
            legend_text(end) = [];
        end
        legend_text = [legend_text, num2str(coeffs(i)), '*s^', num2str(n_coeffs-i), '+'];
end

legend_text(end) = [];

figure;
plot(s, p);
xlabel('s')
ylabel('p(s)')
legend(legend_text);
title(['Polynom with stepsize = ', num2str(step_size)]);
grid minor;
end
```

# Aufgabe 2
$x(t)=
\begin{bmatrix}
x_1(t) \\
x_2(t)
\end{bmatrix}$

$x_1\ '=?$
$x_1\ '= -\frac{R_1}{L} *x_1 - \frac{1}{L} *x_2 + \frac{1}{L} * U$

$x_2\ '=?$
$x_2\ '= \frac{1}{C} * x_1 - \frac{1}{R_2*C}*x_2$

$A=
\begin{bmatrix}
-\frac{R_1}{L} \ -\frac{1}{L} \\
\frac{1}{C} \ -\frac{1}{R_2*C} \\
\end{bmatrix}
$

$B=
\begin{bmatrix}
\frac{1}{L} \\
0
\end{bmatrix}
$

$C =
\begin{bmatrix}
0 \ 1
\end{bmatrix}
$

## Symbolische Lösung mit *Symbolic Math Toolbox*

```matlab
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
```

## Numerische Lösung mit Runge-Kutta Verfahren *(in Matlab ode45)*

```matlab
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
```
