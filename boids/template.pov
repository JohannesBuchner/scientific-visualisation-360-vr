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
camera {
  sky <0,0,1>           //Don't change this
  direction <-1,0,0>    //Don't change this  
  right <-3/3,0,0>      //Don't change this
  //location <0, 0, -1>
  location <10, 0, -3>
  //rotate <0, 0, 0.2*clock>
  angle 60      //Angle of the view--increase to see more, decrease to see less
  look_at <0,0,0>     //Where camera is pointing
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


plane { <0, 0, 1>, -3.2
	pigment{ color rgb<0.25,0.6,0.7>}
	normal { agate 1.00 // bump depth
		 scale 0.5 }
}
 
