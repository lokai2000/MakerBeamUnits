cornerLength = 20.0;

screwShaftDiameter = 3.2;
screwHeadDiameter  = 5.5;
screwEndGap        = 1.0;

useFillet      = true;
filletDiameter = 15.0;

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
      rotate([0,45,0]) translate([-4.25,-5,-4.25]) cube([8.5,l,8.5]);
      translate([-5,-5,-5]) cube([10,l,10]);
    }
    translate([2,-5,-5]) cube([10,l,10]);
  }
}



module cap(){
  x = 5.0 - radi;
  union(){
    hull(){
      translate([-x,-x,-x]) sphere(r=radi, center=true);
      translate([ x,-x,-x]) sphere(r=radi, center=true);
      translate([-x, x,-x]) sphere(r=radi, center=true);
      translate([ x, x,-x]) sphere(r=radi, center=true);    
      translate([-x,-x, x]) sphere(r=radi, center=true);
      translate([ x,-x, x]) sphere(r=radi, center=true);
      translate([-x, x, x]) sphere(r=radi, center=true);
      translate([ x, x, x]) sphere(r=radi, center=true);    
    }
    
    if (useFillet) {

      translate([5,5,0]) difference(){
        translate([-5,-5,-5]) cube([3+filletDiameter/2.0,5+filletDiameter/2.0,10]);
        translate([filletDiameter*0.5,filletDiameter*0.5,0]) cylinder(h=10,d=filletDiameter+2.0*radi,center=true);
      }
      translate([5,5,0]) difference(){
        translate([-5,-5,-5+radi]) cube([5+filletDiameter/2.0,5+filletDiameter/2.0,10-2.0*radi]);
        translate([filletDiameter*0.5,filletDiameter*0.5,0]) cylinder(h=10,d=filletDiameter,center=true);
      }
      
      intersection(){
        translate([5+filletDiameter*0.5,5+filletDiameter*0.5,5.0-radi]) torus(filletDiameter/2.0+radi,radi);
        translate([5,5,0]) difference(){
          translate([-5,-5,-5]) cube([5+filletDiameter/2.0,5+filletDiameter/2.0,10]);
          translate([filletDiameter*0.5,filletDiameter*0.5,0]) cylinder(h=10,d=filletDiameter,center=true);
        }
      }
      intersection(){
        translate([5+filletDiameter*0.5,5+filletDiameter*0.5,-5.0+radi]) torus(filletDiameter/2.0+radi,radi);
        translate([5,5,0]) difference(){
          translate([-5,-5,-5]) cube([5+filletDiameter/2.0,5+filletDiameter/2.0,10]);
          translate([filletDiameter*0.5,filletDiameter*0.5,0]) cylinder(h=10,d=filletDiameter,center=true);
        }
      }

    }
  }
  
}





module makerBar(l){
  
  x = 5.0 - radi;
  
  hull(){
    translate([-x,-x,0]) cylinder(h=l, r=radi, center=true);
    translate([ x,-x,0]) cylinder(h=l, r=radi, center=true);
    translate([-x, x,0]) cylinder(h=l, r=radi, center=true);
    translate([ x, x,0]) cylinder(h=l, r=radi, center=true);    
  }
  
}


module endCornerSymetric(l){

  difference(){  
    union(){
      cap();
      translate([l/2.0,0,0]) rotate([0,90.0,0]) makerBar(l-10.0);
      translate([5.0-radi/2.0,0,0]) rotate([0,90.0,0]) makerBar(radi);
      translate([0,l/2.0,0]) rotate([90.0,0,0]) makerBar(l-10.0);
      translate([0,5.0-radi/2.0,0]) rotate([90.0,0,0]) makerBar(radi);
    }
    scale([1.0,1.0,1.05]) rotate([0,90.0,0]) cylinder(h=2*l, d=screwShaftDiameter, center=true);
    translate([l/2.0-5.0-screwEndGap,0,0]) scale([1.0,1.0,1.05]) rotate([0,90.0,0]) cylinder(h=l, d=screwHeadDiameter, center=true);
    
    scale([1.0,1.0,1.05]) rotate([90.0,0,0]) cylinder(h=2*l, d=screwShaftDiameter, center=true);
    translate([0,l/2.0-5.0-screwEndGap,0]) scale([1.0,1.0,1.05]) rotate([90.0,0,0]) cylinder(h=l, d=screwHeadDiameter, center=true);

    translate([-5,-5, 0]) rotate([0,0,0]) sphere(d=28.5, $fn=4);

    translate([-5,0,0]) bar(l);
    translate([l-10,-5,0]) rotate([0,0,90.0]) bar(l);

  }
  
}



endCornerSymetric(cornerLength);
