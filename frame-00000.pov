
#version 3.7;
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"          
#include "transforms.inc"
//#include "analytical_g.inc"

global_settings { assumed_gamma 1.2 }

//Place the camera
// ODS Left/Right - Docs: https://www.clodo.it/blog/?p=80
#declare odsIPD = 0.0065; // Interpupillary distance
#declare odsVerticalModulation = 0.2; // Use 0.0001 if you don't care about Zenith & Nadir zones.
#declare odsLocationX = 0;
#declare odsLocationY = 0;
#declare odsLocationZ = 0;
#declare odsHandedness = -1; // "-1" for left-handed or "1" for right-handed
#declare odsAngle = 0; // Rotation, clockwise, in degree.              

camera {
  user_defined
  location {
    function { odsLocationX + cos(((x+select(-y,0.,0.5)+odsAngle/360)) * 2 * pi - pi)*(odsIPD/2*pow(abs(sin(select(y, 1-2*(y+0.5), 1-2*y)*pi)), odsVerticalModulation))*select(-y,-1,+1) }
    function { odsLocationY }
    function { odsLocationZ + sin(((x+select(-y,0.,0.5)+odsAngle/360)) * 2 * pi - pi)*(odsIPD/2*pow(abs(sin(select(y, 1-2*(y+0.5), 1-2*y)*pi)), odsVerticalModulation))*select(-y,-1,+1) * odsHandedness }
  }
  direction {
    function { sin(((x+select(-y,0.,0.5)+odsAngle/360)) * 2 * pi - pi) * cos(pi / 2 -select(y, -1+2*(y+0.5), 1-2*y) * pi) }
    function { sin(pi / 2 - select(y, -1+2*(y+0.5), 1-2*y) * pi) }
    function {-cos(((x+select(-y,0.,0.5)+odsAngle/360)) * 2 * pi - pi) * cos(pi / 2 -select(y, -1+2*(y+0.5), 1-2*y) * pi) * odsHandedness }
  }
}

light_source {
  <1, 10, 0>
  color White*2 // multiply to make brighter
}

////Ambient light to "brighten up" darker pictures
// global_settings { ambient_light White*0.2 }

//Set a background color
background { color Black }


// infinite plane, disabled.
/* 
plane { <0, 1, 0>, -0.2
	pigment{ color rgb<0.6,0.,0.>}
	normal { agate 1.00 // bump depth
		 scale 0.5 }
}*/
box { <10, -0.5, 10>, <-1, -1, -1>
	texture {pigment{ color rgb<0.5,0.2,0.2>}}
}



sphere { <0.000000, 1.200000, -2.000000> 0.2 texture {pigment {color Red}}}

sphere { <0.000000, 2.200000, -3.000000> 0.2 texture {pigment {color Blue}}}
