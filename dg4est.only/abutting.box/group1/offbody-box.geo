SetFactory("OpenCASCADE");

xc = 0.0;
yc = 1.0;
zc = 0.0;
outerboxh = 1.0; obh = outerboxh/2;

Box(1) = {xc-2*obh,0.0,zc-2*obh, 2*outerboxh, 2*outerboxh, 2*outerboxh};

Transfinite Line { 1:12} = 17 Using Progression 1.0;

//Transfinite Surface {1,3:6};
Recombine Surface {1:6};
Recombine Volume {1};

Physical Surface ("OUTER-BOX") = {1:2,4:6};
Physical Surface ("SURFACE") = {3};
