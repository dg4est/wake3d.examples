SetFactory("OpenCASCADE");

xc = 0.0;
yc = 1.0;
zc = 0.0;
outerboxh = 0.4; obh = outerboxh/2;
innerboxh = 0.2; ibh = innerboxh/2;
rad = 1;

Point(1) = {0,0,0};
Point(2) = {0,1,0};

Box(1) = {-1.8,-1.8,-1.8, 3.6, 3.6, 3.6};
Sphere(2) = {0.0, 0.0, 0.0, rad};
BooleanDifference(3) = { Volume{1}; Delete;} { Volume{2}; Delete;};

pts() = PointsOf{ Volume{3}; };
MeshSize{ pts() } = 0.4;


Transfinite Line {1:12} = 21 Using Progression 1.0;
Transfinite Line {14} = 41 Using Progression 1.0;

Transfinite Surface {1:6};
Recombine Surface {1:7};
Recombine Volume {3};

Physical Surface ("OUTER-BOX") = {1:6};
Physical Surface ("SPHERE") = {7};
//+
Show "*";
//+
Hide {
  Point{1}; Point{2}; Volume{3}; 
}
