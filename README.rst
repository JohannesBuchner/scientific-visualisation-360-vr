==========================================
Scientific Visualisation with 360° VR
==========================================

Simple demo of how to create views of structures and animated videos for VR.

Examples:

* https://vimeo.com/253234521 -- Simplest example
* https://vimeo.com/253178116 -- More complex animation

Technologies
-------------

* for computing the structure and exporting it -- Python
* for visualising with perspective, making images -- povray
* for animating the images to a movie -- ffmpeg
* for turning the movie into a VR playable one -- spatial-media

Simple HOWTO
----------------

* Take a look at simple.py
* It writes a povray configuration of two blobs.
* These blobs are moving up and down with each time step

To create the povray files, run::

	$ python simple.py

Take a look at frame-00000.pov for an example output. 
POV-Ray documentation can be found at http://www.povray.org/ with a gallery of existing objects http://objects.povworld.org/cat and award-winning results: http://hof.povray.org/

To create images through raytracing, run::

	$ for i in $(seq 0 10000); do k=$(printf "%05d" $i); povray +W1200 +H1200 -V +Oframe-$k.png +WT4 +K$i -d frame-$k.pov; done

You need povray 3.7.1 or higher to run this!

Take a look at frame-00000.png for an example output. The top part is the left eye's view, the bottom is the right eye view.


Next, we need to turn the image sequence into a movie::

	$ ffmpeg -y -hide_banner -r 25 -i frame-%05d.png -c:v libx264 -pix_fmt yuv420p -preset slow -crf 17 simple.mp4

The options are explained in detail at https://trac.ffmpeg.org/wiki/Encode/H.264, and mean::

	-y: overwrite
	-hide_banner: less output
	-r: frame rate
	-i: input image pattern
	-c:v video codec: H.264 is a widely available one. In the future VP9 may be a better option
	-pix_fmt yuv420p: need to select this color scheme because the default and newer yuv444p is sometimes not supported
	-preset: encoding speed. Slower yields better compression
	-crf: quality. Lower is better quality, 23 is the default

Finally, the video needs metadata so players know that it is a 360° video,
and that the top is the left eye and the bottom the right eye. We can add this
metadata with the https://github.com/google/spatial-media/ software. Having it downloaded, run::

	$ python2 ~/Downloads/spatial-media/spatialmedia/ -i -s top-bottom simple.mp4 simple-injected.mp4

Now simple-injected.mp4 is ready to be viewed!

Click below to play:

.. image:: https://i.vimeocdn.com/video/680066292_300x170.jpg
	:target: https://vimeo.com/253234521
	
Or go to https://vimeo.com/253234521.
	


More Advanced simulation
===========================

A murmuration of flocking boids. See boids/boids.py.

Click below to play:

.. image:: https://i.vimeocdn.com/video/679995672_300x170.jpg
	:target: https://vimeo.com/253178116

Or go to https://vimeo.com/253178116.
	
Here I re-used Neil Alexander's flapping bird from: http://objects.povworld.org/objects/cat/Nature/Animals/


License
=========

My code is free to be reused under the BSD 2-clause license.

My videos are released under a Creative Commons license.

