slideLength = 30.0;
slideGap    = 6.0;

screwShaftDiameter = 5.2;
screwHeadDiameter  = 11.5;
screwEndGap        = 5.0;

//Per 6 inch rack design... why the 0.05 I will never know...
unit = 14.05;

$fn=64;

radi = 1.0;


module torus(rA,rB){

  rotate_extrude()
  translate([rA, 0, 0])
  circle(r = rB);

}


module bar(l){
  translate([-3,0,0]) intersection(){
    intersection(){
      rotate([0,45,0]) translate([-4.25,-10,-4.25]) cube([8.5,l,8.5]);
      translate([-5,-10,-5]) cube([10,l,10]);
    }
    translate([3,-10,-5]) cube([10,l,10]);
  }
}


module slideFrontR(l,g){
  difference(){
    union(){
      translate([10,-10,-unit/2.0])cube([g,l,unit]);
      translate([10+g,0,0])bar(l);
      translate([10,10+screwEndGap+1,-unit/2.0]) cylinder(h=unit, d=4, $fn=4);
      difference(){
        translate([-10,10,-unit/2.0]) cube([20,screwEndGap+1,unit]);
        scale([1,1,1.05]) translate([0,10,0]) rotate([-90,0,0]) cylinder(h=screwEndGap+1, d=screwShaftDiameter);
        scale([1,1,1.05]) translate([0,10+screwEndGap,0]) rotate([-90,0,0]) cylinder(h=screwEndGap+1, d=screwHeadDiameter);
      }
    }
    rotate([0,0,-90]) scale([1,1,1.05]) translate([0,10,0]) rotate([-90,0,0]) cylinder(h=screwEndGap+1, d=screwShaftDiameter);
    rotate([0,0,-90])scale([1,1,1.05]) translate([0,10+screwEndGap,0]) rotate([-90,0,0]) cylinder(h=screwEndGap+1, d=screwHeadDiameter);
  }
}


module slideFrontL(l,g){
  scale([-1,1,1]) slideFrontR(slideLength,slideGap);
}

module slideBackL(l,g){
  scale([-1,-1,1]) slideFrontR(slideLength,slideGap);
}

module slideBackR(l,g){
  scale([1,-1,1]) slideFrontR(slideLength,slideGap);
}


translate([-14-slideGap,0,0]) slideFrontR(slideLength,slideGap);
translate([14+slideGap,0,0]) slideFrontL(slideLength,slideGap);
translate([14+slideGap,4+slideLength+(slideLength-20),0]) slideBackL(slideLength,slideGap);
translate([-14-slideGap,4+slideLength+(slideLength-20),0]) slideBackR(slideLength,slideGap);


//rotate([-90,0,0]) cylinder(h=50,d=3);













