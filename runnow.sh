ffmpeg \
 -stream_loop -1 \
 -re \
 -i start.mp4 \
 -thread_queue_size 512 \
 -stream_loop -1 \
 -i bgm.mp3 \
 -c:v libx264 -preset veryfast -r 30 -g 30 -b:v 1500k \
 -c:a aac -threads 6 -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p -s 1920x1080 \
 -fflags +shortest -max_interleave_delta 50000 \
 -f flv rtmp://a.rtmp.youtube.com/live2/$KEY
