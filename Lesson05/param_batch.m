% Parameterwerte
model_name = 'LunarLander_param';
max_time = 100;
mue_values = [2, 4, 8, 16, 32];
lambda_ratio = 2; % Lambda ist immer 2-mal mue
delta_values = [1, 2, 3, 5, 10];
n_gens_values = [2, 4, 16, 64, 128];

% Speicher für Ergebnisse
results = struct('mue', {}, 'lambda', {}, 'delta', {}, 'n_gens', {}, 'solution', {});

% Iteration über alle Kombinationen von mue, delta und n_gens
result_index = 1; % Zum Speichern der Ergebnisse
for mue = mue_values
    lambda = mue * lambda_ratio; % Lambda berechnen (1:2 Verhältnis)
    for delta = delta_values
        for n_gens = n_gens_values
            % Aufruf der optimize-Funktion
            fprintf('Running optimize with mue=%d, lambda=%d, delta=%.2f, n_gens=%d\n', mue, lambda, delta, n_gens);
            solution = optimize_combined(model_name, mue, lambda, max_time, delta, n_gens, 'plus');
            
            % Speichern der Ergebnisse
            results(result_index).mue = mue;
            results(result_index).lambda = lambda;
            results(result_index).delta = delta;
            results(result_index).n_gens = n_gens;
            results(result_index).solution = solution;
            result_index = result_index + 1;
        end
    end
end

% Ergebnisse speichern (z. B. als MAT-Datei)
save('optimization_results.mat', 'results');

% Hinweis:
% Die Ergebnisse können später geladen werden mit:
% load('optimization_results.mat');