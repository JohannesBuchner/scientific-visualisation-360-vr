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
 
sphere { <-0.353239,1.087987,-1.127615> 0.04 texture { pigment {color White}} }
sphere { <-0.029025,0.455671,-0.493103> 0.04 texture { pigment {color White}} }
sphere { <-2.205046,-1.123796,-0.076150> 0.04 texture { pigment {color White}} }
sphere { <1.554856,0.382971,1.513560> 0.04 texture { pigment {color White}} }
sphere { <-1.780347,-0.245356,0.789780> 0.04 texture { pigment {color White}} }
sphere { <-0.843534,2.485487,-1.094466> 0.04 texture { pigment {color White}} }
sphere { <0.453440,1.775679,0.601072> 0.04 texture { pigment {color White}} }
sphere { <-1.222851,0.402711,0.824529> 0.04 texture { pigment {color White}} }
sphere { <-0.988724,-0.652341,-1.088061> 0.04 texture { pigment {color White}} }
sphere { <-0.935995,-0.605711,-0.202259> 0.04 texture { pigment {color White}} }
sphere { <0.595280,-0.240306,-1.820546> 0.04 texture { pigment {color White}} }
sphere { <2.205656,-0.584166,0.286324> 0.04 texture { pigment {color White}} }
sphere { <-0.033292,-0.873369,-0.255922> 0.04 texture { pigment {color White}} }
sphere { <-1.060291,-0.669835,-1.329366> 0.04 texture { pigment {color White}} }
sphere { <0.501849,-0.221644,-0.773153> 0.04 texture { pigment {color White}} }
sphere { <-0.680183,-0.539621,0.190533> 0.04 texture { pigment {color White}} }
sphere { <-0.040870,-0.650331,-0.637716> 0.04 texture { pigment {color White}} }
sphere { <1.106854,-0.962774,0.234475> 0.04 texture { pigment {color White}} }
sphere { <-0.727173,2.465274,0.504599> 0.04 texture { pigment {color White}} }
sphere { <-0.050825,-1.476263,-0.920549> 0.04 texture { pigment {color White}} }
sphere { <-0.907369,-0.926433,-0.302035> 0.04 texture { pigment {color White}} }
sphere { <-0.066506,0.402536,2.112843> 0.04 texture { pigment {color White}} }
sphere { <0.261542,-0.408586,0.068685> 0.04 texture { pigment {color White}} }
sphere { <-1.079888,0.403254,-0.811101> 0.04 texture { pigment {color White}} }
sphere { <-0.308450,0.831877,0.150088> 0.04 texture { pigment {color White}} }
sphere { <-0.196023,1.179171,-1.376778> 0.04 texture { pigment {color White}} }
sphere { <-0.576097,0.721869,1.205565> 0.04 texture { pigment {color White}} }
sphere { <-1.179529,-0.984845,0.271062> 0.04 texture { pigment {color White}} }
sphere { <-1.490083,1.049606,1.127324> 0.04 texture { pigment {color White}} }
sphere { <-0.067869,-1.736711,0.859220> 0.04 texture { pigment {color White}} }
sphere { <-0.216918,-0.029936,0.378926> 0.04 texture { pigment {color White}} }
sphere { <2.143730,-0.497156,0.927500> 0.04 texture { pigment {color White}} }
sphere { <-2.356635,-1.067683,0.129391> 0.04 texture { pigment {color White}} }
sphere { <0.081796,0.680951,-0.694892> 0.04 texture { pigment {color White}} }
sphere { <0.468719,-0.183671,-1.042544> 0.04 texture { pigment {color White}} }
sphere { <1.329707,0.937772,-0.399405> 0.04 texture { pigment {color White}} }
sphere { <0.527197,-1.509040,-2.412358> 0.04 texture { pigment {color White}} }
sphere { <-0.830541,0.766654,1.767169> 0.04 texture { pigment {color White}} }
sphere { <0.029590,0.593445,-1.714699> 0.04 texture { pigment {color White}} }
sphere { <0.540988,0.127274,-0.176644> 0.04 texture { pigment {color White}} }
sphere { <-0.328665,-1.391538,-1.412511> 0.04 texture { pigment {color White}} }
sphere { <0.773463,-0.212271,-1.933704> 0.04 texture { pigment {color White}} }
sphere { <-1.831868,-1.600586,-0.158395> 0.04 texture { pigment {color White}} }
sphere { <1.770506,-2.023478,-0.375011> 0.04 texture { pigment {color White}} }
sphere { <1.561960,3.246732,-0.158460> 0.04 texture { pigment {color White}} }
sphere { <-0.316936,0.878541,0.583121> 0.04 texture { pigment {color White}} }
sphere { <0.688507,1.753386,-0.568381> 0.04 texture { pigment {color White}} }
sphere { <0.118977,-0.463486,0.440091> 0.04 texture { pigment {color White}} }
sphere { <-0.814203,0.616677,0.454650> 0.04 texture { pigment {color White}} }
sphere { <0.115146,0.712289,-0.430018> 0.04 texture { pigment {color White}} }
sphere { <0.975445,0.697579,-0.272605> 0.04 texture { pigment {color White}} }
sphere { <-0.368439,-0.095299,0.544736> 0.04 texture { pigment {color White}} }
sphere { <-0.286981,-0.237441,0.012032> 0.04 texture { pigment {color White}} }
sphere { <-0.034387,-1.992956,0.109073> 0.04 texture { pigment {color White}} }
sphere { <0.532545,0.621285,-2.380462> 0.04 texture { pigment {color White}} }
sphere { <1.228668,0.415163,0.144884> 0.04 texture { pigment {color White}} }
sphere { <-0.704094,1.054933,0.341585> 0.04 texture { pigment {color White}} }
sphere { <0.527032,-0.327698,-0.217978> 0.04 texture { pigment {color White}} }
sphere { <0.120211,1.718733,0.353224> 0.04 texture { pigment {color White}} }
sphere { <-1.780760,-0.481221,1.851212> 0.04 texture { pigment {color White}} }
sphere { <-0.331121,-1.294191,0.112202> 0.04 texture { pigment {color White}} }
sphere { <-0.198978,0.865628,0.681522> 0.04 texture { pigment {color White}} }
sphere { <-0.051567,-0.385645,-0.904892> 0.04 texture { pigment {color White}} }
sphere { <0.288021,-1.342569,-0.881569> 0.04 texture { pigment {color White}} }
sphere { <-2.019862,0.218284,-0.509651> 0.04 texture { pigment {color White}} }
sphere { <0.042594,0.720823,-0.926302> 0.04 texture { pigment {color White}} }
sphere { <-0.615523,0.166560,0.015261> 0.04 texture { pigment {color White}} }
sphere { <-1.374368,0.441267,-0.985037> 0.04 texture { pigment {color White}} }
sphere { <0.506887,4.140956,-0.267800> 0.04 texture { pigment {color White}} }
sphere { <0.659364,0.885428,-1.428197> 0.04 texture { pigment {color White}} }
sphere { <-0.605788,1.444204,-1.643730> 0.04 texture { pigment {color White}} }
sphere { <0.820460,-1.918877,-0.746500> 0.04 texture { pigment {color White}} }
sphere { <-0.287773,0.347881,-1.037118> 0.04 texture { pigment {color White}} }
sphere { <0.023947,0.693385,-0.694191> 0.04 texture { pigment {color White}} }
sphere { <-1.035299,-0.357076,-0.535191> 0.04 texture { pigment {color White}} }
sphere { <1.620288,-0.794989,-0.304731> 0.04 texture { pigment {color White}} }
sphere { <-2.669250,0.297201,1.040692> 0.04 texture { pigment {color White}} }
sphere { <-0.111803,-0.412656,1.367506> 0.04 texture { pigment {color White}} }
sphere { <0.753888,-0.567116,0.648835> 0.04 texture { pigment {color White}} }
sphere { <-1.939108,1.146697,-0.326637> 0.04 texture { pigment {color White}} }
sphere { <-0.106566,1.388633,1.514981> 0.04 texture { pigment {color White}} }
sphere { <-0.085022,0.204347,-1.547881> 0.04 texture { pigment {color White}} }
sphere { <0.878845,-0.523702,-1.975931> 0.04 texture { pigment {color White}} }
sphere { <1.255335,0.609904,0.239923> 0.04 texture { pigment {color White}} }
sphere { <-0.444611,0.783514,0.076654> 0.04 texture { pigment {color White}} }
sphere { <-1.331747,0.663329,-0.217567> 0.04 texture { pigment {color White}} }
sphere { <1.453186,-1.488032,0.069861> 0.04 texture { pigment {color White}} }
sphere { <1.178884,-0.381407,-1.559416> 0.04 texture { pigment {color White}} }
sphere { <-0.518127,0.284765,-1.192647> 0.04 texture { pigment {color White}} }
sphere { <0.389361,0.714194,1.226446> 0.04 texture { pigment {color White}} }
sphere { <0.448970,0.888228,1.013566> 0.04 texture { pigment {color White}} }
sphere { <0.625739,0.681285,-0.698562> 0.04 texture { pigment {color White}} }
sphere { <0.283070,-1.195662,1.938677> 0.04 texture { pigment {color White}} }
sphere { <1.492024,-0.663753,-1.042490> 0.04 texture { pigment {color White}} }
sphere { <-1.649091,-1.205126,-0.528398> 0.04 texture { pigment {color White}} }
sphere { <1.114238,1.862536,0.257322> 0.04 texture { pigment {color White}} }
sphere { <0.330350,0.180813,-1.281681> 0.04 texture { pigment {color White}} }
sphere { <-0.192129,0.580047,-0.581015> 0.04 texture { pigment {color White}} }
sphere { <1.159340,1.085073,-0.257337> 0.04 texture { pigment {color White}} }
sphere { <-2.309485,-0.266662,-0.465692> 0.04 texture { pigment {color White}} }
sphere { <1.576735,0.022251,2.812026> 0.04 texture { pigment {color Red}} }
