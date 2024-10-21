
# MPEG 4
ffmpeg -framerate 30 -i mov%04d.ppm -c:v libx264 -crf 0 -preset veryslow -r 30 transition.mp4

# MPEG 2
ffmpeg -framerate 30 -i mov%04d.ppm -c:v mpeg2video -q:v 1 -r 30 transition.mpeg
