model  = createpde("structural", "static-solid"); % create partial differential equation
importGeometry(model, "hip_steel.STL");

figure
pdegplot(model, "FaceLabels", "on", FaceAlpha=0.8)
view(30,30)
title("3D model with faces")

% set Boundary Conditions (BC)
structuralProperties(model, YoungsModulus=210e3, PoissonsRatio=0.29); % Material Parameters
structuralBC(model, Face=2, Constraint="fixed");
structuralBoundaryLoad(model, Vertex=15, Force=[0; 313.92; 0]);

% Meshing (discretization of our model)
figure
mesh = generateMesh(model);
pdeplot3D(model)
title("Mesh")

% solve equation system
result = solve(model);

% postprocessing
figure
pdeplot3D(model, ColorMapData=result.Displacement.y)
title("Displacement in Y")
colormap("jet")

figure
pdeplot3D(model, ColorMapData=result.VonMisesStress)
title("Von Mises Stress");
colormap("jet");