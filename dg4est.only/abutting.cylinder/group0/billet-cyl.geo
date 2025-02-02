SetFactory("OpenCASCADE");

xc = 0.0;
yc = 2.0;
zc = 1.0;
outerboxh = 0.8;  obh = outerboxh/2;
innerboxh = 0.3; ibh = innerboxh/2;
rad = 2;

Point(1) = {0,0,0};
Point(2) = {0,2,0};

Box(1) = {xc-2*obh,yc-0.4,zc-2*obh, 2*outerboxh, 2*outerboxh, 2*outerboxh};
Box(2) = {xc-2*ibh,yc-0.4,zc-2*ibh, 2*innerboxh, 1.0, 2*innerboxh};
Cylinder(3) = {0.0, 0.0, 0.0, 0.0, 0.0, 2.0, rad};
BooleanDifference(4) = { Volume{1}; Delete;} { Volume{2:3}; Delete;};

Transfinite Line { 1:12} = 11 Using Progression 1.0;
Transfinite Line {13:24} = 6 Using Progression 1.0;

Transfinite Surface {1:4,6:12};
Recombine Surface {1:12};
Recombine Volume {4};

Physical Surface ("OUTER-BOX") = {1:4,6};
Physical Surface ("CYLINDER")  = {5};
Physical Surface ("INNER-BOX") = {7:11};
