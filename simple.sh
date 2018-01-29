#python simple.py || exit

for i in $(seq 0 10000)
do

# pad with zeros
k=$(printf "%05d" $i)

# do not overwrite files:
[ -e frame-$k.png ] && continue

# W: width in pixels, you want 1200 or ideally >2400. For quick viewing: 200
# H: height in pixels, you want 1200 or ideally >2400. For quick viewing: 200
# WT: number of threads to use
# K: time index (set clock variable in povray script)
# Q: low quality: for quick views set 0

# quick:
#~/bin/bin/povray +W300 +H300 -V +Oframe-$k.png +WT1 +Q0 +K$i -d frame-$k.pov || exit
# better:
~/bin/bin/povray +W1200 +H1200 -V +Oframe-$k.png +WT4 +K$i -d frame-$k.pov || exit

done

exit # do the rest manually

# make a video out of it with ffmpeg
# -y: overwrite
# -hide_banner: less output
# -r: frame rate
# -i: input image pattern
# -c:v video codec: H.264 is a widely available one. In the future VP9 may be a better option
# https://trac.ffmpeg.org/wiki/Encode/H.264
# -pix_fmt yuv420p: need to select this color scheme because the default and newer yuv444p is sometimes not supported
# -preset: encoding speed. Slower yields better compression
# -crf: quality. Lower is better quality, 23 is the default
ffmpeg -y -hide_banner -r 25 -i frame-%05d.png -c:v libx264 -pix_fmt yuv420p -preset slow -crf 17 simple.mp4


# finally, need to inject spatial media meta-data, informing the player that
# this is a top-bottom 360 degree video.
# get it here: https://github.com/google/spatial-media/
python2 ~/Downloads/spatial-media/spatialmedia/ -i -s top-bottom simple.mp4 simple-injected.mp4

# now simple-injected.mp4 is ready to be viewed!




