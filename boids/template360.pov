//EXAMPLE OF SPHERE

//param1 = $1
//Files with predefined colors and textures
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
//global_settings { max_trace_level 20 }


//Place the camera
// ODS Left/Right - Docs: https://www.clodo.it/blog/?p=80
#declare odsIPD = 0.0065; // Interpupillary distance
#declare odsVerticalModulation = 0.2; // Use 0.0001 if you don't care about Zenith & Nadir zones.
#declare odsLocationX = 2 - clock*0.002;
#declare odsLocationY = -3;
// height axis
#declare odsLocationZ = 0;
#declare odsHandedness = -1; // "-1" for left-handed or "1" for right-handed
#declare odsAngle = 45; // Rotation, clockwise, in degree.              

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
  <18, 600, -300>
  color rgb 1.2
}

////Ambient light to "brighten up" darker pictures
global_settings { ambient_light White }

//Set a background color
background { color SlateBlue }


#include "birds.inc"


plane { <0, 1, 0>, -3.2
	pigment{ color rgb<0.25,0.6,0.7>}
	normal { agate 1.00 // bump depth
		 scale 0.5 }
}

