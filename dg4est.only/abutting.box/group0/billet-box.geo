SetFactory("OpenCASCADE");

xc = 0.0;
yc = 1.0;
zc = 0.0;
outerboxh = 0.5; obh = outerboxh/2;
innerboxh = 0.25; ibh = innerboxh/2;

Point(1) = {0,0,0};
Point(2) = {0,1,0};

Box(1) = {xc-2*obh,0.0,zc-2*obh, 2*outerboxh, 2*outerboxh, 2*outerboxh};
Box(2) = {xc-2*ibh,0.0,zc-2*ibh, 2*innerboxh, 2*innerboxh, 2*innerboxh};
BooleanDifference(3) = { Volume{1}; Delete;} { Volume{2}; Delete;};

Transfinite Line { 1:7,12:16} = 17 Using Progression 1.0;
Transfinite Line {8:11,17:24} = 9 Using Progression 1.0;

Transfinite Surface {1,3:12};
Recombine Surface {1:12};
Recombine Volume {3};

Physical Surface ("OUTER-BOX") = {1,3:6};
Physical Surface ("SURFACE") = {2};
Physical Surface ("INNER-BOX") = {7:11};
