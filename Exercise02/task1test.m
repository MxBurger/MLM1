figure;
hold on;
legend_entries = {}; % Zelle für die Legendentexte

% Testfall 1
coeffs1 = [1, -3, 2];
range1 = [-10, 10];
step_size1 = 0.01;
draw_polynomial(coeffs1, range1, step_size1);
legend_entries{end+1} = sprintf('Testfall 1: s^2 - 3s + 2, Range = [%d, %d], Schrittweite = %.3f', range1(1), range1(2), step_size1);

% Testfall 2
coeffs2 = [1, 0, -2, 1];
range2 = [-5, 5];
step_size2 = 0.1;
draw_polynomial(coeffs2, range2, step_size2);
legend_entries{end+1} = sprintf('Testfall 2: s^3 - 2s + 1, Range = [%d, %d], Schrittweite = %.2f', range2(1), range2(2), step_size2);

% Testfall 3
coeffs3 = [5];
range3 = [-1, 1];
step_size3 = 0.01; % Standard-Schrittweite verwenden
draw_polynomial(coeffs3, range3);
legend_entries{end+1} = sprintf('Testfall 3: 5, Range = [%d, %d], Schrittweite = %.2f', range3(1), range3(2), step_size3);

% Testfall 4
coeffs4 = [2, -1, 3, 0, -5];
range4 = [-3, 3];
step_size4 = 0.05;
draw_polynomial(coeffs4, range4, step_size4);
legend_entries{end+1} = sprintf('Testfall 4: 2s^4 - s^3 + 3s^2 - 5, Range = [%d, %d], Schrittweite = %.2f', range4(1), range4(2), step_size4);

% Testfall 5
coeffs5 = [1, -1];
range5 = [0, 2];
step_size5 = 0.001;
draw_polynomial(coeffs5, range5, step_size5);
legend_entries{end+1} = sprintf('Testfall 5: s - 1, Range = [%d, %d], Schrittweite = %.3f', range5(1), range5(2), step_size5);

legend(legend_entries);
title('Verschiedene Test-Polynome')

hold off;
disp('Testskript abgeschlossen.');
