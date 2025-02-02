// ---- 2D Circular Cylinder Gmsh Tutorial ----
// 2D_cylinder_tutorial.geo
// Creates a mesh with an inner structured-quad region and 
// an outer unstructured tri region
//
// Created 11/26/2014 by Jacob Crabill
// Aerospace Computing Lab, Stanford University
// --------------------------------------------

// Gmsh allows variables; these will be used to set desired
// element sizes at various Points
cl1 = 0.5;
cl2 = 0.03;
cl3 = 0.5;

radius = Sqrt(2.0);
outer = 5.0;

numinner = 20; 
numsurfpts = 20;

// Exterior (bounding box) of mesh
//Point(1) = {-20, -10, 0, cl1};
//Point(2) = { 20, -10, 0, cl3};
//Point(3) = { 20,  10, 0, cl3};
//Point(4) = {-20,  10, 0, cl1};
//Line(1) = {1, 2};
//Line(2) = {2, 3};
//Line(3) = {3, 4};
//Line(4) = {4, 1};

// Circle & surrounding structured-quad region
Point(5) = {0,   0, 0, cl2};
Point(6) = {radius,  radius, 0, cl2};
Point(7) = {-radius, -radius, 0, cl2};
Point(8) = {outer,  outer, 0, cl2};
Point(9) = {-outer, -outer, 0, cl2};
Point(10) = {radius,  -radius, 0, cl2};
Point(11) = {-radius, radius, 0, cl2};
Point(12) = {outer,  -outer, 0, cl2};
Point(13) = {-outer, outer, 0, cl2};

Circle(5) = {7, 5, 10};
Circle(6) = {6, 5, 11};
Circle(7) = {8, 5, 13};
Circle(8) = {9, 5, 12};

Line(9)  = {6, 8};
Line(10) = {7, 9};
Line(11) = {10, 12};
Line(12) = {11, 13};

Circle(13) = {10, 5, 6};
Circle(14) = {11, 5, 7};
Circle(15) = {13, 5, 9};
Circle(16) = {12, 5, 8};


Transfinite Line {5,6,7,8,13,14,15,16} = numsurfpts; // We want 40 points along each of these lines
Transfinite Line {9,10,11,12} = numinner Using Progression 1.1;    // And 10 points along each of these lines

//Using Progression 1.1

// Each region which to be independently meshed must have a line loop
// Regions which will be meshed with Transfinite Surface must have 4 lines
// and be labeled in CCW order, with the correct orientation of each edge
//Line Loop(1) = {1, 2, 3, 4, 7, 16, 8, 15}; // Exterior

Line Loop(2) = {8, -11, -5, 10};  // Bottom quad region - note ordering
Line Loop(3) = {7, -12, -6, 9};   // Top quad region - note ordering
Line Loop(4) = {15,-10, -14, 12}; // Left quad region - note ordering
Line Loop(5) = {16, -9, -13, 11}; // Right quad region - note ordering

//Plane Surface(1) = {1}; // Outer unstructured region
Plane Surface(2) = {2}; // RH inner structured region
Plane Surface(3) = {3}; // LH inner structured region
Plane Surface(4) = {4}; // RH inner structured region
Plane Surface(5) = {5}; // LH inner structured region

// Mesh these surfaces in a structured manner
Transfinite Surface{2,3,4,5};

// Turn into quads (optional, but Transfinite Surface looks best with quads)
Recombine Surface {2,3,4,5};
// Turn outer region into unstructured quads (optional)
//Recombine Surface {1};

// Change layer to increase z subdivision
extr = 2.0;
nZ = 16;
Extrude {0, 0, extr} { Surface{1,2,3,4,5}; Layers{nZ}; Recombine;}


// Apply boundary conditions
// Note: Can change names later at top of .msh file
// Each boundary in gmsh must be labeled differently
// rename the boundaries manually in the resulting .msh file
//Physical Line("Bottom") = {1};
//Physical Line("Right")  = {2};
//Physical Line("Top")    = {3};
//Physical Line("Left")   = {4};
//Physical Line("Circle") = {5,6};
// Alternate version - make all 4 outer bounds part of the same B.C.:
//Physical Line("Char") = {1,2,3,4}; 

Physical Surface("WALL") = {33,55,77,99};
Physical Surface("OUTER") = {25,47,69,91};
Physical Surface("ZLO") = {2,3,4,5};
Physical Surface("ZHI") = {38,60,82,104};
// IMPORTANT: "FLUID" MUST contain all fluid surfaces(2D)/volumes(3D)
//Physical Surface("FLUID") = {1,2,3};

