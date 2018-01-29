"""

VR 360 video of two blobs moving up and down in a sine and cosine curve.

Johannes Buchner (C) 2018

"""


import numpy
from numpy import cos, exp, sin, pi

template = """
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


"""

period1 = 10000
period2 = 200

for i in range(10000):
	# write out pov file
	f = open('frame-%05d.pov' % i, 'w')
	# start with the above template that defines always-present definitions
	f.write(template)
	
	# now compute the properties of our structures
	# we make two balls: one representing a sin curve, another a cos curve.
	phi   = -i*(2*pi)/period1-pi/2
	theta = i*(2*pi)/period2
	x1 = cos(phi)*2
	y1 = sin(phi)*2
	z1 = sin(theta)+1.2
	x2 = cos(phi)*3
	y2 = sin(phi)*3
	z2 = cos(theta)+1.2
	
	# write out our structure:
	# z is the vertical axis here, but povray likes it to be the second axis.
	f.write("""
sphere { <%f, %f, %f> 0.2 texture {pigment {color Red}}}
""" % (x1, z1, y1))

	f.write("""
sphere { <%f, %f, %f> 0.2 texture {pigment {color Blue}}}
""" % (x2, z2, y2))
	f.close()

