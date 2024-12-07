% Daten laden
data = load('optimization_results.mat');

% Struct in Table umwandeln
tableData = struct2table(data.results);

% Quality-Werte extrahieren und als neue Spalte hinzufügen
quality_values = cellfun(@(x) x.quality, {data.results.solution});
tableData = addvars(tableData, quality_values', 'NewVariableNames', 'quality');

writetable(tableData,'myData.txt','Delimiter',',')  
type 'myData.txt'