model = createpde("structural", "static-solid");
importGeometry(model, "50x50x25.stl");

figure
pdegplot(model, "FaceLabels", "on", "FaceAlpha", 0.8)
view(30,30)
title("Stahlwinkel")

% Material Parameters (structural steel) und Boundary Conditions
structuralProperties(model, "YoungsModulus", 210e3, "PoissonsRatio", 0.29)
structuralBC(model, "Face", 4, "Constraint", "fixed")
structuralBoundaryLoad(model, "Face", 13, "SurfaceTraction", [-300; 0; 0])

% Meshing
figure
mesh = generateMesh(model);
pdeplot3D(model)
title("Mesh")

% Solve
result = solve(model);

% Postprocessing
fig = figure;
pdeplot3D(model, "ColorMapData", result.Displacement.x)
title("Displacement in X")
colormap("jet")


figure
pdeplot3D(model, "ColorMapData", result.VonMisesStress)
title("Von Mises Stress")
colormap("jet")

maxStress = max(result.VonMisesStress);
maxDisp = max(sqrt(result.Displacement.x.^2 + ...
                  result.Displacement.y.^2 + ...
                  result.Displacement.z.^2));
fprintf('Maximum von Mises stress: %.2f Pa\n', maxStress)
fprintf('Maximum displacement: %.2f mm\n', maxDisp)
