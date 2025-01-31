model = createpde('thermal', 'steadystate');

importGeometry(model, "PanV2.stl");

% plot faces
figure
pdegplot(model, "FaceLabels", "on", "FaceAlpha", 0.3);
title("Face Labels")

% PVC - bad heat conductor
%thermalProperties(model, "MassDensity", 1380, ... % kg/m³
%    "SpecificHeat", 900, ... % J/(kg·K)
%    "ThermalConductivity", 0.19); % W/(m·K)


% silver - good conductor
thermalProperties(model, "MassDensity", 10490, ... % kg/m³
    "SpecificHeat", 235, ... % J/(kg·K)
    "ThermalConductivity", 429); % W/(m·K)

% init temperature
T_ext = 20; 
thermalIC(model, T_ext); 

% heat face
thermalBC(model, 'Face', 9, 'Temperature', 350);
h = 2; 

% convection cool all other faces
allFaces = 1:model.Geometry.NumFaces;
thermalBC(model, 'Face', [1:8, 10:max(allFaces)], 'ConvectionCoefficient', h, 'AmbientTemperature', T_ext);

mesh = generateMesh(model);
figure
pdeplot3D(model)
title("Mesh")


result = solve(model);

% plot
figure
pdeplot3D(model, 'ColorMapData', result.Temperature)
title("Heat Distribution")
colormap('jet')
colorbar
view(30,30)
drawnow

