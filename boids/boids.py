import os
import subprocess
import numpy
from numpy import tan, sin, cos, exp, log, pi, arccos

FNULL = open(os.devnull, 'w')

def to_spherical((xf, yf, zf)):
	xf = numpy.asarray(xf).reshape((-1,))
	yf = numpy.asarray(yf).reshape((-1,))
	zf = numpy.asarray(zf).reshape((-1,))
	rad = (xf**2+yf**2+zf**2)**0.5
	#phi = numpy.fmod(numpy.arctan2(yf, xf) + 2*pi, pi)
	phi = numpy.arctan2(yf, xf)
	theta = numpy.where(rad == 0, 0., arccos(zf / rad))
	return (rad, theta, phi)

def to_cartesian((rad, theta, phi)):
	xv = rad * sin(theta) * cos(phi)
	yv = rad * sin(theta) * sin(phi)
	zv = rad * cos(theta)
	return (xv, yv, zv)

fast = False
if fast:
	template = open('template.pov').read()
else:
	template = open('template360.pov').read()

numpy.random.seed(1)
boids_x = numpy.random.uniform(0, 1e-3, size=1)
boids_y = numpy.random.uniform(0, 1e-3, size=1)
boids_z = numpy.random.uniform(0, 1e-3, size=1)
boids_vx = numpy.random.uniform(0, 1e-3, size=1)
boids_vy = numpy.random.uniform(0, 1e-3, size=1)
boids_vz = numpy.random.uniform(0, 1e-3, size=1)

numpy.random.seed(2)
N = 1000
boids_x = numpy.random.normal(0, 1, size=N)
boids_y = numpy.random.normal(0, 1, size=N)
boids_z = numpy.random.normal(0, 1, size=N)
boids_vx = numpy.random.normal(0, 0.1, size=N)
boids_vy = numpy.random.normal(0, 0.1, size=N)
boids_vz = numpy.random.normal(0, 0.1, size=N)
boidid = numpy.arange(N)
R1 = numpy.random.uniform(size=N)
R2 = numpy.random.uniform(0, 2*pi, size=N)

hunter_x = numpy.random.normal(2, 1)
hunter_y = numpy.random.normal(2, 1)
hunter_z = numpy.random.normal(2, 1)
hunter_vx = numpy.random.normal(0, 0.1)
hunter_vy = numpy.random.normal(0, 0.1)
hunter_vz = numpy.random.normal(0, 0.1)


# rule weights
collisiondist = 0.04 * 4
nearbydist = 1 # radius of influence
flightvel = 0.1
huntervel = 0.14
randvel = 0.0001 
hunterradius = 0.04 * 10 # distance where hunter repels with strength w5
w1 = 0.01     # to center
w2 = 0.01     # repellant
w3 = 0.04      # similar direction (velocity)
w4 = 0.001     # to origin
w5 = 0.004     # flee from hunter
mask = numpy.ones(N, dtype=bool)

for i in range(1000):
	# clone a boid
	if False and i % 10 == 0:
		j = numpy.random.randint(len(boids_x))
		newx, newy, newz = boids_x[j] + boids_vx[j], boids_y[j] + boids_vy[j], boids_z[j] + boids_vz[j]
		boids_x = numpy.hstack((boids_x, newx))
		boids_y = numpy.hstack((boids_y, newy))
		boids_z = numpy.hstack((boids_z, newz))
		boids_vx = numpy.hstack((boids_vx, boids_vx[j]))
		boids_vy = numpy.hstack((boids_vy, boids_vy[j]))
		boids_vz = numpy.hstack((boids_vz, boids_vz[j]))
	
	N = len(boids_x)
	print 'iteration %d with %d' % (i, N), boids_x.shape
	# update positions
	next_boids_vx = numpy.empty_like(boids_vx)
	next_boids_vy = numpy.empty_like(boids_vy)
	next_boids_vz = numpy.empty_like(boids_vz)
	
	
	hdists = ((boids_x - hunter_x)**2 + (boids_y - hunter_y)**2 + (boids_z - hunter_z)**2+1e-3)**0.5
	# hunt for nearest
	nearest_boid = numpy.argmin(hdists)
	prey_x = (boids_x[nearest_boid] - hunter_x)/hdists[nearest_boid] * huntervel
	prey_y = (boids_y[nearest_boid] - hunter_y)/hdists[nearest_boid] * huntervel
	prey_z = (boids_z[nearest_boid] - hunter_z)/hdists[nearest_boid] * huntervel
	"""
	# hunt for center
	prey_x = boids_x.mean() - hunter_x
	prey_y = boids_y.mean() - hunter_y
	prey_z = boids_z.mean() - hunter_z
	hdist = (prey_x**2 + prey_y**2 + prey_z**2)**0.5
	prey_x /= hdist
	prey_y /= hdist
	prey_z /= hdist
	"""
	
	# hunter is slow to change course
	next_hunter_vx = hunter_vx*0.9 + prey_x*0.1
	next_hunter_vy = hunter_vy*0.9 + prey_y*0.1
	next_hunter_vz = hunter_vz*0.9 + prey_z*0.1
	vel = (next_hunter_vx**2 + next_hunter_vy**2 + next_hunter_vz**2)**0.5
	hunter_vx = next_hunter_vx / vel * huntervel
	hunter_vy = next_hunter_vy / vel * huntervel
	hunter_vz = next_hunter_vz / vel * huntervel
	
	for j in range(len(boids_x)):
		mask[j] = False
		dists = ((boids_x[mask] - boids_x[j])**2 + (boids_y[mask] - boids_x[j])**2 + (boids_z[mask] - boids_x[j])**2 + 1e-3)**0.5
		
		# rule 2: keep a small distance away from each other
		too_close = dists < collisiondist
		if too_close.any():
			w = collisiondist / dists[too_close]
			cx = (((boids_x[j] - boids_x[mask][too_close])) * w).sum()
			cy = (((boids_y[j] - boids_y[mask][too_close])) * w).sum()
			cz = (((boids_z[j] - boids_z[mask][too_close])) * w).sum()
		else:
			cx, cy, cz = 0., 0., 0.
		
		nearby = dists < nearbydist
		if nearby.any():
			# rule 3: match velocity of nearby boids
			# weighted mean by distance
			w = 1 / dists[nearby]
			avgv_x = (boids_vx[mask][nearby] * w).sum() / w.sum()
			avgv_y = (boids_vy[mask][nearby] * w).sum() / w.sum()
			avgv_z = (boids_vz[mask][nearby] * w).sum() / w.sum()
			
			# rule 1: fly towards local center
			ctr_x = (boids_x[mask][nearby] * w).sum() / w.sum()
			ctr_y = (boids_y[mask][nearby] * w).sum() / w.sum()
			ctr_z = (boids_z[mask][nearby] * w).sum() / w.sum()
			v1x = ctr_x - boids_x[j]
			v1y = ctr_y - boids_y[j]
			v1z = ctr_z - boids_z[j]
		else:
			# no one nearby, lets just keep flying
			avgv_x, avgv_y, avgv_z = 0., 0., 0.
			v1x, v1y, v1z = 0., 0., 0.
		
		# rule 4: stay near center
		if boids_z[j] < -2:
			v4x = 0
			v4y = 0
			v4z = -boids_z[j]*10
		elif boids_x[j]**2 + boids_y[j]**2 + boids_z[j]**2 > 10**2:
			v4x = -boids_x[j]
			v4y = -boids_y[j]
			v4z = -boids_z[j]
		else:
			v4x, v4y, v4z = 0., 0., 0.
		
		# rule 5: avoid hunter
		if hdists[j] < hunterradius:
			hdist = (hdists[j]/hunterradius)
			v5x = (boids_x[j] - hunter_x) / hdist
			v5y = (boids_y[j] - hunter_y) / hdist
			v5z = (boids_z[j] - hunter_z) / hdist
		else:
			v5x, v5y, v5z = 0., 0., 0.
	
		# update velocities
		next_boids_vx[j] = boids_vx[j] + v1x * w1 + cx * w2 + avgv_x * w3 + v4x * w4 + v5x * w5
		next_boids_vy[j] = boids_vy[j] + v1y * w1 + cy * w2 + avgv_y * w3 + v4y * w4 + v5y * w5
		next_boids_vz[j] = boids_vz[j] + v1z * w1 + cz * w2 + avgv_z * w3 + v4z * w4 + v5z * w5
		
		mask[j] = True
	
	# fly slower in z direction
	# next_boids_vz *= 0.99
	
	# normalise flight speeds
	vel = (next_boids_vx**2 + next_boids_vy**2 + next_boids_vz**2)**0.5
	boids_vx = next_boids_vx / vel * flightvel + numpy.random.normal(0, randvel, size=N)
	boids_vy = next_boids_vy / vel * flightvel + numpy.random.normal(0, randvel, size=N)
	boids_vz = next_boids_vz / vel * flightvel + numpy.random.normal(0, randvel, size=N)
	# update positions
	boids_x += boids_vx
	boids_y += boids_vy
	boids_z += boids_vz
	
	# update positions
	hunter_x += hunter_vx
	hunter_y += hunter_vy
	hunter_z += hunter_vz
	
	if fast and i % 10 != 0: continue
	print 'running ...'
	filename = 'boidsHR-%05d.pov' % i
	outfile = 'boidsHR-%05d.png' % i
	fout = open(filename, 'w')
	fout.write(template)
	
	# rotation matrix:
	r, theta, phi = to_spherical((boids_vx, boids_vz, boids_vy))
	if fast:
		numpy.savetxt(fout, numpy.transpose([boids_x, boids_z, boids_y]), 
			fmt='''sphere { <%f,%f,%f> 0.04 texture { pigment {color White}} }''')
	else:
		numpy.savetxt(fout, numpy.transpose([R1, R2, theta*180/pi, phi*180/pi, boids_x, boids_z, boids_y]), 
				fmt='''
	object { Bird (clock*0.15*(1 + %f*0.01) + %f)
  scale 0.04
  rotate <%f,0,%f>
  translate <%f,%f,%f>
} 
''')

	numpy.savetxt(fout, [[hunter_x, hunter_z, hunter_y]], 
				fmt='''sphere { <%f,%f,%f> 0.04 texture { pigment {color Red}} }''')
	fout.close()
	
	if fast:
		subprocess.check_call(['povray', '+W200', '+H200', '+O%s' % outfile, '+K%d' % i, '+Q0', '-d', filename], stdout=FNULL, stderr=FNULL)
	#subprocess.check_call(['/home/user/bin/bin/povray', '+W1200', '+H1200', '+O%s' % outfile, '+K%d' % i, '-d', filename], stdout=FNULL, stderr=FNULL)
	else:
		subprocess.check_call(['/home/user/bin/bin/povray', '+W1200', '+H1200', '+O%s' % outfile, '+K%d' % i, '-d', filename], stdout=FNULL, stderr=FNULL)




